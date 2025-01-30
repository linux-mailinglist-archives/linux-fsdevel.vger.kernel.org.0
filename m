Return-Path: <linux-fsdevel+bounces-40440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CD4A236A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 22:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 255201883320
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 21:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34341F1303;
	Thu, 30 Jan 2025 21:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="m6QFpsXr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AFA1B043E;
	Thu, 30 Jan 2025 21:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738272262; cv=fail; b=lpWbAm9KGUe+//XjRspM9ZzZM7YQhxWTvtUPl2EHaEa0yo6CW6+RmGf/Av8Ooei3EyDUuUc0r37KI4rfPBt0w4tiernmUlIYlpOu8G03j9LoCJPK7N+V/fBgv2VuBZxAN3yEoswdfu/4xTOJgDbKbDSPad8KMFkAvz8sBTotVUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738272262; c=relaxed/simple;
	bh=LLlzXL0MB8YBH3JJ+03qZc3lNhftQv8vsnIDdQR1PQc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xak7+Jlqfdlod4qoLpzFN/2xYN/TUUlUpEn+we6KFW7Iy33zyJqurcdsJphFfMsJz/oOw3WVRib5TZE8gKV/okZeybDJ3dZkyAHjXwUpW2WF7i5U4GHRIEr5DGXgBehiDZDF8cLMNYKZ1Y5GR31+3jBnvHRkcqXKx5gtaHsQUYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=m6QFpsXr; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UJ2vok004646;
	Thu, 30 Jan 2025 13:24:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=LLlzXL0MB8YBH3JJ+03qZc3lNhftQv8vsnIDdQR1PQc=; b=
	m6QFpsXr5Thior3bB9Y77h+jq9NMY7ThBLebbJjuxOYg5H5V9cxoK7C/P/wDgIjF
	2hmmky5OxS4tq/BZGceHlaeaQf61EsS64TQhuGXxzGx+JIKkqNzz4xUCBGjuZ+Dy
	E+2MdtejhmmeuHMuh+70j8ADyqNFkbuCvcrRijqhtCZ2dDxUYSPfnjx5gPCnutSs
	Y7/b8K4R37aJK4OjxRdJh0iVur/zqvI1h+YFZAGZGNLnRzsWA/IRHi7DvG8GSkt4
	2vSnxU4mcPr9QFtbUmp2WSicCtkctidGQ2Sq4y2BAkKxU5oxX/RfNO/6T0c2DIoV
	Kui3XYs5qR7DnG3SDGGeyg==
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 44gf87s060-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 13:24:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=be9BPrKfOfDg5XYrk1JD/f+dQXdw7KHWJU0cgvYPWs4XOkog/P+k6cuKTKwEBnEeQcoJQJ0eyTcQlwmk1PpDfxhjm7ZbOwT3dpRbHwa/0ntVMFaebtElo44Y0WSUAp7WDUT1pLSUNb1Ab6v09qOybCNOOepU4tDLVpPxNh2MjjntoUseT0AGU1CULa70/kxwSuP14UkxJMzVoXL5Lh4JdexRveq4QaFgCIOXcCM7b10GFWoAj6+c5I+ZN3RqpDSGaIr8OXCUsjR9Cj8C0blDcw6RPLrPqzj6oLZUeVd/AnoN7J7BVsz1yMv6YSWWSvYTi29xwI1O4hc1gz4GPv0GZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLlzXL0MB8YBH3JJ+03qZc3lNhftQv8vsnIDdQR1PQc=;
 b=r5cIPaxCTTQHIDF2nk7dmodSj2CilzEHi3wGgxj0j9p8rtxohrXJJ9QEMx35wNg/RtXsalWSVQZ3zz1AaSJFKc1py12K0gPWoaPQ1dz0h6UBZ8kzBy6hRtT2uvM1t1wkAmeuLUluLFgxp0oCOSNDctt1mOuTfcklTYKy1dpLQj63t4HflB1atPtcIczP6TPiOABmj2peeM1OXrIbuLSK5XTFxCwfyl89A8Yy9qcrMHvwhCSqDs09ncfAETtfTC9lyAO/Skw0O18a46wEWz+n3p4U2mEKRs82oQ1/H6bTch5BJr347UY/zY5Q5fp1jq/Dv+qxuhii7XV0efV0VJx5sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SJ2PR15MB5718.namprd15.prod.outlook.com (2603:10b6:a03:4c9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Thu, 30 Jan
 2025 21:24:15 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%4]) with mapi id 15.20.8398.020; Thu, 30 Jan 2025
 21:24:15 +0000
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
        Liam
 Wisehart <liamwisehart@meta.com>,
        Shankaran Gnanashanmugam
	<shankaran@meta.com>
Subject: Re: [PATCH v11 bpf-next 5/7] bpf: Use btf_kfunc_id_set.remap logic
 for bpf_dynptr_from_skb
Thread-Topic: [PATCH v11 bpf-next 5/7] bpf: Use btf_kfunc_id_set.remap logic
 for bpf_dynptr_from_skb
Thread-Index: AQHbcpDg6p82hSN7HE+NyWUR/2AbNLMumScAgAEAYYCAACsYgIAAENKA
Date: Thu, 30 Jan 2025 21:24:15 +0000
Message-ID: <FA63868F-D254-438C-9265-7BE40D970D99@fb.com>
References: <20250129205957.2457655-1-song@kernel.org>
 <20250129205957.2457655-6-song@kernel.org>
 <CAADnVQ+1Woq_mh_9iz+Dhdhw1TuXZgVrx38+aHn-bGZBVa5_uw@mail.gmail.com>
 <58833120-DD06-4024-B7F5-E255AC9261E6@fb.com>
 <CAADnVQLa97RqLONmcrfBWckGRWD+OKOFY0FMEu4_pSsoALtdgQ@mail.gmail.com>
In-Reply-To:
 <CAADnVQLa97RqLONmcrfBWckGRWD+OKOFY0FMEu4_pSsoALtdgQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.300.87.4.3)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|SJ2PR15MB5718:EE_
x-ms-office365-filtering-correlation-id: c2034f92-a09f-4485-130d-08dd41747307
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RmF6YWt2UzVndjhRaDY5eWxmbkg1d3VzWWZpNGoyM2JaMXMrN3dGd1FQcG1I?=
 =?utf-8?B?Y1ZDMTJjNHgweWlaRFkvWC95RGxqRi90RER0cGNxdEtabDREQWt6cW1Fdk5x?=
 =?utf-8?B?c1NsR2lMQ011eTArTG1wa1pUeEFlWnlKSG44a2tVTy9DUDZOZXl1V0p0ODUz?=
 =?utf-8?B?SEhCNHd6SVRjYlNaWGVtUEFSVThSUVNSQVUxYjFrZGgyRC81RkVubkxnU2hZ?=
 =?utf-8?B?N29zbjdHZ3VOUE1kUHNJVThXbXV6TVRySEplK0dhUDErdVNxVGs4YU9PMVIz?=
 =?utf-8?B?TU9XWjVNWTBrVXhhUjA4TndLMTZmYWVTaWZXN0dYTHVKRjRKUWwxaU92eWw3?=
 =?utf-8?B?SUhHQXNBL3FPNU5GNWRyVzhjOENSaVgzUStJSGFvMDkxa3lTMFpLajlNYzZu?=
 =?utf-8?B?NlhHQUxFWUNIalJ6cm10VCtpeXJxdW9WSFRCWDYwVGNZbDN4WFcxMVIzdTZS?=
 =?utf-8?B?cGpPWFFweEp6eXpBM2RHTHFqU05hU0pyZ241dlNGVG10MmlhNTNKQmptT0ZM?=
 =?utf-8?B?YUdoQmV5cW1NWUloalJTNmNvWTB0RlNlaUg4TUhla3hzRkE0RHFNUTNqcFhL?=
 =?utf-8?B?N3pHOC9HRjRBZE9jU294Si93ZzFVaVVBSUgwYU1OZE5yQ3FDQXpnRTFjQWcz?=
 =?utf-8?B?Sy8yclVpMGR2bE02WGlzdG9wNzhXdkZBOEcxVDRybUNOZEtHVWw0N2VFdkJt?=
 =?utf-8?B?SE5RVE1qLzZXVXVCbklSZDZFREdWNTBUUGM2S1lXUW1FS2xwZjZNSUFueEp2?=
 =?utf-8?B?aytRRUUrak9pcXpkT0puNzl6enN2SVZtNFkxWWZIcTd5cXpCVWJ4RlJPZFFO?=
 =?utf-8?B?S0ZUdlBSWU10aGtQR2pBck9SWnF1RWJKTEZmQXp3aHlxcGdvdVpDenpzVTZI?=
 =?utf-8?B?R0ZjMjBUVEQyZVVUNlA5Y1h4cHdObHFYaXQxSmJVOE9wS24wN1BFVEZvMFpZ?=
 =?utf-8?B?OHVpb0k4ejJJS0lGS21pb1pZaXNkNHRFa3MrSElFcDk1Ukc3bkh0clR2YXFJ?=
 =?utf-8?B?TnZ1eXNYZkVmS3RsL0g2NWRTU3ZKMGdXVWJMMUNQeGFsczJjMGUrYTBDYmdW?=
 =?utf-8?B?ZGU0RVphbzZhUjRFNXRrOVIxa1huVHBCMldNL1ZBSHJTbkhINVRQcHo4Zzdv?=
 =?utf-8?B?U3EzL0llTTUzZmYyRmV6dXN4KzdFTzFYZVV0Ui9lQ3hUNzZ0VTJZNHZsVm90?=
 =?utf-8?B?UlJuZWJ6Mm9TQXZMTitLRmJjT29LMXdwRm8rTW5vS3hhM2VMSjllUVhVTFR5?=
 =?utf-8?B?ZEZQZVNPVUVsMEpSakcvdjVnRFVUaXR3S0JxeVBsQVhPWlpOU0FlQkhseE9m?=
 =?utf-8?B?dklxZG1Rc1UzNnB5OEdhWUZOcSt6YjROT25FOEF0MGdVM2ZJWWhSMjJvZjU4?=
 =?utf-8?B?SVhIb1NVeElBaS81QUlDSHhnbVcrUG43UVk2NHNYZlJJcmFnWHE3L29HL3pL?=
 =?utf-8?B?NVlyRUtVM1RYYllkYnlSZkxsSVU3NGRkRzJ5eFJHMTFuSU5mbGJ6SzU0M2o1?=
 =?utf-8?B?a0ZDRW90bVprVDJiUmt2Uk1vNUhiMGljRkFESTNGaDNHeXFqeEhkWHZ0anlD?=
 =?utf-8?B?ejFnUnFMUW5COUVCdUFCWFVGWnRIMWhEcTg1cDdRS2pCMTY2KzByUFZkVkxP?=
 =?utf-8?B?aWVobjRLTFhCRkxzSjBLT0hmV1E0Uk42R0dqcWtidWRsV0t5dmFVMytTWE1I?=
 =?utf-8?B?dVVzcitxNW1xZjJZUnN5NElCZzZUM1NkdDJWaUI2N2lJWGw5Tk1SbUhiS2xr?=
 =?utf-8?B?RklTZjk5aVhZK2pTTjBuZWgvM0tBVTBRaEVYT3lxNCszbkNjQVhOdjBVV1d1?=
 =?utf-8?B?bVMvRVRGYmlRMkFHWmR1Q0ZNa2pOaERjMDlIcE5PRFVoMGNFaVNHNlZPdGFM?=
 =?utf-8?B?ZkF3a1VIcmd5amx4cFFDMVVQUFBueFFMRElIQ3hxNmU5RnMyUHFLbHcwd1VP?=
 =?utf-8?Q?Ex6GvsSPxFelpfp9/ZnPCUGeeVBM3vjh?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZlQwcmtUMU8vN01BYldqYTZtejd6Z0x2eDl1QUlCZ1d4TnVUbFBJMmdzT3Jw?=
 =?utf-8?B?WVd0RGlwU3RZbGtVNExTc0IwREFwRGx4M2UwaVNkcFFmMnh2MFh6NjYvSVIw?=
 =?utf-8?B?d0JOT2oyYWVMNEI1QnNCdkZUQi9jN2hpVnF4MWNzLzlZaTQxUUV1VDZqOVZv?=
 =?utf-8?B?USt0UDRSR1k4Qm1VQkhQVkxRTWMzbTc2aE1jUVgzUHdOejBObGg1b3IreFgy?=
 =?utf-8?B?clJxZEZKT0ZmR3hwaGFzM04rcG55N0EzdVJlY0ExS2VCa3Y4R3Y5Y1kxeXlh?=
 =?utf-8?B?T1U1WjJ1Z1pxZzlYdFZLTzZuYU92b0kyWndhQVFNNFY0T0dUcjcwTkk0TXRq?=
 =?utf-8?B?ZVdBRWc3SUVORHhpR3pEanhPaTV0dmhBYlhTRitKaStpZzhjeWRCY3MxWk03?=
 =?utf-8?B?LzhsNmtNQWxhMnBZUjFPNFB4Y1lGRWJIMGl6NXhQZU1KdlZjZFgvMm5TVkYx?=
 =?utf-8?B?elp5NXphdGVqSWdGVzRwY0NFeGp5RFJWaGlDT0JGa3lEbkxpM0dmUW56YVNh?=
 =?utf-8?B?eUFMZDN1bmd1Yzd4djZHT05VTlg3WFVmT3FBYmFManU4SVZvODB5dUNCWCtl?=
 =?utf-8?B?amxWTFl1ajV3U3pIU0xtcU5PbGVxZzQ0NGxoZ1lwUEJMREVZMXpzTE51NDFN?=
 =?utf-8?B?eVpOMjk2YXkveWE3bjN2d0M1UWxkRXZTWi96MUdRVTFOUThrQ09ETWFRaE13?=
 =?utf-8?B?U2ozQVdVbXJhaXNHSG1tbjNrQUdrNVlydFpCYTBqdG1hTU14MVN3c2tkSk51?=
 =?utf-8?B?Wk1rV0FPaDlsWEtzSHhkUVdKRms1MWJXd3VBaUF5aHB3bE41ZTV0d0w4NU5C?=
 =?utf-8?B?T2R0eGVtL0NDWjJDYmw0VFhYaExEYjBFUU91Vk1LODQ2akJvNnp3RXc1T2Ur?=
 =?utf-8?B?UHNoRHJMbUhoaDNYZC9ybmJuUnMrcHFyQjFHQTRXVjVuSFRvQjNzUjFjQ0xt?=
 =?utf-8?B?ZHk5aFNCMk5ZVDI3MEk3Mm44eTAxcGxBTjFoM1NCcmJHUENNVEVOZXg0WjlH?=
 =?utf-8?B?Y3ZuR2FlcVVMcE9TaUFLanFGeWV5Nmk4cGxwZTYxVGN0MWRxYXphWjdiaWo5?=
 =?utf-8?B?aWcwSlRVK0xwcVZYUk5ZSEtteHE0ZlEvZjNqRko2dXMvVUwzWTlqWDBsdGlh?=
 =?utf-8?B?U3l5Y3lGazVmNDdSYWh4aGxIQ1NHeWwyYUlId1JJZjkwaWxUV3c5cERoYk03?=
 =?utf-8?B?Y3MrRFlSaWYrK1ZJTHJMb2ZaM3VXTkZpVzgvVHNpN3pvaWpBM1o1S29PWDNY?=
 =?utf-8?B?a3lsUkx6VURHVWRDbHpLRU52d0NmeHFoait4dkJxY2tjbzMrcjhaRjFrTlJa?=
 =?utf-8?B?VjFlQ05VWnFYNDVKdzVUc2FPUU5mZEVNejNWM0NpVEsxL3dOVUdONDhRN252?=
 =?utf-8?B?WDl1SFd3cUp5aXdmcDRTa2RBMXlQTHlIQ2VBMkpiamo3d0JObVVqMEovL1Ba?=
 =?utf-8?B?b3dmTnU2dEszdmc4WTBDK2FPVzZubWxjRTlRMFljU0R3a2xFcitRWWVFWkMw?=
 =?utf-8?B?REJ2N0dTd1loY0h5NWovTXkvdnZ2Q1cxc3N0a21kdGR5bVV2TmJXWitoRnhX?=
 =?utf-8?B?WFZtQ09mMm5IaG1hRHdtVngzeU13ZkUyTHBlUVdoWjRoYjlmam9MOTFoR0dM?=
 =?utf-8?B?ZEIvZUJYOVFJVUNreDhTc1pJUHJEWS84ZGNoN0xmZ1QyQTlPM0pYNjZMeEhE?=
 =?utf-8?B?NFNUcnROUlZObmZVMHROZXJHbmY5YXlTYzBrN1JSWVBGeWZRM0ptUm4wN3N3?=
 =?utf-8?B?d0NVdEZIMnpIbytaL3BJN0d4Q0VaQXNLSVIraW9wVnBTVWY3MWVRblZONWtq?=
 =?utf-8?B?R0kybUpNb1dsZ29Yd1ErUWVMYXRJSjlvU2NzRmtHOXZKR1ViNGZ4bEU2TWFW?=
 =?utf-8?B?QUl6VkRUTnlKV0ZMbU1TUUt3em9Qb1VWRlhEMjNGck85M1ZwNlg2aDJVM24v?=
 =?utf-8?B?RFRsZElHSlFEY2JydFJUODcyQkJPNTJtd1BKTWJlWURqV1dHT1dseHI0bjlD?=
 =?utf-8?B?UGtZR1QrK2ZldWp0YUtPekJaNVNiZGtkUkF4UnJreCtWZkVQTlU2c1dsQy9V?=
 =?utf-8?B?SVpkS2czS0hIUkJsZFAyODhiSGNGTVRlYytJcnR4UUp6aDlaNzNNT1dNb1li?=
 =?utf-8?B?ZjdyOHpzSG16OFkzV0lHbk9RYzRpb3VqMS9BdW9WRjJQMmdWT1lZdG9jTGNn?=
 =?utf-8?Q?724+VjmjsgpHFeV86kD+Fv4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3DE033A16922434CA159A5B06D6D458E@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c2034f92-a09f-4485-130d-08dd41747307
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2025 21:24:15.8149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SOW0idbYZFM1ePuTXUpujBYQ2Zkcr4mopJerIXlYG6KzgWw+YsoztEKoa3n12XfBMQSaDJgMFa+NXmxJCEtUUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR15MB5718
X-Proofpoint-ORIG-GUID: dvh2q050y5kkzXLPbSJhAUBVJxHfB7t8
X-Proofpoint-GUID: dvh2q050y5kkzXLPbSJhAUBVJxHfB7t8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_09,2025-01-30_01,2024-11-22_01

DQo+IE9uIEphbiAzMCwgMjAyNSwgYXQgMTI6MjPigK9QTSwgQWxleGVpIFN0YXJvdm9pdG92IDxh
bGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPiB3cm90ZToNCg0KWy4uLl0NCg0KPj4+IEZvciBh
bGwgdGhlc2UgcmVhc29ucyBJIGRvbid0IGxpa2UgdGhpcyBhcHByb2FjaC4NCj4+PiBUaGlzICJn
ZW5lcmFsaXR5IiBkb2Vzbid0IG1ha2UgaXQgY2xlYW5lciBvciBlYXNpZXIgdG8gZXh0ZW5kLg0K
Pj4+IEZvciB0aGUgcGF0Y2ggNi4uLiBqdXN0IHJlcGVhdCB3aGF0IHNwZWNpYWxpemVfa2Z1bmMo
KQ0KPj4+IGN1cnJlbnRseSBkb2VzIGZvciBkeW5wdHIgPw0KPj4gDQo+PiBZZXMsIHNwZWNpYWxp
emVfa2Z1bmMoKSBjYW4gaGFuZGxlIHRoaXMuIEJ1dCB3ZSB3aWxsIG5lZWQgdG8gdXNlDQo+PiBk
X2lub2RlX2xvY2tlZF9ob29rcyBmcm9tIDYvNyBpbiBzcGVjaWFsaXplX2tmdW5jKCkuIEl0IHdv
cmtzLA0KPj4gYnV0IGl0IGlzIG5vdCBjbGVhbiAodG8gbWUpLg0KPiANCj4gSSdtIG1pc3Npbmcg
d2h5IHRoYXQgd291bGQgYmUgbmVjZXNzYXJ5IHRvIGNyb3NzIHRoZSBsYXllcnMNCj4gc28gbXVj
aC4gSSBndWVzcyB0aGUgY29kZSB3aWxsIHRlbGwuDQo+IFBscyBzZW5kIGFuIHJmYyB0byBpbGx1
c3RyYXRlIHRoZSB1bmNsZWFuIHBhcnQuDQoNClRoZSBhY3R1YWwgY29kZSBpcyBhY3R1YWxseSBh
IGxvdCBjbGVhbmVyIHRoYW4gSSB0aG91Z2h0LiBXZSBqdXN0DQpuZWVkIHRvIHVzZSB0aGUgYnBm
X2xzbV9oYXNfZF9pbm9kZV9sb2NrZWQoKSBoZWxwZXIgaW4gdmVyaWZpZXIuYy4gDQoNClRoYW5r
cywNClNvbmcNCg0KPiANCj4+IEkgd2lsbCByZXZpc2UgdGhpcyBzZXQgc28gdGhhdCB0aGUgcG9s
eW1vcnBoaXNtIGxvZ2ljIGluIGhhbmRsZWQNCj4+IGluIHNwZWNpYWxpemVfa2Z1bmMoKS4gRm9y
IGxvbmdlciB0ZXJtLCBtYXliZSB3ZSBzaG91bGQgZGlzY3Vzcw0KPj4gIm1vdmUgc29tZSBsb2dp
YyBmcm9tIHZlcmlmaWVyIGNvcmUgdG8ga2Z1bmNzIiBpbiB0aGUgdXBjb21pbmcNCj4+IExTRi9N
TS9CUEY/DQo+IA0KPiBpbW8gc3VjaCB0b3BpYyBpcyB0b28gbmFycm93IGFuZCBkZXRhaWwgb3Jp
ZW50ZWQuDQo+IFRoZXJlIGlzIG5vdCBtdWNoIHRvIGdhaW4gZnJvbSBkaXNjdXNzaW5nIGl0IGF0
IGxzZm1tLg0KPiBlbWFpbCB3b3JrcyB3ZWxsIGZvciBzdWNoIGRpc2N1c3Npb25zLg0KDQoNCg0K
DQoNCg==


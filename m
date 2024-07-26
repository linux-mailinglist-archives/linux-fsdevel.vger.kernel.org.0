Return-Path: <linux-fsdevel+bounces-24342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C4093D937
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 21:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E544B1F244C6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 19:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BCA61FCF;
	Fri, 26 Jul 2024 19:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="jb4lnEGx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A4C24B29;
	Fri, 26 Jul 2024 19:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722023015; cv=fail; b=HRKebghGCWAhQaewML6JSagVRHh95GsNisWiru0Erf8f/+6BuMYuB5Nu8PnWRLImi6ucwscouYldFlE1Z/D8ZuzsWvhUvT7WkVj+5eufck7OvQ0fT0qH/MYsuWaFHs7+t9BDlhc3zWacDTaEb/z1GqAX3e1uB+Ew7jQiXbvnAxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722023015; c=relaxed/simple;
	bh=4iLLCUQ9gmpMWSt1o0x4uMa78Vhod9R3rh1qAoaCG/s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PapiLM+hgchwNBSnNMfe1V+NdBm7hwgHIxXmha7DmDCa/GOe8HEhhh7CQfIPsDDIK0zDl6UT95X3WpTliSLmGVHbzDHmU95gcP/up88lMfku7tpQaSLckygB1U2S+0pIVG06kg1CfgCRvTmMUpWQ7trx5c2loWyrWi2FwqV/jLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=jb4lnEGx; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 46QEY3I2024008;
	Fri, 26 Jul 2024 12:43:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=s2048-2021-q4; bh=4iLLCUQ9gmpMWSt1o0x4uMa78Vhod9R3rh1qAoaCG/s
	=; b=jb4lnEGxR1OfsZgu4MA70NQCJfDnNrIJhM3BkBFvuCBzukI/A0pZczFFp7K
	CJENktDsbwig3y0jKzvfwu8lSl0rQnUvyw957JDsNLeog5D+wHd/gwsr8AchR+nZ
	F8VLdPyLQ1FMtGXvxKuotcpVUFucAVFrh8YKjiIoYo/1zmGQl6b9XNoJ6Ve8TPKB
	pOyEK0/goD3xd5h4G8QvDYrnc7LwhDibUIW+59kbseV109cOsg9XFCg25JRrxOV1
	HubGqNaQyaBXQ8K685N3pAiIaB8DAMWU5xy+Qqky7+O2czKuHXFeDsxaGhHRq2rY
	a5n3eQ31msosw5wn66JT/4RarGg==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by m0089730.ppops.net (PPS) with ESMTPS id 40m2u94s5x-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 12:43:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vDcsts7u/i3VDBNTGxWwmlY6pSvqjh0U3IiB1wMCDeiIoy065GhK3EHu4aV9Nb5cYIPoUIVl9xg0qIaXMFcbNqaWY1FkFxRRKCb0IXtrUywXQpPKdoY//R4w2jKiUSnYgoXjc1lOQJi+V5EmskCLVYy+QrqG33xO7gU7rugyK50yHDKLz4QPySMHgnF+s5l1i6WUp8N1OZ6ei3cXiBJmVo7ALFWK9ehG74CzTM8Vp6JuEtISD0MsVyF/d9DhzI0sSl2oKkV45SP/a0ro7nQR2xbBbNYO2kNVGuQZzFzje1YKPwii6ZIUMOE9DQLFqgh03IkYdh3OCaaH8GFmSOnpHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4iLLCUQ9gmpMWSt1o0x4uMa78Vhod9R3rh1qAoaCG/s=;
 b=A317Pu0PvHGsrWNkGuxngTNdGFYesmK9TarRLTl9TVSB1x8hP2dESdYD3uyiu51/MCR2V7vpsCnPLNW++chxpvtcrg8aLoH/Pcz5wRNIDiPY13fPgWTwdyTDosQ6+7c9XtzgXYSTwW9rNhL00SzPBVO79xAequJD0eCJVLUZt/9+S24/ysmglEmuaOXHam52+nwlEfenbIoFsPaLu2JHFRJEy/3mG6d9CKIeP2Y0TID55Z9jW+lA6Jn7AxMGly11+mtuKnKahft91YFpUOPeFIZ/MRAYzwUDhTTObaqUcCBQqaF7/fT1+4ktDUoOOu0FenRdESdMU/hNgLeQ0ClYdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by CO1PR15MB5035.namprd15.prod.outlook.com (2603:10b6:303:ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.24; Fri, 26 Jul
 2024 19:43:29 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%4]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 19:43:29 +0000
From: Song Liu <songliubraving@meta.com>
To: Christian Brauner <brauner@kernel.org>
CC: Song Liu <songliubraving@meta.com>, Song Liu <song@kernel.org>,
        bpf
	<bpf@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML
	<linux-kernel@vger.kernel.org>,
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
        "mattbobrowski@google.com" <mattbobrowski@google.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add tests for
 bpf_get_dentry_xattr
Thread-Topic: [PATCH bpf-next 2/2] selftests/bpf: Add tests for
 bpf_get_dentry_xattr
Thread-Index: AQHa3u0J3x+q9TWVEkq4VV2cIBgMWrIIlswAgAAlQQCAACpzAIAAg8YA
Date: Fri, 26 Jul 2024 19:43:28 +0000
Message-ID: <CDDCB34B-4B01-40CA-B512-33023529D104@fb.com>
References: <20240725234706.655613-1-song@kernel.org>
 <20240725234706.655613-3-song@kernel.org>
 <20240726-frequentieren-undenkbar-5b816a3b8876@brauner>
 <1A0AAD8C-366E-45E2-A386-B4CCB5401D81@fb.com>
 <20240726-beisammen-degen-b70ec88e7ab2@brauner>
In-Reply-To: <20240726-beisammen-degen-b70ec88e7ab2@brauner>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|CO1PR15MB5035:EE_
x-ms-office365-filtering-correlation-id: dd85f6e0-aa3d-4b6e-9baf-08dcadab3927
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MFgvNzRNMDhBSWF2NGw4cWEybk1FQzRPQlZabUFLTXdqeG1VRDcyMDFiRHlq?=
 =?utf-8?B?am5KVnFLTEhzQU5sTVVJclBXUjlXZklSZFo4V2pRQVUvUTU0SXBYVlVjVkdC?=
 =?utf-8?B?cnUxb2twM2xJTkd1MFFEVmdHeDJmbWtPSmlJYzJFQXoxaUdQM3Q5dzlqZ1Jj?=
 =?utf-8?B?NEtSVENoV3Y0KzZ3QnlXWFJFMUR0Y2FTcEM1Tk1UeklXWC9mMy9JUmtTYzk2?=
 =?utf-8?B?dGltVmx4SWdxV1BpRHQzbm9PK2w1dFpOcGttT0hPaVdxNndTVVREUHlyS0o2?=
 =?utf-8?B?SUs2dGkyaTBaM3hTZlJsOTgvOHBwRGh0QUQ4dVhmdWtlb1ZVZ00vV3F2aTFV?=
 =?utf-8?B?WStoV3Ftc2h3NWRNOE5NdDBLaTV0L0I1eGZlRXNpL0hBZG1ZQXJRQUZvNmw5?=
 =?utf-8?B?Y1REZ21oWTJnYXFKYjcvQVVTY2RIT2gvUTR0UnZ2dmJlYmVnMDFoVkI1WUJl?=
 =?utf-8?B?STM5NWwrT2tMWUdIOGFtSzhjVy8wa3pMdVN3RDNOYk1Kb21NMGVUaXZrd3ZZ?=
 =?utf-8?B?U1FBckh6WFRqQmgrbUJOZ3AybHEwZmREZnY4SVM3eG42dUcxb29hR0JWZEho?=
 =?utf-8?B?encxYnRsRThLSjdxQ2hLVTRLejR6aW9NNDFuV1VBUVlxb2Q2MWFrMmx3WG8z?=
 =?utf-8?B?L3pLNlRZenJYbUs4VHVCMnZ6NGM2NDJ5alVtaDAzbFRxQ0M4YmxIOU1xbWZk?=
 =?utf-8?B?aXZZazFibm8wQW5YNXUyR0NEMERSb0tKVFRjU2pRZzRna2phR2FEZGpMWlgy?=
 =?utf-8?B?Q0RLelJmNDFSL0R5RW1jVTFGdE9FdUFyUG9FMHkrcFBjNldkWmZISWtWNFJG?=
 =?utf-8?B?R09FYjZweXF4a3c0Vksydk03MktnRnhtaEhNRFZvS3kyVXBaemtQL1dVVlVq?=
 =?utf-8?B?MDYzdHVZVzlkRW92Szk4YnFYd1d1Z01ZME9YNEw0eGN3b1graXhFVWxrckJn?=
 =?utf-8?B?d1NGWXA0SVJobVc4SjhsdVpHMk1rOTFORkJRUk55bTQxOUNNdHFzVjBSekNH?=
 =?utf-8?B?ZlJWNmRRVmRzVVNiUXkrbklDbCtMbzdZQ1pKOEI5T2doNHVuRStZd1lWckZR?=
 =?utf-8?B?dUxIQkczNndmNFM1RW02eW4vckUzY2lKQk56NVoyQ25rNTArS3pBV2wxOTF0?=
 =?utf-8?B?YUlrRm95eklNL0ZJeTJ5bkJBWmloWTl4aS9mYnM3ZDVvY2NKU2wwSGF4ai9T?=
 =?utf-8?B?VDJ4K1RZd05kemNjZlZiRlVKajNUejZ1UC9FUGpzZk43dGNoR2hFMkUvSkM2?=
 =?utf-8?B?L2RNbDQ2RERFVFFmZ0NicGlDaDhIelF5WEdGYmNQb0ZrK3M2SUdTUjdza0hY?=
 =?utf-8?B?TzNoZUYvU3ZPZHlsM21jd2Y0cWhxZUxzWDFVOG1qVDNRdmxGeW85d2lLVjFC?=
 =?utf-8?B?Z1V1QzQxV2lnWldpaXZaU3FlY242c29QWVYzeUkxamZFQXNXb0cxSHJabFB0?=
 =?utf-8?B?SUwvZHJ4UGhueFB6dlkydVlRc0pldUtXUnRxTGVkUnIwU1hVaWxkclhPSTQ3?=
 =?utf-8?B?eVQrTERjSHZUOXBzeXNrRHQySzNlblpaeDNsV09tQ09QLzAwdnhpL2UwakdO?=
 =?utf-8?B?T2pUU3hMN3RJN0hEQ0d0V3paTVZweUhDTzZMQjBHK09MZDdQWlJaMndlS3JE?=
 =?utf-8?B?cDc4QzJPVDh2YjJ6M1MrRTJONnN0Q2k3T1BCajJ3Snhod0xnMURYNFlnUmlo?=
 =?utf-8?B?RU9ub21hMUFJRzQyWmlMTEhaMkNXU3h0dzVxMEgrMk5rTmlQV284TG1wckxx?=
 =?utf-8?B?ZzBXWTZYNzFiSEpMWFRlM0gzRm5XZ05hUjJGWEJJMG9uc25oTE8zSy9JOEwz?=
 =?utf-8?B?TmFtRmVINzd6b2FuUjhuYkM3NExGVHBrdFZmM0pCa3RYWmltNFNpTUxmWVFJ?=
 =?utf-8?B?UzhPK3AvdWdoakx0bHdKOTdubWtrSWRSTGlnYjNaeU92S3c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eWJscG9FRFlrSGQwT3hxS1YzZlRvSG4zaTdFWitzUzdTbStoVzZLTk9saUhw?=
 =?utf-8?B?RmhWNlBjb05xVkgrNVRWUTB4WG4xU1BHUHZrMHIxTlRQTjg4bTlRbkRNaVFD?=
 =?utf-8?B?WXNocThkRXM0c1lvSjVzSFc4MWlyL2ZBRTl0VjR6TkV4VlhXZWc4cTdLdEtC?=
 =?utf-8?B?NncxRmxtK0h6cUwxK2d3WGVpYitYNCtpMG9INndXVlV5NHZwMDRvNy9VSjBH?=
 =?utf-8?B?Snhqd3BZRzFpc3pUQTlLVGRmNVgwN0pmQVh4UlFnd3pBTkI1MWtRUWQrMHlx?=
 =?utf-8?B?c0RKVnpEbFdwb1ZPZGZyRk1uL2o0eE05RlZsZ2hwb1dpUTVSVUgvcGFmaUtO?=
 =?utf-8?B?TWU4V205RmJUcEx4cnhhaHBQSTJaS1F1VXUxcXlBMEh3ZUNicXFWZ2NTRUs1?=
 =?utf-8?B?N3VrUm15Unc5V1ZPZWd5VXNHQlV2eGZhc3FHbllqakVLajBBbnpwdWFoV1pG?=
 =?utf-8?B?NDhXQVJXMDE3UnlPNDVEQ2lPRzBCLzZ2bDBXK2JPczhxUVNicWJ5UHBkUTly?=
 =?utf-8?B?NElmbzNJT3MrZTZrbnNZNXMveHFtZXpNbVVBK2l3VlJuMW14ZjlxdTQzcVlE?=
 =?utf-8?B?UG10bFRybk9qYThaaGk3TFB4VGxWUzUvdHhSc1RTNldQdkNSWUpGZ3FXSzVY?=
 =?utf-8?B?TCsrbWZpRER2dVBIdlNYRGwxWW5OZFlxdTZCRGlBUWc4STA2UVdxVlJuUUIv?=
 =?utf-8?B?c2tqUFNZZ2kwaGs3dGZsbUtPeEpPZEw2dEhGQTR1NVRVN01Yb0tLejZTb2wr?=
 =?utf-8?B?VEpLSkljNlJPMGhielc0bVFWNEp3N2R5ZUltRmZ0MnF1TndWNVB4b1NnWWpB?=
 =?utf-8?B?L2taZDJoL2ZiS3hvZjludythWS9ydzE1SXJmblpMd3U3TmRZOHBrNGQ3Vlp1?=
 =?utf-8?B?VEVTMmRIVjNwdVd3V2E1TzlxR0tsOC92d2RjUHU4RDEydHVpQ3RhRlo4Lzlp?=
 =?utf-8?B?aG5mL1l5SjR1ajRXRHdyRDM0dFNYWXpGK1lGNGZxYWU0NjJEaElsWFJFaUt4?=
 =?utf-8?B?WkswSzcyeUJlZjdxVVY3OE8xMmhlQjhiZDJiemU0MjdNS2QrMmJrRWxsWTBC?=
 =?utf-8?B?UVhUQmZLUEE4QjNGbEhGbUE4TGw0RlZFR3Y2RXJSS1pLYjAvVVpxdDNvR01r?=
 =?utf-8?B?cld0bTIrdjYzd0czMW5sWXJlcEY2eU9BV2NJOUlJQXlBY2x3V1hVOG53T29h?=
 =?utf-8?B?MFFjT3ZBV3JTWWxHUWJlblNWclJPeTNYRnJuYlZIUTRKSVpDN3VGdzFITzFx?=
 =?utf-8?B?T2l6NzNLTkNnU3FaRlFSNVhzcEZyTndVNFg3bmRzR1ZjSGN4YUwycE9FUmJI?=
 =?utf-8?B?MHdJczN4WjZKeFkybHdsMzZKRmVJTXg0R1A3cVRVclZCb3dSekoyUlZ6eGVl?=
 =?utf-8?B?K2RBRzZLc3lDa3M1YTdobEZrOGpTV0ZNK3I3cXBGL1BwZlgwUFhDQWJ3V3gv?=
 =?utf-8?B?TlpScHNRRW5VbjZVd2hwbDlGZ215NGZFQXMyS09wWURMMnRyNFZXZ1UyTVFO?=
 =?utf-8?B?Y1lmcis3QjRvd3lVaVExU2FOVysyZk5uUE1lV2dKZ1FrdStaV0ZnNW50TkEv?=
 =?utf-8?B?dHgvbko3N1poZWg0VXozR0xWbEhoTDA3SWwwcm9Xd3c0b0tUODN5RHVnVnpN?=
 =?utf-8?B?eU5kZHVIek9VaXRGVXF5SmhGMUFCVkw0ZENXYTdYTWJtdGJDVzNWeTlkTVli?=
 =?utf-8?B?Z3N2czV1alh4NFo4bW15K3hhak44RG1NQVFXUE90ZGdIL2tMOENmODJxdGhJ?=
 =?utf-8?B?OGpDM09RNk9QN3NmODJ3b3VYWG82MUtDNzhLK29vUnNaZGlaejJRY3h6bXJ1?=
 =?utf-8?B?OGN6UkFjRlNQYkFkM0pxZkJ2VVhCbTJlOENSMGFORDk5ak9KdFlqcGc0SGhM?=
 =?utf-8?B?NnpqdUVweHRMdVJZamJPSWlMalA3UnFlellzZmxqUk9wNHFSZUpLL2srK1dZ?=
 =?utf-8?B?M3o4dUFjeTI5RVAzeEh0RmJVajJSaDBLRjlpNVpQbUNTZ2x6TjhMTXJGWmZS?=
 =?utf-8?B?L016RG9BK256ZDZvaVg3L3liNGt0R010NUhyZjBadW1rQzN1R2wydDFqUTda?=
 =?utf-8?B?QXZVM2lpZ3RCSkV2emRZcDhzQ3Y0bTUwQXR4TEpReSs2NkpsMTBGYWd4VkJF?=
 =?utf-8?B?Mkp0b09kK2podzBzRU9LNmlQbVN2QUJrTWllSUROVE96M0lhbEJSMXMxT1Jo?=
 =?utf-8?Q?6OJy6EIoUIQVLij7AfIU9JQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <53C2368AC820854CBB9C9F0C92E5A401@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dd85f6e0-aa3d-4b6e-9baf-08dcadab3927
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2024 19:43:28.9421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZXfIbO2yyByO/GsDRPJQe1WNghonY0zFe6wl9lgoHgDlBsjWC6kegM6F/5j8y1ghGmJBvqGuywNxyS+iBwnuzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB5035
X-Proofpoint-ORIG-GUID: k7s4Mcm_grTW_Y7rhjVgghFVNmdGu3f0
X-Proofpoint-GUID: k7s4Mcm_grTW_Y7rhjVgghFVNmdGu3f0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-26_12,2024-07-26_01,2024-05-17_01

SGkgQ2hyaXN0aWFuLCANCg0KVGhhbmtzIGEgbG90IGZvciB5b3VyIGNvbW1lbnRzLg0KDQo+IE9u
IEp1bCAyNiwgMjAyNCwgYXQgNDo1MeKAr0FNLCBDaHJpc3RpYW4gQnJhdW5lciA8YnJhdW5lckBr
ZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIEZyaSwgSnVsIDI2LCAyMDI0IGF0IDA5OjE5OjU0
QU0gR01ULCBTb25nIExpdSB3cm90ZToNCj4+IEhpIENocmlzdGlhbiwgDQo+PiANCj4+PiBPbiBK
dWwgMjYsIDIwMjQsIGF0IDEyOjA24oCvQU0sIENocmlzdGlhbiBCcmF1bmVyIDxicmF1bmVyQGtl
cm5lbC5vcmc+IHdyb3RlOg0KPj4gDQo+PiBbLi4uXQ0KPj4gDQo+Pj4+ICsNCj4+Pj4gKyBmb3Ig
KGkgPSAwOyBpIDwgMTA7IGkrKykgew0KPj4+PiArIHJldCA9IGJwZl9nZXRfZGVudHJ5X3hhdHRy
KGRlbnRyeSwgInVzZXIua2Z1bmMiLCAmdmFsdWVfcHRyKTsNCj4+Pj4gKyBpZiAocmV0ID09IHNp
emVvZihleHBlY3RlZF92YWx1ZSkgJiYNCj4+Pj4gKyAgICAhYnBmX3N0cm5jbXAodmFsdWUsIHJl
dCwgZXhwZWN0ZWRfdmFsdWUpKQ0KPj4+PiArIG1hdGNoZXMrKzsNCj4+Pj4gKw0KPj4+PiArIHBy
ZXZfZGVudHJ5ID0gZGVudHJ5Ow0KPj4+PiArIGRlbnRyeSA9IGJwZl9kZ2V0X3BhcmVudChwcmV2
X2RlbnRyeSk7DQo+Pj4gDQo+Pj4gV2h5IGRvIHlvdSBuZWVkIHRvIHdhbGsgdXB3YXJkcyBhbmQg
aW5zdGVhZCBvZiByZWFkaW5nIHRoZSB4YXR0ciB2YWx1ZXMNCj4+PiBkdXJpbmcgc2VjdXJpdHlf
aW5vZGVfcGVybWlzc2lvbigpPw0KPj4gDQo+PiBJbiB0aGlzIHVzZSBjYXNlLCB3ZSB3b3VsZCBs
aWtlIHRvIGFkZCB4YXR0ciB0byB0aGUgZGlyZWN0b3J5IHRvIGNvdmVyDQo+PiBhbGwgZmlsZXMg
dW5kZXIgaXQuIEZvciBleGFtcGxlLCBhc3N1bWUgd2UgaGF2ZSB0aGUgZm9sbG93aW5nIHhhdHRy
czoNCj4+IA0KPj4gIC9iaW4gIHhhdHRyOiB1c2VyLnBvbGljeV9BID0gdmFsdWVfQQ0KPj4gIC9i
aW4vZ2NjLTYuOS8geGF0dHI6IHVzZXIucG9saWN5X0EgPSB2YWx1ZV9CDQo+PiAgL2Jpbi9nY2Mt
Ni45L2djYyB4YXR0cjogdXNlci5wb2xpY3lfQSA9IHZhbHVlX0MNCj4+IA0KPj4gL2Jpbi9nY2Mt
Ni45L2djYyB3aWxsIHVzZSB2YWx1ZV9DOw0KPj4gL2Jpbi9nY2MtNi45LzxvdGhlcl9maWxlcz4g
d2lsbCB1c2UgdmFsdWVfQjsNCj4+IC9iaW4vPG90aGVyX2ZvbGRlcl9vcl9maWxlPiB3aWxsIHVz
ZSB2YWx1ZV9BOw0KPj4gDQo+PiBCeSB3YWxraW5nIHVwd2FyZHMgZnJvbSBzZWN1cml0eV9maWxl
X29wZW4oKSwgd2UgY2FuIGZpbmlzaCB0aGUgbG9naWMgDQo+PiBpbiBhIHNpbmdsZSBMU00gaG9v
azoNCj4+IA0KPj4gICAgcmVwZWF0Og0KPj4gICAgICAgIGlmIChkZW50cnkgaGF2ZSB1c2VyLnBv
bGljeV9BKSB7DQo+PiAgICAgICAgICAgIC8qIG1ha2UgZGVjaXNpb24gYmFzZWQgb24gdmFsdWUg
Ki87DQo+PiAgICAgICAgfSBlbHNlIHsNCj4+ICAgICAgICAgICAgZGVudHJ5ID0gYnBmX2RnZXRf
cGFyZW50KCk7DQo+PiAgICAgICAgICAgIGdvdG8gcmVwZWF0Ow0KPj4gICAgICAgIH0NCj4+IA0K
Pj4gRG9lcyB0aGlzIG1ha2Ugc2Vuc2U/IE9yIG1heWJlIEkgbWlzdW5kZXJzdG9vZCB0aGUgc3Vn
Z2VzdGlvbj8NCj4gDQo+IEltaG8sIHdoYXQgeW91J3JlIGRvaW5nIGJlbG9uZ3MgaW50byBpbm9k
ZV9wZXJtaXNzaW9uKCkgbm90IGludG8NCj4gc2VjdXJpdHlfZmlsZV9vcGVuKCkuIFRoYXQncyBh
bHJlYWR5IHRvbyBsYXRlIGFuZCBpdCdzIHNvbWV3aGF0IGNsZWFyDQo+IGZyb20gdGhlIGV4YW1w
bGUgeW91J3JlIHVzaW5nIHRoYXQgeW91J3JlIGVzc2VudGlhbGx5IGRvaW5nIHBlcm1pc3Npb24N
Cj4gY2hlY2tpbmcgZHVyaW5nIHBhdGggbG9va3VwLg0KDQpJIGFtIG5vdCBzdXJlIEkgZm9sbG93
IHRoZSBzdWdnZXN0aW9uIHRvIGltcGxlbWVudCB0aGlzIHdpdGggDQpzZWN1cml0eV9pbm9kZV9w
ZXJtaXNzaW9uKCk/IENvdWxkIHlvdSBwbGVhc2Ugc2hhcmUgbW9yZSBkZXRhaWxzIGFib3V0DQp0
aGlzIGlkZWE/DQoNCj4gQnR3LCB3aGF0IHlvdSdyZSBkb2luZyBpcyBwb3RlbnRpYWxseSB2ZXJ5
IGhlYXZ5LWhhbmRlZCBiZWNhdXNlIHlvdSdyZQ0KPiByZXRyaWV2aW5nIHhhdHRycyBmb3Igd2hp
Y2ggbm8gVkZTIGNhY2hlIGV4aXN0cyBzbyB5b3UgbWlnaHQgZW5kIHVwDQo+IGNhdXNpbmcgYSBs
b3Qgb2YgaW8uDQo+IA0KPiBTYXkgeW91IGhhdmUgYSAxMDAwMCBkZWVwIGRpcmVjdG9yeSBoaWVy
YXJjaHkgYW5kIHlvdSBvcGVuIGENCj4gZmlsZV9hdF9sZXZlbF8xMDAwMC4gV2l0aCB0aGF0IGRn
ZXRfcGFyZW50KCkgbG9naWMgaW4gdGhlIHdvcnN0IGNhc2UgeW91DQo+IGVuZCB1cCB3YWxraW5n
IHVwIHRoZSB3aG9sZSBoaWVyYXJjaHkgcmVhZGluZyB4YXR0ciB2YWx1ZXMgZnJvbSBkaXNrDQo+
IDEwMDAwIHRpbWVzLiBZb3UgY2FuIGFjaGlldmUgdGhlIHNhbWUgcmVzdWx0IGFuZCBjbGVhbmVy
IGlmIHlvdSBkbyB0aGUNCj4gY2hlY2tpbmcgaW4gaW5vZGVfcGVybWlzc2lvbigpIHdoZXJlIGl0
IGJlbG9uZ3MgYW5kIHlvdSBvbmx5IGNhdXNlIGFsbA0KPiBvZiB0aGF0IHBhaW4gb25jZSBhbmQg
eW91IGFib3J0IHBhdGggbG9va3VwIGNvcnJlY3RseS4NCg0KWWVzLCB3ZSBuZWVkIHRoZSBCUEYg
cHJvZ3JhbSB0byBsaW1pdCB0aGUgbnVtYmVyIG9mIHBhcmVudHMgdG8gd2Fsay4gDQoNCj4gQWxz
bywgSSdtIG5vdCBldmVuIHN1cmUgdGhpcyBpcyBhbHdheXMgY29ycmVjdCBiZWNhdXNlIHlvdSdy
ZQ0KPiByZXRyb2FjdGl2ZWx5IGNoZWNraW5nIHdoYXQgcG9saWN5IHRvIGFwcGx5IGJhc2VkIG9u
IHRoZSB4YXR0ciB2YWx1ZQ0KPiB3YWxraW5nIHVwIHRoZSBwYXJlbnQgY2hhaW4uIEJ1dCBhIHJl
bmFtZSBjb3VsZCBoYXBwZW4gYW5kIHRoZW4gdGhlDQo+IGFuY2VzdG9yIGNoYWluIHlvdSdyZSBj
aGVja2luZyBpcyBkaWZmZXJlbnQgZnJvbSB0aGUgY3VycmVudCBjaGFpbiBvcg0KPiB0aGVyZSdz
IGEgYnVuY2ggb2YgbW91bnRzIGFsb25nIHRoZSB3YXkuIA0KPiANCj4gSW1obywgdGhhdCBkZ2V0
X3BhcmVudCgpIHRoaW5nIGp1c3QgZW5jb3VyYWdlcyB2ZXJ5IGJhZGx5IHdyaXR0ZW4gYnBmDQo+
IExTTSBwcm9ncmFtcy4gVGhhdCdzIGNlcnRhaW5seSBub3QgYW4gaW50ZXJmYWNlIHdlIHdhbnQg
dG8gZXhwb3NlLg0KPiANCj4+IEFsc28sIHdlIGRvbid0IGhhdmUgYSBicGZfZ2V0X2lub2RlX3hh
dHRyKCkgeWV0LiBJIGd1ZXNzIHdlIHdpbGwgbmVlZA0KPj4gaXQgZm9yIHRoZSBzZWN1cml0eV9p
bm9kZV9wZXJtaXNzaW9uIGFwcHJvYWNoLiBJZiB3ZSBhZ3JlZSB0aGF0J3MgYQ0KPiANCj4gWWVz
LCB0aGF0J3MgZmluZS4NCj4gDQo+IFlvdSBhbHNvIG5lZWQgdG8gZW5zdXJlIHRoYXQgeW91J3Jl
IG9ubHkgcmVhZGluZyB1c2VyLiogeGF0dHJzLiBJIGtub3cNCj4geW91IGFscmVhZHkgZG8gdGhh
dCBmb3IgYnBmX2dldF9maWxlX3hhdHRyKCkgYnV0IHRoaXMgaGVscGVyIG5lZWRzIHRoZQ0KPiBz
YW1lIHRyZWF0bWVudC4NCg0KU291bmRzIGdvb2QuIGJwZl9nZXRfaW5vZGVfeGF0dHIoKSB3b3Vs
ZCBiZSBhIHZlcnkgdXNlZnVsIGtmdW5jLiBMZXQncw0KYWRkIHRoYXQuIA0KDQo+IA0KPiBBbmQg
eW91IG5lZWQgdG8gZm9yY2UgYSBkcm9wLW91dCBvZiBSQ1UgcGF0aCBsb29rdXAgYnR3IGJlY2F1
c2UgeW91J3JlDQo+IGFsbW9zdCBkZWZpbml0ZWx5IGdvaW5nIHRvIGJsb2NrIHdoZW4geW91IGNo
ZWNrIHRoZSB4YXR0ci4NCg0KV2Ugb25seSBhbGxvdyB4YXR0ciBsb29rIHVwIGZyb20gc2xlZXBh
YmxlIGNvbnRleHQuIA0KDQo+IA0KPj4gYmV0dGVyIGFwcHJvYWNoLCBJIG1vcmUgdGhhbiBoYXBw
eSB0byBpbXBsZW1lbnQgaXQgdGhhdCB3YXkuIEluIGZhY3QsDQo+PiBJIHRoaW5rIHdlIHdpbGwg
ZXZlbnR1YWxseSBuZWVkIGJvdGggYnBmX2dldF9pbm9kZV94YXR0cigpIGFuZCANCj4+IGJwZl9n
ZXRfZGVudHJ5X3hhdHRyKCkuDQo+IA0KPiBJJ20gbm90IHN1cmUgYWJvdXQgdGhhdCBiZWNhdXNl
IGl0J3Mgcm95YWxseSBhbm5veWluZyBpbiB0aGUgZmlyc3QgcGxhY2UNCj4gdGhhdCB3ZSBoYXZl
IHRvIGRlbnRyeSBhbmQgaW5vZGUgc2VwYXJhdGVseSBpbiB0aGUgeGF0dHIgaGFuZGxlcnMNCj4g
YmVjYXVzZSBMU01zIHNvbWV0aW1lcyBjYWxsIHRoZW0gZnJvbSBhIGxvY2F0aW9uIHdoZW4gdGhl
IGRlbnRyeSBhbmQNCj4gaW5vZGUgYXJlbid0IHlldCBmdXNlZCB0b2dldGhlci4gVGhlIGRlbnRy
eSBpcyB0aGUgd3JvbmcgZGF0YSBzdHJ1Y3R1cmUNCj4gdG8gY2FyZSBhYm91dCBoZXJlLg0KDQpU
aGFua3MsDQpTb25nDQoNCg==


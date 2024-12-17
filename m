Return-Path: <linux-fsdevel+bounces-37668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A22AD9F593E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 23:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2ACC7A2706
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 22:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DA31F8926;
	Tue, 17 Dec 2024 22:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="cqFVyDdX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CD01D5159;
	Tue, 17 Dec 2024 22:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734473077; cv=fail; b=OIxalkKKOcXyfVbhKvsaedD4cxgF9fgcDV8BtBZWRvBtxVZlcPPp+QZnZfsLw25vmlZK7ELFc3zboxTeJ0Mvz4pFeWP93cdtWEx1zN+05MPmsmaIwnORJu+pyh3/ZAWjSVmftTir8jJVNlInE5tk9WNH+85fs0tgqUcKYi8j3lA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734473077; c=relaxed/simple;
	bh=Oi436Dj7bhZVo3zI+SRkJnYC9dp/XfZij3zm3kgM9CI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E/sL/iQ5qCZAG6ztUnZ2azXn51qdTalNyp6MMy5HdRgzZCKxdDcAxiM+eRWC9t3KyoTwDk47aXwX4+wz5qP5KUQtU0HV+GY3OHCfc/4QhmkawuxDbMx8G/lYZtSwRsa6SIiZiUmYIz0qsjGGvB9Sol9YM2ZT7qFkdO1jn+AJDh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=cqFVyDdX; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHIAZbX030299;
	Tue, 17 Dec 2024 14:04:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=Oi436Dj7bhZVo3zI+SRkJnYC9dp/XfZij3zm3kgM9CI=; b=
	cqFVyDdXbjkV8yz992GGDFJpZb47ogWvbWg9L187lEoWYVoCS+8pScaJwMrtqThq
	6uJBelWivks1aSclGNVPZDLAFC8y/CJjpYEos2jSHx+EonrJWT446SebYvWSDbU5
	wb7WU/B0MM3KkSLQQuPN8YWLmvyYoay0mJBSdY8Yi+XJZ9Ify27RKqjLOUO1qQ1C
	A/crtOHCQgwYqP8jN9lfOUKByWGDrW4vD5ohNzxIfTf8ODXcRShbB/jhrBChf0n3
	f5IoUmTcTVycq9nCpyoUd7YA/WlFbQtgrSAm9sbxHoSgHyd5LzrLQg52nkI+H8Ok
	OPPMnF2T9hDUgmJaYYUoUA==
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2046.outbound.protection.outlook.com [104.47.51.46])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 43kebe9mn6-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 14:04:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pD9rbINU/6BPX+IHRgoDqsuRuCQ771DOaCT6V2CHLi3vT58LFb5JL/qlHqENIkCPZ627Z+3ePYbz7MgtzOgWioCrs1fo8cK8edLxsEpOdmoRth1iQ6mA0Qq5Tfx8FjfiM4KfdXkDqbOeYW/uQGuejiJ1fwDA7SvjAQk+1w+HTtz6c05hWNWuuFIL9+ll13KPDEN3KWQdVLv5s8FU404efq46voqGWj/KiC1D0w/vr6z1M0g5m3BBpNITfExG+jyALUiOqfq1jrfO5zz7gjaPk/c67VI4q/WuuAa5FkIaCXXJjOmyog+9F0VahbTPCBHI5RbfdpJGSKvOatDqsURyQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oi436Dj7bhZVo3zI+SRkJnYC9dp/XfZij3zm3kgM9CI=;
 b=Qf1j+PLGCshR2RAMHnVk3WHqS3CKTExRcuP7agO+tBDB6c5cxod9BzIyLKmZsEHqCeVh0AGkcP8JFx4lj5vA0Ug3OzpeOHRyEFVGM04cRJ39NgGwuooWk1Q1qmo/2nkXW94ETaTP0PpcjL+hS2PaNyBHSYKudACDX85eRzj0gGPwcstoosbIzysEiWm5Wed2Zq+mbOwV9umxkJjPP3t2A/9V9PMLJBpjjaKA07rH4CwS58PecXudj3e/FekH4KF8vJOP5M6aFMPQh7Y+erg4zWXvpGPk8cOVzDNBaNgJOs6yi/JuBV9P5NmX+lzIp/TqTYxkO0QPHENWRh9HJokYUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB4724.namprd15.prod.outlook.com (2603:10b6:806:19f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 22:04:12 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%7]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 22:04:12 +0000
From: Song Liu <songliubraving@meta.com>
To: Paul Moore <paul@paul-moore.com>
CC: Casey Schaufler <casey@schaufler-ca.com>, Song Liu <song@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "roberto.sassu@huawei.com"
	<roberto.sassu@huawei.com>,
        "dmitry.kasatkin@gmail.com"
	<dmitry.kasatkin@gmail.com>,
        "eric.snowberg@oracle.com"
	<eric.snowberg@oracle.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        Kernel Team <kernel-team@meta.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: [RFC 0/2] ima: evm: Add kernel cmdline options to disable IMA/EVM
Thread-Topic: [RFC 0/2] ima: evm: Add kernel cmdline options to disable
 IMA/EVM
Thread-Index: AQHbUMHZ/pEEoDutDkiUOsUV91UKILLq8+2AgAAIjYCAAAEqgA==
Date: Tue, 17 Dec 2024 22:04:12 +0000
Message-ID: <8FCA52F6-F9AB-473F-AC9E-73D2F74AA02E@fb.com>
References: <20241217202525.1802109-1-song@kernel.org>
 <fc60313a-67b3-4889-b1a6-ba2673b1a67d@schaufler-ca.com>
 <CAHC9VhTAJQJ1zh0EZY6aj2Pv=eMWJgTHm20sh_j9Z4NkX_ga=g@mail.gmail.com>
In-Reply-To:
 <CAHC9VhTAJQJ1zh0EZY6aj2Pv=eMWJgTHm20sh_j9Z4NkX_ga=g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.200.121)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|SA1PR15MB4724:EE_
x-ms-office365-filtering-correlation-id: 3c3c07cc-7aa7-4528-fd19-08dd1ee6bd3e
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Mm9HZDNLQjhyeFFZUWFSNGM5M0tKZmpQMTdYODg4Z3lCemF2V3FuaDcwc0RT?=
 =?utf-8?B?a0QwbytJczVoY2R6eGpGV0N6Um1qQ2hjbEMveHNvSkRFTDUydmhIcTFZUzFE?=
 =?utf-8?B?NWsyeG5OdUFSWk1FaStSa01hQzV6R0VXWUtTTDFDbE5seTRpdTJwQTJCRmEy?=
 =?utf-8?B?VlRKUUpLSW53c2Nwb3F6c1MxaldRUzRSdkNkNU8yNitUR2JqSkZiRWxyRHIv?=
 =?utf-8?B?SG45dFllUWNxU1RXUE45RzlZN2dsNjRjMzdOSmQyakdWeHdHRmxISFVyMk1S?=
 =?utf-8?B?MkZZOTh3Q3dJaUlXMHJLcjFWR2NSTCtUdUtnWnZIakdwWTl6bXM3ZjB1Q2JL?=
 =?utf-8?B?QmhFZUUyUEkzM2NDc2xFWGxmM3lrOG90Zy9nZHNsNCtTN0d3ZktRMGJ4bWpp?=
 =?utf-8?B?UmZQVXI0ZU5nU29yZDB0RnRKQW5yd29hL0huSXBPbW5taU1vN3RsRmp6dllo?=
 =?utf-8?B?bUZ1UHpQaVQ2Y0NJWG1SMWx0ZWxrWDl2TFJxVUl6YXZIbFFET0JSMGMraVdv?=
 =?utf-8?B?cVdWWlhFZ3V6djdlMUNSL29Malg4UTA4NnB2c2MyeEs2ejcyRXRPc2wrNkEx?=
 =?utf-8?B?TkdUbDhkL1NLalZZWHcvTy9iTlFJS25NLzRMcTYwZmRRZjZDMVk3V3B2N0tX?=
 =?utf-8?B?K2huWWFiYktVbmVYcjdYTGF4a1lCL1NaajBBaFdia3FJaWtOTk5tMEFmMkZs?=
 =?utf-8?B?cml6aUR1Y0I1SVRBMXFKT0tKUWxMcWw4eU9BenhzcXVsOEpCWWdYTmRydk8v?=
 =?utf-8?B?dHV3SStLVUVpUGl4bG1EKytKaWlrSlhGc04zUGp5SkVlUzVGU0V6NHowblJk?=
 =?utf-8?B?SzEzdHVEdE9xbUQzMjVDcTdDWUdDNCtLem1sdmpMN25hVlJjYWNFUU52eTdj?=
 =?utf-8?B?UXVzTXdpRGlQNVhxUDljNnJ4U1owUHBCdUQybkkzblBOcmQxUVdITSs1eXVX?=
 =?utf-8?B?Vjl2OXNTeVhKbHhpaXUyRmVENFY2TVBKUlY1dlIxdmFiV1gzb3ljb1RPZEpO?=
 =?utf-8?B?MVlZZ25PUnpVMDVsWnhiTUhlcXI1Z2Q3SDBNYTFsTk1LL2hCTDRtdFR5eUh5?=
 =?utf-8?B?Ulh0Yk5HSVErL2tqMFVWSSs0M1J6UC9ZNkErT25aR0RUS3hwUmtQQ3pJeXJx?=
 =?utf-8?B?YUJadEVuR1NZdnFJR29lNDkrZi9MNVlHcThNV1R0RC8xaE1panVYQVRNeHpP?=
 =?utf-8?B?SGlmbk9EYWZaMFc4cnFtTlVCeVl2WmdDazNBLzBPTjBydStSWWZ4NFh6V2VI?=
 =?utf-8?B?Y05NL1FpVUhOYVlQU0pjY01IR0VsRWdML0wrbWZYNnkzUVFKMU1leU8zc1dl?=
 =?utf-8?B?emNZYkZxNTVDR3ZCNUl5U2xEbUFYcmdxWXhHV1NKQk5XcVQxK1JIdnAwdTgy?=
 =?utf-8?B?TFFZQWJXTk5lNndUNUFJakJVT2VGek5WU3hCTlRvRjZzYjZQaUhIVUNsQWtv?=
 =?utf-8?B?T0RWTUk4ZTNnWHRhMDVtbUQ5TE1WNktKeHlwSjkxTHBqRnJDSGE4Rlh6dU12?=
 =?utf-8?B?NC9Tdm9LcW1NZlB6eU1sMVRRZEZ2TmdlQ2Y1aGxFaWN1UUlwTy9BQkJKYUd2?=
 =?utf-8?B?NUN6aTdCZ1ZMQUZMWU12cEdsa0tLWG5oUG1XOER1ZXp1ckpSRXFkNjhQNUJ4?=
 =?utf-8?B?U2VIWmtBRTVvcjMvUzIyRGNidStxYi94K0dlaWY5c3NvUFFEQkFhNFJkREVP?=
 =?utf-8?B?UUJRYUlXTUVJNXFQUE5OWVBhZ1FkTU4yVHVlM3dyN01vbWtTYktSZnY3d2VF?=
 =?utf-8?B?NGlHcHJlZ1NYd0U5WkkycDk3amE1RnVodW1wem5PV2szVmZMd0tlWjN0UGZh?=
 =?utf-8?B?dXhGMFArTkdMaVVCRTJIU3dQNE80TnBIdWtZU1NpRmkvUWVQUk8xQWdqb25H?=
 =?utf-8?B?ZXlWK05rUGVVaS9QNDFWRlpKZThkbE4yUy8xTHNuY1BtSU0xMlVLWDlXVTAr?=
 =?utf-8?Q?5bywZJlC7e88ygicwwa5Uiz8Kl7v4ciO?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bFM1WEl2T2hRM0plZ0xvT1JCR3ZkVTlobHpCN1Y3K09HRWxkayt5UzZpNHFG?=
 =?utf-8?B?eEdLc0JLMlMyVkFJeFhMOUZ4SzhoM3VJU01UVW9zZlAxMDJ6K0pYWktRaCtl?=
 =?utf-8?B?bmsyd0tLWmdza3lDRnBaQ09DNW5PLzRlalBmcmJiTDJzWGhrNjJsNWJTa3No?=
 =?utf-8?B?UVdQYktkcFE3b1JLN2ZMRlpZbzBpSTRuaERBTjhHKzFHVlBxUUI0R2c5MytS?=
 =?utf-8?B?TUN1ZXVjOUhDVEIrbmpjWWR1VFdXNUVkZ3pjS2xWMWdQcWI3REd6ODN1YzdU?=
 =?utf-8?B?UGlXV0kzaXVPVllWWHovaklqdTdRL0tDNEJ0L0x3T1F5VzlTL3ZiNlhkeDdT?=
 =?utf-8?B?WitpaGlSVTN6ejZFb1FYQnEyZlJjWXF1TkV1ZUpFQnl4VkZzL0ZrUUZ3VVZ3?=
 =?utf-8?B?TTFjUllGZ2JOMU1hZnY0azdoQTJ4MVgzME5zTGhXL3hpOWVNYlVpY1FMTWVj?=
 =?utf-8?B?YWF4bUVRS3hqZ3Y0S25lbTh0V1RkTm51Y2ttcVlyaGFTREw1TVdxaDJTZ3dX?=
 =?utf-8?B?ZlQyUlQ3WDVRN2ZKSGM2bkhTSUpTbEkzaWN5S3BJUWJPc1BQWStxWU01TGVD?=
 =?utf-8?B?N3h3a01BNjk4WVZsV2Q1blM5ZTYyTkZ4SHEwb1NFYmtaTURxQUx1RnoySFlw?=
 =?utf-8?B?aG1lTHFCcFp0a0YrQWlnQkt6R09HSyt3KzFmcU5OZzByUGpmaWc5MnFBODll?=
 =?utf-8?B?TFNaRTk4UVNwSTVLK21jOFhIdVNFeHFubGRON0d3cFdaT3BtaERxNDBKVWZq?=
 =?utf-8?B?WTVnSmFWaXh4a0pqbm91dzlzOUJrY0k4OHZkeTFTYVF1ODhJMWJVR0FEdU9P?=
 =?utf-8?B?Y2FvR09icmRmaXNUSjB5VmM1ME43bm5tWC9xNXpKRWZoTmRTc1Rrc0ZIZEM3?=
 =?utf-8?B?UUNWNVdIK2RkbXJpc2dWSFRNVlFYK2M5SXdhZ0xhTXN0MkxuT1RwUXVFazhY?=
 =?utf-8?B?WUUrdk5VVzNyL0xHREdHZnBHRHI4UTR0SDZaMS84Q0pZRjU0aldHQWZ0VWZX?=
 =?utf-8?B?a0FaTlJrbzhFWlBUMk0wWXRqMFFFZHgwMWcxQ2RLcUNkVVRuc2t0d0J5Skow?=
 =?utf-8?B?S2ViMlREMnd6V1VTaUpjNVNkWGJYTlBWSDE2T1YzZ2NEenZsSmJYdTBBcHB2?=
 =?utf-8?B?cGFvdlZOTHg5aEpZUDIzOVpzb21hM2NXdGRuKzFOMlRuaXdJZkRER0lYVGJl?=
 =?utf-8?B?VUlhSkNqdGJ6bkJaR0hWZUpSaloycjNRSUt3TnFDUDJBR29CdmNpN3J3S2ho?=
 =?utf-8?B?Tm9XR0xJekNsWEJJdS9qRVpNdXpxbkw5NFhXSTJ6aDFWMCtOVVdPNDlGZSsx?=
 =?utf-8?B?VEsreGRzYTN3aU9hWlJPSXhuUisydXFRL1E0dTNkKzBoU0FTYmVnSkJtSld1?=
 =?utf-8?B?L2w2RTcybk1BUG92Nk9XdUNKek5EQUcwVHF6VG9ieGtyUDVjZm84bk41amZt?=
 =?utf-8?B?dlcrZWRMN1J6dE9oWUQ3WWtSQTkzbDhYLzl0MGtydTVaTElGTWt2U1lQcU8r?=
 =?utf-8?B?ZmEwY2tsOXdYV1MyYjZ1aWp3ci9UUmF5My9TU0Ivd05jZ0pTK1o4NDlHSWsy?=
 =?utf-8?B?WjR4QXJQeGNuVzE1NkRFTmRiMlBwcmpIRldRZ2ZESDhmK0tscjdBWEJYRXJE?=
 =?utf-8?B?L2d1SjQ2eU9WNGxqb2ZIMmdlNnZsYmIzbmdyYjhvb3ZJdll3R1RJVk5oS2N1?=
 =?utf-8?B?TnZNdUVDTVZmcXovazBscGVDd2R6RXpvUEkxL2RyUHNad1N4SmdGd0tjUjh3?=
 =?utf-8?B?eDBEUXFLcHdoK0RRRjhKUE5iOGRNSTIxZHBuejNQaEU5Wk03UDdSeEV1dWEv?=
 =?utf-8?B?YlZScUhPM3FrdTlBN0pJcUtUendqY01MckJjcXMzck5zTzhVeXZ2L245N2I0?=
 =?utf-8?B?RDYyWHVTTFl5N1UrODdPNk9VTCtGYlF5SVJpVUJianAvdks1U0hOTzhJZHVU?=
 =?utf-8?B?alluNFJybEE0U2lOZ1owQUpuMXdLZkZiVFRFS040TER3cGYvb3Q4Zzl1aVVw?=
 =?utf-8?B?MW1OZDdGdHNFNlhoMUt3WTlsVDVESk02cjhoS2lkR2RhdWE2L1dkUHJ3RkFC?=
 =?utf-8?B?SW1XT3g2bk9Na0lWcjg3K1ExYkF1OEhPZG1ZcUQ5WEY1SkpiaWtYOGdYUzNT?=
 =?utf-8?B?NXJzVXJlYnN4Qm9hUFg0T0ZOa09qRlg3UGFoRGdKeDA2RXpzNmRudXVlblRz?=
 =?utf-8?Q?QGcSiZd+c7DBFOrHJI4TCGM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <662BC26BA1F398408329DDE7F1B8EDCE@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c3c07cc-7aa7-4528-fd19-08dd1ee6bd3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2024 22:04:12.2176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YzxmWcSMoQhlUsVCQm7ksmv5P6fx7l4cRGAFY+LCyV991BPKDBtAxvAvfr47I37SCj6vHg8lXQiWTEUiL2AZzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4724
X-Proofpoint-GUID: zG_P3laoDMYon-5o2N-L5EdPNdJpbzaw
X-Proofpoint-ORIG-GUID: zG_P3laoDMYon-5o2N-L5EdPNdJpbzaw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

DQoNCj4gT24gRGVjIDE3LCAyMDI0LCBhdCAxOjU54oCvUE0sIFBhdWwgTW9vcmUgPHBhdWxAcGF1
bC1tb29yZS5jb20+IHdyb3RlOg0KPiANCj4gT24gVHVlLCBEZWMgMTcsIDIwMjQgYXQgNDoyOeKA
r1BNIENhc2V5IFNjaGF1ZmxlciA8Y2FzZXlAc2NoYXVmbGVyLWNhLmNvbT4gd3JvdGU6DQo+PiBP
biAxMi8xNy8yMDI0IDEyOjI1IFBNLCBTb25nIExpdSB3cm90ZToNCj4+PiBXaGlsZSByZWFkaW5n
IGFuZCB0ZXN0aW5nIExTTSBjb2RlLCBJIGZvdW5kIElNQS9FVk0gY29uc3VtZSBwZXIgaW5vZGUN
Cj4+PiBzdG9yYWdlIGV2ZW4gd2hlbiB0aGV5IGFyZSBub3QgaW4gdXNlLiBBZGQgb3B0aW9ucyB0
byBkaWFibGUgdGhlbSBpbg0KPj4+IGtlcm5lbCBjb21tYW5kIGxpbmUuIFRoZSBsb2dpYyBhbmQg
c3ludGF4IGlzIG1vc3RseSBib3Jyb3dlZCBmcm9tIGFuDQo+Pj4gb2xkIHNlcmlvdXMgWzFdLg0K
Pj4gDQo+PiBXaHkgbm90IG9taXQgaW1hIGFuZCBldm0gZnJvbSB0aGUgbHNtPSBwYXJhbWV0ZXI/
DQo+IA0KPiBFeGFjdGx5LiAgSGVyZSBpcyBhIGxpbmsgdG8gdGhlIGtlcm5lbCBkb2N1bWVudGF0
aW9uIGlmIGFueW9uZSBpcw0KPiBpbnRlcmVzdGVkIChzZWFyY2ggZm9yICJsc20iKToNCj4gDQo+
IGh0dHBzOi8vZG9jcy5rZXJuZWwub3JnL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLmh0
bWwNCj4gDQo+IEl0IGlzIHdvcnRoIG1lbnRpb25pbmcgdGhhdCB0aGlzIHdvcmtzIGZvciBhbGwg
dGhlIExTTXMuDQoNCkkgZ3Vlc3MgdGhpcyBpcyBhIGJ1ZyB0aGF0IGltYSBhbmQgZXZtIGRvIGNh
bm5vdCBiZSBkaXNhYmxlZA0KYnkgKG5vdCBiZWluZyBhZGQgdG8pIGxzbT0gcGFyYW1ldGVyPw0K
DQpUaGFua3MsDQpTb25nDQoNCg0KPiANCj4+PiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGttbC9jb3Zlci4xMzk4MjU5NjM4LmdpdC5kLmthc2F0a2luQHNhbXN1bmcuY29tLw0KPj4+IA0K
Pj4+IFNvbmcgTGl1ICgyKToNCj4+PiAgaW1hOiBBZGQga2VybmVsIHBhcmFtZXRlciB0byBkaXNh
YmxlIElNQQ0KPj4+ICBldm06IEFkZCBrZXJuZWwgcGFyYW1ldGVyIHRvIGRpc2FibGUgRVZNDQo+
Pj4gDQo+Pj4gc2VjdXJpdHkvaW50ZWdyaXR5L2V2bS9ldm0uaCAgICAgICB8ICA2ICsrKysrKw0K
Pj4+IHNlY3VyaXR5L2ludGVncml0eS9ldm0vZXZtX21haW4uYyAgfCAyMiArKysrKysrKysrKysr
Ky0tLS0tLS0tDQo+Pj4gc2VjdXJpdHkvaW50ZWdyaXR5L2V2bS9ldm1fc2VjZnMuYyB8ICAzICsr
LQ0KPj4+IHNlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX21haW4uYyAgfCAxMyArKysrKysrKysr
KysrDQo+Pj4gNCBmaWxlcyBjaGFuZ2VkLCAzNSBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygt
KQ0KPj4+IA0KPj4+IC0tDQo+Pj4gMi40My41DQo+IA0KPiAtLSANCj4gcGF1bC1tb29yZS5jb20N
Cg0K


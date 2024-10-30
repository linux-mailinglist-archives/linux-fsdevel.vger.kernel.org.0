Return-Path: <linux-fsdevel+bounces-33299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 009AB9B6DFE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 21:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4BF12829C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 20:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230F8205AC7;
	Wed, 30 Oct 2024 20:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="JDgGu2uf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681C119CC24;
	Wed, 30 Oct 2024 20:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730321077; cv=fail; b=SNunX1/Yk1ttMVsQ1AuIxEZ57RKEwl6+3n7ZHZMGHWIH0gPD88tiVHY1rddLQWO71g/rS1VPXsGLwDUcsx8cl1RE170iVq392GK9WHHo5lSlO686z8keN/S1wUZip3fnqKdY5qmG51sWDAVbWuR/o9UXIufUR9h1XUygrOAbEyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730321077; c=relaxed/simple;
	bh=sF/cYQxy7pHH/XIJsY7l7+WHrt7vaIVfMZBV3kZDWiM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ALMv+hc5m/5aSo0f1hoiy8ROa6RMhou+VWZskHTFvf+IcQpk4LyOWvTW4hkN/1vd4/4yqbMLzY4cK8PvgMh61jnPhekeMdt3d4gTszuYrzDAVGhjWrQs3laumFhugGmt0zpPXVHGo5h/0mAthqq538WszZ/oaPWg8zg2Jycva2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=JDgGu2uf; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49UJJHuM023193;
	Wed, 30 Oct 2024 13:44:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=sF/cYQxy7pHH/XIJsY7l7+WHrt7vaIVfMZBV3kZDWiM=; b=
	JDgGu2ufOOI/890iY37rCYa2Hu8R0b9ywP3C/pfFxkpoDGvo8PdFqiTM5flBJF5m
	7PYb1qMMcrJBa8C9UJmVulT4MCfaLOhyvCDSQO+o4P8w2fkkzgcAiPBg+3Gz7V6M
	c3W1pc6/TrBrbBc2sHed6ttCRFvPR672euUlo9NWOMreO0SxfPZ/YKzHaFSi5OCh
	BtAOqIcBw7b9l9WYuC1RbhE6HrhJVFZJNK1xBH4OoeYRyPStAyKCaTsJ3XGIf3Nr
	X6U4lph7wuSlF3FdhgzDECFkHRlPHwim5KkVBzPz6iNla3IGKXoNzfZzpj08ZoPV
	OsWiJYRO5CQZkzEVIszGNQ==
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42krwy29qs-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 13:44:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=prPenLyCFE2Y7Q2pBOkSuvioapFvtQfI6OLtGQkrQBf9F9nG/FRQv3atLaLRkf1c59e46AcdtA+9ONqhksHaEXo20GnK74E/CdNAKmObfJ7ZKKxcdCInQK8vGoX4cAcM9RfZAXUsDgFjRTzrahb5jYoKGJy+I3l2vwr37xAY7RBwHgjV8XqvEpyldz0wwQkcnH/n9SmC7PYwRPjhUcmxcRNKA9lCVX4Z+YgqONT0Q+EMCLbRkbGIyrrNokn4oJxp/rfceM7l+qPAxCqA/TGNcv0mGA+BwyPqQbCnvc2EkD5ETHgGhXe8aZ4w/ffGlo8DfMBnjUOA4cSMjvROc37yug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sF/cYQxy7pHH/XIJsY7l7+WHrt7vaIVfMZBV3kZDWiM=;
 b=Nua5M/wdZK9I8QJwnTI7m6+M9em2NxFHuSN+PaCq/lVu6AxR+o6/xQ9Ho4R0H69JZDazMQFKL6Kou49mUS91NLz3BxGSbQ0LSbthoSoDxV74rbBMf2XulpYGv5U3ylaZZ1Nh+s1NFjVQT6WIJkrIPPDC2uhAC+59ksVcKBoFTpMItJB9PzNeD68Hrh/fcwSt3ArXY9OQ/vsnlE1fVzc/7ZSfwIOXBLUglv7ZE36ldFfxkUXp8nc/QjAaziW3ufmBT2MZ/185LTSmHiMkUwUQJwDoq+TmUZXZQpqhBzIT4hCpn4hRXC8hyXBZqJqiMToAiAAI3HriFoBJ4ttGtYWHKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SN7PR15MB5682.namprd15.prod.outlook.com (2603:10b6:806:349::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Wed, 30 Oct
 2024 20:44:26 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%3]) with mapi id 15.20.8093.025; Wed, 30 Oct 2024
 20:44:26 +0000
From: Song Liu <songliubraving@meta.com>
To: Christoph Hellwig <hch@infradead.org>
CC: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Song Liu
	<songliubraving@meta.com>, Song Liu <song@kernel.org>,
        bpf
	<bpf@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML
	<linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        Andrii
 Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Alexei
 Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin
 KaFai Lau <martin.lau@linux.dev>,
        Al Viro <viro@zeniv.linux.org.uk>, KP Singh
	<kpsingh@kernel.org>,
        Matt Bobrowski <mattbobrowski@google.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Extend test fs_kfuncs to
 cover security.bpf xattr names
Thread-Topic: [PATCH bpf-next 2/2] selftests/bpf: Extend test fs_kfuncs to
 cover security.bpf xattr names
Thread-Index:
 AQHbFRSqQ+6V3A7WhE2nOTZ+DtSM+rKHVfgAgAAEFACAAAEygIAAB0MAgAIYdICAABCugIABlcCAgAYtkQCAArUZgIAL6sEA
Date: Wed, 30 Oct 2024 20:44:26 +0000
Message-ID: <41CA4718-EE8E-499B-AC3C-E22C311035E7@fb.com>
References: <20241002214637.3625277-1-song@kernel.org>
 <20241002214637.3625277-3-song@kernel.org> <Zw34dAaqA5tR6mHN@infradead.org>
 <0DB83868-0049-40E3-8E62-0D8D913CB9CB@fb.com>
 <Zw384bed3yVgZpoc@infradead.org>
 <BF0CD913-B067-4105-88C2-B068431EE9E5@fb.com>
 <20241016135155.otibqwcyqczxt26f@quack3>
 <20241016-luxus-winkt-4676cfdf25ff@brauner> <ZxEnV353YshfkmXe@infradead.org>
 <20241021-ausgleichen-wesen-3d3ae116f742@brauner>
 <ZxibdxIjfaHOpGJn@infradead.org>
In-Reply-To: <ZxibdxIjfaHOpGJn@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|SN7PR15MB5682:EE_
x-ms-office365-filtering-correlation-id: 6469a87d-3a7c-4a91-3543-08dcf923a505
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UFRzWjRaUmNvcldhRno4ZHBmS1NCTTVWNW9ON1J0cFJXYVlYV1VMdk9rQytD?=
 =?utf-8?B?YU1GRjVyMWVQbW9rSEVWZlprWjdWUkgxS3V4RHFHRkQxWWN0ODhPbzVvRzVY?=
 =?utf-8?B?N1dWSVVSc1owYU9WUnVBck1XUkxaSC9TNFNPUitZVHluM0ZmVFBBbFBXRjZp?=
 =?utf-8?B?TUpLVzdmMFl4d2lWMzlqbUQ0ZjNEZndXOEoxbFArRG9hRDZOajlVS0s4ZTdC?=
 =?utf-8?B?cnI5YkI0eUk1L254d1JDdGgrc1pYOHpjd3JFR3crOUNBQmphUWRwQXgzNEtI?=
 =?utf-8?B?d0lPRndaMlE1Sys3VklrRUtiMGgrSEhxZDlxbFVJcHpicFdkanBGWFBxbWp5?=
 =?utf-8?B?UmRhdHdlYStpR3hBR1BWQXRIYVVhSzl4c0JqNFZrT3BndmlRb1hkUmJmcWlL?=
 =?utf-8?B?WStlckQxdjd2SVA2UUt2enVjMm54bmdwQUJUcmxuMjVtWWpkV2R6RWtRZGlN?=
 =?utf-8?B?YlFLczFrQ3hWaWh2VlA1YU9XdEZoTGZVL2xoazZJN0xJcnlJckFpR2I2UEFq?=
 =?utf-8?B?ejM4Q0NqMWM4ZTd3SDZaOHJhMDlram5zQUtJWEh3RkNjMkFQVTN0VWpHY0VL?=
 =?utf-8?B?YlNmWVo2MWxOY2w2ald3S2JrVGl6QUhxemwwVXJmd0VuZXZZb3I2aENaaWlp?=
 =?utf-8?B?UzhxRW1Tbk84aTBSdmVRVDlaaDN4SFdNTWtVZDlPU0pIUHFOUU5WQ3h3VFl3?=
 =?utf-8?B?aDQ1RERTOHgvd0lCeWkweDEyZDMxeUZKeTJWaU9odVBMa1FQU29ZdXZ6bnRt?=
 =?utf-8?B?VG1iTTBjWWphK3gzb3A2dEJkUVl1R2VpUEpxY1dzNDVqbmRNZU1rbGFicWZJ?=
 =?utf-8?B?KzRpT05qTDI3V1habUhkNkRML0dFbTFOcjdVQjFyL0VOVVgvN3AvRTRqZk9P?=
 =?utf-8?B?UkdUM25tT3pUNVdzM0lYdzNOb1FvczRJMnRYVDlWeWhKYjVIcVkwZWxodGJT?=
 =?utf-8?B?OHdVaFMyMzdZQ1ViNFZ2SDMrbTlPMVdRMHhEVkRWa0RIVjQweUF3Y3BiaE1T?=
 =?utf-8?B?c1BCSUM1cjQzQ3JwTUZITXRvUTJGWjNINzBHZWdpQUNaWmhCYXR6Z3hWNTZp?=
 =?utf-8?B?dmRwejF6aUFpNURPOGtmTG1uL2dhbmpHK1k4TmprTThXRUh3NDV2dGE2Mzc2?=
 =?utf-8?B?aHhwMjNVWnFka3lEblFmdkZqRlprdS9ta2JBU2I4Zm9oV05PemNaRC83Ymwz?=
 =?utf-8?B?SzhxSGU1SjNXZHBkWHZwOVVVRkRPQWxvZlpGSzdmS0RjVGt1UFRkOVVJN2wx?=
 =?utf-8?B?aGcvTWJRZnZGNElQdGFMZk1hU05OMVdOYS8zazNGakRTcVRaRDliMnRSbTJO?=
 =?utf-8?B?RnhjMVZuRWhKU2pmaW1SSDhuTHNmSUI3ZFV0MTVUbjNJTnhQMVpVMENmdGln?=
 =?utf-8?B?OG8vVjE5N2VuYUxwUk04MUlMRnhMSllNT3cyYTFkbDEvVncvKysrbU5qbkla?=
 =?utf-8?B?RDVoZGIvUWZPRGVOL0g0RGpmcjZnWEdZV0pJSnJZZVBCZ1Y1RDlEMTRib3NZ?=
 =?utf-8?B?UStBU1c0VXk3NWRrOWIyaHhqb21aSmRNL3p3OExsdE8wS09NbUlDZlFxanlP?=
 =?utf-8?B?cXA0Um82ajRxVUs1WmZXMWNqeHVyZGxIWU9jWDlLWWV3eSsxRmM1cjhMUzBL?=
 =?utf-8?B?alpPc2NKbklCNE9kTjdzaXdnNkZ0c2tYekdyejBVQnB4QjFZdjc2Zk1sRHRZ?=
 =?utf-8?B?MElpYnlSRy9yTlpCNGtielkrMjRYUjlaYWcxQmxQQ2FvWGlmaG9ZMmNUV2p2?=
 =?utf-8?B?ZlpZWExQSjEvUForVXVrRVlaa1hWTVRZNThmUnI0bVAzOGxkU1E1ZXY4RDVi?=
 =?utf-8?Q?pa737Nwzy6vkeOGXaAy4oeZnY46BktWTOviV4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Ny9RdSt5a3h6YVBpVDhPOFZBOXRSN0JxOUN5bC9qMXdVenFoYk9KQjRzQ0JB?=
 =?utf-8?B?TFZEWnJwOVFGeWRHMVlqbkNXS2NtaGFGalVwcFhIRzdrVmZuM2JLL1R2ZVh1?=
 =?utf-8?B?N1BMWGwyNXJwY2lrY1ZpeVNLSEd1UStOcGlHWTdPYXMwRGxZN0RpSTN6aGxR?=
 =?utf-8?B?SXRhWFpCMmx4Z2dEOXY5RmtwKytOYStGZ3F4alpKcEd4aEpsUnhyZjZXaTdq?=
 =?utf-8?B?S1ZRZlJvUTV5UkVwSy9Hb1dXR3JaeTYvQjV4c1FZQTlYaUlxVnJvRjAzMXpo?=
 =?utf-8?B?NTNrVHpBUEFvdzZPNDFMZVlqMVU1dEFYOEZwSlVOcnpNTmIvRDByS01FenZG?=
 =?utf-8?B?UmR0SmVSMFNkMjBpQ08ybXZscmRTcUJDVWFYeXRGN1F5MEZ1MWM0RmRXVXB1?=
 =?utf-8?B?d21PUW43d21EQU81citMWG1NZ3dvcGxBcUZsYmdNNzl4dGtNM0lBajBhdFl6?=
 =?utf-8?B?RTJ2V3BLUERwS3VabVdlcjExVWdSMTVuN3dIZ0R6dUhPYkJTL09xT0RkWU45?=
 =?utf-8?B?NllJTENSSlBvbnQvRDhsMm5zUVR2OC9mUnM2UGlVenI5WVlMQm41YnFrZ2Jm?=
 =?utf-8?B?N25DdFRQaDNtcXdXS1RzRE9sVWRMMTI2dDEvMlZ3TEFqM2JhYzRXcXl5ZEdL?=
 =?utf-8?B?T1FVV043akEvZGVPeWdIeUw5aXVDTzdvTVk5cC9PUFRBSXFUVUltcUsxN0pR?=
 =?utf-8?B?NUNzOTZ5cUphb3ZnV21kZzc0cnM1dlZUVWJOb0NtbW5FanZQMmJUUGlHK2ZU?=
 =?utf-8?B?N3pCTFRTQkM1dGdtRk5DMU1NV3lTZWk4aVI0eTl1YndzREd4ZzZlM0VNdDB0?=
 =?utf-8?B?ZThURlJYU3RHS3I1WCtOakxxVU56VTNwSXZBSlBUdHNLNWl2NENJMmlTbmpK?=
 =?utf-8?B?eGpEOERzOVNwWGszMnpDS2Z5OCtmcmEra2lxYlB4NUFOcy9SeEJIRTBsVVpM?=
 =?utf-8?B?aDV1VmJOa2FLak1OeEYyQ3FCSWh3S0ZnZy9Cd0t2RWJDdXMwSzlSUW1zY0NE?=
 =?utf-8?B?VnczNmxMRmpxK0IybERTNEJJaTFqR1VlcmJTT2Urbk14WlU5TWNzTVBLalFh?=
 =?utf-8?B?bmlNZ3FORVRIM2pDK3ZqYTRPa0p0MUhpREVRNHNlaGJNVnFYc0ppNDV3Mnpo?=
 =?utf-8?B?L0M1Y3BBYWcrOGtnLzZyL0JwZlZyVjljeFBNQ1pzNG5pMjJaakFyY3NjQlNH?=
 =?utf-8?B?bGhuOE5BT3FLbi9TdytraDlwSG9KaXJER0hVT29oY3pSSDFQbkJGWHcwMElQ?=
 =?utf-8?B?YjJVTTR6aTBsMndnWUNKQ3lsV3BwRHROWmFURXlLWC81NnRqMC9nU0pOME1s?=
 =?utf-8?B?M3RGWVBIVWtrRzdXUXEzaDdYbHZoTUlzWURpU2syUy9QZzByZzRrR1V0OUZW?=
 =?utf-8?B?eFZIUEViK2xtRURyL1Fya0VFcVBDeFdpYVJJMnpLQ3JRakxva2JtbU1mRG1G?=
 =?utf-8?B?YUlFb2pxTmhPZXhVejIzUnFwSEhSOURWSFB0TmEvUWN5clMwQ0Q3djNtSFpo?=
 =?utf-8?B?ZFUyb29xNVNwb3VMY0RsYVVhNE5XQU0wUVprWWJocGdJdERMajJoRm9uMUc2?=
 =?utf-8?B?c2NDUDdQa2tTZG82a1h5RG5qbkgwMURmOUJ3TEpVOEY0MmZPZzgxNzVRZlox?=
 =?utf-8?B?QnJzUTVwOFFsT09iOHhhbmJadWx1bGtWcjVqck9HLzlEYVhyVEhEK3RsbTNN?=
 =?utf-8?B?aFpGbVJFVVFsVmhjSXYySWw4VVdIdUZ4MXd2MzFiYnYrNkVUV1hzNGxrZjlI?=
 =?utf-8?B?MURTa1BoNnJKZ042V1E2YVdXMjBKMUk1WWxpZEJQc2dJSHE0UWpDK3RtTU5P?=
 =?utf-8?B?YXBXTVM1NjNPWEU4U3lMck9uRHY1a1MxZU1Id3VtVWN2S1JKMERZczNWQmV3?=
 =?utf-8?B?RUpDSktXMlM1N0FLVXNCM2YySHRJdHlTUUU2T1RIUWpncUw3aXlUUlNmRkRw?=
 =?utf-8?B?L3JBa09OUzV6TWl5cnNCYk4za1RKQTRwajJZZnI3TGZjNFk3Yi9GMEtnQ2pB?=
 =?utf-8?B?aUlVakdhaHBvcVBZRmRqMy85cUJrZERTMW84QmUydFNqRzEzbXBGZGZVR0V3?=
 =?utf-8?B?TTFSVVlnNVo4K1N2SmJpSVpVcHN4NlVlR2NZTmFVVyt3cmJUbzZFMUlVVU9q?=
 =?utf-8?B?SWVXVURJVGpmdWppbXRsL0ZOZ3JiNWtEWWdTOEdVL0RYVVltNnRNQlpFbUVv?=
 =?utf-8?Q?BfcQK/hhN0doUwg9UcEBn0Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <11083035EE550D44A58ECF887E63CA12@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6469a87d-3a7c-4a91-3543-08dcf923a505
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 20:44:26.7014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +G718QH9IqVUDDk5bfbScatxdNYF3TJczDKtIrHiu+6HD6R80s6V5a+eFPSREDCS4XIydXZRXu8NmwM4bAotdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB5682
X-Proofpoint-ORIG-GUID: 7itC_elBgYbPEjDrwffiflEnKM-2WJB_
X-Proofpoint-GUID: 7itC_elBgYbPEjDrwffiflEnKM-2WJB_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

SGkgQ2hyaXN0b3BoLCANCg0KPiBPbiBPY3QgMjIsIDIwMjQsIGF0IDExOjQ14oCvUE0sIENocmlz
dG9waCBIZWxsd2lnIDxoY2hAaW5mcmFkZWFkLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBNb24sIE9j
dCAyMSwgMjAyNCBhdCAwMzoyNDozMFBNICswMjAwLCBDaHJpc3RpYW4gQnJhdW5lciB3cm90ZToN
Cj4+IE9uIFRodSwgT2N0IDE3LCAyMDI0IGF0IDA4OjAzOjUxQU0gLTA3MDAsIENocmlzdG9waCBI
ZWxsd2lnIHdyb3RlOg0KPj4+IE9uIFdlZCwgT2N0IDE2LCAyMDI0IGF0IDA0OjUxOjM3UE0gKzAy
MDAsIENocmlzdGlhbiBCcmF1bmVyIHdyb3RlOg0KPj4+Pj4gDQo+Pj4+PiBJIHRoaW5rIHRoYXQg
Z2V0dGluZyB1c2VyLiogeGF0dHJzIGZyb20gYnBmIGhvb2tzIGNhbiBzdGlsbCBiZSB1c2VmdWwg
Zm9yDQo+Pj4+PiBpbnRyb3NwZWN0aW9uIGFuZCBvdGhlciB0YXNrcyBzbyBJJ20gbm90IGNvbnZp
bmNlZCB3ZSBzaG91bGQgcmV2ZXJ0IHRoYXQNCj4+Pj4+IGZ1bmN0aW9uYWxpdHkgYnV0IG1heWJl
IGl0IGlzIHRvbyBlYXN5IHRvIG1pc3VzZT8gSSdtIG5vdCByZWFsbHkgZGVjaWRlZC4NCj4+Pj4g
DQo+Pj4+IFJlYWRpbmcgdXNlci4qIHhhdHRyIGlzIGZpbmUuIElmIGFuIExTTSBkZWNpZGVzIHRv
IGJ1aWx0IGEgc2VjdXJpdHkNCj4+Pj4gbW9kZWwgYXJvdW5kIGl0IHRoZW4gaW1obyB0aGF0J3Mg
dGhlaXIgYnVzaW5lc3MgYW5kIHNpbmNlIHRoYXQgaGFwcGVucw0KPj4+PiBpbiBvdXQtb2YtdHJl
ZSBMU00gcHJvZ3JhbXM6IHNocnVnLg0KPj4+IA0KPj4+IEJ5IHRoYXQgYXJndW1lbnQgdXNlci5r
ZnVuY3MgaXMgZXZlbiBtb3JlIHVzZWxlc3MgYXMganVzdCBiZWluZyBhYmxlDQo+Pj4gdG8gcmVh
ZCBhbGwgeGF0dHJzIHNob3VsZCBiZSBqdXN0IGFzIGZpbmUuDQo+PiANCj4+IGJwZiBzaG91bGRu
J3QgcmVhZCBzZWN1cml0eS4qIG9mIGFub3RoZXIgTFNNIG9yIGEgaG9zdCBvZiBvdGhlciBleGFt
cGxlcy4uLg0KPiANCj4gU29ycnkgaWYgSSB3YXMgdW5jbGVhciwgYnV0IHRoaXMgd2FzIGFsbCBh
Ym91dCB1c2VyLiouDQoNCkdpdmVuIGJwZiBrZnVuY3MgY2FuIHJlYWQgdXNlci4qIHhhdHRycyBm
b3IgYWxtb3N0IGEgeWVhciBub3csIEkgdGhpbmsgd2UgDQpjYW5ub3Qgc2ltcGx5IHJldmVydCBp
dC4gV2UgYWxyZWFkeSBoYXZlIHNvbWUgdXNlcnMgdXNpbmcgaXQuIA0KDQpJbnN0ZWFkLCB3ZSBj
YW4gd29yayBvbiBhIHBsYW4gdG8gZGVwcmVjYXRlZCBpdC4gSG93IGFib3V0IHdlIGFkZCBhIA0K
V0FSTl9PTl9PTkNFIGFzIHBhcnQgb2YgdGhpcyBwYXRjaHNldCwgYW5kIHRoZW4gcmVtb3ZlIHVz
ZXIuKiBzdXBwb3J0IA0KYWZ0ZXIgc29tZSB0aW1lPw0KDQpUaGFua3MsDQpTb25n


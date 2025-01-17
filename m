Return-Path: <linux-fsdevel+bounces-39552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF287A1580C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 20:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F06701884FE7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 19:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C4F1A83F9;
	Fri, 17 Jan 2025 19:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Uj/checu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E9225A62F;
	Fri, 17 Jan 2025 19:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737141492; cv=fail; b=dI4GH2FeSkc0suH+K1dxVBlaQPNlLRWOYrLn8ze8+S1BrCNObrADGqC//qPQCltds7nrIsLpfSorVdry/B1jcPpuJucPIG+8d3ayoxjf7spPdNLvRj/mTI29KCiH6UnBkJQZ+mX6pWzLXKklvTHeyQvyiCGAMquTsx4jrt+KaRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737141492; c=relaxed/simple;
	bh=rl7xPXJuuJjCZETxhpIjnMG34Z6H1VJRS6FX+3KUE4s=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=bsRjmtjWs9j+Pd7joh9MOYmjDOXCLjNRzO9yx1T3ohtTrCnkj6wPS3SRnBnonuSmC2f3Xt3Gb870u1k2MESQudWf/Pbj5TgdqbFVAa+/idyWxWp7R8a15ru0bdPofQpVE6tK8HPeaVkjk3DSbTQF3TgRVii9Ls7bplQsNiqb6vA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Uj/checu; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50HD4nP5018476;
	Fri, 17 Jan 2025 19:18:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=rl7xPXJuuJjCZETxhpIjnMG34Z6H1VJRS6FX+3KUE4s=; b=Uj/checu
	RndqJ5KYi9g8sxDSbNRPb5e+2CpldDNLWajz9Aig/wbkwxl64eUIQ7m2xwL7mJGF
	2wgrK7QuHmTiZmkC4tyjgDkqr0pRflqGgG/+SF6JfK1WsL5n4lh4RSIpkgKtsySb
	V5xG2ko/zbtgcbZ2VWQ9DMWZldT4U5wZ21/tXA7T7jzAwQLa6tpY69cgNipTbxKp
	naOdhH5hQDr1XMAtFnIBUpS2nGaRx9M6lF7+MNv3gGY1CdOqUagczpS4axxOXHJP
	Vve8/Z5zkJXZg/m2VoWWox00FSj2omG/yjMpAYsSWQPeaPnkh+UoK2ccDab8YU/h
	KWWnaQijNQ3vfQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 447bxb4s06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 19:18:06 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50HJFbbR012533;
	Fri, 17 Jan 2025 19:18:05 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 447bxb4s04-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 19:18:05 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zTmKFVtaoVK+OWMrekzDDvn3tCHPmtNLd8LJhf1iSs3Yt78QdglkYjtB5tiZ126cmQ+ZHUbtc6V/C0o9kwz2eC85cy4986ZZLsRcUOyTQv+zXixKT3lPn5kMGwf3ur8MmsCe8DYaGpTwi0rP88s+gmUJnDfvHOJGcJjBIQ+Hu4jIDZdf4we52+50DYXqBzkPjl2HLNDP3ylyLr9TJemSAn2KsqG+DhDblcqj/YX050XzurC4mu6UnhraPA/EQIiy1ZvT98+5B+qcuoNAoZpaPpFyBI9fS2aSxQIbGmWIxeZPK/hOLUN1NDsZlXoyviL5A+2UfONm9ICiGNQifpV6Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rl7xPXJuuJjCZETxhpIjnMG34Z6H1VJRS6FX+3KUE4s=;
 b=L2Vtfy7vlpNEYJhCBqdz4z99Cvkiv4qaJHbRcpPv+PnCzApgOGa23B09sSmOA3J6sFBztzWvGP91Xm3YhVUDdJe2QxSSc3op0tTaFP2OKrR4TSng3R6OeoMRqbk4DVhpZYYbJ+eu6gGWCC0xdyAKRqQXudxEpNtcRPQTbcTO8fZBy54wy/+veRFKEQAxmqXzgZvrHpDs6Bb/hcAEzoFNbm8+XbHBYTuMVoHA0ce0W0Zuh5MVwbg8dRy1+2PPp20MUK6hjsnNtL0b5Gct/DwhoyKAcXby7myRsIm6ps+LtV+XHWS9+/Zk8gedSOqI2CpZbV6X3JMQ3DirKL0hpgkocg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by MW4PR15MB5272.namprd15.prod.outlook.com (2603:10b6:303:18a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Fri, 17 Jan
 2025 19:18:03 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 19:18:03 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "idryomov@gmail.com" <idryomov@gmail.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alex Markuze
	<amarkuze@redhat.com>,
        David Howells <dhowells@redhat.com>
Thread-Topic: [EXTERNAL] Re: [PATCH v2] ceph: Fix kernel crash in generic/397
 test
Thread-Index: AQHbaNhIe6Epl3XAGUWb+VKorX8AorMbV1uA
Date: Fri, 17 Jan 2025 19:18:03 +0000
Message-ID: <9e8549979a832b345cb2193cc0eede6b350a4981.camel@ibm.com>
References: <20250117035044.23309-1-slava@dubeyko.com>
	 <CAOi1vP97xPyka60H=bMh3xyOtumO+WQfMYF8NG0V545oYnQG7Q@mail.gmail.com>
In-Reply-To:
 <CAOi1vP97xPyka60H=bMh3xyOtumO+WQfMYF8NG0V545oYnQG7Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|MW4PR15MB5272:EE_
x-ms-office365-filtering-correlation-id: 801c62d9-a044-4565-4a7f-08dd372ba9f5
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cHowWjBIbEJyVFEwL3BXK3ZtaTNKRHc3YTJ6T0NXb3VRYTF3YW1QU0tMbVoz?=
 =?utf-8?B?OS9SbE00OUZXbjFBVW5wTXh3WkhnSHoxSHR1OTQyUEN0SmNQdmhudVd4UVFR?=
 =?utf-8?B?SkVMS1A3dk1YVlR0MEQ5VzBRMzcyaGc0NzdPN2FrU2tiMFdsTGljZVNQeG9h?=
 =?utf-8?B?eHFwS3VodW9kUE1UbzdabVlGeHAzSUxpQ3FXSERTcXRpSzBzSzlZR0Nia3pX?=
 =?utf-8?B?MUlLbzU0Qk1Qa0dVZDViT2xQWVNxelZreVBOWDh5WDRGSk5rYlVjdnBPaUEw?=
 =?utf-8?B?MitITlZDS0wyeUZVVkFYVURQUHU2UG92MFRtNDdqblg0eUJGVmFzRDEydkMv?=
 =?utf-8?B?OUtWcXFMNWlldGc1bzRLRjdIdVFlbzVXdVlxa3FLNkFMWUEzYll1T2o0enVp?=
 =?utf-8?B?ZjdDM3JnMnhnNmh6eSs3azJJK0xmMzZpbHJQQnFDOEZuRHVqbW1iQmlkTG91?=
 =?utf-8?B?b0VTbDZyRzBQcnR3ajcvbGIyanplYWpjVVhwSFREUzZWbGR2VldoVnh1Y0pu?=
 =?utf-8?B?K0tCaGlod1lyRVRreW1tY00yN0pYMkhseGRzSTBsQ3c3MUpmeGdxUnpoYkVE?=
 =?utf-8?B?SFk2d3pxUUtzK3RMOXB5dGpGb25iOUtTVG13SDV1T1JKVXZmRzlScmxlcktV?=
 =?utf-8?B?U1owQURoQ2dTRThlcDZsNU5PbHNsSHZ5UnRuOVp6WHJJMk80NkZCMDJFSTlK?=
 =?utf-8?B?VDdTTW9ZZk95QU80Yjc4aVhQbUtxcjBYd2JsaXlpclBhU0g3NExsYUxFTjFt?=
 =?utf-8?B?cDNjWmdnaERxNTJYbWVyL3ROZUc0OWFNRktZOTcrM213aU1maEpLVmJYeHF6?=
 =?utf-8?B?VW1FZmhvUDlyNkFtNlFGNzVtcWdndGVVNmZ1aTBJa2NGQXZxYnRNcytjcmNF?=
 =?utf-8?B?UzBTcXlOcmFiSHVQMk5lU0JheisvSGc5Nzl6bDUrT2tYeUx1SXlTSCthWFVa?=
 =?utf-8?B?OEo5TzdGNmQ1V0JtQVNJTU9DS25SWGFRaHBXazg1ZUR4Y1lxZnBnZE4vbC9J?=
 =?utf-8?B?U2FEbm01c3FrM0xjK29ESGZNbkpnWW9YeVRmakYxMzlVeUpmY2lhamFvejZs?=
 =?utf-8?B?cWZmS1gzL2ZhZVI1VElRZ2ZPb21la2xRRnBsMTZUUHVqaEZsZlEwQUlYWFpi?=
 =?utf-8?B?dGNNdnlDa0pqUjVNOVRTMUZCQk8zTjVmdzJaMTlXSTRzeU5zVnFzR0Yrd3g4?=
 =?utf-8?B?QTgzb3RoWW5RYW1qTUV2R1FwMUx0UmhNS3BNdTdlUlFDZm9TcXl5MDRUMlhn?=
 =?utf-8?B?bXBvQkdISUJUWU03YjBSa0ZWbXVQQnBheFFQU1IwMWZpaHcwcWtYS2RkU0dz?=
 =?utf-8?B?Sng2UmNBbjBqa2ZENG9nbituZ0RqUlpGT3d4OG5OSUoxdjQ3ZXVFNjYwajUx?=
 =?utf-8?B?azVjRUpSbXh4VWRIVlpybWYwVUJldTlTdHczY21oYkZGYzFzN3VrOEtGMDdQ?=
 =?utf-8?B?dDlaUjFORW1LKytBVXFESGZiOUJtMGd1QzR4NTFVcDgxRDdaMGdpR1EybDVt?=
 =?utf-8?B?M3J4WVNYODVNdGorZkpsN1V3Q1RGN2crUEl2bWMxcTZDZHlGaFJUMkhweUJ4?=
 =?utf-8?B?am1LUHRzK1k5azVZU0l4NDVWSXI0MWIxSXExYTJyeENac1U3UHlWWFF3SmdT?=
 =?utf-8?B?MUljYlhFMUNMMzEzcnFnZVB0Y2NaZmlMQUlJUFhNSkQ5bmZRa0dOVjdVeVl3?=
 =?utf-8?B?bVJrMWs2a0hjMDFoMVk0VFBCVHp0ZWlHbDNnMWhBVThsT05MdkFFc1ByWStK?=
 =?utf-8?B?dHQwNHhKKzBQZXdqSkwxZ3QyTHp4T1BLeXhFc054dzJDcXYyeEVSSDRpSVlW?=
 =?utf-8?B?ckJFZWNwdHdWVVBLY0ZhanlXMzBvc0NHTG1KQzRQVnFoZGh0Y0tNQzVYL21x?=
 =?utf-8?Q?68QgqXkdEq6w8?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cWhHWktUTXpPOFVPWUMvMTNXVjBNbWlldm4rQUZwOUFMTlZPTWJabFo2aEh5?=
 =?utf-8?B?eE4rS3RoalJldTNtclJ4UTNIejliRGhVQlpRblJsZWxoVHJQajlpMTZxeFd1?=
 =?utf-8?B?WlIvWjVMcncwZE1zeXFUNklnM2ZXZTdPcGNoNjVCMGEyL0Y5cTZmQjlYZDE1?=
 =?utf-8?B?ZjVHQjEwak4va3hpVy9xSTZYcmpZdWpUS0o3bmlzVGxUUmtlQTBMM0Y0YUpJ?=
 =?utf-8?B?QmVNckMwWFpTbVRZNXNoUUd3TmxBUUorZ2FWaStEb0ZKM1l1N29HNUVqa051?=
 =?utf-8?B?UUtodGoya3huWkRMM2FZL3J1dFp2OVoyY2VmSkNTUFpHdkpLVFZTVmdKSjRq?=
 =?utf-8?B?UTVpZG9iRkdPZm1TSVgyMFdiNTJWQXlnSWdEeng4VWJCYjV2dFpnbUhweXBT?=
 =?utf-8?B?bStqb0RPN1NLc2VEcDZmZ1VFZzZiQk9Ud0Vnd1p4WXZTWlF6SWNxbnQ3Z2Fz?=
 =?utf-8?B?ejNLVk1pbC8wbUVxQmIxdndPbzUrUmkyMGdUNEZhMTlHaXBuMVAxVm9XeHBR?=
 =?utf-8?B?UU91V2c1VDVFRVl6clpRSkFUOFowNGVKczdyNjZzbU5PU2ZPV1JsN0g0MmRy?=
 =?utf-8?B?cnRxSkg4aTBOVmR2eUdTQjJaWUhXb1lUKzVSeDU1dzBLZDVEc21IR2ZCMWdQ?=
 =?utf-8?B?ZDNSU2sxNzh6K0dyZTZqeDhLaG5LdFZtd1FMMURTdDFzTE0wNFdWZEVzSkZH?=
 =?utf-8?B?T1hSWlcrZ3RkTTRUL2RGNDRrOXVCcDdIc1RVSnhORDFYRE1YMFN4RTZSSVdh?=
 =?utf-8?B?c2ZJc0hpZENaRVJRT2VwaE05TmNza1NXaTRPeTE1bjExbklXcUs0YllHRE1T?=
 =?utf-8?B?MlN0dnZVYk1oYWRQM2tOanFlNWduNnhEWENsN0RJbkdUSmlIOHZidXI5Wlpk?=
 =?utf-8?B?VjF3cnBCMDdzSFdCOS9wdEhlTzJHOEVCUWhuUGN2UFNxSDc1dVM1QVdWY1Nn?=
 =?utf-8?B?cUR5V2ZPYTBqWG92QW4rWlo5aUxMc3psWmQvMGFEWnV2c2Foa0R6R2NyVG9F?=
 =?utf-8?B?QWlXMVJnK2RjbFZKYitQbWY5SGcySFVMRkZOazg4emFzNE5maUI4YVYyaUJM?=
 =?utf-8?B?QUNRazN2MmZqd3doRHB4TkxWMnU5V25SaEpaSmhQTUp3bEZwYkw5aXpVd3ZL?=
 =?utf-8?B?K0l3VHlhS3pRMUtSMTlRUzFjajQzcFJOZnErM3VqcGowR3p3azBmelFHMTlm?=
 =?utf-8?B?ZElxeVZvZ3BReVQyQklxZkEvd0JIRHRmZWZqNlExY2NhSGFsK0VXUUl4RjNY?=
 =?utf-8?B?c0hXb3NpYURBeWxlc3hPMDBNOTJHTzQrT0RiOVNSOWdGUFJjZ2ZtT3gvMFBP?=
 =?utf-8?B?K3JRc1FZQjBpdGtpTFdXRU1QbjlqUHdMMU5pL01Wam41MmhxQkpXenBxTXpq?=
 =?utf-8?B?Nm9OSlFIZjdaZVl3RDc1cFp5elljUDNkZlg4MEo2YXY0TUtUZ2doQWo3Y2kx?=
 =?utf-8?B?bXlVV0xycXZpczJkNnNyNFlFcWJLLy9qZlVPVFdhaU9abjB0SDd1SFE0cUdx?=
 =?utf-8?B?YldpU21UZDJ3OHVaZVVpQkxPRjROKzNvbzZEeDFDTGYreUZzYy8yN2ZrTVBj?=
 =?utf-8?B?RW5CS0YyQWxJUDhqeFNCcWxKdGF0dWhiK2haNHFubGhTK2RtUHIwakRsOElD?=
 =?utf-8?B?MVNUTFVrdFlLK1praWwvc1FRVk56ZTUwdUxXeFFvYzNKYTNvbmRUbUZGekdZ?=
 =?utf-8?B?KzE4VXBxbHoyYVJsSWFQR2JYNmtUeGZoVUt2MFJRQU9xWXFmanFqSEYvWVpk?=
 =?utf-8?B?V3lQaXNOTnhoRlBreXkwUUlQQTAzVE9qZ043L3UvQ3BndWtzWmZnalgvNyt2?=
 =?utf-8?B?VkZWdldTRE9PQW1qeG43VFdHQjFoWEx1TkorN2tuZmhjcFNmTXZBRnpZaDhR?=
 =?utf-8?B?Z3FsTFk5RjBmRnFMRmhlYlNWUXVpeVVUYzVNOGdOTzZWT3FSTjljR2NzTmZU?=
 =?utf-8?B?MDExb0NPRnVUYVV2WHptSTRweHdqYTZmZTVFMUFDdWtyTG1SLzAxL015L2pZ?=
 =?utf-8?B?c1Rka0tpL3VoN2tGMUZ4NHo1U0FCVHFvZmQzekEwRkVoM2tJVW5nQWl0bEoy?=
 =?utf-8?B?NTdaYjJnbFR2UGdqSXg2QThNSlRHakJLZVc1NUFCVmZyOFlnYTFDZkw2dkdt?=
 =?utf-8?B?Y3duNllWMEV0a1NDeXlCQzlmM2FKb0tjbDBBckxDaHY4WWNmNUMyN0dTWGNE?=
 =?utf-8?Q?7u+3MjBKozdodqd25xwm5Vk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DED701225DA0484DB240AD7B3A294C26@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 801c62d9-a044-4565-4a7f-08dd372ba9f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2025 19:18:03.0845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w/iC4My20KQFF1DBqduzPUeILvLbtf52Jdx+Gc5T4XZAuEKWuh3Jg9X9bkX5wxrq2dQzalH7JyBQEWjElbO7KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB5272
X-Proofpoint-ORIG-GUID: RbK_9qki2tfc1cNeMiqoZDRrPcKUJsaq
X-Proofpoint-GUID: b7kX8zA9ZAlkYj7Jl8wqFb3dA5nafeaA
Subject: RE: [PATCH v2] ceph: Fix kernel crash in generic/397 test
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_06,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501170149

SGkgSWx5YSwNCg0KT24gRnJpLCAyMDI1LTAxLTE3IGF0IDEzOjA2ICswMTAwLCBJbHlhIERyeW9t
b3Ygd3JvdGU6DQo+IE9uIEZyaSwgSmFuIDE3LCAyMDI1IGF0IDQ6NTHigK9BTSBWaWFjaGVzbGF2
IER1YmV5a28gPHNsYXZhQGR1YmV5a28uY29tPiB3cm90ZToNCj4gPiANCj4gPiANCg0KPHNraXBw
ZWQ+DQoNCj4gPiBTaWduZWQtb2ZmLWJ5OiBWaWFjaGVzbGF2IER1YmV5a28gPFNsYXZhLkR1YmV5
a29AaWJtLmNvbT4NCj4gPiAtLS0NCj4gPiAgZnMvY2VwaC9hZGRyLmMgfCAxMCArKysrKysrKysr
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAt
LWdpdCBhL2ZzL2NlcGgvYWRkci5jIGIvZnMvY2VwaC9hZGRyLmMNCj4gPiBpbmRleCA4NTkzNmY2
ZDJiZjcuLjVlNmJhOTIyMTlmMyAxMDA2NDQNCj4gPiAtLS0gYS9mcy9jZXBoL2FkZHIuYw0KPiA+
ICsrKyBiL2ZzL2NlcGgvYWRkci5jDQo+ID4gQEAgLTM5Niw2ICszOTYsMTUgQEAgc3RhdGljIHZv
aWQgY2VwaF9uZXRmc19pc3N1ZV9yZWFkKHN0cnVjdCBuZXRmc19pb19zdWJyZXF1ZXN0ICpzdWJy
ZXEpDQo+ID4gICAgICAgICAgICAgICAgIHN0cnVjdCBwYWdlICoqcGFnZXM7DQo+ID4gICAgICAg
ICAgICAgICAgIHNpemVfdCBwYWdlX29mZjsNCj4gPiANCj4gPiArICAgICAgICAgICAgICAgLyoN
Cj4gPiArICAgICAgICAgICAgICAgICogVGhlIGlvX2l0ZXIuY291bnQgbmVlZHMgdG8gYmUgY29y
cmVjdGVkIHRvIGFsaWduZWQgbGVuZ3RoLg0KPiA+ICsgICAgICAgICAgICAgICAgKiBPdGhlcndp
c2UsIGlvdl9pdGVyX2dldF9wYWdlc19hbGxvYzIoKSBvcGVyYXRlcyB3aXRoDQo+ID4gKyAgICAg
ICAgICAgICAgICAqIHRoZSBpbml0aWFsIHVuYWxpZ25lZCBsZW5ndGggdmFsdWUuIEFzIGEgcmVz
dWx0LA0KPiA+ICsgICAgICAgICAgICAgICAgKiBjZXBoX21zZ19kYXRhX2N1cnNvcl9pbml0KCkg
dHJpZ2dlcnMgQlVHX09OKCkgaW4gdGhlIGNhc2UNCj4gPiArICAgICAgICAgICAgICAgICogaWYg
bXNnLT5zcGFyc2VfcmVhZF90b3RhbCA+IG1zZy0+ZGF0YV9sZW5ndGguDQo+ID4gKyAgICAgICAg
ICAgICAgICAqLw0KPiA+ICsgICAgICAgICAgICAgICBzdWJyZXEtPmlvX2l0ZXIuY291bnQgPSBs
ZW47DQo+IA0KPiBIaSBTbGF2YSwNCj4gDQo+IFNvIEkgdGFrZSBpdCB0aGF0IG15IGh1bmNoIHRo
YXQgaXQncyBzdWJyZXEtPmlvX2l0ZXIgYW5kIGNvbW1lbnRpbmcgb3V0DQo+ICJsZW4gPSBlcnIi
IGFzc2lnbm1lbnQgd29ya2VkPyAgVEJIIG11bmdpbmcgdGhlIGNvdW50IHRoaXMgd2F5IGZlZWxz
IGFzDQo+IG11Y2ggb2YgYW4gdWdseSB3b3JrYXJvdW5kIGFzIGlnbm9yaW5nIGlvdl9pdGVyX2dl
dF9wYWdlc19hbGxvYzIoKQ0KPiByZXR1cm4gdmFsdWUgKHVubGVzcyBpdCdzIGFuIGVycm9yKSB0
byBtZS4NCj4gDQoNCkFzIGZhciBhcyBJIGNhbiBzZWUsIHRoZSBtYWluIGlzc3VlIHRoYXQgc3Vi
cmVxLT5pb19pdGVyIGtlZXBzDQp1bmFsaWduZWQgdmFsdWUgaW4gc3VicmVxLT5pb19pdGVyLmNv
dW50LiBBbmQgaWYgdGhlIGFsaWdubWVudA0Kd2FzIG1hZGUgZWFybGllciBbMV06DQoNCglsZW4g
PSBzdWJyZXEtPmxlbjsNCgljZXBoX2ZzY3J5cHRfYWRqdXN0X29mZl9hbmRfbGVuKGlub2RlLCAm
b2ZmLCAmbGVuKTsNCg0KdGhlbiBpdCBuZWVkcyB0byBjb3JyZWN0IHRoZSB2YWx1ZSBvZiBzdWJy
ZXEtPmlvX2l0ZXIuY291bnQgbGF0ZXINCmJlZm9yZSBjYWxsaW5nIGlvdl9pdGVyX2dldF9wYWdl
c19hbGxvYzIoKSBbMl06DQoNCglpZiAoSVNfRU5DUllQVEVEKGlub2RlKSkgew0KCQlzdHJ1Y3Qg
cGFnZSAqKnBhZ2VzOw0KCQlzaXplX3QgcGFnZV9vZmY7DQoNCgkJZXJyID0gaW92X2l0ZXJfZ2V0
X3BhZ2VzX2FsbG9jMigmc3VicmVxLT5pb19pdGVyLCAmcGFnZXMsIGxlbiwgJnBhZ2Vfb2ZmKTsN
CgkJaWYgKGVyciA8IDApIHsNCgkJCWRvdXRjKGNsLCAiJWxseC4lbGx4IGZhaWxlZCB0byBhbGxv
Y2F0ZSBwYWdlcywgJWRcbiIsDQoJCQkgICAgICBjZXBoX3Zpbm9wKGlub2RlKSwgZXJyKTsNCgkJ
CWdvdG8gb3V0Ow0KCQl9DQoNCgkJLyogc2hvdWxkIGFsd2F5cyBnaXZlIHVzIGEgcGFnZS1hbGln
bmVkIHJlYWQgKi8NCgkJV0FSTl9PTl9PTkNFKHBhZ2Vfb2ZmKTsNCgkJbGVuID0gZXJyOw0KCQll
cnIgPSAwOw0KDQoJCW9zZF9yZXFfb3BfZXh0ZW50X29zZF9kYXRhX3BhZ2VzKHJlcSwgMCwgcGFn
ZXMsIGxlbiwgMCwgZmFsc2UsDQoJCQkJCQkgZmFsc2UpOw0KCX0NCg0Kb3IgY2VwaF9uZXRmc19p
c3N1ZV9yZWFkKCkgbmVlZHMgdG8gYmUgY2FsbGVkIHdpdGggYWxyZWFkeQ0KYWxpZ25lZCB2YWx1
ZSBvZiBzdWJyZXEtPmlvX2l0ZXIuY291bnQuDQoNCklmIHdlIGhhdmUgY29ycmVjdCB2YWx1ZSAo
YWxpZ25lZCkgb2Ygc3VicmVxLT5pb19pdGVyLmNvdW50LCB0aGVuDQppdCBkb2Vzbid0IG1hdHRl
ciAibGVuID0gZXJyIiBjb21tZW50ZWQgb3Igbm90Lg0KDQo+IFNpbmNlIHRoaXMgY29uZmlybXMg
dGhhdCB3ZSBoYXZlIGEgcmVncmVzc2lvbiBpbnRyb2R1Y2VkIGluIGVlNGNkZjdiYTg1Nw0KPiAo
Im5ldGZzOiBTcGVlZCB1cCBidWZmZXJlZCByZWFkaW5nIiksIGxldCdzIHdhaXQgZm9yIERhdmlk
IHRvIGNoaW1lIGluLg0KPiANCg0KU291bmRzIGdvb2QhDQoNClRoYW5rcywNClNsYXZhLg0KDQpb
MV3CoGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2LjEzLXJjMy9zb3VyY2UvZnMv
Y2VwaC9hZGRyLmMjTDM2NQ0KWzJdwqBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92
Ni4xMy1yYzMvc291cmNlL2ZzL2NlcGgvYWRkci5jI0wzOTUNCg0KDQo=


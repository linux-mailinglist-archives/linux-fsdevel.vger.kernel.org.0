Return-Path: <linux-fsdevel+bounces-69469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06072C7BDA8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 23:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A95EA3A5DD4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 22:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBD63064AE;
	Fri, 21 Nov 2025 22:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dnIrfxNK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EE82D6624
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 22:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763764101; cv=fail; b=ehfUJJx4R42cj0EKa16R5VE5b2on6mLHaSmRMr6QbpeOCOvIkrHGGZHAs19pA8PW20GOZQsqvXHjGdaw5/0O/saTTarMH3O1gvKpdx461SKYts6icudb0GuQxgDNvbs3eWga3SWzqswWm++Et5WtUf2CH+KB0p4iPY3QFfvUnys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763764101; c=relaxed/simple;
	bh=OlBhuRqpPbAQ6yXNtuflrxujQQLazsrSU7tzHQWNG/o=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=jOpvZc8GxI7b6pHjUOIJCsKS1hBmC9M4XIrPzqSYn2/fPDXT8leNllV4ahvgRrRsDBpGx8pzLJEGjB6ebJNjiq7b1I7ICitqLB55mEu79Fp2zVAJNW0chGqXndZOFVY+9lGGLOGzKrZTl3d0wJ+nmBunZ9GNeDv6XkDSOkrZ0Js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dnIrfxNK; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALCuB0f021553
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 22:28:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=zhEJHNzM1xRWPs0hoyWMdjWkldA+QzYyO+c7bRWxd1E=; b=dnIrfxNK
	Q87+aMEzCmY1KYJLxA6sOM4Zt0dVu4DttgTRM89GpiBgnV6OnLCHvwTCkiZwd5+x
	KUMSt9PWcrwsGkSK6lPYckCmvC58ZICdusL0eobNNgyeCGvspXahXi/IGMcQNSl1
	GUer4AP+lICiVUUPMok077cbV0FZosSdWLWLfI7wojdIGryomwyKDV3zPTh89bp1
	X8yYgqTLXuSNu8Yf4YWydWl0Ldy8SzRtK0Kd6kDJrVItj043kxGvrNl1izpLbONX
	CivjoslBkeh/UMGSFGhXuW0Ozd2eXSp7d/arod0zMMRZIpIw/yiUbTTnRhaEHdfx
	piQgPaoV7NcLzg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejjwpmvt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 22:28:18 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ALMObnR011610
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 22:28:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejjwpmva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 22:28:17 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ALMSG26016759;
	Fri, 21 Nov 2025 22:28:16 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012017.outbound.protection.outlook.com [40.107.200.17])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejjwpmv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 22:28:16 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IuWYhXJ1oaINWm/RJz69Jswq/nNDgMUY7Of+HIkhm1L1LIgNrnX8zh435CAiIyCu90cuOwgAKjo36MtwGSklGaptefMALrHsKp/eNgQnbv3VpnauzR6Iyn915Up5rOIxfs8XHOTvBYgT59/s0D7XXZJ6JK2zONJZsx7/Hh9RzMWq9lJLqfpKAFFcwFCpMi6nxSra44Sr0PgPWPxGS7TSKfV53G0xmEFtopx3XwyQlVSdnPsJOAVjIuvVqdsyKNVYO8hm72xRgHKLXuBm7gVvJTX4l3pblv3tohRqpzNqKvC5LUbVCv/Cch/7RnR6pE6rgryiSjHJ5I50ItSOSdi9BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5gactzDKNPBIg7BpzK4a2XKnm5vvpnH66QTCX6TXeU=;
 b=hPVv7J/DgUhAALMUIc9uSgerIusBm6RQsHA24HCWtumj+LruFjc96+U3kcpYzpmXl32RLR+jy2c4W5oGeuJtPuszpydzNfVwhaE0XPJTP3TUlc/lbkAnW/msFgyl0sCr2ZVLhgdWETJ+j7BohrMw/EP2YD3UvQonDol23xG0onWNYkivPJY9xuaFpMJHfe8xvE/bfz1n/E5Ap0tFiTvIDiM8Ni7lpH9l6J0Yk/VbkPM2BmqrwD84j4zP3Rb0KnQsa7MUm/Mlw3fpAIgsg5P4yrUXFMXnNEYOZhdX+KIPeOPiefNDnoOpfk8wGLD9w9aVR8zVmpNUKVvRuYQPbuoV8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by IA0PPFB0EB21A72.namprd15.prod.outlook.com (2603:10b6:20f:fc04::b40) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.14; Fri, 21 Nov
 2025 22:28:13 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9343.009; Fri, 21 Nov 2025
 22:28:13 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "jack@suse.cz" <jack@suse.cz>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "mehdi.benhadjkhelifa@gmail.com"
	<mehdi.benhadjkhelifa@gmail.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC: "linux-kernel-mentees@lists.linuxfoundation.org"
	<linux-kernel-mentees@lists.linuxfoundation.org>,
        "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>,
        "david.hunter.linux@gmail.com"
	<david.hunter.linux@gmail.com>,
        "khalid@kernel.org" <khalid@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com"
	<syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com>
Thread-Topic: [EXTERNAL] Re: [PATCH v2] fs/hfs: fix s_fs_info leak on
 setup_bdev_super() failure
Thread-Index: AQHcWxbjI2wNRsxXGEmG7hnNwSoKY7T9oaoAgAAaLgD///OkAIAAFCeA///ybQA=
Date: Fri, 21 Nov 2025 22:28:13 +0000
Message-ID: <960f74ac4a4b67ebb0c1c4311302798c1a9afc53.camel@ibm.com>
References: <20251119073845.18578-1-mehdi.benhadjkhelifa@gmail.com>
	 <c19c6ebedf52f0362648a32c0eabdc823746438f.camel@ibm.com>
	 <3ad2e91e-2c7f-488b-a119-51d62a6e95b8@gmail.com>
	 <8727342f9a168c7e8008178e165a5a14fa7f470d.camel@ibm.com>
	 <15d946bd-ed55-4fcc-ba35-e84f0a3a391c@gmail.com>
	 <148f1324cd2ae50059e1dcdc811cccdee667b9ae.camel@ibm.com>
	 <6ddd2fd3-5f62-4181-a505-38a5d37fa793@gmail.com>
In-Reply-To: <6ddd2fd3-5f62-4181-a505-38a5d37fa793@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|IA0PPFB0EB21A72:EE_
x-ms-office365-filtering-correlation-id: 8356d266-6d43-45a0-6a2b-08de294d4268
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VXl1aGJDajF5SVdxQ2FySUxFSVBHUlRsK2NFSXpPSWRwd3l3akxFREFVUU5S?=
 =?utf-8?B?UEcxblN3YlRFM1RiSmRHeWhLQnU0MVVERHRYMjFHWGtKeWRMbFRxbk8wS0Ux?=
 =?utf-8?B?SDVtVkdObjlURlROV1pRcnJ4UjBRSFU2MDVGT2hOMEVMYWo4UWo5Uy9MUW94?=
 =?utf-8?B?SVhlZ3BsU2dnbzcwTWhNNXVrWlZRVUl2TTkxTEp5RVhxZWtaclNqZDAzMWRF?=
 =?utf-8?B?S1JIRCtkT1E3aUd0WjBHbytjN0YwdmlISzlMUitEekkvT3ZIS2JpYUgxN2Jw?=
 =?utf-8?B?NVBrejIyck9UR2lmVU0zMmd4UHNFSDhDY1JSQkN3WFJ4WkZyY2FUelo0N1U3?=
 =?utf-8?B?OVRmeHZHcURsOCt3bHJaNmE2TTdnemFRR3ZPZHNWSU9IVVpOWmUvZE5wQ1I5?=
 =?utf-8?B?dUpOcnZnRUpuWXc1d09zRlliaW5oUEhETnpPa01lQWMyOE1FQnNLUG03T3g1?=
 =?utf-8?B?V3k3bGkvT2liS2RhMWZkVy9Bam1reS9mUUoranQ3aGRlMkJ5dElGcnYvamNS?=
 =?utf-8?B?ZjE3SkJRczBkRkQ2clRKUWJ5VnRDeWR2V0o5UXRJYkRXa0NObzlWSkJXUlZ6?=
 =?utf-8?B?dnFUTW5SN1g1aW1wRloyWERFRlRKaFVwUDg2L2JtR1VsQXpEME81TGlWemdn?=
 =?utf-8?B?RnJ6S0hLVXJZb29OTXU5OTFzazhqUzZ6eVhUTklIbm9hU2ljVzBtRGhyU1dT?=
 =?utf-8?B?KzZFbTBlUXNrcXkycVUxSysxRjVub2RIOVkrTXd1L2JwQzJhVnFXMmlJRDB3?=
 =?utf-8?B?MkRuRHFHRTZoZVF4amdGTlBkaFErWmNOcGRBYnF1RkFYZmJnUTZ5ZnpWa29n?=
 =?utf-8?B?anFJUE5OT1BkSEF2Ti9JdmNXSm1mREdBRDFJNTFzc1hKRVh1MVVqN0pYUGtM?=
 =?utf-8?B?ZWp4UGVoV0dnMmFGZVJLMW41K3g0ZGFjQnNrMitzaUV3dkRVVU9hL1cwaTdN?=
 =?utf-8?B?L2ZsZkk2SHNtREFDU2FMeXhDcE5PTnRsK1ZwOGQ5QUVsYnB6cUdWd0FhRUhw?=
 =?utf-8?B?TjNDNFMzME9rcXRlSTcrME1wMU94L3N4YmdiY2w1VDI2bjBmWkVtWGMxTUZB?=
 =?utf-8?B?bXFjR3BTTHhSQS9ORTZCbFg2REZUNDE3NzRHdUxRSDRncVJsUTJPZGs2V1Ex?=
 =?utf-8?B?TWc2NEdCdmt0b2o3MkRjclBsSXdLMEd5NTJMaDNpb0N0UWdvcm5zc1VZcHBQ?=
 =?utf-8?B?Q2dURU8rMG12VmFPQmpqNnkwRXp6c2Y4MXpPc3VPZ1BUZGpYU1k4Q1RjQmc1?=
 =?utf-8?B?YnJqa3NhamFuR1R3ZERHajVvdjI1eTZMNGczbTA4b2VaMmFpWGxOejNtN3NQ?=
 =?utf-8?B?WjlVQUU1SUJseURQdDhkMllQaVdadHpEeUNyNStXQ2tSU1hMUEJCZDZ4TkxO?=
 =?utf-8?B?dExGemF6cU40dEhlSHRaQU4yUEhhdlB0Ti9Td0kxdHI1cjFyTlBxM3V5eWky?=
 =?utf-8?B?aStCS0FHUHR6S0E2ZVpMcGFpZkFIUFRDQzRkK2dUOXNkcElPNEYzQVVwLzYr?=
 =?utf-8?B?L2t5VS9HUDV4WFhrNWgwdmZrd0dacFFjV0U4ZEowMXNEeFdObGVDV3huT2t4?=
 =?utf-8?B?clV3VDd5azZwNjVnN1FZdkEwTmp2OVBFNmNUanZ5SUVzUEp1bGhJdDZWUHlt?=
 =?utf-8?B?VE1lbGQ3eit2MEpSL281UlFTa3pYSFA5WmJ2L1kydktqODZRWlc2UENDUEhm?=
 =?utf-8?B?L24wTXFGZ1c3SEhPL2JyN0s1ZFZuWXJJdzd4K2s1STZqdkZRNTAzalh6Mnkz?=
 =?utf-8?B?QnBxZnJObll0cU53TmpUVWdVblJGdXI2UXBybjl1Z0F0YnJPc3VKaU1pTXpa?=
 =?utf-8?B?RFFkQjkxeE96c2tlSVVlaFc0QzdHQlVSNmNLR0wvOVc4WEVZUks5UnViRURF?=
 =?utf-8?B?cHNjMmtSOEszNkpiQldhaTRxamJxK2FneFQ4TnpDTWp2TEFFaEVmSzByd1N3?=
 =?utf-8?B?ZzBQWHRLZDRwSzQ4ODBMUHJ2NHpoQTRBVVN6cVNPVWp4OUdHczBHOGJNWmY2?=
 =?utf-8?B?MHFGS1NEODBBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?REZUTjN1WG02anBvSGNzaUp6d08wekw3TG5WNkZBSFBSZVpjQnZ6OFZsOS84?=
 =?utf-8?B?UzZvSU1vVEg2WHdjWE1vdFB6cld2QWw1Zm9icStET05yQVNET3VJb0lhWU5K?=
 =?utf-8?B?SjRoNHY2cWJ0T2hUSUNEWmFOeUhhT0lRU0tlYWc0Mi8xc1Q1Y0NoMUpCZktV?=
 =?utf-8?B?T3pLRW1adVlOV0VySVNnbzBtcHpkOVVaREpqUEFsWEJUSHZwdXNuTmZCVHRx?=
 =?utf-8?B?QkRaQW9MOEVORk12bHFzVlZKRnVzR0NJZVZTcXFTOFhJNENxSjgyM0JwdzlZ?=
 =?utf-8?B?R2ZXNnlnZW9NQXBMOC9MTTJvQUNQcDBGeXVxdTRtT2d1SkxOdXVtaml5b3Nx?=
 =?utf-8?B?eXZ2Z0Nia1BPbGV6WjNZZURHRlBZSEJYc0ZPMnNzTXVxQWFaUGdRQUV6OXAz?=
 =?utf-8?B?dmRGaFJ2QlgxYVNIL1ZTZHVqRUQyOVRGNmYvc29TVm5OYVZFZEhWSnlwV1Ro?=
 =?utf-8?B?UWNIOHo4N3JMWDJDak5IalNXZHYrQWhJb2JBVTlkU0IzSGNJZTF1YmtXaGF0?=
 =?utf-8?B?MHhxeVU4UFUvZDdWYTh1R2owOGdMdzBBRTQxdFFlMlc0dXMvSkVOcGhsV2Nl?=
 =?utf-8?B?bC9CRmVBZ2pxa2FzcDhwOEFXb2t3MG9IaEFYbWVHbnFoYUoxOXM5VVpiYkk2?=
 =?utf-8?B?WlU0dWxjaXdlS2ZxcVRtT3dwd1c0SkJUNWRBZWk4UDNkZXphRyt6emJSclBQ?=
 =?utf-8?B?NDB4SW9waEhGL0FMRitvWnVWb05ENzhvSHVRM2Rlb3hUSlN4VnN2cjF2c2Ry?=
 =?utf-8?B?OHJMMmMxazM5emtZYWRwcHA2Mk1nb05KTWdXMjd3SDZWUkttUm1vRzBWdGJw?=
 =?utf-8?B?RFBoeHpTZm5XUE5lQlpOK2d2TlhYcHRnVVZpbnZXaW1pRWtEb3M2L2VDU2lK?=
 =?utf-8?B?a0xpU2NxSml0Mkg2bW13K3plTWI1Q0tWaG02d2kxa0M4bzViS1N1cFJrTkJr?=
 =?utf-8?B?dUl4QmdpaE4wQVIwOFpaVUNOVjR6aEFLa3RwWHgxK0VBOUpGYnFiU3ZDeDAr?=
 =?utf-8?B?RWhJa3lha1BzTUltRUFEWUE3YmFDZTZSd0xkT0NDWEF0K1VHVFFqRmtnOEF6?=
 =?utf-8?B?NW5wVEJhSmFqeW5HSTUzTVVDOVc1bTljeTdTaVFaZkhiUzJxSjJvc2FZR0NC?=
 =?utf-8?B?dDQwdnJYTFp5QUVZNjJyRzlERGRjTm1aOXk0aTlyc0NmeGdZSFhKbXg5eERk?=
 =?utf-8?B?WHh1NlZrL0Y3c2pCeEIzMnBPdWlQTlgvZlZlbGlrOTk1NjJGQTE0YkkrQ3k0?=
 =?utf-8?B?SHR4WlY1SDlvTm5INzVwMWRVM3crc0FhMmUzNEVhWEhXU0p2N1crdGxEc2lI?=
 =?utf-8?B?NXlUc3g3Nk41QmY0bUdVK2h0SWZadUtiREowb1NVUVI2ZkhYNEx0U3BZdkta?=
 =?utf-8?B?Q1ZqNjgzWUh1dytyNWZmbitkejFmK2lYOUhGK3IrcjYybVhkczV5NUdTelo0?=
 =?utf-8?B?OEliVnVjeEJoTzF4c3F4WlU3c2xscTBYMSt5MHYxQ3BLWG14S1dSM1Bxc3Yv?=
 =?utf-8?B?NE51SmZtSkU0eWdvSU82SEFsbUxVWXo2ekJzVlJ4VlBJUWdYNXhodU5mdmU5?=
 =?utf-8?B?b0tlZm8wYmJMd2RKcFdDdHZFdDhjamZZRzljQnEvc0ZKZWZQMEE2M1BXeFV0?=
 =?utf-8?B?UlBPUGErc3kyUDk5Tmx1elpFQUhCNnFzcEluWjJscVFNNzQ3YmQyL3hBc0s0?=
 =?utf-8?B?UC9xVlA5ZjZVeWhsRUVGU2tsTkN0dUp5N0VGMldYSVY2L3B1UVRnVHh6RTVk?=
 =?utf-8?B?V1BRcjkwY0JFY3F5c0J3RHNLcG9JN21jR2J1TXJyTCtCZW9UZy8wNmh1V1VB?=
 =?utf-8?B?NDFtTEE5VTFzWGt2VFZkRW5rZDB4MlByQldpWUpXbjN0aFBkZzB1WmsybnlZ?=
 =?utf-8?B?VzltYitiRHdFTk9wWElmcWpGcDJ1TGlhS1VhNE1UanhTMGxFSDZ2Z1pXd3pz?=
 =?utf-8?B?d3BmSTZWZnlDcFRITkZPaXl1dzVCazlsbmpCRkdiMjNKWXcrNVpYb2NjM2Ru?=
 =?utf-8?B?UENBclNGMlRIVXRTc1I1OCtLN2NBQlowdmZEa1BTQ3NKNmI4UXpRUURHVDl3?=
 =?utf-8?B?ajRWS0JrZlhFaGFRKzVmZzZmcUhDKzhjVEM3TnJpMlVCVUNTdVNsZzBHL21T?=
 =?utf-8?B?RnN0SktFa3lwU0tONUk1akNzRXg2ZzBxSUpBM01DNUxLSVFRYUV4SjRmcjln?=
 =?utf-8?Q?wEeoYPNXXGqbaAHjum9CdB4=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8356d266-6d43-45a0-6a2b-08de294d4268
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2025 22:28:13.5577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lzwa1JZygfxM34AZPEOsfGaAb6NlcJ+3H6V42nS+St4ZR4AkHrncuGvJ1/Y4Wz6nsfYhgtN9GHqxPvgsub2mbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFB0EB21A72
X-Authority-Analysis: v=2.4 cv=BanVE7t2 c=1 sm=1 tr=0 ts=6920e781 cx=c_pps
 a=Pcpo/nSjxNMkuCW/QO6CAA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=edf1wS77AAAA:8 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=NEAV23lmAAAA:8 a=P-IC7800AAAA:8 a=hSkVLCK3AAAA:8
 a=drOt6m5kAAAA:8 a=Dvw4buVJ8Ntvg3mRF4UA:9 a=QEXdDO2ut3YA:10 a=YbIxtS8kvYwA:10
 a=DcSpbTIhAlouE1Uv7lRv:22 a=d3PnA9EDa4IxuAV0gXij:22 a=cQPPKAXgyycSBL8etih5:22
 a=RMMjzBEyIzXRtoq5n5K6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfXwkLa7WVH1YXH
 1PvsmQSt85YQkTw7sHQARz9Y/vhMajC3hd92AFetcXsl2QJLbSsctMGSJI+urZYOinYU/s5/36D
 kaNqJqVFODFJRGvJVIueJ5jdvH9f+FPv7M3h5cmPGlNFvH89GePBqNpckKC/KeHw3ZKG8ADCV3g
 kBXg4fC/caaD79NJTbKPXYKwAp85fsRWEPTrnmq9U/khYxiDMPkzcaeIaWP4GFc5WotV+bU7qyG
 JLiAo9XIRmVTafjFqyxbpuIBhrIGaeBHPzesDtukm0kp2aqEWwyrxPjyHRkZBOeozTq5SN6olVA
 g/D+S04DaFwaC+yLPo1xmJFmS4mPzL1Z6aN/BupwSAddzgd7AkO74Bw+NK7DXFcNsF9kcunb5+C
 UsjVzPeZ/MQ6/5ktrD4wFulHtDDr/g==
X-Proofpoint-GUID: zxmSErgO-Ru7JJJM_XGY7IL9s7QAbSX2
X-Proofpoint-ORIG-GUID: VMWo-ls1hE18zltihoHI6fgcot0ByMQn
Content-Type: text/plain; charset="utf-8"
Content-ID: <C17F78AC3C84BF42A6A02157E2F7E59A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH v2] fs/hfs: fix s_fs_info leak on setup_bdev_super()
 failure
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_07,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=2 engine=8.19.0-2510240000 definitions=main-2511150032

On Sat, 2025-11-22 at 00:16 +0100, Mehdi Ben Hadj Khelifa wrote:
> On 11/21/25 11:04 PM, Viacheslav Dubeyko wrote:
> > On Fri, 2025-11-21 at 23:48 +0100, Mehdi Ben Hadj Khelifa wrote:
> > > On 11/21/25 10:15 PM, Viacheslav Dubeyko wrote:
> > > > On Fri, 2025-11-21 at 20:44 +0100, Mehdi Ben Hadj Khelifa wrote:
> > > > > On 11/19/25 8:58 PM, Viacheslav Dubeyko wrote:
> > > > > > On Wed, 2025-11-19 at 08:38 +0100, Mehdi Ben Hadj Khelifa wrote:
> > > > > > > The regression introduced by commit aca740cecbe5 ("fs: open b=
lock device
> > > > > > > after superblock creation") allows setup_bdev_super() to fail=
 after a new
> > > > > > > superblock has been allocated by sget_fc(), but before hfs_fi=
ll_super()
> > > > > > > takes ownership of the filesystem-specific s_fs_info data.
> > > > > > >=20
> > > > > > > In that case, hfs_put_super() and the failure paths of hfs_fi=
ll_super()
> > > > > > > are never reached, leaving the HFS mdb structures attached to=
 s->s_fs_info
> > > > > > > unreleased.The default kill_block_super() teardown also does =
not free
> > > > > > > HFS-specific resources, resulting in a memory leak on early m=
ount failure.
> > > > > > >=20
> > > > > > > Fix this by moving all HFS-specific teardown (hfs_mdb_put()) =
from
> > > > > > > hfs_put_super() and the hfs_fill_super() failure path into a =
dedicated
> > > > > > > hfs_kill_sb() implementation. This ensures that both normal u=
nmount and
> > > > > > > early teardown paths (including setup_bdev_super() failure) c=
orrectly
> > > > > > > release HFS metadata.
> > > > > > >=20
> > > > > > > This also preserves the intended layering: generic_shutdown_s=
uper()
> > > > > > > handles VFS-side cleanup, while HFS filesystem state is fully=
 destroyed
> > > > > > > afterwards.
> > > > > > >=20
> > > > > > > Fixes: aca740cecbe5 ("fs: open block device after superblock =
creation")
> > > > > > > Reported-by: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmai=
l.com
> > > > > > > Closes: https://syzkaller.appspot.com/bug?extid=3Dad45f827c88=
778ff7df6 =20
> > > > > > > Tested-by: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.=
com
> > > > > > > Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> > > > > > > Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@g=
mail.com>
> > > > > > > ---
> > > > > > > ChangeLog:
> > > > > > >=20
> > > > > > > Changes from v1:
> > > > > > >=20
> > > > > > > -Changed the patch direction to focus on hfs changes specific=
ally as
> > > > > > > suggested by al viro
> > > > > > >=20
> > > > > > > Link:https://lore.kernel.org/all/20251114165255.101361-1-mehd=
i.benhadjkhelifa@gmail.com/ =20
> > > > > > >=20
> > > > > > > Note:This patch might need some more testing as I only did ru=
n selftests
> > > > > > > with no regression, check dmesg output for no regression, run=
 reproducer
> > > > > > > with no bug and test it with syzbot as well.
> > > > > >=20
> > > > > > Have you run xfstests for the patch? Unfortunately, we have mul=
tiple xfstests
> > > > > > failures for HFS now. And you can check the list of known issue=
s here [1]. The
> > > > > > main point of such run of xfstests is to check that maybe some =
issue(s) could be
> > > > > > fixed by the patch. And, more important that you don't introduc=
e new issues. ;)
> > > > > >=20
> > > > > I have tried to run the xfstests with a kernel built with my patc=
h and
> > > > > also without my patch for TEST and SCRATCH devices and in both ca=
ses my
> > > > > system crashes in running the generic/631 test.Still unsure of the
> > > > > cause. For more context, I'm running the tests on the 6.18-rc5 ve=
rsion
> > > > > of the kernel and the devices and the environment setup is as fol=
lows:
> > > > >=20
> > > > > For device creation and mounting(also tried it with dd and had sa=
me
> > > > > results):
> > > > > fallocate -l 10G test.img
> > > > > fallocate -l 10G scratch.img
> > > > > sudo mkfs.hfs test.img
> > > > > sudo losetup /dev/loop0 ./test.img
> > > > > sudo losetup /dev/loop1 ./scratch.img
> > > > > sudo mkdir -p /mnt/test /mnt/scratch
> > > > > sudo mount /dev/loop0 /mnt/test
> > > > >=20
> > > > > For environment setup(local.config):
> > > > > export TEST_DEV=3D/dev/loop0
> > > > > export TEST_DIR=3D/mnt/test
> > > > > export SCRATCH_DEV=3D/dev/loop1
> > > > > export SCRATCH_MNT=3D/mnt/scratch
> > > >=20
> > > > This is my configuration:
> > > >=20
> > > > export TEST_DEV=3D/dev/loop50
> > > > export TEST_DIR=3D/mnt/test
> > > > export SCRATCH_DEV=3D/dev/loop51
> > > > export SCRATCH_MNT=3D/mnt/scratch
> > > >=20
> > > > export FSTYP=3Dhfs
> > > >=20
> > > Ah, Missed that option. I will try with that in my next testing.
> > > > Probably, you've missed FSTYP. Did you tried to run other file syst=
em at first
> > > > (for example, ext4) to be sure that everything is good?
> > > >=20
> > > No, I barely squeezed in time today to the testing for the HFS so I
> > > didn't do any preliminary testing but I will check that too my next r=
un
> > > before trying to test HFS.
> > > > >=20
> > > > > Ran the tests using:sudo ./check -g auto
> > > > >=20
> > > >=20
> > > > You are brave guy. :) Currently, I am trying to fix the issues for =
quick group:
> > > >=20
> > > > sudo ./check -g quick
> > > >=20
> > > I thought I needed to do a more exhaustive testing so I went with aut=
o.
> > > I will try to experiment with quick my next round of testing. Thanks =
for
> > > the heads up!
> > > > > If more context is needed to know the point of failure or if I ha=
ve made
> > > > > a mistake during setup I'm happy to receive your comments since t=
his is
> > > > > my first time trying to run xfstests.
> > > > >=20
> > > >=20
> > > > I don't see the crash on my side.
> > > >=20
> > > > sudo ./check generic/631
> > > > FSTYP         -- hfs
> > > > PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 6.18.0-rc3+ #96 =
SMP
> > > > PREEMPT_DYNAMIC Wed Nov 19 12:47:37 PST 2025
> > > > MKFS_OPTIONS  -- /dev/loop51
> > > > MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch
> > > >=20
> > > > generic/631       [not run] attr namespace trusted not supported by=
 this
> > > > filesystem type: hfs
> > > > Ran: generic/631
> > > > Not run: generic/631
> > > > Passed all 1 tests
> > > >=20
> > > > This test simply is not running for HFS case.
> > > >=20
> > > > I see that HFS+ is failing for generic/631, but I don't see the cra=
sh. I am
> > > > running 6.18.0-rc3+ but I am not sure that 6.18.0-rc5+ could change=
 something
> > > > dramatically.
> > > >=20
> > > > My guess that, maybe, xfstests suite is trying to run some other fi=
le system but
> > > > not HFS.
> > > >=20
> > > I'm assuming that it's running HFSPLUS testing foir me because I just
> > > realised that the package that I downloaded to do mkfs.hfs is just a
> > > symlink to mkfs.hfsplus. Also I didn't find a package(in arch) for
> > > mkfs.hfs in my quick little search now. All refer to mkfs.hfsplus as =
if
> > > mkfs.hfs is deprecated somehow. I will probably build it from source =
if
> > > available with fsck.hfs... Eitherway, even if i was testing for HFSPL=
US
> > > i don't think that a fail on generic/631 would crash my system multip=
le
> > > times with different kernels. I would have to test with ext4 before a=
nd
> > > play around more to find out why that happened..
> >=20
> > The mkfs.hfs is symlink on mkfs.hfsplus and the same for fsck. The mkfs=
.hfsplus
> > can create HFS volume by using this option:
> >=20
> > -h create an HFS format filesystem (HFS Plus is the default)
> >=20
> > I don't have any special package installed for HFS on my side.
> >=20
> In my case, -h option in mkfs.hfsplus doesn't create hfs format=20
> filesystem. I checked kernel docs and found this[1] which refers to a=20
> package called hfsutils which has hformat as a binary for creating HFS=20
> filesystems. I just got it and used it successfully. I will be rerunning=
=20
> all tests soon.
> [1]:https://docs.kernel.org/filesystems/hfs.html =20
> > Thanks,
> > Slava.
> >=20
> Also did you check my other comments on the code part of your last=20
> reply? Just making sure. Thanks.
>=20
> Best Regards,
> Mehdi Ben Hadj Khelifa
> > > > > > >=20
> > > > > > >     fs/hfs/super.c | 16 ++++++++++++----
> > > > > > >     1 file changed, 12 insertions(+), 4 deletions(-)
> > > > > > >=20
> > > > > > > diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> > > > > > > index 47f50fa555a4..06e1c25e47dc 100644
> > > > > > > --- a/fs/hfs/super.c
> > > > > > > +++ b/fs/hfs/super.c
> > > > > > > @@ -49,8 +49,6 @@ static void hfs_put_super(struct super_bloc=
k *sb)
> > > > > > >     {
> > > > > > >     	cancel_delayed_work_sync(&HFS_SB(sb)->mdb_work);
> > > > > > >     	hfs_mdb_close(sb);
> > > > > > > -	/* release the MDB's resources */
> > > > > > > -	hfs_mdb_put(sb);
> > > > > > >     }
> > > > > > >    =20
> > > > > > >     static void flush_mdb(struct work_struct *work)
> > > > > > > @@ -383,7 +381,6 @@ static int hfs_fill_super(struct super_bl=
ock *sb, struct fs_context *fc)
> > > > > > >     bail_no_root:
> > > > > > >     	pr_err("get root inode failed\n");
> > > > > > >     bail:
> > > > > > > -	hfs_mdb_put(sb);
> > > > > > >     	return res;
> > > > > > >     }
> > > > > > >    =20
> > > > > > > @@ -431,10 +428,21 @@ static int hfs_init_fs_context(struct f=
s_context *fc)
> > > > > > >     	return 0;
> > > > > > >     }
> > > > > > >    =20
> > > > > > > +static void hfs_kill_sb(struct super_block *sb)
> > > > > > > +{
> > > > > > > +	generic_shutdown_super(sb);
> > > > > > > +	hfs_mdb_put(sb);
> > > > > > > +	if (sb->s_bdev) {
> > > > > > > +		sync_blockdev(sb->s_bdev);
> > > > > > > +		bdev_fput(sb->s_bdev_file);
> > > > > > > +	}
> > > > > > > +
> > > > > > > +}
> > > > > > > +
> > > > > > >     static struct file_system_type hfs_fs_type =3D {
> > > > > > >     	.owner		=3D THIS_MODULE,
> > > > > > >     	.name		=3D "hfs",
> > > > > > > -	.kill_sb	=3D kill_block_super,
> > > >=20
> > > > I've realized that if we are trying to solve the issue with pure ca=
ll of
> > > > kill_block_super() for the case of HFS/HFS+, then we could have the=
 same trouble
> > > > for other file systems. It make sense to check that we do not have =
likewise
> > > > trouble for: bfs, hpfs, fat, nilfs2, ext2, ufs, adfs, omfs, isofs, =
udf, minix,
> > > > jfs, squashfs, freevxfs, befs.
> > > While I was doing my original fix for hfs, I did notice that too. Many
> > > other filesystems(not all) don't have a "custom" super block destroyer
> > > and they just refer to the generic kill_block_super() function which
> > > might lead to the same problem as HFS and HFS+. That would more diggi=
ng
> > > too. I will see what I can do next when we finish HFS and potentially
> > > HFS+ first.
> > > >=20
> > > > > >=20
> > > > > > It looks like we have the same issue for the case of HFS+ [2]. =
Could you please
> > > > > > double check that HFS+ should be fixed too?
> > > > > >=20
> > > > > I have checked the same error path and it seems that hfsplus_sb_i=
nfo is
> > > > > not freed in that path(I could provide the exact call stack which=
 would
> > > > > cause such a memory leak) although I didn't create or run any
> > > > > reproducers for this particular filesystem type.
> > > > > If you would like a patch for this issue, would something like wh=
at is
> > > > > shown below be acceptable? :
> > > > >=20
> > > > > +static void hfsplus_kill_super(struct super_block *sb)
> > > > > +{
> > > > > +       struct hfsplus_sb_info *sbi =3D HFSPLUS_SB(sb);
> > > > > +
> > > > > +       kill_block_super(sb);
> > > > > +       kfree(sbi);
> > > > > +}
> > > > > +
> > > > >     static struct file_system_type hfsplus_fs_type =3D {
> > > > >            .owner          =3D THIS_MODULE,
> > > > >            .name           =3D "hfsplus",
> > > > > -       .kill_sb        =3D kill_block_super,
> > > > > +       .kill_sb        =3D hfsplus_kill_super,
> > > > >            .fs_flags       =3D FS_REQUIRES_DEV,
> > > > >            .init_fs_context =3D hfsplus_init_fs_context,
> > > > >     };
> > > > >=20
> > > > > If there is something to add, remove or adjust. Please let me kno=
w in
> > > > > the case of you willing accepting such a patch of course.
> > > >=20
> > > > We call hfs_mdb_put() for the case of HFS:
> > > >=20
> > > > void hfs_mdb_put(struct super_block *sb)
> > > > {
> > > > 	if (!HFS_SB(sb))
> > > > 		return;
> > > > 	/* free the B-trees */
> > > > 	hfs_btree_close(HFS_SB(sb)->ext_tree);
> > > > 	hfs_btree_close(HFS_SB(sb)->cat_tree);
> > > >=20
> > > > 	/* free the buffers holding the primary and alternate MDBs */
> > > > 	brelse(HFS_SB(sb)->mdb_bh);
> > > > 	brelse(HFS_SB(sb)->alt_mdb_bh);
> > > >=20
> > > > 	unload_nls(HFS_SB(sb)->nls_io);
> > > > 	unload_nls(HFS_SB(sb)->nls_disk);
> > > >=20
> > > > 	kfree(HFS_SB(sb)->bitmap);
> > > > 	kfree(HFS_SB(sb));
> > > > 	sb->s_fs_info =3D NULL;
> > > > }
> > > >=20
> > > > So, we need likewise course of actions for HFS+ because we have mul=
tiple
> > > > pointers in superblock too:
> > > >=20
> > > IIUC, hfs_mdb_put() isn't called in the case of hfs_kill_super() in
> > > christian's patch because fill_super() (for the each specific
> > > filesystem) is responsible for cleaning up the superblock in case of
> > > failure and you can reference christian's patch[1] which he explained
> > > the reasoning for here[2].And in the error path the we are trying to
> > > fix, fill_super() isn't even called yet. So such pointers shouldn't be
> > > pointing to anything allocated yet hence only freeing the pointer to =
the
> > > sb_info here is sufficient I think.

I was confused that your code with hfs_mdb_put() is still in this email. So,
yes, hfs_fill_super()/hfsplus_fill_super() try to free the memory in the ca=
se of
failure. It means that if something wasn't been freed, then it will be issu=
e in
these methods. Then, I don't see what should else need to be added here. So=
me
file systems do sb->s_fs_info =3D NULL. But absence of this statement is not
critical, from my point of view.

Thanks,
Slava.

> > > [1]:https://github.com/brauner/linux/commit/058747cefb26196f3c192c76c=
631051581b29b27 =20
> > > [2]:https://lore.kernel.org/all/20251119-delfin-bioladen-6bf291941d4f=
@brauner/ =20
> > > > struct hfsplus_sb_info {
> > > > 	void *s_vhdr_buf;
> > > > 	struct hfsplus_vh *s_vhdr;
> > > > 	void *s_backup_vhdr_buf;
> > > > 	struct hfsplus_vh *s_backup_vhdr;
> > > > 	struct hfs_btree *ext_tree;
> > > > 	struct hfs_btree *cat_tree;
> > > > 	struct hfs_btree *attr_tree;
> > > > 	atomic_t attr_tree_state;
> > > > 	struct inode *alloc_file;
> > > > 	struct inode *hidden_dir;
> > > > 	struct nls_table *nls;
> > > >=20
> > > > 	/* Runtime variables */
> > > > 	u32 blockoffset;
> > > > 	u32 min_io_size;
> > > > 	sector_t part_start;
> > > > 	sector_t sect_count;
> > > > 	int fs_shift;
> > > >=20
> > > > 	/* immutable data from the volume header */
> > > > 	u32 alloc_blksz;
> > > > 	int alloc_blksz_shift;
> > > > 	u32 total_blocks;
> > > > 	u32 data_clump_blocks, rsrc_clump_blocks;
> > > >=20
> > > > 	/* mutable data from the volume header, protected by alloc_mutex */
> > > > 	u32 free_blocks;
> > > > 	struct mutex alloc_mutex;
> > > >=20
> > > > 	/* mutable data from the volume header, protected by vh_mutex */
> > > > 	u32 next_cnid;
> > > > 	u32 file_count;
> > > > 	u32 folder_count;
> > > > 	struct mutex vh_mutex;
> > > >=20
> > > > 	/* Config options */
> > > > 	u32 creator;
> > > > 	u32 type;
> > > >=20
> > > > 	umode_t umask;
> > > > 	kuid_t uid;
> > > > 	kgid_t gid;
> > > >=20
> > > > 	int part, session;
> > > > 	unsigned long flags;
> > > >=20
> > > > 	int work_queued;               /* non-zero delayed work is queued =
*/
> > > > 	struct delayed_work sync_work; /* FS sync delayed work */
> > > > 	spinlock_t work_lock;          /* protects sync_work and work_queu=
ed */
> > > > 	struct rcu_head rcu;
> > > > };
> > > >=20
> > >=20
> > >=20
> > > > Thanks,
> > > > Slava.
> > > >=20
> > > Best Regards,
> > > Mehdi Ben Hadj Khelifa
> > >=20
> > > > >=20
> > > > > > > +	.kill_sb	=3D hfs_kill_sb,
> > > > > > >     	.fs_flags	=3D FS_REQUIRES_DEV,
> > > > > > >     	.init_fs_context =3D hfs_init_fs_context,
> > > > > > >     };
> > > > > >=20
> > > > > > [1] https://github.com/hfs-linux-kernel/hfs-linux-kernel/issues=
 =20
> > > > > > [2] https://elixir.bootlin.com/linux/v6.18-rc6/source/fs/hfsplu=
s/super.c#L694 =20


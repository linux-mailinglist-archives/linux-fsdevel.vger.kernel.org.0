Return-Path: <linux-fsdevel+bounces-40421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21186A2336D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 18:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AACD03A4CFB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 17:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5253A1EBA0B;
	Thu, 30 Jan 2025 17:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="jSyaAzTz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E2112CDA5;
	Thu, 30 Jan 2025 17:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738259395; cv=fail; b=octOcbHncsmLJMdVAhI3ORIUqTBbRH8e9TF3z5D3lMo3V87B/cuHkJm2s6nW+NEokPfb85VqtRbSzJ/Cmux/1j2GGlTDQh+ee0jednRllmxrNO7XNEMLDIhq1TluUyVNwfMI5dehuI/yQBimuPu9Jecz3FHLDzndZvetyGLMcb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738259395; c=relaxed/simple;
	bh=+/D+eHnyL07FSWIUB3w+x1v1y4PYHhbQLI6kOpo7ejs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nBZMvT808YyWSJPl1oQKQadoOHvCBQLgbnM0UeEdarg8L39GKo7Oox4S3R1iR7jnFg1ZgnCs5ZGAtkxo+24oMZLM15ZznQyoO745QnqCrZM/sOzdlXQ5Asxo7TvL1hnyLhgl1GYkvgi4ED94FtoCmRcdGDGFrr+2wn8XIn1IrFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=jSyaAzTz; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UHbFQ3015463;
	Thu, 30 Jan 2025 09:49:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=+/D+eHnyL07FSWIUB3w+x1v1y4PYHhbQLI6kOpo7ejs=; b=
	jSyaAzTz/XtNfYfUGvDt+7tRSmuxXkKtZiGEYz5RPY2Dpr2ytjil1if4oqxvphHC
	5pqAup4y9+DBHIMiGcvUNeo97xUAX2rBqePnNwJgFolv1yNWATyaSoMaISYbCBxq
	eEcfc3XMLvhTvsrUtjS/VF4DTyJhyX3+vxtcYYqQqA0hPrZzHUuV0PNaEYmVNiNk
	Iw0FuH4JFxRPIV6L09XnUC/eCfFvXCwjHaAvrYun46USeTFs9GE5WVreRy5p3e/t
	GhnXhQ4Ay7O6VkB7zVcbeeCaCUIKR7gNeT7r3OnpAByULiiO0Uzv7lkGEQ9XcAGp
	49hfVtU6S/RoDCOSBqApqg==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 44gcpk0r2s-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 09:49:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w6leLq/HaANWVjtPEfDuC8gxlD5o8VqggN+54M/5eIX/z4ZMrCfhrDfhlVoaC9ZQg7qmAq6XbiZ+jFp9Mq2NmSQ/fzsOf0eiBG3d74ZUPJPWU9uS2NqPuKQ8j+TyWHB/w0Yq5L1TJ1jUr+qHaj+TO4ljUErfKAQAD3/Td/Y03rZd5twdQhgNEBE9fEF5t0z/0pz/EgLwi1WQJzPmIgnDEimAt1nsxuTK57fvliysnyCTIJV4jjli3pOKxDMzu96OyuMDvvj1gM4KJzzuGkKzR2nRwFHElzC6sgVwWDO1bkZ2K+tBIAa7asbPnvv9POFPMPlDJmMZi6B9pxldtuO7YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/D+eHnyL07FSWIUB3w+x1v1y4PYHhbQLI6kOpo7ejs=;
 b=APJSh/QhzzLVgvXuFmaQIN6Sz42d68oNGKWrQOB5qeoEyf/2nD9WMYSgG6rtdJOI89QuYwiEcl815+l9Vm95k85PUrjWuUZF7fgWu0G74hD/pGz03DP41RDXpHObngeoIv8Gkmby8dccVb1WB7iyiWwWWbUd6z2JMufcSGyB/rkTj/kOONP930A2sIpRT48IijsmBlsZTIWfdu+gGm2fa4ioNpCvV4+K5fTHXiHmhfVd2USWF2Q1UCHXoUWbBacyOP5vs2rqTP2/h/roqfGSqsAdFnzs9rRHdAApBWzUWwirhtkhx09c4Tuv5GvSdZM/JExwb/bEeIe7a28K+hahuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by MN0PR15MB5321.namprd15.prod.outlook.com (2603:10b6:208:370::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Thu, 30 Jan
 2025 17:49:50 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%4]) with mapi id 15.20.8398.020; Thu, 30 Jan 2025
 17:49:50 +0000
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
        Liam Wisehart <liamwisehart@meta.com>,
        Shankaran
 Gnanashanmugam <shankaran@meta.com>
Subject: Re: [PATCH v11 bpf-next 5/7] bpf: Use btf_kfunc_id_set.remap logic
 for bpf_dynptr_from_skb
Thread-Topic: [PATCH v11 bpf-next 5/7] bpf: Use btf_kfunc_id_set.remap logic
 for bpf_dynptr_from_skb
Thread-Index: AQHbcpDg6p82hSN7HE+NyWUR/2AbNLMumScAgAEAYYA=
Date: Thu, 30 Jan 2025 17:49:50 +0000
Message-ID: <58833120-DD06-4024-B7F5-E255AC9261E6@fb.com>
References: <20250129205957.2457655-1-song@kernel.org>
 <20250129205957.2457655-6-song@kernel.org>
 <CAADnVQ+1Woq_mh_9iz+Dhdhw1TuXZgVrx38+aHn-bGZBVa5_uw@mail.gmail.com>
In-Reply-To:
 <CAADnVQ+1Woq_mh_9iz+Dhdhw1TuXZgVrx38+aHn-bGZBVa5_uw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.300.87.4.3)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|MN0PR15MB5321:EE_
x-ms-office365-filtering-correlation-id: c6735be1-22db-4eac-6d55-08dd41567e6c
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d1NXd3E1ZXpRVzh0c25pcHJpTkl2cWZoWkYvbmNuTWpjc1h6UEVNSnF1dUlF?=
 =?utf-8?B?anF4a1ppWTd4T0xrNk5TNzVoT2JWcWRPQUJrT243TjNidWJSckZRQWp4SnQ3?=
 =?utf-8?B?UmxpZnZ3TjJ6U0cwOWFZcUs2bGg5dEFubllRbUNxK2Fmb0lrKzVUNW5tL3hT?=
 =?utf-8?B?Ny8yNDZQZHhSdGtrWVlWa0JrVVM2bjk4dmxpaE9NcFlDNDFSTWsxRWswUjVt?=
 =?utf-8?B?NnZLLzc4U2xoUU5TbE9MalJwYXRiTHByS1VMUS9YNC9vaUF2R3lCZ1J0VWJn?=
 =?utf-8?B?Wmo3TC9DM1FTRmswS1ZFWVRvQ2YxQ1BqdGd6dm05N3lLK3M4S3ZocFJlLy9L?=
 =?utf-8?B?QytIVlBuZjlWM2JPRzBWUlBrV1MrcnNXRStuVkFLelcyQ0FQK3ZXekF0MTFC?=
 =?utf-8?B?Y09BZ0YrOHprczlKWXNOUlp1bUI4akhaMUh2aUlSQ0pKK1E2c0VPTEZwYXRT?=
 =?utf-8?B?WU5KNVNiR2ZUcnRGT2hJajdFUzRtc0QvSkZMcGFKajV1K3JKZXY4ZUJHL1Bq?=
 =?utf-8?B?ck9McHZVU1lkOWpnblVabEJwZnN0T2lPVmxnQUJKV0d5cUN0blU1UXdDb2du?=
 =?utf-8?B?c2R6K251bHBPYkVsZmd0aEVsK2JsZjNqU3A5MFczZk1aemRISUo3WDRxRy9C?=
 =?utf-8?B?K2VlZC9pbk5yMGlWelBnQWw4MGc3ZHU3REVVcVpISkwwR0djMVYwV2g1WVpy?=
 =?utf-8?B?djVWdjlmdFpXWGxaRHJkRy9xQW5IaCtXdVBTeUdpRXYyUHNHRjZlV3A1bnZm?=
 =?utf-8?B?YlZTUUhJMExhYXlldDlnVHBnWTJaZEVuR3crK2ZTa0dub1EzRGFaRHd6VzNa?=
 =?utf-8?B?N2tvNU5hMmdJdjlOUEhxdE90Z0F5Q1kySTZsR0NoVUYxV0NhSTZpdlhFMEx0?=
 =?utf-8?B?UEVhVFBRZmNaZXFCd05oMGNnSE1mUHFJQmhYMSthQzJHd3lBZFZzMUxrZGN3?=
 =?utf-8?B?elJuVkdqa1Foa0ZnUmtnWU1uSlIzSWI5K3hnamY3RzQvL2M3bURlWG5nSjI4?=
 =?utf-8?B?cDl4Q1NqQmlLbHJOdDZEQndkVG1NcUQ2WFYwNzlyV3NpcEZ4dVlycm8wbklV?=
 =?utf-8?B?NWovTlN1dXZBZ0lUWndhenhoVGxOdXJ2OTRVZG04dVl5UUJRTi85bGl2M1g2?=
 =?utf-8?B?ZHFTZUhLa3JiWkNjVWxvT01hakRPV2FQS3BrZ1UrbWg4SVB4TjlXS1E1eTEx?=
 =?utf-8?B?MG1VNjJRNk8vQ0tqOUFSWVhNdzhLOUF5THplVVEwWDVOcVBnWitScUN3dCtQ?=
 =?utf-8?B?YTV5RDNEOWZaazJyejUzOGd5MzBmcVRPckJKSWhIdWZpeWFWRlZDai8zWmpo?=
 =?utf-8?B?cHYvSUVxcVRCUUJYajE4c0xRUmhDWkxXQXhkTnR5RkxhNkN4YnljT3ZZK1lW?=
 =?utf-8?B?aUc3RHZGZGp5WGhFMUFEUFJQREg5ek9nRUM0NXkrWkNaVGdwT3plVGNvRWZY?=
 =?utf-8?B?SWgyTmVUbTNEeWo0dFdnWXNvNjZDTERnb3pCT09lTWdsWEg1L3IyK3BvMlZp?=
 =?utf-8?B?VVYxVjFsU1NqOUNrVUNMRFljcnUvblB0UFRpOXE3ZzV4SXNDUXlKNWFmMVRw?=
 =?utf-8?B?RURjc2ZOaWtZU0l0NGdwL0ZhaUNkVkczVVArTE8yZkl0WHBVcDNIbFczWHhO?=
 =?utf-8?B?OVF2cVhYQ2Vmdi9XWCtsenloRXB5ajQyZVExUXV2bkVsWWpJdzBuUEhTR0o4?=
 =?utf-8?B?aVJ1elJic1lYeXZxeXhWbEI1SGVYUnkxS1ZyNEtGbUIyQlJMRGh4dnNiV29J?=
 =?utf-8?B?OXJJM0NSRzBFbVNEQW5CcVFkWDllT2NDdlNUVHpJR013K0tON292YjQxcGEy?=
 =?utf-8?B?bHZXMzNFSGhFdi9Mdk9GUFRTcmh4dUdHMmhuRjVPMHRmYnV2MDMyL0dqZjRk?=
 =?utf-8?B?dDJSYVJkVm9PNG9vRXoxalhHUlNhOFNuM3ovYkh4UExoU0ozQlN4ZWZHUm15?=
 =?utf-8?Q?Fz1qQQoCFThrURrDrDDQq7ZkGEwxKlQj?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?djNhVm8wS29rcEZQcDBpVkdGeVNSQUxpUVIvQmJ5ajlzSGpwUjlyNXBwaDZl?=
 =?utf-8?B?SVdQaHlxSkxWdURheVhmeGNjUExpNlJkZUhvU2RVblRQRW9zVkxKdFdONTNk?=
 =?utf-8?B?ZGhLRm1nN0x0Tnh1akFDbElDeUhlRW1PdXN2aVl4dWkycDhiam9qcVBzM2g4?=
 =?utf-8?B?VTIwcTBYVGxlZHpYanBVTUFvNVhSeTI2dWJmNStvZHljcEluUFBBNXBHNURs?=
 =?utf-8?B?ZU1kclJ1WEtyNUExYm9YYko3Z2I4c2J6RUhFRkZPTDBvOVFMNkhLY0dBd21H?=
 =?utf-8?B?Vys1LzA1OVZIQXpBUnlhbk04SXUwdGV6K3JjaHU5VTY0SmdnMWpFVld0RHVE?=
 =?utf-8?B?RDdGR0VIZ3l4UU4yTk9MdnZyZEtwWW5SVE1wSUFiYWtCR0dTT2kwZ2xLTjVa?=
 =?utf-8?B?N0swODlzdkNpcisyUGovVmZ1MWNCTFMwQ0xqRGZxNHRPU0tVN3RKVUVOUThZ?=
 =?utf-8?B?cy9hSmFCZWlMdEpGR0pKNWN0UWdMMUdjVWpvT1ZGczIra0FIYThxb1dOVDNC?=
 =?utf-8?B?eHU0UFJISHlZdkFUV2Nhb0U5QTNubkphWmRMK3U2WUlmRHlwT0pWa2JtZWk3?=
 =?utf-8?B?dWIwaGdUQjlhYUZ0ekY1azNEd2R4QldUYzlFWHArYUx5NndkVDdiYWd4Und5?=
 =?utf-8?B?U2s1SHJZSUtLeTZXdDZRUDNrSzYwQlNWUW80YWIwT1gzU3pnQVlUUGVSZlZV?=
 =?utf-8?B?Z25qS1h3WEEzRENmVVFmVXNsR1BibE5nL2tRcnQ2dDZxRmZWOXVyejhzbFdQ?=
 =?utf-8?B?T1dLOTNxeVYzVmNJMGtJZHYrTk9NTHBTU0o1aUc3V1BiQUFGcWV1a25STDVt?=
 =?utf-8?B?Y3RXbDl0TlBjNkF2VVRsOWVTZFJqbFlobHZ5SHAzdnFzQm56QmpRbUlHU0s1?=
 =?utf-8?B?bG50YUFlWHY4SitpQVdCVGZIc2cwcjBNd1FhRWNIZTRCcGcvV21LdGxzeEkz?=
 =?utf-8?B?NmdRVmlwOEJzVUVUSmJvU2JZVy92T0NrNzdnVmxMRUczdmNJZzNoMWRpdjM5?=
 =?utf-8?B?Vng1K01ZQVBQTEJpa3pvNzF1cVcvWllWcytDKzUzYzVLQ1MzNE81RDhWNU5m?=
 =?utf-8?B?NzNGUXRjMnJ6d003bzNad1RMc21LdzdsTmdIS0JBN21paXdZZzRNL01GbWI3?=
 =?utf-8?B?dFVld2pXVGJSWFFWclRJUDVEM3YxMGpJcW1MVlIxWnk1VDhEM2VrK1pEaDRT?=
 =?utf-8?B?a2t2Ujc2bTI3MkdtdU5GNVoxa05kVjNuU0x5K3pSd1lHLzNwTEZaZ0RKajNn?=
 =?utf-8?B?b2JiL3NJUFQ0NVR0SmlLUkJ3OEszVlc3TVdGYlMwcEo4b1M1TzNIWmkwdXhi?=
 =?utf-8?B?RXJQeHk5NDhPT1Rjc3lsSElNR3BWQm9TOFRaeERYZkFwcUs2K2RFZEFVRU1v?=
 =?utf-8?B?Um1OOGxXblBTdFhWcTFkNmFqcmI5Z2RVVkpXbzdrUkdWQVJpbTlCbEVjdTQ4?=
 =?utf-8?B?alFiVFU0dmpaV1oreVlzckhSM0pXWTdUUE9TU1VjdzlVcGxHYmxtc0F4cm5r?=
 =?utf-8?B?TDJzeHNDZ0JpZE93b1hIQlB4Y2hacWRIL1FuMXRDbWZvcHFvaWptNG53ZnE5?=
 =?utf-8?B?cjFFSUJoVyt4UnVmZzYxQ0t4cXdxYUFrVTRQMUN3SlpJcE94MXc5NFlOS2Zr?=
 =?utf-8?B?SVA2cU5tdUVWcjI3L0tsMVpPNjZHbnY3d0krWVBVNmVNWWl1cjY3ZGp6NlZ3?=
 =?utf-8?B?eUkweEgraU9xSzE0dlZjK0lDb1hlUW9Id3BVVEgva0VwUHVDTW5kVFlXbkVm?=
 =?utf-8?B?WGlsWEc0TkNLcUFZL0RFR1Z5QzNYOXg4UHJ2TVFwcEhMZ1RORUNXYndXTlc0?=
 =?utf-8?B?czdXejQ4MW9oZGNFT3NIV1lYK1VWMStHUC82bUE2Z3R4aWdzZTIxcHFzTDY0?=
 =?utf-8?B?dVlJZmdOZWtaUXpKM3EyTStnQTN1eG4rZVJ0dEFMbXJuQXRKVFpHdTdnMDlW?=
 =?utf-8?B?Tks5TWp1VmVsNjJ4cEpwd01UUWxGWG1rZ1hnVVJCYVdjcjRaaVBsWUpMbG01?=
 =?utf-8?B?c2EzNkpIOFZyMHZ5d0FWeGNUb3U0QXZDcFFXWHBZKzYySFVYUk5CY0ppajVp?=
 =?utf-8?B?cmRyaUhhRGppbFRWMk5SMWJDalBVRGxpQ2E4bS9uaTk5MGppSlNvNWIwUEp6?=
 =?utf-8?B?SU9LTTZDL2YvWC9uOUk1Q2ViVjl5dWtvTTNVb0oyQTJmMk94dzZWQVV3akJI?=
 =?utf-8?B?dWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <878999D3A7DD6B4F81B6BD777FE8E319@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c6735be1-22db-4eac-6d55-08dd41567e6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2025 17:49:50.0258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N0SnCLnsMdZ5i7PmA9ZHq9nrz62ouIYnfK6vc/LeiNcuJSV3cTu+feOUkLCZRjWZfeV+3JTL6AY+RUQZxCuGvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR15MB5321
X-Proofpoint-GUID: qSV8QQvZHdhhYOFbAduSTNYhCPOl9rSD
X-Proofpoint-ORIG-GUID: qSV8QQvZHdhhYOFbAduSTNYhCPOl9rSD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_08,2025-01-30_01,2024-11-22_01

SGkgQWxleGVpLCANCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3IQ0KDQo+IE9uIEphbiAyOSwgMjAy
NSwgYXQgNjozMuKAr1BNLCBBbGV4ZWkgU3Rhcm92b2l0b3YgPGFsZXhlaS5zdGFyb3ZvaXRvdkBn
bWFpbC5jb20+IHdyb3RlOg0KDQpbLi4uXQ0KDQo+PiANCj4+ICtCVEZfSURfTElTVChicGZfZHlu
cHRyX2Zyb21fc2tiX2xpc3QpDQo+PiArQlRGX0lEKGZ1bmMsIGJwZl9keW5wdHJfZnJvbV9za2Ip
DQo+PiArQlRGX0lEKGZ1bmMsIGJwZl9keW5wdHJfZnJvbV9za2JfcmRvbmx5KQ0KPj4gKw0KPj4g
K3N0YXRpYyB1MzIgYnBmX2tmdW5jX3NldF9za2JfcmVtYXAoY29uc3Qgc3RydWN0IGJwZl9wcm9n
ICpwcm9nLCB1MzIga2Z1bmNfaWQpDQo+PiArew0KPj4gKyAgICAgICBpZiAoa2Z1bmNfaWQgIT0g
YnBmX2R5bnB0cl9mcm9tX3NrYl9saXN0WzBdKQ0KPj4gKyAgICAgICAgICAgICAgIHJldHVybiAw
Ow0KPj4gKw0KPj4gKyAgICAgICBzd2l0Y2ggKHJlc29sdmVfcHJvZ190eXBlKHByb2cpKSB7DQo+
PiArICAgICAgIC8qIFByb2dyYW0gdHlwZXMgb25seSB3aXRoIGRpcmVjdCByZWFkIGFjY2VzcyBn
byBoZXJlISAqLw0KPj4gKyAgICAgICBjYXNlIEJQRl9QUk9HX1RZUEVfTFdUX0lOOg0KPj4gKyAg
ICAgICBjYXNlIEJQRl9QUk9HX1RZUEVfTFdUX09VVDoNCj4+ICsgICAgICAgY2FzZSBCUEZfUFJP
R19UWVBFX0xXVF9TRUc2TE9DQUw6DQo+PiArICAgICAgIGNhc2UgQlBGX1BST0dfVFlQRV9TS19S
RVVTRVBPUlQ6DQo+PiArICAgICAgIGNhc2UgQlBGX1BST0dfVFlQRV9GTE9XX0RJU1NFQ1RPUjoN
Cj4+ICsgICAgICAgY2FzZSBCUEZfUFJPR19UWVBFX0NHUk9VUF9TS0I6DQo+IA0KPiBUaGlzIGNv
cHkgcGFzdGVzIHRoZSBsb2dpYyBmcm9tIG1heV9hY2Nlc3NfZGlyZWN0X3BrdF9kYXRhKCksDQo+
IHNvIGFueSBmdXR1cmUgY2hhbmdlIHRvIHRoYXQgaGVscGVyIHdvdWxkIG5lZWQgdG8gdXBkYXRl
DQo+IHRoaXMgb25lIGFzIHdlbGwuDQoNCldlIGNhbiBwcm9iYWJseSBpbXByb3ZlIHRoaXMgd2l0
aCBzb21lIGhlbHBlcnMvbWFjcm9zLiANCg0KPiANCj4+ICsgICAgICAgICAgICAgICByZXR1cm4g
YnBmX2R5bnB0cl9mcm9tX3NrYl9saXN0WzFdOw0KPiANCj4gVGhlIFswXSBhbmQgWzFdIHN0dWZm
IGlzIHF1aXRlIGVycm9yIHByb25lLg0KPiANCj4+ICsNCj4+ICsgICAgICAgLyogUHJvZ3JhbSB0
eXBlcyB3aXRoIGRpcmVjdCByZWFkICsgd3JpdGUgYWNjZXNzIGdvIGhlcmUhICovDQo+PiArICAg
ICAgIGNhc2UgQlBGX1BST0dfVFlQRV9TQ0hFRF9DTFM6DQo+PiArICAgICAgIGNhc2UgQlBGX1BS
T0dfVFlQRV9TQ0hFRF9BQ1Q6DQo+PiArICAgICAgIGNhc2UgQlBGX1BST0dfVFlQRV9YRFA6DQo+
PiArICAgICAgIGNhc2UgQlBGX1BST0dfVFlQRV9MV1RfWE1JVDoNCj4+ICsgICAgICAgY2FzZSBC
UEZfUFJPR19UWVBFX1NLX1NLQjoNCj4+ICsgICAgICAgY2FzZSBCUEZfUFJPR19UWVBFX1NLX01T
RzoNCj4+ICsgICAgICAgY2FzZSBCUEZfUFJPR19UWVBFX0NHUk9VUF9TT0NLT1BUOg0KPj4gKyAg
ICAgICAgICAgICAgIHJldHVybiBrZnVuY19pZDsNCj4+ICsNCj4+ICsgICAgICAgZGVmYXVsdDoN
Cj4+ICsgICAgICAgICAgICAgICBicmVhazsNCj4+ICsgICAgICAgfQ0KPj4gKyAgICAgICByZXR1
cm4gYnBmX2R5bnB0cl9mcm9tX3NrYl9saXN0WzFdOw0KPj4gK30NCj4+ICsNCj4+IHN0YXRpYyBj
b25zdCBzdHJ1Y3QgYnRmX2tmdW5jX2lkX3NldCBicGZfa2Z1bmNfc2V0X3NrYiA9IHsNCj4+ICAg
ICAgICAub3duZXIgPSBUSElTX01PRFVMRSwNCj4+ICAgICAgICAuc2V0ID0gJmJwZl9rZnVuY19j
aGVja19zZXRfc2tiLA0KPj4gKyAgICAgICAuaGlkZGVuX3NldCA9ICZicGZfa2Z1bmNfY2hlY2tf
aGlkZGVuX3NldF9za2IsDQo+IA0KPiBJZiBJJ20gcmVhZGluZyBpdCBjb3JyZWN0bHkgdGhlIGhp
ZGRlbl9zZXQgc2VydmVzIG5vIGFkZGl0aW9uYWwgcHVycG9zZS4NCj4gSXQgc3BsaXRzIHRoZSBz
ZXQgaW50byB0d28sIGJ1dCBwYXRjaCA0IGp1c3QgYWRkcyB0aGVtIHRvZ2V0aGVyLg0KDQpoaWRk
ZW5fc2V0IGRvZXMgbm90IGhhdmUgQlRGX1NFVDhfS0ZVTkNTLCBzbyBwYWhvbGUgd2lsbCBub3Qg
ZXhwb3J0IA0KdGhlc2Uga2Z1bmNzIHRvIHZtbGludXguaC4gDQoNCj4gDQo+PiArICAgICAgIC5y
ZW1hcCA9ICZicGZfa2Z1bmNfc2V0X3NrYl9yZW1hcCwNCj4gDQo+IEknbSBub3QgYSBmYW4gb2Yg
Y2FsbGJhY2tzIGluIGdlbmVyYWwuDQo+IFRoZSBtYWtlcyBldmVyeXRoaW5nIGhhcmRlciB0byBm
b2xsb3cuDQoNClRoaXMgbW90aXZhdGlvbiBoZXJlIGlzIHRvIG1vdmUgcG9seW1vcnBoaXNtIGxv
Z2ljIGZyb20gdmVyaWZpZXINCmNvcmUgdG8ga2Z1bmNzIG93bmVycy4gSSBndWVzcyB3ZSB3aWxs
IG5lZWQgc29tZSBjYWxsYmFjayB0byANCmFjaGlldmUgdGhpcyBnb2FsLiBPZiBjb3Vyc2UsIHdl
IGRvbid0IGhhdmUgdG8gZG8gaXQgaW4gdGhpcyBzZXQuIA0KIA0KDQo+IEZvciBhbGwgdGhlc2Ug
cmVhc29ucyBJIGRvbid0IGxpa2UgdGhpcyBhcHByb2FjaC4NCj4gVGhpcyAiZ2VuZXJhbGl0eSIg
ZG9lc24ndCBtYWtlIGl0IGNsZWFuZXIgb3IgZWFzaWVyIHRvIGV4dGVuZC4NCj4gRm9yIHRoZSBw
YXRjaCA2Li4uIGp1c3QgcmVwZWF0IHdoYXQgc3BlY2lhbGl6ZV9rZnVuYygpDQo+IGN1cnJlbnRs
eSBkb2VzIGZvciBkeW5wdHIgPw0KDQpZZXMsIHNwZWNpYWxpemVfa2Z1bmMoKSBjYW4gaGFuZGxl
IHRoaXMuIEJ1dCB3ZSB3aWxsIG5lZWQgdG8gdXNlDQpkX2lub2RlX2xvY2tlZF9ob29rcyBmcm9t
IDYvNyBpbiBzcGVjaWFsaXplX2tmdW5jKCkuIEl0IHdvcmtzLCANCmJ1dCBpdCBpcyBub3QgY2xl
YW4gKHRvIG1lKS4gDQoNCkkgd2lsbCByZXZpc2UgdGhpcyBzZXQgc28gdGhhdCB0aGUgcG9seW1v
cnBoaXNtIGxvZ2ljIGluIGhhbmRsZWQNCmluIHNwZWNpYWxpemVfa2Z1bmMoKS4gRm9yIGxvbmdl
ciB0ZXJtLCBtYXliZSB3ZSBzaG91bGQgZGlzY3VzcyANCiJtb3ZlIHNvbWUgbG9naWMgZnJvbSB2
ZXJpZmllciBjb3JlIHRvIGtmdW5jcyIgaW4gdGhlIHVwY29taW5nIA0KTFNGL01NL0JQRj8gDQoN
ClRoYW5rcywNClNvbmcNCg0K


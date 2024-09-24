Return-Path: <linux-fsdevel+bounces-29993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5773984B77
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 21:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 331541F236C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 19:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F03013BACB;
	Tue, 24 Sep 2024 19:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="cd31GVv7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAE03BBEF;
	Tue, 24 Sep 2024 19:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727205480; cv=fail; b=aHxIqTGwX9IDXHZVVE7+ky1w+4c9VA0NwaPyLiibjuZ+kKLOGJHFVc196bTCXDAOuu5B9XTTMq2zYfyTi6ZbIrdOX3FpS7DNU2Ktqh7ZFU/+ZZXcvFyUpY5FUl5ai3cKt1tTGLz3JoocsJhbL1eh5dh+deMVTAVGKFt/yuQ7NUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727205480; c=relaxed/simple;
	bh=XWl2+zbynb/a//zXYxKGd5QdCVqOIjOVoK2K1CBSaLc=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L9L0gDZZmABWo2FKbAVcJ7RdTs8kyUOlox8SZGdBKEfNrreXXgqlUwxFdo4IWM/ytMZkZaSQgGU6tRi0rYNYnm2fJZyP4P7fH9mJX6zrTCyr+YZI0YCFO4NoX70Sd2Ej1rZ863FgCh1LsFwmZqhz4jKWrcpbr4avCmEvBh6apXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=cd31GVv7; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48OHFAKq003266;
	Tue, 24 Sep 2024 12:17:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=
	message-id:date:subject:from:to:cc:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	s2048-2021-q4; bh=wmf2G4d/vJ/CwnSTka8Hj1sk96CAOKWQeYrTHrSi1W0=; b=
	cd31GVv7S7inYCREbZgdPk/5sxlzXNglxaSvjlDhiZ2Aui8bNw7YMr95g5cUcnOw
	wC7MTm/ZvD+JSlLHAp04yCp9oHai49Tn0VbnQC05UOCfJSY2iFx/ZG+FS9zggm5k
	FqpRKfORH4l+4VYTeW8kjLm4GpsqYxvvoFGVWB7rwraDpK1mHmX1XmDlXES8qnpM
	l/xQ7/xzzW5PXXyNLdSpT4BbBp1YXbkWMQL28bDnEBB6dbdTiYebauElMy2DaFUo
	ym1R1y9hzGjkBlPqjv3UiKJixT13nq2RF+YqnYM51GW6DObcxM4HhpIIUOweFPzE
	mL/PX5ldObU54ozZR/avBQ==
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41uxdhtkyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 12:17:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NU5AnTnZSf8bc6gqVD3m1Sh0dN19cbOuzJexg6ZYLuoUOGVyPON0CWptikkcgnSms2sOZJ5zCCXaATAgj0TRz6WQTZkcRDe6kk6iD7//FZd3Hj/rS/MGeD0zIKWmEbixPQ/qEN/xEcKkJ/Aqd28SFr8jhlx5g5izsgOmNAxXyQM6MpXLpNRdVv4lbFvCL65N7f3dMx6qcFna0lg1zzUWQctH2g7qYNrE8oL9Ai8iKfBnx+LiD9jeWa9wIZ81G1uqkyidOHFRWH/MyqH4OVbBJvg4QGivVBqBrT3xTZp63x7XqPSEgigvIRqdkbrEI5l3SFOYt/5ysUDSCyGHniLH1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmf2G4d/vJ/CwnSTka8Hj1sk96CAOKWQeYrTHrSi1W0=;
 b=m907Eq97MicFHJIb4Vd1dNY4HSYb4zy1GrWFvk25VuO65XUKIhYN1WsXJyzeb9QmGXObu5Z7a04EuUob99AyuGIUt3kSmJHmG7HFLDMpaI2O4mqvaNoJlngbvRnxpImeoCP/uxHzVhB2ya43sHghgXo5jBE9nq5HkG1ILiOqVa6NcfcfrjHw4BHzaZjlO9mYK0E+nfunar77LzWiA5ksp/6c33p3ty+zSwN41+nu7bxmaAKYN9CihVjdFcVpac4FHfunlFi0Rtwleu9gkoFglK7tkOgiQSwtj7W9sM+xRD65G2z84hbuCaVRJjcdnZK9W2lFCx8HUs7RgO80PLTMvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by PH0PR15MB4200.namprd15.prod.outlook.com (2603:10b6:510:21::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 19:17:16 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::27d6:9fe:3f9f:3d44]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::27d6:9fe:3f9f:3d44%5]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 19:17:16 +0000
Message-ID: <15f15df9-ec90-486a-a784-effb8b2cb292@meta.com>
Date: Tue, 24 Sep 2024 21:17:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
From: Chris Mason <clm@meta.com>
To: Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Christian Theune <ct@flyingcircus.io>, linux-mm@kvack.org,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Dao <dqminh@cloudflare.com>, regressions@lists.linux.dev,
        regressions@leemhuis.info
References: <ZulMlPFKiiRe3iFd@casper.infradead.org>
 <52d45d22-e108-400e-a63f-f50ef1a0ae1a@meta.com>
 <ZumDPU7RDg5wV0Re@casper.infradead.org>
 <5bee194c-9cd3-47e7-919b-9f352441f855@kernel.dk>
 <459beb1c-defd-4836-952c-589203b7005c@meta.com>
 <ZurXAco1BKqf8I2E@casper.infradead.org>
 <ZuuBs762OrOk58zQ@dread.disaster.area>
 <CAHk-=wjsrwuU9uALfif4WhSg=kpwXqP2h1ZB+zmH_ORDsrLCnQ@mail.gmail.com>
 <CAHk-=wgQ_OeAaNMA7A=icuf66r7Atz1-NNs9Qk8O=2gEjd=qTw@mail.gmail.com>
 <8697e349-d22f-43a0-8469-beb857eb44a1@kernel.dk>
 <ZuuqPEtIliUJejvw@casper.infradead.org>
 <0a3b09db-23e8-4a06-85f8-a0d7bbc3228b@meta.com>
Content-Language: en-US
In-Reply-To: <0a3b09db-23e8-4a06-85f8-a0d7bbc3228b@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0047.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cb::8) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|PH0PR15MB4200:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ea868b3-050b-4298-b35c-08dcdccd80af
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGNwcmdCSGlhKzQzK1ArZWYyb1dpcSt6Qjdqb3lUWEs5UGpOY2tQaUxLQ2hI?=
 =?utf-8?B?ZU1rL213TDBZN1FTMjRqcFlwY0RHVmJXMnV4amhMdktCVHRzSno0blhTYzhw?=
 =?utf-8?B?RS9QVm5YR2w5VVljZVR0dzFLVlVyNUsxdFJnRXlaYUZWN1F1Ny9ESWl6Tlpm?=
 =?utf-8?B?YU9vRkFta1ZXQ1J6V1dKemE3RTNPNm05SFZtdFpIT0ovbWh0aUF3NnR2cGZ1?=
 =?utf-8?B?MGRLcWd5NVJGQ0JYNmltaVN1S2ErMWJtYko1Q3RpQkh3ekk3alUxY3ZNb0pJ?=
 =?utf-8?B?aWowTlRtODd3bTVRQTgxRWIvSmxOUGZ3ekwwOUJMNlRFUDcyZkFEZ0JWamt6?=
 =?utf-8?B?b2pIbkdTUzI3MkpIVnYzWHpQb2ZNTExrUnBvOGhNaVFOVHpEU241YXg3Q1VP?=
 =?utf-8?B?c2xpUlBRdUlVV3VTL0pZSlJ1dVhaa1NrZmdON3NNRkw2YWpWNmhhVTlnRGM4?=
 =?utf-8?B?Ti82aE1zK2orN3VDYm8wSTA5TkpVVUdVeVJ1bnlKSWZYZWs2VVEwMGcyOHdI?=
 =?utf-8?B?c1NIV0JIaW9RVklGcEw1bHUzZGVLZ05RN1Zlem9Tem9EWXRaU24xNEZpbDZF?=
 =?utf-8?B?dVdkRUFYbjZTeHl0eVdVb3NZdlhXc0l1OXhHWkw0a1l4NkQyeEVOYXBMenNH?=
 =?utf-8?B?K1BrNGlrNmpXZzdFQVE1b2dyYlFZSjhvWXRPZVNNbFYxOGttcnVmeU1WMTZw?=
 =?utf-8?B?TTRHOVRZOXQwWjh3UG9kRTJaTDVseERRR3pxMU96SVo5YVEvSDdITTdlbGRI?=
 =?utf-8?B?V1RmR1o1R0hsMFVwaWNMUnE3NzljckRqTjQxN1dNY2J3eTJYMEZVMkNZV0lz?=
 =?utf-8?B?YXJuNk1BWWJSZ0RMM1V1bnBhQ05xVlBSaHppT0dCR2kzVXhzVnc5SktvcWxM?=
 =?utf-8?B?bGsyZ3MzWEJCNkFOQk5xZGlnZXAza2pvQ0NQbEtKS21qN3ErYVcyc2FOdDNi?=
 =?utf-8?B?NzFMVnRaLzBaVldnTE1jNFFGb3B1Zk5IMHNwSTlCanhka2dSNzg4dzE1ZVFF?=
 =?utf-8?B?aUdvditCNm9VLzBrekVnb3JIc3hxeDgzQkpkWUkyN3F6WDVJTTdSb3d3OERn?=
 =?utf-8?B?SGkxS1hHZzZMdVNBU0FRbHFUb2ZMMXl1aG4zYjl6b0poUjhjMHFUQzBEMWZa?=
 =?utf-8?B?SURIcEFKclFyNjNycDVaYjVlcDBmeDFjVkFMM0l1RC9QSDluNEhBVU83dXRW?=
 =?utf-8?B?WXJCNjNvaVlJYW9MNHJzUExnTXVwMlRuWXJNWWc5ZndtdnpHQ2NjOERGOVFt?=
 =?utf-8?B?cm43KytOQUdjTkVhSStlMWthY2xsTU5nOE9lTzNFSjErRm9LRWJXNE91dHNP?=
 =?utf-8?B?UUJtMnJoenR3dWR4emZNYTRrZTdpUllBbGgxbS9DdXl2dUNMcmpXeXJQYm9P?=
 =?utf-8?B?K3IyanpmZFEwTTRjNEJac0g5UkhSK0FwOVVsWEM3UlFvZE10ZVFIVkU3K2l4?=
 =?utf-8?B?U3hZRXJyRVFLSWY0NlpCL3NMd0Q4eW1adGkrOHl5SGlLdXFXOHBqVVpjUW1E?=
 =?utf-8?B?bWY5NXJQdjJaVkxnQXRvQVdmZjk1Y3JESWlPL3R3eVJsZVVGYWg2NzNZY3ky?=
 =?utf-8?B?YXhtZUF6K0x4bkNxTndjNzQ3amQ2a24wYjVUYWV3RDhvNnRXMms1cTl5eFZn?=
 =?utf-8?Q?BOkr+6fqMkFkno4BaXrcb3SVK2ivarb+B1/BJak50MCI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bitKLzErTVdiNkJNTXltSEZWVkMvcldPNUYxWGJydUVSM2FPbVNmLzJ1clU3?=
 =?utf-8?B?STJ5VHQ2TjJBRDNiK09GZUowNjFpWTloVlFrY1g2WmZYSUlMcVJmUjlMaSto?=
 =?utf-8?B?Z01xTUMzWm5qaGNNRE93L3lVVlQvck1wWXRRak9IL2ZJaDFRYzlzU1RDNGY5?=
 =?utf-8?B?bHZVYmUwanB3VXNNOVkwcUhCWmRzSjhhanAwTnFiR1hQNE1XUWVpbWY3R09W?=
 =?utf-8?B?WVhWVDRjYUhSZUJTbXN6dUN5U1g4dTVkbXJyRlFYNHY3MUJXeXJ1Znh5ZE5L?=
 =?utf-8?B?UCs1SGdKZnk0TUtDVmN0WncxMmpsSTNSTXBPeHphQXJvMjVRQU5FOVZVd3FB?=
 =?utf-8?B?c2s3UlpmUzBhVTNJZzM2SEVHZWhUNWloTXJwVk1WclpBamgwRzduZVRkUnFQ?=
 =?utf-8?B?d3lDVjNGOTl0WlI2aEJMNFVEbHM2NW5UZXp2WlowY3RJOUFlanFDVlk4RVFq?=
 =?utf-8?B?VlhNa1RFN2dkS3VxVlFOYWhrclBxSnVWNTFha1h0ZHBXdFJoTklubVVPbytt?=
 =?utf-8?B?OUdlWVdZdzNhT0xKdjY3TmZpKzVHRkJmODA4TG8xVVFyTTBkbktUNmoyelB6?=
 =?utf-8?B?eGxvcitpOXo4azdXQTVtcTRaYi9NTjdzQ1g4NXBCS2lrQkJiL1lDWm5MSCtR?=
 =?utf-8?B?RU9VZTFiZklMeW9oM2czZzRYQll6ai91YytReE1FanBEcVd5V3dzMjhuUVU2?=
 =?utf-8?B?YTVabURVSlROaVNKb3M1UVUzQWl3MlErVUdIN3A0UlZEa3NZd2xScnh1ZTdX?=
 =?utf-8?B?Vlh4VkFnSFNRVkJVdTJVS3pJcWlTS0FucjhKbkVZVWlWYzFick00T0h5TkxQ?=
 =?utf-8?B?Y3kvQkhyUTkxcmhHRzl1MFBiSjVDWnNGR1VTUFFUYmxnRjR5RkVFc2dsQWUr?=
 =?utf-8?B?WGRIWmtzYTJhamtiZ1c1blFKVzlsL1MrNVdqeWliZG9lSzJ4OEJTVFNLNFI0?=
 =?utf-8?B?RjdzVVZzem1MbVV2YlVBSStaRFFwaTFtNGtHeTNjMzZPSGJlbVZDRU1zZ1RY?=
 =?utf-8?B?dExueHhTbFFtWVM0SmI4ZXpwUWdOU3hBYkVFd3QxUzExVUYzbE1pcHh1c0Mx?=
 =?utf-8?B?NzZ5QUs4WitabFhHSGdjSTRwUEd5NkRHdktzYjBwdzJlbHEvN3lXRGw4OG5y?=
 =?utf-8?B?SmQwWk1aS2Exc0ZqSHdudk5HcHFiY1hDZURQOUV1c01NaVRGbFAwY1dDbUtD?=
 =?utf-8?B?THJDUUk0TEdDT3NmU1R2TGh5cUNQeFNnK2dLRnhGazJ4bEJkTFpZZ1pBNnhQ?=
 =?utf-8?B?NUNHVloxTXI5MjA0dUJuMGtVN3d0aTdCNVd3a3V0bTRmUW41UXJDSWRRcnll?=
 =?utf-8?B?aloxMXN6WWkxNXJkOTNuWEdXMGU1ZmtSdnJMTk9GcHd5SDNlbm1tTGNMN2Z0?=
 =?utf-8?B?dFo5MlZlR3hJdVc1MDBrZjNESXdUK1pBcCtOQnM4YlhjMEhJVFUvekJycnFW?=
 =?utf-8?B?RFd3ZzFyNGNmYkRDRDJpalFLTldoNERTdGhYS09WYjg5ckwrc2c1RjUxVjJW?=
 =?utf-8?B?OVhYRXlDVFI4N0FXbjRkc1IvWnE5L0JKbjVuQ0pUS0NxQzZZd3JTTjV5cDFB?=
 =?utf-8?B?UTViQTEvOHZ1aEFuR2hRSmx6ODlNRGNjeC8yZGhvZzBsWGJyWUNrZTFqWEow?=
 =?utf-8?B?RmkyQTdGODZHeXg3MDBtM1lhUVltRTVpWGQxL0JNYjNTdEx4cWhtckp4TDUw?=
 =?utf-8?B?c0VqWDZXbTlPNHQwQUg3eUhDZHl5eHhkYXlVeVdycEYxZzZnM1pCbGxDdjM0?=
 =?utf-8?B?N0R0Y0tXdmp5dXJnbnFSMmZZZjQzYm1XcGxEVmZ0SzREdEhyY3c5c2FFRktv?=
 =?utf-8?B?UHpYdmlCcnM0dlJ3ZUJ5NEJNeU43RE1ZdWRwUHdiVmVOTEFkZnRSNWFaTnpp?=
 =?utf-8?B?RzlZSVpZVFkyYm9RUWtnUFdUN3J6UGNEMU11VFFEQWNMYndWb2NZU05CU1Bu?=
 =?utf-8?B?WUYyenRaK0xMOXp6ZlpEbUh6TkxRWjhzVU1zMXpBN2MzNWo3ekdJVCtnUThn?=
 =?utf-8?B?TW8waXhmNGlUQkVrQ251KytManBSeGcxby9MWU1uRURyVld4WUVKL2JNTUhW?=
 =?utf-8?B?MmJLa1MrR01YR1RvY0NuRU5Jcy9UUERoRElGNUp1UmNwQjAwVUtBSi9lV1Bp?=
 =?utf-8?Q?jyEA=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea868b3-050b-4298-b35c-08dcdccd80af
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 19:17:16.7599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JI7t/NbZup/VRz1sJMroPazfffiLKMF+2Qj0ue2HfBgm39DuYKC0zbhz7x/5JZw4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4200
X-Proofpoint-GUID: RWxJ_alxbvNpbC1O7GT3c-wsq1kzz-Dr
X-Proofpoint-ORIG-GUID: RWxJ_alxbvNpbC1O7GT3c-wsq1kzz-Dr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-24_01,2024-09-02_01

On 9/20/24 3:54 PM, Chris Mason wrote:

[ ... ]

> xas_split_alloc() does the allocation and also shoves an entry into some of
> the slots.  When the tree changes, the entry we've stored is wildly 
> wrong, but xas_reset() doesn't undo any of that.  So when we actually
> use the xas->xa_alloc nodes we've setup, they are pointing to the
> wrong things.
> 
> Which is probably why the commits in 6.10 added this:
> 
> /* entry may have changed before we re-acquire the lock */
> if (alloced_order && (old != alloced_shadow || order != alloced_order)) {
> 	xas_destroy(&xas);
>         alloced_order = 0;
> }
> 
> The only way to undo the work done by xas_split_alloc() is to call
> xas_destroy().
> 
> To prove this theory, I tried making a minimal version that also
> called destroy, but it all ended up less minimal than the code
> that's actually in 6.10.  I've got a long test going now with
> an extra cond_resched() to make the race bigger, and a printk of victory.
> 
> It hasn't fired yet, and I need to hop on an airplane, so I'll just leave
> it running for now.  But long story short, I think we should probably
> just tag all of these for stable:
> 
> https://lore.kernel.org/all/20240415171857.19244-2-ryncsn@gmail.com/T/#mdb85922624c39ea7efb775a044af4731890ff776
> 
> Also, Willy's proposed changes to xas_split_alloc() seem like a good
> idea.

A few days of load later and some extra printks, it turns out that
taking the writer lock in __filemap_add_folio() makes us dramatically
more likely to just return EEXIST than go into the xas_split_alloc() dance.

With the changes in 6.10, we only get into that xas_destroy() case above
when the conflicting entry is a shadow entry, so I changed my repro to
use memory pressure instead of fadvise.

I also added a schedule_timeout(1) after the split alloc, and with all
of that I'm able to consistently make the xas_destroy() case trigger
without causing any system instability.  Kairui Song's patches do seem
to have fixed things nicely.

-chris



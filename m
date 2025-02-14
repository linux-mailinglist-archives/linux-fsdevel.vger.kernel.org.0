Return-Path: <linux-fsdevel+bounces-41745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DECEA36600
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 20:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C93491709FA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 19:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA82E1990B7;
	Fri, 14 Feb 2025 19:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PkRTWC1C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9327C18B460;
	Fri, 14 Feb 2025 19:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739560235; cv=fail; b=mmA9/QvsIsbelKGHoP2jXR7aK7QJ3tfXTX/J3KZ2h5lUZ0TEpO9jD7rx7g1WG7T88m3uUaqNEYkWxRwxt5Kg0XvWkPYUTFdMpfNK3uOP7YBTWclhkHQwNL9kKKCdov4Oo1W0dlgqKHNyTFYaqJHZ74T7Nf9IeCNDC4pR0uWzHv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739560235; c=relaxed/simple;
	bh=NMJd2rACyGtub5fpjHijLqkHrVwTkcaqGl3HGo2Es/s=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=P9gRl6AQohJY6qyxOnkcFiuNMNyDrmac+dxzhfHbemvboxXLKEVezEKW6+zMvkg6vSfcjx3zFBbzd4I9LV6rx9DZirxh582n/AtB9bFN7yRPk3Ua60cPKCGHbX7PyXbB+yNmn/9D9pDG/BjNgkbawNrPjGeN9s6xWG2Tn36DPVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PkRTWC1C; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51EFdSOu032257;
	Fri, 14 Feb 2025 19:10:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=NMJd2rACyGtub5fpjHijLqkHrVwTkcaqGl3HGo2Es/s=; b=PkRTWC1C
	5A18anjivS81yl3VT9X8QZrpP04QGpWje1ox4nVn8WIeWVvWUg+Mky7GFeAEb8mL
	6gtsyQtSo7UtqbSZuCFBeX6UQxwGhtWSd3rmOJVreiM6AXKbU/3J70VMSFKp4Gdy
	R9yTFjPKaPp23H1DAl6Z9z4tisjYk6fSbQr13a2lsWdO9Oj8RhqZmRZhthv5XPRy
	fObC0rPVSO1CapPyXqb5mazDXKLhNmga0hZ2lCx3ktSz33wWHHQpm7VDvBKBzxkW
	IOyCZRW3F4dj+dsXyx3W5uE99qrV6rT358zxZfmOM3kcIQxWf/mK6PnX/r8R+leB
	DiY/5400l0ezCA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44t8nuh1g1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 19:10:29 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51EJASB2030538;
	Fri, 14 Feb 2025 19:10:28 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44t8nuh1g0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 19:10:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bkBG2VJHpWdzD+ludUM4j/+Mj3QAh2Jci8eCIrGhJY/uNWzlUlUOGvmSMNsgevQ2NevoOydXXU1rWW0Endj1p2hMnMvWfHr2vvKok8BmQp6p4gVeSfoeXRpNFZIqie9gagaH1rllfkWQQDirD9RjDvrLOMbVKWp9vFA1j14yLgk9mdqI4chYh4sFT5m+s2poUazdQ1bIymtkp/ktXZlmxkZdRsb1c2X7yRVCo8iK7oqRgUbMvPMrPxWRkj9ilcHpBZ6iG3+1pW4uwuYrwEqaNrhzllkw2lKAK1eKazRHZQIDBN2eGzGaLl9DOkDPlMzJ86hVAhFrTiEaOyCsRpDnyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NMJd2rACyGtub5fpjHijLqkHrVwTkcaqGl3HGo2Es/s=;
 b=DRWK2EfBM0ppfd8vDPZmp7lTUv/ozifI1qzG5ERr0abpcRioBJJIIhZND0as3UQXRW0i/EDp50b/n51Ob6Hs1/TkdRTXx6h/yRlxNUewaY2AIhmsp9Y4aJPhOLrkhTF8LVdU+q8nJ+6tLxBG+5gODOdbmjxhbUvSQM6zAiWoXTMxSIBXpIglZeroe4LjMBa7YeUF8AyCxNYmRxD8Qy6nxO+mFttM5HdSvhjiQSCphHeMBJnfZ6pq+Pdf3hxVH9InPFSCyyRcFB0xvsRkLqL/eiCfJ7imElMb4q6vpczItNFkDGgi9SrboH+AZ/0a95+SVlb8JK60MJC7iT/bEEQwug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA3PR15MB6171.namprd15.prod.outlook.com (2603:10b6:806:2f3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Fri, 14 Feb
 2025 19:10:26 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%4]) with mapi id 15.20.8445.016; Fri, 14 Feb 2025
 19:10:26 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "idryomov@gmail.com" <idryomov@gmail.com>,
        "willy@infradead.org"
	<willy@infradead.org>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        David
 Howells <dhowells@redhat.com>
Thread-Topic: [EXTERNAL] [PATCH v2 5/7] ceph: Convert
 ceph_readdir_cache_control to store a folio
Thread-Index: AQHbfvlCmiA3BT1KsEuR2DVpZBZsDbNHKkIA
Date: Fri, 14 Feb 2025 19:10:26 +0000
Message-ID: <da997962ce076d3962948d5404f51074a6829bf8.camel@ibm.com>
References: <20250214155710.2790505-1-willy@infradead.org>
	 <20250214155710.2790505-6-willy@infradead.org>
In-Reply-To: <20250214155710.2790505-6-willy@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA3PR15MB6171:EE_
x-ms-office365-filtering-correlation-id: b0605848-2ec7-4a65-6ea2-08dd4d2b3d88
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dlI5Um9CMlI1Q3JxUDJiZDFqS3lpOTRyTG5yZ0U2eHBKSGtYdXZjaVBnaENC?=
 =?utf-8?B?Q0paUGNqOGlHQmgxZjNmdS9vWXFKaUhHNUQwRG1KQnJxTHZNRFB5OXZid05F?=
 =?utf-8?B?WnRPN25aUFVHVUhxLzM3UllRKzM3OWRVWlQyamNEWGp0L0FIcGNrdVdrOEZF?=
 =?utf-8?B?a3JhMUJwNjczZkVBQnlDK1VKU0JYRVYwUG1LdkRkYThWUmdzS3dueUJ4SzVy?=
 =?utf-8?B?VWtwUkZFa2Q1TGhEQ1pjcTZsOU5KYThrVnM0QktKcm1BNytHYkgxVDduc3Fa?=
 =?utf-8?B?a1N4K1c1NlNhbnJKOTJDRlhlb0UwQjhTdmF1RjRzL3oxL3RvcW5Yc2t3Qlp5?=
 =?utf-8?B?czFiSTlCSWlwbXZVbmluaWZ0WExGQkhhcy96VHN0bGFaWjhTbzhGcFlmZklP?=
 =?utf-8?B?UlJieE93L0hPR09vWU9sWE5nV2EycWdLY0R3VDMwcllmNERmN1hURUJkdDJB?=
 =?utf-8?B?RFdCUXNKNW1UaW9YTDVNYmFPaE1sR085Rm9jSmQvMlJRYm1QQ1VQbFN3eGlO?=
 =?utf-8?B?VE5WZFR3NGYrd3pKMHNZbWI5RE9ObXNBeXgyeURJeU5ZUHg5NGsvci9nemVL?=
 =?utf-8?B?azVUeXV5RXBzdzlrNnduTTZINkRZRkFRN3BVU3BhZUFGbXU2VjdBczk3TFlv?=
 =?utf-8?B?dUJ3UW4reGtoc0d0Ylh5TmtZME5FNVVDWHB5MFR4NG5FZWxzNUFzaHRBUzV0?=
 =?utf-8?B?ODIxRlc3RmN2MVNhclJ5RkNNWHBIZ3FXSk9ZSEVnVmdOcHNESythMjhxVVZm?=
 =?utf-8?B?Z3NiRXpiUkZXK3VtYTRQdjAzSDc1RnBpVWd1U0pHNWVacjg4VlF2cGIwb21r?=
 =?utf-8?B?VVlQOThJaDZiUGFjNnh3S1hNRkVOby82MUxZTjByMHIySEFyN3gwNzJtbWVw?=
 =?utf-8?B?T1lodC9YK1JNSmxBaXV5Lyt3RURJNk94YmJDSzd1QS9TZFJPMzRJNEtzY3ZX?=
 =?utf-8?B?dlovRjZSb3d0T2JjcldzbUxBemd4QjFxR2RLYkhTVnc4MWN0aDZlZlhRWWdU?=
 =?utf-8?B?OFgvMFRMcHpOVW1LdlVKYktUdEpHa25mak9vMXpoOGRoNTJvYjlCRVRTNDFx?=
 =?utf-8?B?WC9xdHhyUjZZSi9Ea2orQW9iSUZSK0V5NFYzMkYvSTBDTGM3VWJacys5THRZ?=
 =?utf-8?B?NDdVNnd6Yi9RdnErRERONEZUcENHd2RrY0RYc3NpZ0VQSmFNeU12K0JnVFUw?=
 =?utf-8?B?b0RLQkZtcUtBU2FVVjNsNGgxY0JsV3BhWHJNdTJmZ3hXdXI5YVdEcjlBWi9v?=
 =?utf-8?B?SEdQNERjK1pHREFMM0RRY2plMlhBVWpJYzdEc0FjVFMvcldEemhBQllZT2ZI?=
 =?utf-8?B?REMrYXY3ei9kMXRhcHkwNWVlb3VLSE9YYWlRc1VWMXpMcGordUt5N1YxK3dB?=
 =?utf-8?B?UUd0ZEQvYnh1dkhRVi9nazRoS0c3dmJ2YU9BMlNWTG54YzBKRFJ0bDM5c2NH?=
 =?utf-8?B?SEc4Z3YyMXIwVndiemNQa0JUV0FjcXlPcU5LM2Z0ZkYxZzJtMmJtUGtCQWo2?=
 =?utf-8?B?cGsvbFRvaGdSR0N6V2lHa2VodGsxWWxlcnM0d1ZGMWVxb1kvTWsxYU5oYmhZ?=
 =?utf-8?B?NFMrQ2JzR0dGV1BKVTlxektFRHVNQlVuTmhMYlZSS2FDWjlraUZHcXNxWHRJ?=
 =?utf-8?B?M1hqeEUxc21OZ3BMcFUxL0xYczk1WlFTenRqK2hYSWE5cmFMZk9yaXJJUXJl?=
 =?utf-8?B?WUZsQnhRZkNaRUR3RS9YN01uOUsybHhJMDJ1ZXIvdVdSZWRPTks1M3ZQOGJZ?=
 =?utf-8?B?eTkvdUhIaDFjYmJocmljVlZJcmt6NTRNdzc5M0RWSERzcTBFS1FSZ3J6L3My?=
 =?utf-8?B?ZDF3aDVtYU5VQXExUGhMSkRZQUJaV3hmemJtaXZWZDZtVFJRUWIwUGJkejRX?=
 =?utf-8?B?TE5YcTV6KzNEVUZ6RFA3VTZ5bXlRYzgvRGp0NnE4UGE0SnZGaXFvT2dRdE1J?=
 =?utf-8?Q?6oZHRmElyEnHDH4n6+wcAVW82wrMet5L?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S1d0MjF1VWtzL0JOaFlOZGRFbHZrcnlGVzZ5U05OYk4yTExQQ0YwSFlUM2dW?=
 =?utf-8?B?NURqWFpQZUV6L2Zibk9ucUFRVmgvNWpKeDliRTlmN2drVW5pRDJFYy8vRW9W?=
 =?utf-8?B?R1Rtcy9EdHhucXpodnFhUHVVZGY3UU9Cb0lFd1B1MG9VZVVNM2w4cEUrYXhB?=
 =?utf-8?B?aWZ3dHpYOGtLVFEyOVY3SzVlNEx6dzZ6K2ZJazBFTlJXL0MrY0pPblJiUlp2?=
 =?utf-8?B?Wmh2ZVBCTTE2TzB6TDVERWZFZHhiZ3VjVDByWEtSd1pjaEplQXRkWTdMY080?=
 =?utf-8?B?Vm9rcGxmUmJOMTZNSkRSZ1BDeTV0c0NKM1lnVGs2V0p1Uk9NZG1Md1lpUHdZ?=
 =?utf-8?B?M0hkSkxVeXRjOHRLQWZEamJKNlhFREwzR09sNExpb05mOCtJU2d1RmU3VE5E?=
 =?utf-8?B?Vk5pZFhSbGpSbDdvQlBUQUxpOUpiV2tzM2NSQTM5T2FKVmhXTlZjV1praDVv?=
 =?utf-8?B?RVhmangwQUlVNlZFalRJNmVaalRhbkZLcjJsQXFuOHhNNSt4amFXK25IeGx3?=
 =?utf-8?B?SmlGbTNTeHNpeFRZR0xTSjE0dUNuZ3dobDR4ZTRMWlE2NG5kUlNYbm1TM0lQ?=
 =?utf-8?B?c0M5R2trU0NqTWNYMmdRQWJESktLV2NPS0hnK0tJYzk1Vy83SmR1cVRYZ2hB?=
 =?utf-8?B?UHZITnFyMnpWeStmbldEdXFYelVKSDZLYkR5ZWZVNDM2VUliZHcrMTNKVHc0?=
 =?utf-8?B?c3JIMHA3WlhNT0ZIS3E1elo3MTFKWmxCMVIvV3NvdFJPM1I0RFNkdFJlUFk0?=
 =?utf-8?B?cnVqVlcrWE9BS1lWQXRnWk1BT294VTA5SkQ4TE0yZExVWHdxa2NjeGdLRzRO?=
 =?utf-8?B?dEorWFV2N2JEN3Q1bkxET2VGbDJ4L1dvVk9PbGkzbTVab2ppMXBpV2RsNlds?=
 =?utf-8?B?OUI3NkpHYkY1TDBrSXhuNkdvOTQ1WGIxcjZHTVBJWEVpaytHdTc0aEZmd2tK?=
 =?utf-8?B?blkvaXpqUXdqeVkxNytrNFdkWlRMMEFwSVZRSTcvYWFCQkhHNEI3dVcvcHc5?=
 =?utf-8?B?UjExT3pPODh2ZUNWVnNML25aaysrb0JTSXRhUGVBbS9Dcys2US9sRkFMV0Rx?=
 =?utf-8?B?dWU4K2N0QmluSS90VmVNVk1walVNZTJ2dWdCby9VNlQ3QksxOGFxSWdNeDc5?=
 =?utf-8?B?NVpsZFZMMFd5c1l0WU44K2NNNnpZbEIvMGhVZ2Nua2VtejNoYjBKcU5XaUhJ?=
 =?utf-8?B?b2NjclZVT0ZzbXFQVkh5bGRhVDg3d1pvZTBDM3gxMG95S3hRd2lhTzdoL0dk?=
 =?utf-8?B?YUg2bUVDbzRGblRUYm9mdlhEVlA0TlZhQU45TnBvYlVReVg3YVRSZ2d2bTl5?=
 =?utf-8?B?YUwvOWg3ZFdNeFh0UWpHalVCUlJvT1hlMXJEMytoUlpQNGQ2bEVKTEhQaGpV?=
 =?utf-8?B?ZUVNdGM3dG5lMjJhZW5UQnhQUTJ2R3FDdnROQ3FlaCtaSnIwWjRZcUh1cnBv?=
 =?utf-8?B?bWdmZHBUOGhCZlM1Vmt4bk40ME1RZlRocGlaRjNzcjBybkN1TzhFYTJucW5O?=
 =?utf-8?B?cENzOEhhYjRzaWpvK0lRbHVWemlXVTFva1I2bjlCenFyYkt6d1FvMTNjRVhj?=
 =?utf-8?B?eDFmdVhyMXpoR0t1dVlFKzNqUU9jMVRPbUpVQnA4cHRkM05hejlEbmN3cCtU?=
 =?utf-8?B?MlMzK3htaHZNYzNENm5jaUNEeWN3Z1IzY2NNSUtVVUdkVnQ2QkZLUHVBRlBH?=
 =?utf-8?B?Z3Y4bkk2b1dyMlI0K3FjSDR1d3ExaDBlaHc5MURYL05XTUJzNUIyNEwrTzhU?=
 =?utf-8?B?cjVHUjJ0VGJTc0JMUTdLbnJpcXphUHhJWkQxS1g4WitpaFRTQVpBRU02VXV1?=
 =?utf-8?B?TjRLZ2JPTGl0d2VrNUs3NE1DZDdqams4bTJxVmtlRjdVRHJlNm1hZUdjT0FV?=
 =?utf-8?B?ZFJjWEN3T1Z0NUtQaEN5UjgwWUxjbDNTQk1aQko1V05pZU90VlpiN0Z5M00r?=
 =?utf-8?B?MWlCM3diZVV4M0htK250VUI0dWluV3lFNm1RNGVpV3FaOFA4ZURMczVLTzZ2?=
 =?utf-8?B?MDFUQzNGbC9haGV3cEEzbEt4Z2w3QnRNUHMrNVN1UVJrT2hZS0srUkxmTTBS?=
 =?utf-8?B?OGxqVnZVQ2NwRUoxVWxlc1Z6aVNOMjU4VjFHbElQZktpWEtPZVRmUXhrTGhy?=
 =?utf-8?B?Smlrd0FNNkRZNnBaOUorSk1oVXdrMHB0RHd1dEkydEh3d3RIZEFWOXRscTNn?=
 =?utf-8?Q?bI52HCx4UNPBTxeBiRIaQwc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E98E72AA5952ED4F94581D563145067E@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b0605848-2ec7-4a65-6ea2-08dd4d2b3d88
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 19:10:26.7610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XES6IXicuoGGa0z9wgczy4qEiSVM2vg+Ok3bfBq8hBHDiv3r2XwnHOQvkqzFKsecm+BHwBXO3kPX4p+kGff8fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR15MB6171
X-Proofpoint-GUID: 4LToqDAzw8PBVtmMJ1NWmVpwXvc037YT
X-Proofpoint-ORIG-GUID: OUlDAsEysPWe_YPH4MsXam9d44Po408M
Subject: Re:  [PATCH v2 5/7] ceph: Convert ceph_readdir_cache_control to store a
 folio
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502140131

T24gRnJpLCAyMDI1LTAyLTE0IGF0IDE1OjU3ICswMDAwLCBNYXR0aGV3IFdpbGNveCAoT3JhY2xl
KSB3cm90ZToNCj4gUGFzcyBhIGZvbGlvIGFyb3VuZCBpbnN0ZWFkIG9mIGEgcGFnZS4gIFRoaXMg
cmVtb3ZlcyBhbiBhY2Nlc3MgdG8NCj4gcGFnZS0+aW5kZXggYW5kIGEgZmV3IGhpZGRlbiBjYWxs
cyB0byBjb21wb3VuZF9oZWFkKCkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXR0aGV3IFdpbGNv
eCAoT3JhY2xlKSA8d2lsbHlAaW5mcmFkZWFkLm9yZz4NCj4gLS0tDQo+ICBmcy9jZXBoL2Rpci5j
ICAgfCAxMyArKysrKysrLS0tLS0tDQo+ICBmcy9jZXBoL2lub2RlLmMgfCAyNiArKysrKysrKysr
KysrKy0tLS0tLS0tLS0tLQ0KPiAgZnMvY2VwaC9zdXBlci5oIHwgIDIgKy0NCj4gIDMgZmlsZXMg
Y2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZnMvY2VwaC9kaXIuYyBiL2ZzL2NlcGgvZGlyLmMNCj4gaW5kZXggNjJlOTllNjUyNTBk
Li42NmYwMDYwNGM4NmIgMTAwNjQ0DQo+IC0tLSBhL2ZzL2NlcGgvZGlyLmMNCj4gKysrIGIvZnMv
Y2VwaC9kaXIuYw0KPiBAQCAtMTQxLDE3ICsxNDEsMTggQEAgX19kY2FjaGVfZmluZF9nZXRfZW50
cnkoc3RydWN0IGRlbnRyeSAqcGFyZW50LCB1NjQgaWR4LA0KPiAgCWlmIChwdHJfcG9zID49IGlf
c2l6ZV9yZWFkKGRpcikpDQo+ICAJCXJldHVybiBOVUxMOw0KPiAgDQo+IC0JaWYgKCFjYWNoZV9j
dGwtPnBhZ2UgfHwgcHRyX3Bnb2ZmICE9IGNhY2hlX2N0bC0+cGFnZS0+aW5kZXgpIHsNCj4gKwlp
ZiAoIWNhY2hlX2N0bC0+Zm9saW8gfHwgcHRyX3Bnb2ZmICE9IGNhY2hlX2N0bC0+Zm9saW8tPmlu
ZGV4KSB7DQo+ICAJCWNlcGhfcmVhZGRpcl9jYWNoZV9yZWxlYXNlKGNhY2hlX2N0bCk7DQo+IC0J
CWNhY2hlX2N0bC0+cGFnZSA9IGZpbmRfbG9ja19wYWdlKCZkaXItPmlfZGF0YSwgcHRyX3Bnb2Zm
KTsNCj4gLQkJaWYgKCFjYWNoZV9jdGwtPnBhZ2UpIHsNCj4gKwkJY2FjaGVfY3RsLT5mb2xpbyA9
IGZpbGVtYXBfbG9ja19mb2xpbygmZGlyLT5pX2RhdGEsIHB0cl9wZ29mZik7DQo+ICsJCWlmIChJ
U19FUlIoY2FjaGVfY3RsLT5mb2xpbykpIHsNCj4gKwkJCWNhY2hlX2N0bC0+Zm9saW8gPSBOVUxM
Ow0KPiAgCQkJZG91dGMoY2wsICIgcGFnZSAlbHUgbm90IGZvdW5kXG4iLCBwdHJfcGdvZmYpOw0K
DQpNYXliZSwgd2UgbmVlZCB0byBjaGFuZ2UgZGVidWcgb3V0cHV0IGhlcmUgdG9vPw0KDQpkb3V0
YyhjbCwgIiBmb2xpbyAlbHUgbm90IGZvdW5kXG4iLCBwdHJfcGdvZmYpOw0KDQoNClRoYW5rcywN
ClNsYXZhLg0KDQo=


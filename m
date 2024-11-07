Return-Path: <linux-fsdevel+bounces-33957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7BB9C0F12
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 20:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DC361F23E5A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 19:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AC621791E;
	Thu,  7 Nov 2024 19:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="D3DnfD1G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C575198840;
	Thu,  7 Nov 2024 19:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731008372; cv=fail; b=msOhRRB20sgW45mGH9csPoSOeK98b1hi1yDiWeXO6t9XpWkjwE0KKymq3v8lVu0cy74n1RnQFea46Ke1KeGt4g1JwBbH7Y8o+bn18FzW4nguLEMrq3Dbp3qSCrKtRvLK9Fo3EBryy0W7gX7lMjdDwHkVEabp3HoYJ6o9na21628=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731008372; c=relaxed/simple;
	bh=cocFH3GsUj7xd4ZtgdeLFru5nWB5kRZ+9At2lhBZG6M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ns4pMvfQjYwxwTAAzaMc4Hjgofa7IoyotHJSpdBTBAZI57VO2FP7OZfikWA0I25p+lMsGBOzP45s1z6BbU4SX0qMrNZHbmvKLQ7rqtYBqegNy51/fszdjFuRltLXl9/xnPgo+RGOHuuokMFWKpvder77dRNUk9X4zdHI9J7kZdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=D3DnfD1G; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7ImPXu018715;
	Thu, 7 Nov 2024 11:39:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=cocFH3GsUj7xd4ZtgdeLFru5nWB5kRZ+9At2lhBZG6M=; b=
	D3DnfD1G+lOgvlstvlKmNWFhILGxv40P67eaN2ses7ecTGnH/NuGPMbcgv6bIfU/
	tseqpkW5U7fbwl2GOVyTlSNEvWTFsw4BMcaFIAO9GB7zWPFDpK/TgAb6lM16Fw26
	KVX7Z9kMfgAJHxSuhC8HRoseuUnahVxNmNbyHtS7p3x6y8Ngp8H07ojnlnWPNJDm
	L2WwPGDlT34NCrbIrdy35H0csJqqYznY5KuFbmhF7v4IQJUgoXW1UH4AbG5UsCPZ
	vPC6P3b39PfRKahOKyxlOT7vYtX6h4YhT4It6NLZ4zKTL8V1S3rAtbcCYMkU+MKD
	JI/tjGKD0KmgqLYzqNOVqw==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42s12shjrn-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 11:39:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R6s+z7tdmXAONd0dxuwWx4IGAff5YoCu591BMrQCS0zhmbKGju4jNovCgyGK7OQZXZ8ZbA2xqa3NUfdgWCGLFw2R0XgMTn7vwD+YkaiJlkYq7CofjqdC2UKPW3PCfehOHt/jDJbXWT9PypJQUMsMpX3GTf+kR5xdfvZVljAi7Z7ZGcWHP5K0j/arXQQvuNeoOTNi0pC+UfBVQOuznp4vE5nxJ0eGgoly0FCk4PUSJBYgIBFRD1CwWLZKIRuMRQlz1VRVhLtF4BeGRPOItc64SuhD+vB3DtnfYyYSGwHH8/ub2LJSivtsHNAGn3xUJVGO/Up7p3t8wb0PmsuItY7g4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cocFH3GsUj7xd4ZtgdeLFru5nWB5kRZ+9At2lhBZG6M=;
 b=YXWluWEJTxGYPgyEn/5TEfj8nm9IezSqyCXgHNmA2Ax8v1P8WQFlfarNLJvnyoR4StfzhK9Q1zn9fj1oTctg0w1LDisauffxViqWZ2Okb642Cgh4hrrhMbS9thMh6U8lkYPqPRpCYVqIB6aiwXyPY/xRKO93Sb8LdBBdfiB9Zv4BTVtABqpEAw+lPCoaKyNeZsuuQRF/ENKgu7Ner9nPUONKOMplNruv2X/zh3JzMD6gCtPNHekDWUu9GSSwBXwuctvGCS44Hfh5sleoa10Yeio8SmFj7TLBw9+aG7w6aPQ0yxFI7kue+t1CwD7l8NFJNSPzY61QF/AqZVEIP8lv0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by MW5PR15MB5171.namprd15.prod.outlook.com (2603:10b6:303:199::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Thu, 7 Nov
 2024 19:39:12 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%3]) with mapi id 15.20.8137.019; Thu, 7 Nov 2024
 19:39:12 +0000
From: Song Liu <songliubraving@meta.com>
To: Amir Goldstein <amir73il@gmail.com>
CC: Song Liu <songliubraving@meta.com>, Jeff Layton <jlayton@kernel.org>,
        Song
 Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux-Fsdevel
	<linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel
 Team <kernel-team@meta.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard
 Zingerman <eddyz87@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel
 Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Al
 Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>,
        KP Singh <kpsingh@kernel.org>,
        Matt Bobrowski
	<mattbobrowski@google.com>,
        "repnop@google.com" <repnop@google.com>,
        Josef
 Bacik <josef@toxicpanda.com>
Subject: Re: [RFC bpf-next fanotify 2/5] samples/fanotify: Add a sample
 fanotify fastpath handler
Thread-Topic: [RFC bpf-next fanotify 2/5] samples/fanotify: Add a sample
 fanotify fastpath handler
Thread-Index:
 AQHbKlgjXcuBZV3LVEOnRP7zXkEQ0rKfQ4eAgAB824CAAEEOAIAAGNGAgAufAQCAAItxgA==
Date: Thu, 7 Nov 2024 19:39:12 +0000
Message-ID: <A6B3F486-6392-4A07-85B9-84FD6AA71F97@fb.com>
References: <20241029231244.2834368-1-song@kernel.org>
 <20241029231244.2834368-3-song@kernel.org>
 <5b8318018dd316f618eea059f610579a205c05db.camel@kernel.org>
 <D21DC5F6-A63A-4D94-A73D-408F640FD075@fb.com>
 <22c12708ceadcdc3f1a5c9cc9f6a540797463311.camel@kernel.org>
 <2602F1B5-6B73-4F8F-ADF5-E6DE9EAD4744@fb.com>
 <CAOQ4uxgyC=h4+kXvem8nDf0Niu-HgswoamxYnFXz03K5dFe6Zw@mail.gmail.com>
In-Reply-To:
 <CAOQ4uxgyC=h4+kXvem8nDf0Niu-HgswoamxYnFXz03K5dFe6Zw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|MW5PR15MB5171:EE_
x-ms-office365-filtering-correlation-id: a9898adf-1be5-42cc-3f5a-08dcff63db25
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VVpBcFJEb3puU3d2dnlYMzVPeHpoUHdtQUR4OUJOVU1tQlcxNlNBc3hJd25t?=
 =?utf-8?B?cE11MG8yandycUZPdFJmaUltNldkcEZSNktZY1ZYeGxwcGJHK0V5OGNZZkJy?=
 =?utf-8?B?QUVwZ1BaOEJSNmZJeHczRlFEK0pxaVIzT0E5ci9VY3Nuc1VYMXl3OGhVWS9x?=
 =?utf-8?B?Ym5EbnEwK3lJMDRjcEZXWWRxeFZMMGVmQWpTWDFQSUhTaXB3MFVjbkVKTDlu?=
 =?utf-8?B?UXArSU1hK0JkNVZpN3dYSmR1NjBYR1BqQURXVDNOeGtkRVNNTTh2QWNQNlJo?=
 =?utf-8?B?cUhUdWNZcU5KN0ZBaEVGeXd2N1IwcmlSM3NicDJpZjVhVTdiWjNMYmY2WHZp?=
 =?utf-8?B?MGpkK0dVSXpBMzBDYlRISXE3dnh0SXpwY2ljYTB6MFpYZ1VoTFlXcWRRVW9r?=
 =?utf-8?B?WlAzTFJQbzl2SG1FWHZBZVFnbmg3NS94Tm9ETjkzVnRCbGF0eGVEbXV0cjl1?=
 =?utf-8?B?L3dwcFNRWk1Uc1RiR01Nc0hhNkxRRk83SVFUUThpN3FkRHdmVzg2RGNJYXgw?=
 =?utf-8?B?bVdYbmNVdDM0YUs4QlNVU2xsYXZleDNmSHRKVU5GcEtVZmFYQlFud3dzSWZQ?=
 =?utf-8?B?UXl0cVI0R1I4V29ZQUdnV05kVHhTVVBweUk4ZmNvMjRwV082SkFVN2tnTVVn?=
 =?utf-8?B?U1l0TGlIWUR6VkZkYU9pbW5iQlBxOUlvcE9CVzRMOE82WDN5NTdTMXNmZklO?=
 =?utf-8?B?NHZ5WDQrVVozRzhIT09KeG8vVTRGNmFoWU01YTc0S0RIcXZJK1lOSXpFd3Fm?=
 =?utf-8?B?MFF3bnkvenhJRnlBVXYrR2QzNHdZdTE0NitnR1orVTZBb3V6Wm5HQWlrVS81?=
 =?utf-8?B?NDliRTRScVFCemlyaFNyUysxc05JQVhReE44VWJJWEdOSEdZemcyVkR6VVpQ?=
 =?utf-8?B?ZHBnbk83WG55ZFM4REhzZlI5RnRtZDZRVzdZaFlxaGZROGxKVnBYMVNGYnZZ?=
 =?utf-8?B?MEF3c3NtS0crdWQ2ZzNJVlkvSStYSWl5NDhlUFFzVm14Y2twQTdiQTZ2enJy?=
 =?utf-8?B?c3FQdG93ZVBmWHovY01LZkpxUkE1RjlhbDV5L2RYb2dTUmdWZHpRUXFNUjZO?=
 =?utf-8?B?RE9PQjJCbnBEM1QrMmk4M2dJN0wwNDZqRGY4bXNVUG9XdCtlc2Vwc1o3WXJ4?=
 =?utf-8?B?WWJGbmowNlltMW9PMmN0WkgrRjE3Yy9UanpsMVF3MEpON0F1RVlTQVBYdGMx?=
 =?utf-8?B?b2dnR055QnIvVUFibzk5WmZLek5KTVdXSEdpRmdJdlBsTUR0WkNXQlFadmM3?=
 =?utf-8?B?enArbXlNWFhnZ3RqRDQvbXNsWGpKdHFqWjkrSnE4OWxrWDdQVWdnT1R2U3RF?=
 =?utf-8?B?M0xVa0ZWS1Y2cHNWREc1S3JiTEh2dnREckJYZ2Q3aDAzR1VoV29uT01jbFpK?=
 =?utf-8?B?OHFtRC8rcTVlcjFKeWoxS3B5QjNTVEZ3RFQrVGRrYUZYeitHMGYva0FiQXdK?=
 =?utf-8?B?QUhvRmZCeGtBT0xTTDArS3B2b2s5TmhyZ050VU0xSGtWWFhKWWpGTFVpbGp5?=
 =?utf-8?B?VGJncndPbmxMTjR4SmMrSGlBOE03NytJZnQyZVpuM1dVQ3hVa1ExOHJ1Sm96?=
 =?utf-8?B?MlVvQnlQR2hUWmVaK24weDBSdXU4ZTJVQkhBb3FJY1g2NktWQVFoR29SYUdv?=
 =?utf-8?B?NFR4dkRDTkV4YUw4OGRHYVRZemJ6US9NeVlyWFIwZ1kvdTlPYkxjUCtzNGxL?=
 =?utf-8?B?bmJXODI2QlkvbDM0VU5TUFdsa2ExNzJEU2NQMWc0a1lzd3lTTVhucENwMTl3?=
 =?utf-8?B?NW9DL2xVMjZlcURvazZlazJSenlmbmtadHlLT2JqeDVEdi9vN3Y4aFU2TytJ?=
 =?utf-8?Q?Cz5fNg2doRfKSvdyfLUsm4RZSjMoqcoZolNvE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ancvTTE1eVNZazkvUkNQUFRkcUlwNEIxNGk0ekRaOWhia0U0cTM1dUNOcXRk?=
 =?utf-8?B?cVkyZFlVZ0lpYW5XcklkdHBWWUp6d0k3Z21vNkdsWjk1NHI1bzR4ZnpHYmgy?=
 =?utf-8?B?NkNLZEFnclVhTHFCOFNpOEtjRGZqZHpwVFFmWmdPbFI1SWNOUkY4YmpnNzB2?=
 =?utf-8?B?c0RFYmwrWGZTZnFBcmJ0ZDFzaFYza2lJQXZyL2F4bXpRcjkraG1zWEkyZ0ts?=
 =?utf-8?B?akZUWUgzdENxM2ljRklidG5MVzFVbXNOZitMamlvYi8zSGh1eEFtYUJZMnRG?=
 =?utf-8?B?dGhUVmo1cTVWdWVzSjNUc244ZDdCOUErSGpZeUdiYzRyUmExRGI4amd3bXk2?=
 =?utf-8?B?bTdxMnNOd0dKNzJodW1FMXByYURNQ3ZhdTBJbkczb2pkczFKY1d1QzZrM2lJ?=
 =?utf-8?B?ekhteENva0IvTE1iTWlZY2sySDlsVTJVbHovNjdCM2dhbHd6U01ab1NaVVNk?=
 =?utf-8?B?Yll0bW9BUUtnUGF5MDVLNGVLVzNWK0RrelNsU3ZHQmFGVWx0MU1IRHQzb2Zz?=
 =?utf-8?B?ZWFueDhxZnFrM0FwUXMvRE8zRGphZkhNYmFNQ05rSHUyaEc4a2p5V1l6WlAv?=
 =?utf-8?B?Vm0xSFRna2I0SEhROEtqZnRQeW5HZ0poejlVTFBOSkNNUEhtT3hVTTE0NlRh?=
 =?utf-8?B?dTArTFB6QW5FNzVGQytzZzk5N3NhS0FkMmNueVhYRTcwSHhYSUdwaU1ybkpG?=
 =?utf-8?B?cHY5WXRMVWs5UUI0WlcvUWpkL3B5NFlnWm9vcGxzSGtHaWJ4bzlDelJpWWVy?=
 =?utf-8?B?elZLSm92UjhRM1d1U1k5aytkTXFKSnJFcGo1RnoyaUVBSWFZMzZKa0FEMlU0?=
 =?utf-8?B?cm0reVlKa0padmhXZzNSTTFOUUlHYXB3eDV2dThrN1MxVzRtTWRZSjdMb21k?=
 =?utf-8?B?eDkwUWlsV09XK3Zxb0pjL2tiMUVLVng4Njh5U2IzUi9xcEJSNUUwc0h0QjJS?=
 =?utf-8?B?dEpVOGw3L3pMVldoQm5ha29EMnFrMXNSNDk2MUlWU1JlSEVJZmFkaUFCQzkv?=
 =?utf-8?B?UXZEVHN1VG5lMnNXcC9CZ3dNZUZsRjF0eTlYM0ZwZ3pNZUR3UnFJTXBKcXpR?=
 =?utf-8?B?czRETXZmYmNOSmhibzVjdmVSRkVIZjlRdWpDbXd4MlplWnN1YnBzK2xTbzRK?=
 =?utf-8?B?cXJqVTllUjZWNU9TSWVtTVgxaVIzbldzOWdWUHdRcWZESHNPWU5DQ0FIVTBx?=
 =?utf-8?B?dDNYZ2Vpalo3eldudi9Sb09Qd3p5NDB1aXFSc3prNmpoOEZZM1FqS2pRWkdD?=
 =?utf-8?B?c1VhNWVZTkVNNWlWRG5FYndSSnVWRkdyL25MVzRvRUNHQ1JocWtYSDdmRzBY?=
 =?utf-8?B?V2FDakdGdzNWR1RlUnBNSE05d1FjTVhMa0tDK1VMUGVyYUN5QVozN083Mnla?=
 =?utf-8?B?dHdFQlFBZkp5clM2My82bUN1MER4UjhuTlc5eFlKV3hSdGtSNmM1dzJBc08w?=
 =?utf-8?B?SjZVVnQzdzM1VGdNS05aQldkZW16ZVZhS1pMcVk2OE5SNmVGUjRDazhmSHEx?=
 =?utf-8?B?bkx3VDB5VmtMbzRaOHpsN2FobmtHOWJwNmVQMWVhMVRmV2h3V2RQNnpoalRh?=
 =?utf-8?B?MS9Hdjk5VHFDZkZJUkdhNVNmV1JwWXFqbUFpSGVzYXBEWUhKS1RGZi9yeG1l?=
 =?utf-8?B?ZDBDbUl2UWRqOXdHeWdQQ2F4UXN5ZFhvZGFyWEdDRHlzZlg1K0Y5WFhCWUl2?=
 =?utf-8?B?Y1F2R3MzbStESkw3dWY5c3QwRmpXc0FVcCtITWpEQmpmM2pLSVRCWGhmMDFw?=
 =?utf-8?B?RG0rOE5CNGo1YzRsRmUwQS9CSHdqd1NZa3R2aTV4cnQ3RklqL0NTZ1BJRnFw?=
 =?utf-8?B?L0FvUlFrTWw0OTlDYnk4VjVhMEZaeThka2FYK1FKWDNybkduM29vR1dxZ2tJ?=
 =?utf-8?B?a2hzVk8ycktpend0R1BKY1QrNUFDZzhGd21mMUI1dEwrMnhxVXY4Rmdkeng0?=
 =?utf-8?B?THk5RWNpWkwzK0EzcHNaeW41U0tCZ245MzVmcnY5cTQ1R2h1N0c0S1B1RE9H?=
 =?utf-8?B?Snh4MXJHU3JuS244RnJGVmxERWZJRnN0RCt3UHVzWmZxZ0x6cFJnV2ZQMjB2?=
 =?utf-8?B?K2J1VlVHNVlCNlZmQUE0Qzl0RnZGaWw3eE1EWFh2a3FGdko4Sm8zb2tLczFO?=
 =?utf-8?B?bWIrT0k1TUExUHpUMk96MDNCNzFDUkFqVDA2cFRMazN2UEtJWEt2UnUwVzNW?=
 =?utf-8?Q?fh+XHzSK2RcOHq4dCsia5+M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E93F499127B1094DAB01D2477891ADB1@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a9898adf-1be5-42cc-3f5a-08dcff63db25
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 19:39:12.2784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zVs7uzAVojXT0M2hW1T5WAdtiqySgifRibw5pqA4tOY1wM5eYdGLrmg8mCImSGFY0cMNWj/3ixPEymkylL7ypQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR15MB5171
X-Proofpoint-GUID: r9WAZsD9W3DkNqaZgLAGQZOErdOQ9w2m
X-Proofpoint-ORIG-GUID: r9WAZsD9W3DkNqaZgLAGQZOErdOQ9w2m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

DQoNCj4gT24gTm92IDcsIDIwMjQsIGF0IDM6MTnigK9BTSwgQW1pciBHb2xkc3RlaW4gPGFtaXI3
M2lsQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIE9jdCAzMSwgMjAyNCBhdCAyOjUy
4oCvQU0gU29uZyBMaXUgPHNvbmdsaXVicmF2aW5nQG1ldGEuY29tPiB3cm90ZToNCj4+IA0KPj4g
SGkgSmVmZiwNCj4+IA0KPj4+IE9uIE9jdCAzMCwgMjAyNCwgYXQgNToyM+KAr1BNLCBKZWZmIExh
eXRvbiA8amxheXRvbkBrZXJuZWwub3JnPiB3cm90ZToNCj4+IA0KPj4gWy4uLl0NCj4+IA0KPj4+
PiBJZiB0aGUgc3VidHJlZSBpcyBhbGwgaW4gdGhlIHNhbWUgZmlsZSBzeXN0ZW0sIHdlIGNhbiBh
dHRhY2ggZmFub3RpZnkgdG8NCj4+Pj4gdGhlIHdob2xlIGZpbGUgc3lzdGVtLCBhbmQgdGhlbiB1
c2Ugc29tZSBkZ2V0X3BhcmVudCgpIGFuZCBmb2xsb3dfdXAoKQ0KPj4+PiB0byB3YWxrIHVwIHRo
ZSBkaXJlY3RvcnkgdHJlZSBpbiB0aGUgZmFzdHBhdGggaGFuZGxlci4gSG93ZXZlciwgaWYgdGhl
cmUNCj4+Pj4gYXJlIG90aGVyIG1vdW50IHBvaW50cyBpbiB0aGUgc3VidHJlZSwgd2Ugd2lsbCBu
ZWVkIG1vcmUgbG9naWMgdG8gaGFuZGxlDQo+Pj4+IHRoZXNlIG1vdW50IHBvaW50cy4NCj4+Pj4g
DQo+Pj4gDQo+Pj4gTXkgMiBjZW50cy4uLg0KPj4+IA0KPj4+IEknZCBqdXN0IGNvbmZpbmUgaXQg
dG8gYSBzaW5nbGUgdmZzbW91bnQuIElmIHlvdSB3YW50IHRvIG1vbml0b3IgaW4NCj4+PiBzZXZl
cmFsIHN1Ym1vdW50cywgdGhlbiB5b3UgbmVlZCB0byBhZGQgbmV3IGZhbm90aWZ5IHdhdGNoZXMu
DQo+Pj4gDQo+Pj4gQWx0ZXJuYXRlbHksIG1heWJlIHRoZXJlIGlzIHNvbWUgd2F5IHRvIGRlc2ln
bmF0ZSB0aGF0IGFuIGVudGlyZQ0KPj4+IHZmc21vdW50IGlzIGEgY2hpbGQgb2YgYSB3YXRjaGVk
IChvciBpZ25vcmVkKSBkaXJlY3Rvcnk/DQo+Pj4gDQo+Pj4+IEBDaHJpc3RpYW4sIEkgd291bGQg
bGlrZSB0byBrbm93IHlvdXIgdGhvdWdodHMgb24gdGhpcyAod2Fsa2luZyB1cCB0aGUNCj4+Pj4g
ZGlyZWN0b3J5IHRyZWUgaW4gZmFub3RpZnkgZmFzdHBhdGggaGFuZGxlcikuIEl0IGNhbiBiZSBl
eHBlbnNpdmUgZm9yDQo+Pj4+IHZlcnkgdmVyeSBkZWVwIHN1YnRyZWUuDQo+Pj4+IA0KPj4+IA0K
Pj4+IEknbSBub3QgQ2hyaXN0aWFuLCBidXQgSSdsbCBtYWtlIHRoZSBjYXNlIGZvciBpdC4gSXQn
cyBiYXNpY2FsbHkgYQ0KPj4+IGJ1bmNoIG9mIHBvaW50ZXIgY2hhc2luZy4gVGhhdCdzIHByb2Jh
Ymx5IG5vdCAiY2hlYXAiLCBidXQgaWYgeW91IGNhbg0KPj4+IGRvIGl0IHVuZGVyIFJDVSBpdCBt
aWdodCBub3QgYmUgdG9vIGF3ZnVsLiBJdCBtaWdodCBzdGlsbCBzdWNrIHdpdGgNCj4+PiByZWFs
bHkgZGVlcCBwYXRocywgYnV0IHRoaXMgaXMgYSBzYW1wbGUgbW9kdWxlLiBJdCdzIG5vdCBleHBl
Y3RlZCB0aGF0DQo+Pj4gZXZlcnlvbmUgd2lsbCB3YW50IHRvIHVzZSBpdCBhbnl3YXkuDQo+PiAN
Cj4+IFRoYW5rcyBmb3IgdGhlIHN1Z2dlc3Rpb24hIEkgd2lsbCB0cnkgdG8gZG8gaXQgdW5kZXIg
UkNVLg0KPj4gDQo+Pj4gDQo+Pj4+IEhvdyBzaG91bGQgd2UgcGFzcyBpbiB0aGUgc3VidHJlZT8g
SSBndWVzcyB3ZSBjYW4ganVzdCB1c2UgZnVsbCBwYXRoIGluDQo+Pj4+IGEgc3RyaW5nIGFzIHRo
ZSBhcmd1bWVudC4NCj4+Pj4gDQo+Pj4gDQo+Pj4gSSdkIHN0YXkgYXdheSBmcm9tIHN0cmluZyBw
YXJzaW5nLiBIb3cgYWJvdXQgdGhpcyBpbnN0ZWFkPw0KPj4+IA0KPj4+IEFsbG93IGEgcHJvY2Vz
cyB0byBvcGVuIGEgZGlyZWN0b3J5IGZkLCBhbmQgdGhlbiBoYW5kIHRoYXQgZmQgdG8gYW4NCj4+
PiBmYW5vdGlmeSBpb2N0bCB0aGF0IHNheXMgdGhhdCB5b3Ugd2FudCB0byBpZ25vcmUgZXZlcnl0
aGluZyB0aGF0IGhhcw0KPj4+IHRoYXQgZGlyZWN0b3J5IGFzIGFuIGFuY2VzdG9yLiBPciwgbWF5
YmUgbWFrZSBpdCBzbyB0aGF0IHlvdSBvbmx5IHdhdGNoDQo+Pj4gZGVudHJpZXMgdGhhdCBoYXZl
IHRoYXQgZGlyZWN0b3J5IGFzIGFuIGFuY2VzdG9yPyBJJ20gbm90IHN1cmUgd2hhdA0KPj4+IG1h
a2VzIHRoZSBtb3N0IHNlbnNlLg0KPj4gDQo+PiBZZXMsIGRpcmVjdG9yeSBmZCBpcyBhbm90aGVy
IG9wdGlvbi4gQ3VycmVudGx5LCB0aGUgImF0dGFjaCB0byBncm91cCINCj4+IGZ1bmN0aW9uIG9u
bHkgdGFrZXMgYSBzdHJpbmcgYXMgaW5wdXQuIEkgZ3Vlc3MgaXQgbWFrZXMgc2Vuc2UgdG8gYWxs
b3cNCj4+IHRha2luZyBhIGZkLCBvciBtYXliZSB3ZSBzaG91bGQgYWxsb3cgYW55IHJhbmRvbSBm
b3JtYXQgKHBhc3MgaW4gYQ0KPj4gcG9pbnRlciB0byBhIHN0cnVjdHVyZS4gTGV0IG1lIGdpdmUg
aXQgYSB0cnkuDQo+PiANCj4gDQo+IElJVUMsIHRoZSBCRlAgcHJvZ3JhbSBleGFtcGxlIHVzZXMg
YW5vdGhlciBBUEkgdG8gY29uZmlndXJlIHRoZSBmaWx0ZXINCj4gKGkuZS4gdGhlIGlub2RlIG1h
cCkuDQoNCldpdGggQlBGLCB0aGUgdXNlcnMgY2FuIGNvbmZpZ3VyZSB0aGUgZmlsdGVyIHZpYSBk
aWZmZXJlbnQgQlBGIG1hcHMuIA0KVGhlIGlub2RlIG1hcCBpcyBqdXN0IG9uZSBleGFtcGxlLCB3
ZSBjYW4gYWxzbyB1c2UgdGFzayBtYXAgdG8gY3JlYXRlDQphIGRpZmZlcmVudCBmaWx0ZXIgZm9y
IGVhY2ggdGFzayAodGFzayB0aGF0IGdlbmVyYXRlcyB0aGUgZXZlbnQpLiANCg0KPiBJTU8sIHBh
c3NpbmcgYW55IHNpbmdsZSBhcmd1bWVudCBkdXJpbmcgc2V0dXAgdGltZSBpcyBub3Qgc2NhbGFi
bGUNCj4gYW5kIGFueSBmaWx0ZXIgc2hvdWxkIGhhdmUgaXRzIG93biB3YXkgdG8gcmVjb25maWd1
cmUgaXRzIHBhcmFtZXRlcnMNCj4gaW4gcnVudGltZSAoaS5lLiBhZGQvcmVtb3ZlIHdhdGNoZWQg
c3VidHJlZSkuDQo+IA0KPiBBc3N1bWluZyB0aGF0IHRoZSBzYW1lIG1vZHVsZS9iZnBfcHJvZyBz
ZXJ2ZXMgbXVsdGlwbGUgZmFub3RpZnkNCj4gZ3JvdXBzIGFuZCBlYWNoIGdyb3VwIG1heSBoYXZl
IGEgZGlmZmVyZW50IGZpbHRlciBjb25maWcsIEkgdGhpbmsgdGhhdA0KPiBwYXNzaW5nIGFuIGlu
dGVnZXIgYXJnIHRvIGlkZW50aWZ5IHRoZSBjb25maWcgKGJlIGl0IGZkIG9yIHNvbWV0aGluZyBl
bHNlKQ0KPiBpcyB0aGUgbW9zdCB3ZSBuZWVkIGZvciB0aGlzIG1pbmltYWwgQVBJLg0KPiBJZiB3
ZSBuZWVkIHNvbWV0aGluZyBtb3JlIGVsYWJvcmF0ZSwgd2UgY2FuIGV4dGVuZCB0aGUgaW9jdGwg
c2l6ZQ0KPiBvciBhZGQgYSBuZXcgaW9jdGwgbGF0ZXIuDQoNCldpdGggbXkgbG9jYWwgY29kZSwg
d2hpY2ggaXMgc2xpZ2h0bHkgZGlmZmVyZW50IHRvIHRoZSBSRkMsIEkgaGF2ZSANCnRoZSBpb2N0
bCBwYXNzIGluIGEgcG9pbnRlciB0byBmYW5vdGlmeV9mYXN0cGF0aF9hcmdzLiANCg0Kc3RydWN0
IGZhbm90aWZ5X2Zhc3RwYXRoX2FyZ3Mgew0KICAgICAgICBjaGFyIG5hbWVbRkFOX0ZQX05BTUVf
TUFYXTsNCg0KICAgICAgICBfX3UzMiB2ZXJzaW9uOw0KICAgICAgICBfX3UzMiBmbGFnczsNCg0K
ICAgICAgICAvKg0KICAgICAgICAgKiB1c2VyIHNwYWNlIHBvaW50ZXIgdG8gdGhlIGluaXQgYXJn
cyBvZiBmYXN0cGF0aCBoYW5kbGVyLA0KICAgICAgICAgKiB1cCB0byBpbml0X2FyZ3NfbGVuICg8
PSBGQU5fRlBfQVJHU19NQVgpLg0KICAgICAgICAgKi8NCiAgICAgICAgX191NjQgaW5pdF9hcmdz
Ow0KICAgICAgICAvKiBzaXplIG9mIGluaXRfYXJncyAqLw0KICAgICAgICBfX3UzMiBpbml0X2Fy
Z3Nfc2l6ZTsNCn0gX19hdHRyaWJ1dGVfXygoX19wYWNrZWRfXykpOw0KDQpmYW5vdGlmeV9mYXN0
cGF0aF9hcmdzLT5pbml0X2FyZ3MgaXMgYSB1c2VyIHBvaW50ZXIgdG8gYSBjdXN0b20gKHBlcg0K
ZmFzdCBwYXRoKSBzdHJ1Y3R1cmUuIFRoZW4gZmFub3RpZnlfZmFzdHBhdGhfYXJncy0+aW5pdF9h
cmdzIHdpbGwgYmUgDQpwYXNzZWQgdG8gZmFub3RpZnlfZmFzdHBhdGhfb3BzLT5mcF9pbml0KCku
IA0KDQpJIHRoaW5rIHRoaXMgaXMgZmxleGlibGUgZW5vdWdoIGZvciB0aGUgImF0dGFjaCBmYXN0
IHBhdGggdG8gYSBncm91cCINCm9wZXJhdGlvbi4gSWYgd2Ugd2FudCB0byByZWNvbmZpZ3VyZSB0
aGUgZmFzdCBwYXRoIGxhdGVyLCB3ZSBtYXkgDQpuZWVkIGFub3RoZXIgQVBJLiANCg0KVGhhbmtz
LA0KU29uZw0KDQo=


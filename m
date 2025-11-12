Return-Path: <linux-fsdevel+bounces-68009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E48C5074B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 04:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E82714E6420
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 03:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C872C326E;
	Wed, 12 Nov 2025 03:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="kfzhui7+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C340D27B359;
	Wed, 12 Nov 2025 03:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762919779; cv=fail; b=ImH43klZTEbwjXEJlHEZIWtr3K1E2Pd9ftEx4YvgJ7+HJbAhQcaJ3GxV1TLqkUb/AuTHJTBt0iVVBGlHiLow+KIXYBv4J5lMHgCXg1V9t+u3bFPp+TKJ0FOl6AEeFQyo9LY9kMjz+DJ5+pPUy1UZDqinrn6e/5nVgjKM4jCUz/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762919779; c=relaxed/simple;
	bh=wR8X00dImNgO6zHnN/QFSHWhqvaRymXqj8R7YrYM4W8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=duY98F3jrmv5fB8FsXs0vx4aTbdaqpytvLlRlIJss7+c2WgJ1m7kA0V4PZTXBPV9puhXdNFE57/UdyGU77hbj3Jr0oPPRolFG2ghpL5aShqYO4bTUjbmap/poimUJay4rg8ZI0kSUrIf470+y2BR92DUBpVomkOhV2KtQhrZgSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=kfzhui7+; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC3JYAT1269547;
	Tue, 11 Nov 2025 19:55:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=OB/cpdGWxB4zxDnFJj+LrCrZCVV+ZQNT99AoTB9O/zA=; b=kfzhui7+CjDt
	JdEzwKOdF5nBeyjzrfB+9980p9xqusrZtdBK35Wscj2NV4F8rgqIPU8onkZwXn4K
	XAl6pftZZKeJnHRc/QlEGxbdqm091eyLf3Wlx/QSTusK32zAztgSL2CDEVYAKM2E
	ET+TCscrgibglPbkdkgY5flJolvvkQKEzmnCkEOkKKUL6hyskkENcelqMyJ6giXR
	LjdwX4h4TyVpXZt3p7urfnXXnpNwSHTagWIsZnCAdZcsdDAoD49pnh20zDZlhXYh
	CRGEjvy7WVpsa4uYEV7hSdLowiLVfBLn5IRPPu0hYdd5nNi23oV4xceIwDbPdJEE
	IAe0eH0ZWA==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011031.outbound.protection.outlook.com [40.93.194.31])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4acj7t84m2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 19:55:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TYyAaO8BD8l4YSjZsk8hoDe9gB8qX0q4gP6O+eFucVx1sfHykvku3jihf0qIIhYxG19gmHZE79/uX8SmPgx1HqnGgn3a7659W51NI4n9fdgg1PBOSgx3MWEdUH3BTsl9e8noZTheH8L4lOFHnOVg4HFwUcC9aLG8qoxpXfe7hVDNgFbm6xgPkr0Foz0BeLSqWar8NHYqMCAEOoj2B2I0jAF6LM5yTRP2EWvgSszAsjkicTOPp9CEwGBPMV7zyNgLahmL/ReTz3xOWY1W+cYjt3sMfjDW9G+VRCj/lUQKY/51NxAY36kjK34P+5nAfMpEqAzMCWenf1Q85mlLfenOQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OB/cpdGWxB4zxDnFJj+LrCrZCVV+ZQNT99AoTB9O/zA=;
 b=Q6DIwc//3/sy51Ew7Zee/WGlASnKSBu0tHBovlu0F6ehxGNQLJqM8GH4ufe5xKiOknxIMC5ugf1oD86uXRxXTedZc4njfbpNE8ERu0K2kYW7TuKF6eAPHQn/X/KG5nRyvXxVG6maOOz5H5nTLbMTj1UFe7u23ZpROsoWiLvaqbHm4TC+UZQ9CRIQGiZIuGnI73Ma7QKUoWznvqIG4/ijiCDalvJGuG0RBwtax3KfS1idNDdYs4IOQTz4YPoGmI1O3riTTvi+5hG+w12SQQwGC8IAmJIdWjbKsluCafNN1hc7mh3zKkNqAJCTo5eiI+2L0tlKZQ2vbZeBf6mgKPPKAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by CH3PR15MB5609.namprd15.prod.outlook.com (2603:10b6:610:140::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 03:55:38 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e%5]) with mapi id 15.20.9298.007; Wed, 12 Nov 2025
 03:55:38 +0000
Message-ID: <bec4e374-7933-4887-9f86-d736e3c215ce@meta.com>
Date: Tue, 11 Nov 2025 22:55:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 34/50] selinuxfs: new helper for attaching files to
 tree
To: Al Viro <viro@zeniv.linux.org.uk>, bot+bpf-ci@kernel.org
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        brauner@kernel.org, jack@suse.cz, raven@themaw.net, miklos@szeredi.hu,
        neil@brown.name, a.hindborg@kernel.org, linux-mm@kvack.org,
        linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev,
        kees@kernel.org, rostedt@goodmis.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, paul@paul-moore.com, casey@schaufler-ca.com,
        linuxppc-dev@lists.ozlabs.org, john.johansen@canonical.com,
        selinux@vger.kernel.org, borntraeger@linux.ibm.com,
        bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
        yonghong.song@linux.dev, ihor.solodrai@linux.dev
References: <20251111065520.2847791-35-viro@zeniv.linux.org.uk>
 <70d825699c6e0a7e6cb978fdefba5935d5a515702e22e732d5c2ad919cfe010b@mail.kernel.org>
 <20251111094957.GT2441659@ZenIV>
From: Chris Mason <clm@meta.com>
Content-Language: en-US
In-Reply-To: <20251111094957.GT2441659@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:208:91::32) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|CH3PR15MB5609:EE_
X-MS-Office365-Filtering-Correlation-Id: a5cca6b8-49c4-4c80-fc39-08de219f575c
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amgvWXU2eHhzeWw0M0UzbTk2eTFsTWczeUYwNTdnNURCUXBBd2Z4TW1kR1Zq?=
 =?utf-8?B?clU1RkxlSWJWY0hJc3pUNDBkbDFVejJUWjJ3M2N3RmY5UTkxazV5ZXk5T1Yx?=
 =?utf-8?B?VkpoQzBvL0JwTXM0YldqMDZnUGVhN3pXdzNCOVQrZHpFNkxXSGZYYmxFb1do?=
 =?utf-8?B?b2pyNjM0Tjg2ZmZKUmxMVHlQUVF6Mkw0VzFEUVFMSUQrekh1NndYMlJRQkt1?=
 =?utf-8?B?eERDNENoUzVlS1pYSWcvdlhjNWNOT2NpZGFob1QvK3lwYkxXZnIvcDlPWmtB?=
 =?utf-8?B?SkxnVEJOZ0ZWcEN6TE9qQXg1dDlTN2pmcG56UXhIVmpBaUMrbFg4ZnY0V1hw?=
 =?utf-8?B?cGxQMU1kM25mNFAyekU2cTE5VklRYkY2dWdHaytkQmhjVEtwL2NhcDRROFJx?=
 =?utf-8?B?SDN0bFBvcUZRREREU2ZQWGU0OWhodzdTUzdsVDBBVkJMRWE4d0M4Zk81dXps?=
 =?utf-8?B?RGFVeW12MFZHeHpmYzQvRVpLQkJzcXJ1SXVySnh5dzdQVTNSbmRhTGhZY1l2?=
 =?utf-8?B?aXZHdGxCbFdRNk9GNTRlWFU5WWs4a2tveFpFT3BteHMvUzYvMktPRnY0TGdw?=
 =?utf-8?B?N2NaeGxmSDdXS2VtVS9NU2xMYlgvcFFET2pTbkNuQ2tNRUdUUlNWaDM2YVhN?=
 =?utf-8?B?eWVDU29scWU3WDVqNWpQOGd0TllhaFRoQ3FLWDBqV0RPL24zUXg0ekQ5QjBR?=
 =?utf-8?B?ZDdTeTR3Vkk4QXgwUW5XTEE0WmdJWHRIRzNNd0wzS2ZTdVcxZkdWRXNmQWM5?=
 =?utf-8?B?aTEyMWk2b0FCTnBocFJhdjlNMC9TcVhoQlpQVzNTVnV5d3I4bDJSblFUdko4?=
 =?utf-8?B?bW9GSk1lTURrT0RxSis0YTIwOS9xNUhVbXVCbmU1bHE5RWw4MUxoVGpGK2V6?=
 =?utf-8?B?Wjhaa0ZPOEViTENCK3B1ekN4Q0tXc2xudUtKcUN0UGU3VDhCYmZaTXlKdFFQ?=
 =?utf-8?B?UHc0azdtM3RnSW5tblA4Y3c5YmpzQkgzYjdRbkF6MHl6aW4xKzNqbXZ0c3R4?=
 =?utf-8?B?VW95T2lhWE41enlpMGxrdUd3ZXJmSVUyekoySU9mdUVndFUxeG5CT3g4UlBt?=
 =?utf-8?B?U1hqa3RGTE04ZzJxUUdSOXloZkhYRDNZcWFDQUtmdnc2TDcrMEQ0SWV4eHJW?=
 =?utf-8?B?RFZhMmlaY0pEc3RYVU1qMHo4RkdWVzE3Z2RjTVF1MzhDM3QwUG5mSmh3THB3?=
 =?utf-8?B?REpmWWdOUVozazdDSWIxZmNCbmoveE9QNzYwaGZ4TXJjS0Z4cWJIWmxEWVY0?=
 =?utf-8?B?UnJYNThzRFA2WFhuZXRoZXhhTVZIY1VyZyszOHhjSitOS0o0RGllS2pqSTNa?=
 =?utf-8?B?SHNvbVhucU5oWms3cUlnNTRiak4wSkZ2UEpOMldFcE9CWmNkWjdDTEZidkRQ?=
 =?utf-8?B?d1kyZDl6dDJyaXlleFd3bE1RK1hiZEtGY0J3LzJmd1d4RU5YZjNsQndHc2h0?=
 =?utf-8?B?c3ZUclB0My9kNHlJdzZrQzNFaVRLTDUyU2lNZzF2bjVjK2ozZ2h0Q1MzRGR1?=
 =?utf-8?B?K2hKK0R5eFFFNTNJMEFaUGN4bFYrbytZQ3ptU3FhZ3oxNERqK01jZFJzZUZR?=
 =?utf-8?B?OUFQVUFPYS80dmwzNlVtY2N3LytGWEhGQkFzeDZLZ1JmY2syTWtPVTJpRXhy?=
 =?utf-8?B?aVFSVnBrS29QMlFPcXJ5VlFaWms5bVVWNlpnd1dlRWowNmlrd2xOd3U1ektQ?=
 =?utf-8?B?dG9Wa0dhbWwyZUwyWWI5cVIrcWxLN3NLRWd4Vm5WMitVenZMdkFaOXF2enVo?=
 =?utf-8?B?NWljSG9wKzBiM1ZJNllnOXlsczFMU1Q1ejBqcWg3UFE4V3VmeE9WZ0xUSTVk?=
 =?utf-8?B?VWtxTEx1cVpGS0ZFdVhOTHZ1dkRlQTlSU2NuYXdBNDhHbFQvWlVoQTdGMzd4?=
 =?utf-8?B?YTJBck5YMkIzWG9HVDcvVlYvd0hHQkNvbnF6OHlEenFDcnJncVptYloxdExn?=
 =?utf-8?Q?kIjQnHTxhgnKq+MGyqWk8bKOlzvT/I7H?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXRVeTRNWGNYWW9NVFJGbis1SWpoTEFybytaeHV0M2RmRlhKWFBvTDJoYWlS?=
 =?utf-8?B?VGZvekJBK2dGdjk1ampaNmd2N0ozK1M2Q2JXLy9SdlIyUjl6amdoN0tYMUQy?=
 =?utf-8?B?aEthYXY1QnREVVJuZEsrSkY3cWsvd3RTNnBNcEJFVWM3b05nSUhlMS9EM2NR?=
 =?utf-8?B?ZGU4R0IwKzFjZGNMMUZxSTZXcFlNRkFpKzZXeWZCNlVEeVNMNFF3YzJEbEYz?=
 =?utf-8?B?RnBhdUxtSm95Q1lnNk5waDdDVDN4TUZ6U2lwdTBLa3I2Y3UvMnJ5TktSS2Zi?=
 =?utf-8?B?d2x3N2lrRmhGMUVlbWI2NTNhQTlDREZHTkJHSXNBYjNNNE8vWXlyZjJzdHdn?=
 =?utf-8?B?a2NvN0VGck0zM1ZmbG9LdEpzdy9GOVJiWURBSHZDV09oRkdveHpHTlJKMm5x?=
 =?utf-8?B?TjhQV2FVYlBBS1QxZDdxSFpxeUdnS0ZFVTNxWWZNRmhFbTJsdnJvUm85OEpM?=
 =?utf-8?B?QWRpandVbFBzSFF1NnBhZjVKWE94NzBNTEdDdzZyaktRQWhEM1Roano3Tllw?=
 =?utf-8?B?bitlaUtsTUlTNW1HMDh6OG8rRDVLRk04bHZqUEplTkdvYnVsQ00xcWg0UjFh?=
 =?utf-8?B?aGI3SHlzazJoMHVtVmhNcjkvUmdsY0YxMHBOdEkyY0d5dmV3L3hjYWQvck4r?=
 =?utf-8?B?dVhiUmh5Z2R1SXVkMVE1U2FENEtJNGdnMFBObkZBTEFxdUxEYkFUY1I1YWR6?=
 =?utf-8?B?djNqdzlIMUhhV205TU1SdTY3ZHlueTJNMXB0N3RqeHNyTHFCOHowOXhkL1g5?=
 =?utf-8?B?T3RVR2RzWUI4WWtyaGNUbWpaVkNOSzNtb0VvdzZsZ3lVZm9QbTVRWFNWckJ6?=
 =?utf-8?B?R2ljWWgxNHRUMTdtQWRidm5GZmt0Z1lTYmIvM0wwZWhOdVorSTNuNGlWTm9O?=
 =?utf-8?B?Qlp3ZTFJN1ptdTdRalJDeitlY2hyWmVOOHF3MVFXZk92bW0xaFRCem42aFdS?=
 =?utf-8?B?ZzE3bTNFNEUxQW9zQXpYbTZ3VGtGTk43bE1rZjl4ZzVHL082cUY1aDU0L3lB?=
 =?utf-8?B?bjRZL2ZkdHI2T0NPeG1zOXhrSERScnhEYWk2NFovMGhHcHR0L3I5bStZR1pz?=
 =?utf-8?B?YUJXNUNPUVJtcmQ2V2ZHMWtkdnk2QzFkdVBVWDBPVlYxNndhOTNtUk9PK2N4?=
 =?utf-8?B?aUM4L3RpWi80K29jZGpkWndwTlcwV2syS0hCYjBGK3orRDFsQitOYWRyODRv?=
 =?utf-8?B?bXFjNTdabHpDd28yeGp3SlpyRXU4Z2Q1dEphNXEvZWMrOC8xL0hOR3FXU2hV?=
 =?utf-8?B?ZzRpWEROcTdWNzdkUjhXQjZ0dW5PTzViOTB0SmlMOFJWQUlZZ0V0YUxoZjZq?=
 =?utf-8?B?TGI5bjdhWWhaeW9FRVBOOE5IaW1mVFRwVkF2OXZ5ZjA5T0d4dVFzTGlKU2w1?=
 =?utf-8?B?clU5WUIzYXgrWWFUblIybWhTeUM4NWRNNlpOcFNUWWg0bmlvU2wxSmdkanhn?=
 =?utf-8?B?K2wya1dPb3AzY1JNbjNOclVTREtzY1lKaFhrNkF2TFV2S1RPdE9QTjJhYUMx?=
 =?utf-8?B?TmR6d05zWUd0TGp6aThONThQa1RxQnI3dG1KcHFnKzRzejd1ditHUENRYXoy?=
 =?utf-8?B?RC94VG1kSjdDaFp2b2l6bGo2MG9mRkRHRjlFaFFFZXdRVHVETVFUQUd1aEpn?=
 =?utf-8?B?dVk5MDVSR04vcHdlZk54UnpSNlcvVm9kUXc3TjJ1WmUwWUFsTS9ZMDk0ZkpH?=
 =?utf-8?B?U1QyVCtKUWo1OHNFaGZPbDR1ZW9YWDJ6dHc2dzA5azJESVRXRExSbC96VEl4?=
 =?utf-8?B?NG1xQXlnREVaVlZvcUVPdTZvTGdaYWVZNmoxZSt5ZUlCYXlGdDJrWWdUNlc2?=
 =?utf-8?B?eHNmeE5sTjB2Ni9aNXJUS01ZVTl2YVkwNUVibHRCZXFZSHVhcjBUOFVrcXRU?=
 =?utf-8?B?RWdyMHBuZ2h0NlVDeGNFcUdHWjlML0RiOHg1dFAzckpscVZ4RCtUeWRBT3R1?=
 =?utf-8?B?QUgzRTBwNFhVVS9icWNvVjU5LytQaWNNN1Z2VlU0cVRUWlJEQlhvaUFDa1Az?=
 =?utf-8?B?MG9FWUsyUE9OZlNqS1RHRnFnU1lQMTMvNkNPbzA0TXc0UTFPVU5wOGhzTXBp?=
 =?utf-8?B?S2xJc1FycVJTa2ZZdXhNNk03UmpTRnNLYVI4RDgwSGtSa0pvZTdZWG5UU25p?=
 =?utf-8?Q?wd1o=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5cca6b8-49c4-4c80-fc39-08de219f575c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 03:55:38.3460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: naCAFEsCnqhI+0LtDoZH5ByxKX3SGg66tIaIVWBav45sy4rCvDBPkobrFaCr13JU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB5609
X-Proofpoint-ORIG-GUID: dkpDveMzxDxr2zAYLC3QFiJUICr4EnVF
X-Proofpoint-GUID: dkpDveMzxDxr2zAYLC3QFiJUICr4EnVF
X-Authority-Analysis: v=2.4 cv=Wb4BqkhX c=1 sm=1 tr=0 ts=6914053c cx=c_pps
 a=Kwamffe9LshCGz4O85X6AQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=N29JupQgJH5nwLzWIrwA:9
 a=QEXdDO2ut3YA:10 a=DXsff8QfwkrTrK3sU8N1:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=bWyr8ysk75zN3GCy5bjg:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDAyNyBTYWx0ZWRfX5Eqh5N7tDRXW
 xIbaJYWSkPoMLdFHiI61FVy0iwWF/1i9YWr0PObJaQ7eDChX0Z9L9PMKTtGPO0SxVdTSGIvZRGH
 AcVRPr1bVZvbccK25ldPLFBQgLxID92BqxOA4OSJpWVlAzIr4oWKMdrE8ifo1hu3X3QHuham9gx
 mIaUwnNK59aAul4TDn/x6ZRGJDN1L0NqKgNEp3+yzzDMGWgNS5tcih/jEwE2CqzkxQmU9s8mlCr
 5s1ht4fyraFGZhh71Fds+ee0m2WcUwAejGl3tE/c+3WiedzmbWd7xs3bsZ1kJknm4Lx+vJhGHWq
 SOqxg99mw139S71l/CTC4w+l5yKQbhE2waN8xCoc1LB/Ihk9r4zqU6DB228loNAdA1t8JCFZgxT
 MLU9kVU96GkrH8+BnVeIN674PYstww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_01,2025-11-11_03,2025-10-01_01

On 11/11/25 4:49 AM, Al Viro wrote:
> On Tue, Nov 11, 2025 at 07:53:18AM +0000, bot+bpf-ci@kernel.org wrote:
> 
>> Can this leak the parent directory's reference count? The parent inode's
>> link count is incremented with inc_nlink(d_inode(dir)) before calling
>> sel_attach(). When sel_attach()->d_alloc_name() fails and returns NULL,
>> sel_attach() correctly cleans up the child inode with iput() and returns
>> ERR_PTR(-ENOMEM). However, the parent directory's link count has already
>> been incremented and is never decremented on this error path.
>>
>> In the original code, the parent link count increment happened after
>> d_add() succeeded, ensuring it only occurred when the full operation
>> completed successfully.
> 
> All callers of sel_make_dir() proceed to remove the parent in case of
> failure.  All directories are created either at mount time or at
> policy reload afterwards.  A failure in the former will have
> sel_fill_super() return an error, with the entire filesystem instance
> being torn apart by the cleanup path in its caller (get_tree_single()).
> No directories survive that.  A failure in the latter (in something
> called from sel_make_policy_nodes()) will be taken care of by the
> call of simple_recursive_removal() in the end of sel_make_policy_nodes() -
> there we
> 	1.  create a temporary directory ("/.swapover").  We do *NOT*
> use sel_make_dir() for that - see sel_make_swapover_dir().  If that has
> failed, we return an error.
> 	2.  create and populate two subtrees in it ("booleans" and "classes").
> That's the step where we would create subdirectories and that's where
> sel_make_dir() failures might occur.
> 	3.  if the subtree creation had been successful, swap "/.swapover/booleans"
> with "/booleans" and "/.swapover/classes" with "/classes" respectively.
> 	4.  recursively remove "/.swapover", along with anything that might
> be in it.  In case of success that would be the old "/classes" and "/booleans"
> that got replaced, in case of failure - whatever we have partially created.
> 
> That's the same reason why we don't need to bother with failure cleanups in
> the functions that populate directories - if they fail halfway through, the
> entire (sub)tree is going to be wiped out in one pass.

I've rerun this review a bunch of times, and it properly reproduces a
variation of Al's explanation every time.  I'll try to firm up the vfs
rules but I can't find a specific way to fix this one.

-chris



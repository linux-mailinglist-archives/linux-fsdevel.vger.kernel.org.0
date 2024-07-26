Return-Path: <linux-fsdevel+bounces-24292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F107093CE68
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 09:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CCCE1C20EE3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 07:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA07F176255;
	Fri, 26 Jul 2024 07:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="nEhVyBhx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6028723D2;
	Fri, 26 Jul 2024 07:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721977309; cv=fail; b=W2crb1+oiXZHabpjjWMO/K7fBSRiaZTUVDB5Vcn7IOVAq1oRe8CIk2+NKf7pJ9OIx3gVJHJ70spDK3DjXfND7rwbYltugJ+GVvT6D602CA2xFGB+1NuHdDI5HetIEFZ3mjPF1I6XHk3i7pGeJjdW2fhNZllYBvLsqO+dBsGk87s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721977309; c=relaxed/simple;
	bh=gCyorpbMceTaYGPk+RqYBhHxGJrqMzfUtRC/78i0pXI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I3Q1RfGLysTOLh/TdLkzUFzcz/Z6gHePFSugfNipsaD3IYHwkz0Em32z7HByBogsyeRk6vF+Ub5DOR0i0+9X8VzKnsdsMZhKEkfHZJXymUg+DDbUPwaHgCj0YJPdKcXcYjz3qSkWWfKUiA7ybjrQyV9d7CoP7iR3MIpRm0LjOls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=nEhVyBhx; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46PLYF9k018345;
	Fri, 26 Jul 2024 00:01:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=s2048-2021-q4; bh=gCyorpbMceTaYGPk+RqYBhHxGJrqMzfUtRC/78i0pXI
	=; b=nEhVyBhx9tk0UsqgZ7jx6Pii/4Qv1ARrjkeDLfr5AJP74K0eWpoZzefuJTK
	/3M3weWHt+GgGBwEIXl6xgG7WWwlgmK4hMPjuJPowZkUsJ0XHlYIgf+xK9vOkS9p
	cJse+nasS4GVzoyicI7LoIGCUjwelNAhxV2hFDHl3MZt0ua9JR5fX6E4Fnb5/dFq
	6iRMlln+i4AF8jhutzlKGStSB/ADI4/8FiiKY8vCH4HFDaOCJgAW8UGRLU/6oWk5
	FdRl6GOQVc1AU68l6xzeaDjDru1hcMVLk8ud/YtjFxP6ZyVOFt+6uJQErFN2hRQn
	+ovpbdH2cAtNzdkJ9t9/5u8xHKQ==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 40kxr0a69u-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 00:01:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQfhAyFRChPBvNZwxYXusuJ/k8511e8ezmG2IYo/T48IDo8lEM6asAxE0YIJJVx1tO0p2PS0W/7OzkVy5qqfjuelhGNzhh5ccQDCESX9nKdZKWh3Thw7LYqvLMrcf7e5pgAN8+byh09vE8SEtxRT2uVOy/2Dmxe/Y2/szI1idTRzHqOa0UfaRElT9/PffjynHUuGGtYpf8pn3hDZMXg760tUWaI2z1dYOfUBMhae84hSY7uBMRAAd2ExovFuT1T50vLdKqexNMvmOecPi639itSdPQHGoY2KUhaBTESMfuIo4H+NnxB+LF0S7EDnWwiFg6Hjqhs4ZwlobzIujvR02g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCyorpbMceTaYGPk+RqYBhHxGJrqMzfUtRC/78i0pXI=;
 b=FyAxp7myT2oa07k9gZwZG4YnWxNBNsqgbBllRl7aMl5yL/2LaNCXsFA0fZAgqvaKqqf4XZGfxdNKAQslTaEXWYdqJ8qz3vSGyKpapYoHlDoY1utm1SPZLSB/Hjc85i2X/gdpVd1/8YJVDpa3HXXu0R+8ei4BFoWjtCIT1xrILX3vFab/4BUKwkKfKE64iJYxHYnd1vux+Mx/lGKR3C7rDlRWIs50oZysNfcqhmSuBgsqOR0REQUwResjORE9SVr+b/kwK+nBNYztt+8dNOOoicszWYoYQhlJ10Kh7XMpNZxoj2AC3my0UqpJnoUEQoE5aFUyjoK7VUcgTnITR9zcCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by CH3PR15MB5564.namprd15.prod.outlook.com (2603:10b6:610:141::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Fri, 26 Jul
 2024 07:01:39 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%4]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 07:01:39 +0000
From: Song Liu <songliubraving@meta.com>
To: Al Viro <viro@zeniv.linux.org.uk>
CC: Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
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
        "brauner@kernel.org" <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        KP Singh
	<kpsingh@kernel.org>,
        "mattbobrowski@google.com" <mattbobrowski@google.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add kfunc bpf_get_dentry_xattr() to
 read xattr from dentry
Thread-Topic: [PATCH bpf-next 1/2] bpf: Add kfunc bpf_get_dentry_xattr() to
 read xattr from dentry
Thread-Index: AQHa3u0Cexf6lH6r+0uPB508WO+f57IIfR8AgAAYTAA=
Date: Fri, 26 Jul 2024 07:01:39 +0000
Message-ID: <B0E4F345-9958-44C2-9985-96F77F0DEF0F@fb.com>
References: <20240725234706.655613-1-song@kernel.org>
 <20240725234706.655613-2-song@kernel.org> <20240726053430.GB99483@ZenIV>
In-Reply-To: <20240726053430.GB99483@ZenIV>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|CH3PR15MB5564:EE_
x-ms-office365-filtering-correlation-id: 1e9c5096-cccf-4b99-b648-08dcad40cbf6
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZUNFcktsYUkzeU5lYUk0RVArc0pPN3BKVVVCMVV1ZjNLaWo1QkhnTk92UStD?=
 =?utf-8?B?bHRmWElmRWJTZTNFd05RMjNIbGllZlZMNlBSajZyTG9zc29XNkFzVkNZOFpj?=
 =?utf-8?B?Sk9TTVAxZDhkU3VlQXgyUER4Zy92eWkvcUJvTmpOamI2M0tLLzllRFVLSU9j?=
 =?utf-8?B?Y1NkcnltanhHY0ZnYlBGR0xjRDRaNFpyMWQ2YzFDQzNVaGpPUm83QUt2bDgy?=
 =?utf-8?B?WHBYVzR0TTVkQUsyUjk2Qzk0ZkM0SmRZbUc1aFNsU0ROaWZxNVlCeGJFSjRP?=
 =?utf-8?B?MUlEbE5EMlFKcHQxVVhWZ1RBNk1xcEd6bDZ1WXZNTWl6T0ovL1VlY25GemlH?=
 =?utf-8?B?UUpWZ3RMSDcrODRhVFB1ZEYyblRVRGp6a3hadDRzeCtSdUdLVWZjVFNqZnZB?=
 =?utf-8?B?UDdERHlZTmRnWGhiQVJmS0JFdmhsak9oN2x6emY1WTQ2WUQ4K0ZnUkZqZHBy?=
 =?utf-8?B?Y1VLcHBoQ3k4eTJrYW0rY3RWdW5yNWZrQmg5SE0xVHk5bmN1b1ZnOVhpMW11?=
 =?utf-8?B?ME9xYVJZUlFVTHBUcm5mWUZrUlBvQ3RmUmdWRHhqaitNd2N0RVlyTXZDVHZI?=
 =?utf-8?B?TGN1RHFFWTIyN0kvNGh1MUFWZTZYcEJPeklUZmxvOGt0YUs4b1Q1b1pweXNp?=
 =?utf-8?B?SnE0Tmt3T2E1eFUwSno0a09aNmRYZ3M3NmZKVkk2MysxTVpPSDg4T1REOWxv?=
 =?utf-8?B?RkFUWkQxM0ZUSmdSakwrWm04UVEra2ZtTHNCZTBleG9NU2tlalU5MGIyWk1v?=
 =?utf-8?B?NnhvVGoza1hCS0RDQXF4dE5jWVQyd1h4dEdrSkltTHJadDJkak50S3k1OTM2?=
 =?utf-8?B?dzBEUFhldGxUVUlZRTBqbEhEZ1BRYTlPRlQ4ZnYyUmVOMTZObUsybzZ5aTd2?=
 =?utf-8?B?azlFeUFMOHVvelBpRmZUN3hvbnVPbDRnTjJWTVIxK0FudmNzWmFrS3g4Njlz?=
 =?utf-8?B?dTVrZnVraFhUNWkyeCs4OXh2R1hQakF3V052bEw2VS9qUnFlVEJDa3FvTTla?=
 =?utf-8?B?MUVBOHpWRkIvWE9VUkdMQmFLSEJYYnNTdW1LNEtkODlmMUhucnNVZzNtczJE?=
 =?utf-8?B?Ums4TDZBOE1MZFlDN01ZL3hLb3A3RUhTQXc0Sjl6amlzWnUrTGw2WVlDOFgr?=
 =?utf-8?B?ckFtaDY0NjRNRGVJM1FDRSt2UUdxaXd1L2EwSURrSE1xMkxCSU5Demw4a2hm?=
 =?utf-8?B?Ky9YNjB6YllzOXhBcmhkd0JncjhWMDFoTGJOYXBqbmRISVpKZFptbDVmcEZY?=
 =?utf-8?B?TkVPc3dhN3JoNjYrTjNlZWdaOVBjbVhGaXQ5S2x1TzNDTDMyK2FpQWg2aVdz?=
 =?utf-8?B?WVRKTEw5M0RnSXRZZktKbE9oNGNYa2lZOUFST0VuUjZ0THd2R1RyZzFscTNT?=
 =?utf-8?B?VGI1VWM3a2VKWEFOL2l5N2NKc0ltYWtkS2FxZk1OWkZjUVIzbFV4QXUyMFNo?=
 =?utf-8?B?QUJSMlR0OHZrdTVVb0o4ZStzbzIzVE9DVi8rK1Jwdkt0WEZLNEVtYmtIR1pE?=
 =?utf-8?B?Y1VxbDZnQUEzT3RpeW02ZDk1R00xWENIMWZ5R3FiRC83Y1JkanNzbmMwdDRE?=
 =?utf-8?B?dmtveHNKYXd0S0pMVEdJSVkrWml6TE1kRHJEVEpFenB5Z2RwZEdreGdYYTdK?=
 =?utf-8?B?S0QvdThEenR2WWdwQUNMcERCQ3FDMDBKdDdoSGE5MUhWUkdhYVdTS0tMQTNp?=
 =?utf-8?B?WUxLaUNtcjFNZ3h2K1NucmIrMm0yQVZhTWFNNld2aHBqSk15TWx0Tm95R3F2?=
 =?utf-8?B?Q1FDRlRSWGpjTUcxTHFNL2syZEFucWtzc09SREEwVnFiTkJOcFdJeFROQ2gw?=
 =?utf-8?B?Q0MvaFhhTklNWUVJMWhobTZPQTZyS1EyUDVHOEpCbDRjNUc2alg5REJiamJt?=
 =?utf-8?B?L3EyRkpibUpMTm9IRjEvR0s4UGo4RU1ROE03OXU1cVd4N1E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L2piYTJQS1p6aFdUbUw3clBDYndoNncxSmFHRlpCaU8weCtoYXdkZUhJNGRN?=
 =?utf-8?B?NGhoZGNkRDdZREhHTEN4bHIvelUwUmtsK2FVdGpOTkVJb2ljZjQ2Y2VaaG9P?=
 =?utf-8?B?anNMNXVTWjJuTzZDUWRNYmV6Z0FQUXZmbTlKVGxLdWNXNzkwZm1OUjdkZ2Na?=
 =?utf-8?B?UHV0TEt4bTJjNDlwY3BiRWVra3JhS1dzU290MUwxZ3hqUDdVZ2dhbHIybzJS?=
 =?utf-8?B?WWJHMmkvMk9NZ1grRzJ4c1h2MWxqQWdiZlpLdVNlNUo0MDVvVzhiUWs2QzBw?=
 =?utf-8?B?OFN2ZWpoajBESHZwa1dHNEtjOWpiMEJrSzJ0Wm9TRXovYVFTWDRIOVpsbVBs?=
 =?utf-8?B?QXk1a1k3ZjZsMnBuSjVITExUS2xhY0FwVzJjakJQVXBHbmhuZERRZVA5UUlv?=
 =?utf-8?B?dkRtTW1nYlRoZGdjcHM4bzR4N3RKMTZIZ1pYWWNRVHp1QUpFOFJKTDA0TGtV?=
 =?utf-8?B?L2NnME41NEdzak9CeUlFaDhiblVpbGZYM2I3anNMVDl4R0JJUXFRT0o4YTZJ?=
 =?utf-8?B?ZGZzM3gySVUrNlZwUjdvQzhabUUzV2NyZzdjcW45RnRFeldYZ0k5RTdiY3Vy?=
 =?utf-8?B?SHgzakI3Vk0rZkVxanlaWGZ2TGw1NElNMHlQbkRZTWRWUnFiVVkySFNtbVhr?=
 =?utf-8?B?UVNub09Da1dHazB1a0JiWExBUU1pSjdNRjdVQlNvNmJOMkR3anZSbld0Tmdr?=
 =?utf-8?B?d1cxbkxiSnFaVy9kZHpGOUFKQnlBaGhVaENCRU9SYW81TTdzeDlFdUZ5aXR3?=
 =?utf-8?B?TXFxSDhmQzhVV3RyRWJxc2o1NXY4ZEhLZ2NreHVsZVFGTGtGTmF6MWNVSngz?=
 =?utf-8?B?czRFVWtXaEs4elBONzIvU1BSUEt0emdtVHEwcnlwKzF5ZTZTTUVmL1YweVlC?=
 =?utf-8?B?M25wYU8wdmIybEFXK1A2TmE2UE53eURtT1puYXRMdVh2RjhYTVErTmRBb0pC?=
 =?utf-8?B?SHExVXgvNUpKT1Z0bFFxVkFDSWRPNHQwdE5pUkRQNUJvaGk2Ukh0QkUxRUhD?=
 =?utf-8?B?SGNKMmdPNDZ0NEVNYWhUZEViUVhWdUNzVGFWWFF5VXlwZDJhU2pmbStGRFR6?=
 =?utf-8?B?VU1qRkRyeUFpOUprMUtoRTZ0dm8wKzZOYmRIdk9qNkp6a2k0azg4ZUF6WVo5?=
 =?utf-8?B?SzFGaXFwQnY4S05QU1pEU1FFR2R6RWhUZjNHTGJ4dTJ0WmQrMVhUTmNaL1JE?=
 =?utf-8?B?c0VQY0xaUDU3R3NENCswRCtLaXBlRXRhM2Uvd1R4ejd4UHFkUkphNWJzQ2R6?=
 =?utf-8?B?WHJRbzhRWkx0ZDI5c2UwaGl1WFQ3SWs0d280ZTlUQXI4OTk1akdibEphWDdP?=
 =?utf-8?B?SXJOanFLTXdVOG10N1d3K2VwUGlDUUUrSExUaDJrdktlcDlncE5VNFhSUDVK?=
 =?utf-8?B?UGtDNHNuVEdlcXdWL0Vidm5QeEV2UHJseU1MZDVRaFlzZjIzc091Z2pML0Rt?=
 =?utf-8?B?VVF2aUFVaUY3UmhxeXd5OGI1RU1pKzBWNlNwb2o0STVBcFd0dWRXNmxuN2RM?=
 =?utf-8?B?NzNZL1kwN09PcU1LY2xwU1poSWc1MGxYTFVuK3ZNOUFsbE5ZZ1o0eWk4d05B?=
 =?utf-8?B?QzAzTGQ4clhnVFVrTVJiSnRnZUtveFNiaW1zUElydStzQ0JRRlhOMEUydG1O?=
 =?utf-8?B?RjVmdEZHRzVRNmxoZGhJdzlvYmU1WVp6djRIOUpZZFVlS0s1TWpVSVhOanNR?=
 =?utf-8?B?UzcxZXhxQzQwclV1V2lWdURmMGF0b0VKV2wrMkw5Zllrd09LS1FabDNJaTc2?=
 =?utf-8?B?dUFXaC8wNm93MXBsNVZrcTFhTDVqVWc3L3AwazJ5cE1VUWlFaEJRNXlyRWpN?=
 =?utf-8?B?d1pTM2hKeFJNWS9tdDFEcGJXSFZsd0UxNlBWUnZXejcvdTlqYk9ZM1dZRExE?=
 =?utf-8?B?SkYweTFIaFdaYjVFdzFZR3l6OUt0ZUdvdVFLa01pVTZUdEVtcEMxQ2JuOHpl?=
 =?utf-8?B?VVZxREFVVXhCR2srbWRuZkMzbTlBVWxPYmNOVzBEL3NvUDU4eWpJekV5WWJ2?=
 =?utf-8?B?YnpmYVRxdXluNmdrbzBMeFpxd3RQYmJ2bWo5U2xUWDJRTVVYWU9RWStRN0dE?=
 =?utf-8?B?TEFwVU14bnl5TC92dlViV1FyaFE1QmIzMUU2SitWY2VBeDJQMW5KNjdQcTFK?=
 =?utf-8?B?MHg2Q0dRRERnQi82bmdsc0RmZ21tdGNNN3RuNTZ1YVcremhKeDlHUkNybndR?=
 =?utf-8?B?WGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <765ABB3805D37A48A166114E569667F0@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e9c5096-cccf-4b99-b648-08dcad40cbf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2024 07:01:39.1054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SA8+/Qqn45/fF9MLUjIn5LDLx/Glzl8A4QLmeqQZbN0OMFAtNkNQLletAIhfEAKRnq6m6aUplFQe8cqg0Paq+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB5564
X-Proofpoint-GUID: QNxYeUnVEmYqv-ux-iAKvvOKRe0HYsJU
X-Proofpoint-ORIG-GUID: QNxYeUnVEmYqv-ux-iAKvvOKRe0HYsJU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-26_04,2024-07-25_03,2024-05-17_01

SGkgQWwsIA0KDQpUaGFua3MgZm9yIHlvdXIgcXVpY2sgcmVwbHkuIA0KDQo+IE9uIEp1bCAyNSwg
MjAyNCwgYXQgMTA6MzTigK9QTSwgQWwgVmlybyA8dmlyb0B6ZW5pdi5saW51eC5vcmcudWs+IHdy
b3RlOg0KPiANCj4gT24gVGh1LCBKdWwgMjUsIDIwMjQgYXQgMDQ6NDc6MDVQTSAtMDcwMCwgU29u
ZyBMaXUgd3JvdGU6DQo+IA0KPj4gK19fYnBmX2tmdW5jIHN0cnVjdCBkZW50cnkgKmJwZl9maWxl
X2RlbnRyeShjb25zdCBzdHJ1Y3QgZmlsZSAqZmlsZSkNCj4+ICt7DQo+PiArIC8qIGZpbGVfZGVu
dHJ5KCkgZG9lcyBub3QgaG9sZCByZWZlcmVuY2UgdG8gdGhlIGRlbnRyeS4gV2UgYWRkIGENCj4+
ICsgKiBkZ2V0KCkgaGVyZSBzbyB0aGF0IHdlIGNhbiBhZGQgS0ZfQUNRVUlSRSBmbGFnIHRvDQo+
PiArICogYnBmX2ZpbGVfZGVudHJ5KCkuDQo+PiArICovDQo+PiArIHJldHVybiBkZ2V0KGZpbGVf
ZGVudHJ5KGZpbGUpKTsNCj4+ICt9DQo+PiArDQo+PiArX19icGZfa2Z1bmMgc3RydWN0IGRlbnRy
eSAqYnBmX2RnZXRfcGFyZW50KHN0cnVjdCBkZW50cnkgKmRlbnRyeSkNCj4+ICt7DQo+PiArIHJl
dHVybiBkZ2V0X3BhcmVudChkZW50cnkpOw0KPj4gK30NCj4+ICsNCj4+ICtfX2JwZl9rZnVuYyB2
b2lkIGJwZl9kcHV0KHN0cnVjdCBkZW50cnkgKmRlbnRyeSkNCj4+ICt7DQo+PiArIHJldHVybiBk
cHV0KGRlbnRyeSk7DQo+PiArfQ0KPiANCj4gSWYgeW91IGtlZXAgYSBmaWxlIHJlZmVyZW5jZSwg
d2h5IGJvdGhlciBncmFiYmluZyBkZW50cnkgb25lPw0KPiBJZiBub3QsIHlvdSBoYXZlIGEgdmVy
eSBiYWQgdHJvdWJsZSBpZiB0aGF0IG9wZW5lZCBmaWxlIGlzIHRoZSBvbmx5DQo+IHRoaW5nIHRo
YXQga2VlcHMgdGhlIGZpbGVzeXN0ZW0gYnVzeS4NCg0KWWVzLCB3ZSBrZWVwIGEgZmlsZSByZWZl
cmVuY2UgZm9yIHRoZSBkdXJhdGlvbiBvZiB0aGUgQlBGIHByb2dyYW0uIA0KVGhlcmVmb3JlLCBp
dCBpcyB0ZWNobmljYWxseSBub3QgbmVjZXNzYXJ5IHRvIGdyYWIgYSBkZW50cnkgb25lLg0KSG93
ZXZlciwgd2UgZ3JhYiBhIGRlbnRyeSByZWZlcmVuY2UgdG8gbWFrZSB0aGUgZGVudHJ5IHBvaW50
ZXIgDQpyZXR1cm5lZCBieSBicGZfZmlsZV9kZW50cnkoKSBhIHRydXN0ZWQgcG9pbnRlciBmcm9t
IEJQRiB2ZXJpZmllcidzIA0KUE9WLCBzbyB0aGF0IHRoZXNlIGtmdW5jcyBhcmUgbW9yZSByb2J1
c3QuIA0KDQpUaGUgZm9sbG93aW5nIGV4cGxhbmF0aW9uIGlzIGEgYml0IGxvbmcuIFBsZWFzZSBs
ZXQgbWUga25vdyBpZiBpdCANCnR1cm5zIG91dCBjb25mdXNpbmcuDQoNCg0KPT09PSBXaGF0IGlz
IHRydXN0ZWQgcG9pbnRlcj8gPT09PQ0KDQpUcnVzdGVkIHBvaW50IGlzIHRoZSBtZWNoYW5pc20g
dG8gbWFrZSBzdXJlIGJwZiBrZnVuY3MgYXJlIA0KY2FsbGVkIHdpdGggdmFsaWQgcG9pbnRlci4g
VGhlIEJQRiB2ZXJpZmllciByZXF1aXJlcyBjZXJ0YWluIEJQRiANCmtmdW5jcyAoaGVscGVycykg
YXJlIGNhbGxlZCB3aXRoIHRydXN0ZWQgcG9pbnRlcnMuIEEgcG9pbnRlciBpcyANCnRydXN0ZWQg
aWYgb25lIG9mIHRoZSBmb2xsb3dpbmcgdHdvIGlzIHRydWU6DQoNCjEuIFRoZSBwb2ludGVyIGlz
IHBhc3NlZCBkaXJlY3RseSBieSB0aGUgdHJhY2Vwb2ludC9rcHJvYmUsIGkuZS4sIA0KICAgbm8g
cG9pbnRlciB3YWxraW5nLCBubyBub24temVybyBvZmZzZXQuIEZvciBleGFtcGxlLCANCg0KICAg
aW50IGJwZl9zZWN1cml0eV9maWxlX29wZW4oc3RydWN0IGZpbGUgKmZpbGUpICAvKiBmaWxlIGlz
IHRydXN0ZWQgKi8NCiAgIHsNCiAgICAgICAvKiBtYXBwaW5nIGlzIG5vdCB0cnVzdGVkICovDQog
ICAgICAgc3RydWN0IGFkZHJlc3Nfc3BhY2UgICAgKm1hcHBpbmcgPSBmaWxlLT5mX21hcHBpbmc7
DQoNCiAgICAgICAvKiBmaWxlMiBpcyBub3QgdHJ1c3RlZCAqLw0KICAgICAgIHN0cnVjdCBmaWxl
ICpmaWxlMiA9IGZpbGUgKyAxOw0KICAgfQ0KDQoyLiBUaGUgcG9pbnRlciBpcyByZXR1cm5lZCBi
eSBhIGtmdW5jIHdpdGggS0ZfQUNRVUlSRS4gVGhpcyBwb2ludGVyIA0KICAgaGFzIHRvIGJlIHJl
bGVhc2VkIGJ5IGEga2Z1bmMgd2l0aCBLRl9SRUxFQVNFLiBLRl9BQ1FVSVJFIGFuZCANCiAgIEtG
X1JFTEVBU0Uga2Z1bmNzIGFyZSBsaWtlIGFueSBfZ2V0KCkgX3B1dCgpIHBhaXJzLiANCg0KDQo9
PT09IGJwZl9kZ2V0X3BhcmVudCBhbmQgYnBmX2RwdXQgPT09PQ0KDQpJbiB0aGlzIGNhc2UsIGJw
Zl9kZ2V0X3BhcmVudCgpIGlzIGEgS0ZfQUNRVUlSRSBrZnVuYyBhbmQgDQpicGZfZHB1dCgpIGlz
IGEgS0ZfUkVMRUFTRSBmdW5jdGlvbi4gVGhleSBhcmUganVzdCBsaWtlIHJlZ3VsYXINCl9nZXQo
KSBfcHV0KCkgZnVuY3Rpb25zLiANCg0KVGhlIEJQRiB2ZXJpZmllciBtYWtlcyBzdXJlIHBvaW50
ZXJzIGFjcXVpcmVkIGJ5IGJwZl9kZ2V0X3BhcmVudCgpIA0KaXMgYWx3YXlzIHJlbGVhc2VkIGJ5
IGJwZl9kcHV0KCkgYmVmb3JlIHRoZSBCUEYgcHJvZ3JhbSByZXR1cm5zLiANCkZvciBleGFtcGxl
LCBpbiB0aGUgZm9sbG93aW5nIEJQRiBwcm9ncmFtOg0KDQp4eHh4KHN0cnVjdCBkZW50cnkgKmQp
DQp7DQogICAgc3RydWN0IGRlbnRyeSAqcGFyZW50ID0gYnBmX2RnZXRfcGFyZW50KGQpOyANCg0K
ICAgIC8qIG1haW4gbG9naWMgKi8NCiAgICAgDQogICAgYnBmX2RwdXQocGFyZW50KTsNCn0NCg0K
SWYgdGhlIGJwZl9kcHV0KCkgY2FsbCBpcyBtaXNzaW5nLCB0aGUgdmVyaWZpZXIgd2lsbCBub3Qg
YWxsb3cNCnRoZSBwcm9ncmFtIHRvIGxvYWQuIA0KDQoNCj09PT0gTW9yZSBvbiBrZnVuYyBzYWZl
dHkgPT09PQ0KDQpUcnVzdGVkIHBvaW50IG1ha2VzIGtmdW5jIGNhbGxzIHNhZmUuIEluIHRoaXMg
Y2FzZSwgd2Ugd2FudCANCmJwZl9nZXRfZGVudHJ5X3hhdHRyKCkgdG8gb25seSB0YWtlIHRydXN0
ZWQgZGVudHJ5IHBvaW50ZXIuIA0KRm9yIGV4YW1wbGUsIGluIHRoZSBzZWN1cml0eV9pbm9kZV9s
aXN0eGF0dHIgTFNNIGhvb2s6DQoNCmJwZl9zZWN1cml0eV9pbm9kZV9saXN0eGF0dHIoc3RydWN0
IGRlbnRyeSAqZGVudHJ5KQ0Kew0KICAgICAgIC8qIFRoaXMgaXMgYWxsb3dlZCwgZGVudHJ5IGlz
IGFuIGlucHV0IGFuZCB0aHVzDQogICAgICAgICogaXMgdHJ1c3RlZCANCiAgICAgICAgKi8NCiAg
ICAgICBicGZfZ2V0X2RlbnRyeV94YXR0cihkZW50cnkpOyANCg0KDQogICAgICAgLyogVGhpcyBp
cyBub3QgYWxsb3dlZCwgYXMgZGVudHJ5LT5kX3BhcmVudCBpcyANCiAgICAgICAgKiBub3QgdHJ1
c3RlZA0KICAgICAgICAqLw0KICAgICAgIGJwZl9nZXRfZGVudHJ5X3hhdHRyKGRlbnRyeS0+ZF9w
YXJlbnQpOw0KDQoNCiAgICAgICAvKiBUaGlzIGlzIGFsbG93ZWQsIGFzIGJwZl9kZ2V0X3BhcmVu
dCgpIGhvbGRzICANCiAgICAgICAgKiBhIHJlZmVyZW5jZSB0byBkX3BhcmVudCwgYW5kIHJldHVy
bnMgYSB0cnVzdGVkDQogICAgICAgICogcG9pbnRlcg0KICAgICAgICAqLw0KICAgICAgIHN0cnVj
dCBkZW50cnkgKnBhcmVudCA9IGJwZl9kZ2V0X3BhcmVudChkZW50cnkpOw0KDQoNCiAgICAgICAv
KiBUaGUgZm9sbG93aW5nIGlzIG5lZWRlZCwgYXMgd2UgbmVlZCB0aGUgcmVsZWFzZSANCiAgICAg
ICAgKiBwYXJlbnQgcG9pbnRlci4gSWYgdGhpcyBsaW5lIGlzIG1pc3NpbmcsIHRoaXMNCiAgICAg
ICAgKiBwcm9ncmFtIGNhbm5vdCBwYXNzIEJQRiB2ZXJpZmllci4gDQogICAgICAgICovDQogICAg
ICAgYnBmX2RwdXQocGFyZW50KTsNCn0NCg0KDQo9PT09IGJwZl9maWxlX2RlbnRyeSA9PT09DQoN
CkluIHRoaXMgdXNlIGNhc2UsIHdlIHdhbnQgdG8gZ2V0IGZyb20gZmlsZSBwb2ludGVyLCBzdWNo
IGFzDQpMU00gaG9vayBzZWN1cml0eV9maWxlX29wZW4oKSB0byB0aGUgZGVudHJ5IGFuZCB0aHVz
IHdhbGsgdGhlDQpkaXJlY3RvcnkgdHJlZS4gSG93ZXZlciwgc2VjdXJpdHlfZmlsZV9vcGVuKCkg
ZG9lcyBub3QgcGFzcw0KaW4gYSBkZW50cnkgcG9pbnRlciwgYW5kIGZpbGUtPmZfcGF0aC5kZW50
cnkgaXMgbm90IGEgdHJ1c3RlZA0KcG9pbnRlci4gVGhlcmUgYXJlIHR3byB3YXlzIHRvIGdldCBh
IHRydXN0ZWQgZGVudHJ5IHBvaW50ZXINCmZyb20gYSBmaWxlIHBvaW50ZXI6DQoNCjEuIEFzIHdo
YXQgd2UgZG8gaGVyZSwgdXNlIGJwZl9maWxlX2RlbnRyeSgpIHRvIGhvbGQgYSANCiAgIHJlZmVy
ZW5jZSBvbiBmaWxlLT5mX3BhdGguZGVudHJ5IGFuZCByZXR1cm4gYSB0cnVzdGVkIA0KICAgcG9p
bnRlci4gDQoyLiBHaXZlIHRoZSB2ZXJpZmllciBzcGVjaWFsIGtub3dsZWRnZSB0aGF0IGlmIGZp
bGUgcG9pbnRlcg0KICAgaXMgdHJ1c3RlZCwgZmlsZS0+Zl9wYXRoLmRlbnRyeSBpcyBhbHNvIHRy
dXN0ZWQuIFRoaXMgDQogICBjYW4gYmUgYWNoaWV2ZSB3aXRoIHRoZSBmb2xsb3dpbmcgbWFjcm9z
Og0KICAgICAgQlRGX1RZUEVfU0FGRV9UUlVTVEVEDQogICAgICBCVEZfVFlQRV9TQUZFX1JDVQ0K
ICAgICAgQlRGX1RZUEVfU0FGRV9SQ1VfT1JfTlVMTC4gDQoNClVzaW5nIHRoZSBzZWNvbmQgbWV0
aG9kIGhlcmUgcmVxdWlyZXMgYSBsaXR0bGUgbW9yZSB3b3JrIGluIHRoZQ0KQlBGIHZlcmlmaWVy
LCBhcyBkZW50cnkgaXMgbm90IGEgc2ltcGxlIHBvaW50ZXIgaW4gc3RydWN0IGZpbGUsIA0KYnV0
IGZfcGF0aC5kZW50cnkuIFRoZXJlZm9yZSwgSSBjaG9zZSBjdXJyZW50IGFwcHJvYWNoIHRoYXQN
CmJwZl9maWxlX2RlbnRyeSgpIGhvbGRzIGEgcmVmZXJlbmNlIG9uIGRlbnRyeSBwb2ludGVyLCBh
bmQgdGhlIA0KcG9pbnRlciBoYXMgdG8gYmUgcmVsZWFzZWQgd2l0aCBicGZfZHB1dCgpLiANCg0K
Rm9yIG1vcmUgZGV0YWlscyBhYm91dCB0cnVzdGVkIHBvaW50ZXJzIGluIGtmdW5jcywgcGxlYXNl
IHJlZmVyIHRvIA0KRG9jdW1lbnRhdGlvbi9icGYva2Z1bmNzLnJzdC4gDQoNCkRvZXMgdGhpcyBh
bnN3ZXIgeW91ciBxdWVzdGlvbj8gDQoNClRoYW5rcywNClNvbmcNCg0KDQo+IEl0J3MgYWxtb3N0
IGNlcnRhaW5seSBhIHdyb25nIGludGVyZmFjZTsgcGxlYXNlLCBleHBsYWluIHdoYXQNCj4gZXhh
Y3RseSBhcmUgeW91IHRyeWluZyB0byBkbyBoZXJlLg0KDQoNCg0KDQoNCg==


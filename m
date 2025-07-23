Return-Path: <linux-fsdevel+bounces-55898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E93DB0FA26
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 20:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 452E61C83054
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 18:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7878B22DF95;
	Wed, 23 Jul 2025 18:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Hvy8/ddL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB8A22D4DE;
	Wed, 23 Jul 2025 18:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753294795; cv=fail; b=rV4xpb+GFZ4YII/nnJciOy37DsYlFC+YMKEyz5SK+CNdMAbQzmGSH9l8WrInbwkZlsAmFkiSJxB0z8QfaxRr8fepTR5rtkbe147ImwIb2GpSrYK5StZR95xqDgdnhn4MQOgSNnLN8ISDk96hd1cGDrBvMZdiAHa4V7tHIoUQQYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753294795; c=relaxed/simple;
	bh=9EcBkMkn2dsM5QS9Awfrp9Sz6z7559deglDKG46abrk=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=sVjWn2+Et6DnIpC9as/6Sqtl157Ftyr5dEeCvLz6Z82G6IFQsJo1yPeNTTou+jQaCoTOmLfq+DzC7iF4fYpN2ERv+tmeBy+NNX15iaWE9E/WwLidFsF70kRl+kgZkfXfN0vAYmAa+duzosjFJQnkKFogiZJ8SavHyQpYi3dPNf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Hvy8/ddL; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NE3V2E022298;
	Wed, 23 Jul 2025 18:19:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=9EcBkMkn2dsM5QS9Awfrp9Sz6z7559deglDKG46abrk=; b=Hvy8/ddL
	TuBCBF55u8wTdHv6RxA3jd1u4Y1Fs1BiSdoTAtVDBUW48iGmmZVWGX9Ak/lI/fPQ
	iBWCIaytCRExTxLRX9FeYfhylwiOyhRIORDAUks7eJLKxMyVMpU13sqzPkbBFrMJ
	htP72SMsT0gdew6b1EA4sMz8fphnMbi+plWGEZZ+ERGiKpLnxshiI53mGbmQp25T
	Z7iKqtySvAGiOUiZU7TkY+KsUD1Y798Qdb4yERJn0cfSO1f9TvAPw2GOb8Bv6ouu
	6A957jIHmikaOvg+N7M10lb9qirlLv+N6PMTSEKwl6iCQCjBL3pxO8k/0Pmu4ITE
	nx9G07Tf4ooWZg==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ffbef6j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 18:19:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h8VsQxaHH5trk4yKnMqvZsC5Hd/Y1uOtSKxEmxP9F+7VM947fYore/cqn3JBhBHhw7hS3z0zBzbnWTLWiHE8nQPsMozOL63NQjAle+DYiifLuJUSlgL8eZxVCwJbUvj+rsKkA22AtOm8AUwGTdN2QlQQGPSgvRRI3XIUiBURmvk1tOG1wjDv25y+i6QnhnkrbgnNm3kB4saUydHZGDIgWw9bwNMT47lw+FC2ljJ+rLVWaGNNkGWqoBUCQiSCYuERVtpa/vo0u8NPO3XEgsxoBNAx8GWPCaPbS6jezOlLFEZYDJLYrdZd8YoBDYISlWZDSOySoLqHixmdy7rPYYmxbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9EcBkMkn2dsM5QS9Awfrp9Sz6z7559deglDKG46abrk=;
 b=StglBipsCx4zHwgPUch/QwNSfYeRSbARq/2eQRGQq5QXTdbfUZr4LDSXyDJhw1plpltPAJLJiae+aHJSBBZz/LunrH7NPVdR1Kv4npZ1ZkHifLJA9tGHYkHjJ7Org9zg/wtkeFl4WDGSuQveR0eZ786RX6t78R8DIugtJi4bGD3/i9FV2QuwT+XlXcCKlNUr9Mzr3JnumISMJEboYMHTg9rwr5NQ+x6tWj4EZgsFvrxQXuwN00NmdqT8cfcwT9SFX/IIUJFYfA/0OBt/8CYaHQwKynIxj23gyEJJ1lpfoe6kRDtEL11tkCvB4hJDO80IyhLy/fMp3WavZnqLVFX66g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH0PR15MB4200.namprd15.prod.outlook.com (2603:10b6:510:21::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 18:19:38 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8880.026; Wed, 23 Jul 2025
 18:19:38 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "penguin-kernel@I-love.SAKURA.ne.jp" <penguin-kernel@I-love.SAKURA.ne.jp>,
        "willy@infradead.org" <willy@infradead.org>
CC: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
Thread-Topic: [EXTERNAL] Re: [PATCH v3] hfs: remove BUG() from
 hfs_release_folio()/hfs_test_inode()/hfs_write_inode()
Thread-Index:
 AQHb91IJ4dXLt/uuZkqRbEGinlBUibQ2uTqAgAAmwgCABfRaAIABJ7GAgAAu4ICAAAmKAIAABPwAgAA/FgCAAHUJgIAAE2cAgAENGoA=
Date: Wed, 23 Jul 2025 18:19:38 +0000
Message-ID: <c99951ae12dc1f5a51b1f6c82bbf7b61b2f12e02.camel@ibm.com>
References: <4c1eb34018cabe33f81b1aa13d5eb0adc44661e7.camel@dubeyko.com>
	 <175a5ded-518a-4002-8650-cffc7f94aec4@I-love.SAKURA.ne.jp>
	 <954d2bfa-f70b-426b-9d3d-f709c6b229c0@I-love.SAKURA.ne.jp>
	 <aHlQkTHYxnZ1wrhF@casper.infradead.org>
	 <5684510c160d08680f4c35b2f70881edc53e83aa.camel@ibm.com>
	 <93338c04-75d4-474e-b2d9-c3ae6057db96@I-love.SAKURA.ne.jp>
	 <b601d17a38a335afbe1398fc7248e4ec878cc1c6.camel@ibm.com>
	 <38d8f48e-47c3-4d67-9caa-498f3b47004f@I-love.SAKURA.ne.jp>
	 <aH-SbYUKE1Ydb-tJ@casper.infradead.org>
	 <8333cf5e-a9cc-4b56-8b06-9b55b95e97db@I-love.SAKURA.ne.jp>
	 <aH-enGSS7zWq0jFf@casper.infradead.org>
	 <9ac7574508df0f96d220cc9c2f51d3192ffff568.camel@ibm.com>
	 <65009dff-dd9d-4c99-aa53-5e87e2777017@I-love.SAKURA.ne.jp>
	 <e00cff7b-3e87-4522-957f-996cb8ed5b41@I-love.SAKURA.ne.jp>
In-Reply-To: <e00cff7b-3e87-4522-957f-996cb8ed5b41@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH0PR15MB4200:EE_
x-ms-office365-filtering-correlation-id: 82148c33-7375-419c-1b82-08ddca157c45
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?K1FTdU9HVHhzeW8zOXoycFBVcnhob0tWU0E5bTdNbWw0SllqQ1BvM2tLRzB4?=
 =?utf-8?B?L1lmV1ZTbTh4d3JQS1VvUzNUM2NXaFJkOFV3NE9jc2xmZzUra0I4RTE4NW4w?=
 =?utf-8?B?ZHF0YnJHbWhGR3hGenJESnlSaEZJQm1Xem1JLzRWeWkzREs5WjRlejZ2TjlR?=
 =?utf-8?B?TlowYS8xc2UyUFVPdDlzcFRlZXB2QmdUR0VtenYwMWdyanhKR3lsS2M3OTk4?=
 =?utf-8?B?UGZpWlp4RjFmTUgyOTdFT0pPMDhDQXNHdDlLc25LL3VoV3NPLzRXS0JvdTIr?=
 =?utf-8?B?cDhjckN1ejRGRzlVSkduaXhjeTVUNFNUMGdaa2Uwc3oxOFFFRis4dE45amlr?=
 =?utf-8?B?cTBUV0U0SFFxUm8yZ0ZtQXd6WENTb0ZYWmN4WDdNN2grMVF6VzIvK2ZQZWVX?=
 =?utf-8?B?em1veGJDYzNhRkxmOGw2bkFQcEk0Y2hQeGxINTRyNkJmc1NtTy8vZkc0eUlk?=
 =?utf-8?B?TjhXWjArOGUzRGlZWWNsdENVRmtCd3ZDRGZmMEVpUjgrQk15K3RtM3JyZlM5?=
 =?utf-8?B?RUhWcnVKTjJHc21oQjQ0c3NHbEtQV1ZIMGw0OUNJVFpBQTM3aDAvdk9OTHBD?=
 =?utf-8?B?M0J2MDNoUmNrbnY1SmZYUlk2ZXJZdERTMlc1OHdEcWZNK2dwbDJIR1Q2NGlH?=
 =?utf-8?B?SUFKMXhNbDhxOE9xSmJKUWN4bkVUMGxtdWMvZlRrb1JtMVF6TmR4ZmtDb1gy?=
 =?utf-8?B?Zjl1VjdvTTlxNVBTeUpIa0RrU3hXdTlpS0ZXcW4zZmRPVEZKL2xhQmJvMXg4?=
 =?utf-8?B?Wmo1clJFY0Y0Ry9QR2xlL1BWRWhITzh6OS9vU0xOVmxpcUJJc21YdHFRSitE?=
 =?utf-8?B?ZFdWSWcxWVNTOUxVTksrZURmRWZCSk1hN0pXeTlaSHMxNVdNY0xSeUxNQkxo?=
 =?utf-8?B?TUNYRDlwVjluQUkxazA3VkFLVk5VU2RRYVU1am55OXBOMW5uQXU4U0RjbVhO?=
 =?utf-8?B?UjEwNWNrREpaeTJKcFJxVDllZysvZXZKZ1g5RFRlMkZXRUdodU5Jd2FDUzY2?=
 =?utf-8?B?RzNscUlSUG9UY1B2cmE2OHF1SngvU0ZyRXZpamRPcmRQQTlSeUx6Z1NSci9M?=
 =?utf-8?B?eFlVZjd2bnZ1dzNmVlJuOG9MT1RPcVNkSmpNK2R4eGlWNnVrbUVvTk0xRURU?=
 =?utf-8?B?WUFvMHJ4UWxkZE5qVmdqRGtIRWhBK3F0OWhEdXR5djk1S1JqNmJuNU56ZGxa?=
 =?utf-8?B?TXVnR0hmTm1sQmY5bWpicnprMWFPTGtpVDFwaVRpZTN1UFhZU1RxS20vZXJJ?=
 =?utf-8?B?cFpJcnF0bUVxa3ZFdVNTZlZxOCtXSkE2OGFrdjhUelZTdnZFdjlzTWlDL0VD?=
 =?utf-8?B?QTJ0RjRsRUh6TVJlRlhoeG9lKzlvVkZ5am1tSUo4SStEKyt2amJhTkpOK0hw?=
 =?utf-8?B?RU5ob1l1emU0WjlQS3pVb20vaXpUd0JsbVdsUnF4UzY4ZXJoNlp2Zjh5NUZp?=
 =?utf-8?B?K2Q2bTlMREVPYjUyK1JsNWNnTDNQa0Q0RkUxQy9tSFJ3SnRqYjFMV0tjRU5T?=
 =?utf-8?B?YTcrZHRoN2VnZlNjeXFzLzk1N2Q2WXhzOWxrTFhPS3o3RkQ2ZU1hWUFzSlRr?=
 =?utf-8?B?QUNRSHVDeWgxdHZqdWFkcUFuU3EwenFsQms2Q3hRWXk0R2ZSb2V5Wkx6MFB5?=
 =?utf-8?B?NDQ5SnpVOVZyZGpEV1pnSmZzN0NOQ2Z5QkMxRjYySi9RU3JURFBBd1BHSWlD?=
 =?utf-8?B?Z3BCeGx5eXM0Z1F2YytFU0dsK0drRllmYjFvcTBaQzlPQzV5VkVZRVNpT1Bz?=
 =?utf-8?B?dVhMZ0tCUmJFMERSbXJIMFcvTXoveGNiU0dGVkZicGdUbG9BWXNaMkVmR1VU?=
 =?utf-8?B?eU1Od0xUeHB6UzVCcWM2cjNrZ2haTC9QYTFjVk5FRUY2UlRXRFhrUDc4Q1g5?=
 =?utf-8?B?NVhVUWd3RHAzQjh6eVNwdlNFK2hVOENZcEY3c08yQjdzcWpMNWpLdmFkK0li?=
 =?utf-8?Q?8CO7S7C87Yo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RnNZS0dGZUxGS2ZjNFVieFg2MXN2RkppRGx3QmpuRUg4NU1hS2FFZlhEQnRJ?=
 =?utf-8?B?bmo1RElkQktQVEtOZmVoYWJpdWxtSXJPM1NxdFRxb3MyUStMZlhiamliNjhV?=
 =?utf-8?B?NlkvTklicktXVUdiNEt0Uk5TdXNIM1VjbjVvcGVDZUhHZHJrdlNXVzVLbk5V?=
 =?utf-8?B?TW5qVzVEOWVaOTN3blVSZFcrZ2greHFINXcyMGRHdmdrU3dTc3oybUhzazF6?=
 =?utf-8?B?bk95ZWJRL2lPaUF6QmQxN0pVaU8yTmdSelFLdnJsWEJNRjU3YUN2d25iNUdu?=
 =?utf-8?B?WTl1bFNlb1hHNjR6QjVHaW1ub0F3a0crTWRmNlJiY1lodlF5RGFrOXA0V3RM?=
 =?utf-8?B?V1Y3V2ZkNTdTNWF4UEZRc0dIZzkzbzdqRVlGaVNXakJTWE96dkxIWThHamRl?=
 =?utf-8?B?VGhXOEd0dTZpWVFzcjl0OFpFU1oybjk0eURvV1J5c3lEZ0lJUXp2bzhiTE16?=
 =?utf-8?B?cmp6T0VDcXJHdUh5UTN6aEtsRDZqZ1EvSjNRdlBCUmIrL2hSQXphcldWbVA1?=
 =?utf-8?B?VnA0VGN0a3F4aXpobEpJOTBZLzkySXVkbHYxWW5ZZ29NaUJ3UDkxL2pWZmZG?=
 =?utf-8?B?WkVnTVZOM2NnR1c2ZWI3UWQwQ0pqUmNTdlRTUE9MdDFxdklWL0VYNDVwUW4x?=
 =?utf-8?B?c3dubVZ6RE9uTUpXQmNGQVhtNmJVQi9pYjA3bkhmQVAzNDRpUzdRSzNxREZK?=
 =?utf-8?B?a0xjN0pxN1pQTm9wekRqWkptQWdNOHpCcTlyN3dxUzBrREpvTE82RkpaMzV2?=
 =?utf-8?B?eVdCandMRXhQaWhxQUUwZSttM2tPK0tmQUJNRVo3cGJSRzBVMEZFQXRad0ZX?=
 =?utf-8?B?WnR6c2d3dUNiN3JJelhid1M1dnVRaXhkY2xsZGh6T2Y3Y1B0WTBacThZWXpj?=
 =?utf-8?B?YjJTZjg0ZjRiQmQweVNUVm5Ob0QvdXJPRzFTK2Z3Z3UwRkVSMTlZMnJRRkZB?=
 =?utf-8?B?aEZVbDJxeTExbmtlaEQvOHpuUmxvUENWamJRU2R6WWdvS2J4OGZhWEFKWmh1?=
 =?utf-8?B?NFFYSzRLL0VVV3F5M1VDMURucTA2cXh3TjlJOExicXdxZTcwaEovYjlvd1M2?=
 =?utf-8?B?R0hLbVh6RGVFVHJSZnFGNnY2UXZUZ1g3Uk1vZTVKOGF4TGo5c04vWkQrS1dG?=
 =?utf-8?B?bWN2ZU1LM1JJalRHTXlkMnBHRmQ0Nis4cVR0d0trNXpTMkN5eUowRzladjdJ?=
 =?utf-8?B?dWZyOWRVVzlub2RmSkJwSWFZVVNRZThGWS9ZTTU1dWhkdTJLMkQvT3ppOHJa?=
 =?utf-8?B?VDNEalkvT2V0UzR2dVBKOGt6eklaVUttTWFHaUl5VmNGTlhXVHIzNkYzREhq?=
 =?utf-8?B?RlFvQkJPY1Z6eHpRUU1zdE1HTUUyS2FBSHpEdTIrOEZ2Ni8yZGRyck92WkNM?=
 =?utf-8?B?YjZPWkc2VzhuZ252Z0RxKzhjS3ZHeXJhZXk2WHRIcjU4NnFGNGRkR1lPekZK?=
 =?utf-8?B?bDF0RHEzRGo4ZEtRc2V3Ulc5Rm5pc09LNWthS0ZoSmxJOWw2QjB4a3hpd3Vv?=
 =?utf-8?B?TStLYWxSWTY5L2Y0aFpFTDgvaWV1M2x5eVl1SnRSSnA0V0FVbFJML3VPQ2tk?=
 =?utf-8?B?NG8xZTI3eVdQN1RLWkdBOEd1QWNXTUVWRmNmbndqUE5aOXRGTkdpZnZPRysz?=
 =?utf-8?B?cnljR0IrRkdJYXMwbTlsdjVFaTNFYzFZTU4wMXBtTldOd2I1ZTA5VmhwQ1RD?=
 =?utf-8?B?S0RwK3I1QUtHWlpkYlRBVEUwblNvbGZocHBDSlFiOWVoZEFpalpxZFhmMEtV?=
 =?utf-8?B?cGVxZTFSZUtTVnVXOGU3ZnRuaGl2Q1lGU3ZEV1VRZzd5K2Eyc3V3YThGTFpV?=
 =?utf-8?B?OSt1MjBLc29PR1UvbVJmcDlGVUxGS2daVm42c2xud3FzUHMrU2VscEE5UURp?=
 =?utf-8?B?NnpSK3VTaHNtZzJwZFIrWDJUYUc1eE1ldk5qWFhyTmNkdUFER1RnZlM2UnFR?=
 =?utf-8?B?MGNvZis5MzBSN2w0OWdWSy9Pc3lZVERpQlByaG4yaSsyakxPTmxzRXJZalpk?=
 =?utf-8?B?WDh3bG1YZjdKZGRtVWRBK2M5MVM5WWRMVGZCY2pUNm1WWFlmQSsyMHJPbUlI?=
 =?utf-8?B?YkVZd0ZKYjNBSEs4a2hnZGo5SFc5TGdoMW5rNDZFeHF0TnlPZ3FISUxqWUw4?=
 =?utf-8?B?TEZZRXVhbDNKc2hqbG1wQ0Y0OTFZeGdIajJCYzJZNUhuY0NkRmhWR2p1b0g2?=
 =?utf-8?Q?JwR6Fn7Np0IHHz+O9PeRoXI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <36498F3B9552294A8EDAED45DE939AC5@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 82148c33-7375-419c-1b82-08ddca157c45
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2025 18:19:38.4334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TBBC14sSh3u291tFH0U2dm710S8p4OgvOzd3MeUMBHRMBOD5ietnlT7qoonKEjX6UoVnnwCPiE9Xqv2vfW1Mdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4200
X-Proofpoint-ORIG-GUID: Y6Y5Ww9a63yMH08kkFSH9WkMCqCZS9-I
X-Authority-Analysis: v=2.4 cv=De8XqutW c=1 sm=1 tr=0 ts=688127bd cx=c_pps
 a=k8WdsgGmLKCkffjC5Q7UFQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=P-IC7800AAAA:8
 a=h1hZwkKw8eX9D7OlF_oA:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: Y6Y5Ww9a63yMH08kkFSH9WkMCqCZS9-I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE1NiBTYWx0ZWRfX2a4uSvlhhT+2
 FcQg1cfRk+LG1/CwhrZ1F09HWG6c8HYaqNSecw982p68zFPqWL2T5X/kzDDgzbvnDfxE0CJtHGe
 MpU1JptKiLaYpZKk20w98KhUbTlvBWPE8SoPTAZXZUkq8SZh4aZHiCn78MSY7Vt9vrvm3piwAOI
 Vm3Fr7HXpE4IarVuP+c0NLOwxjXv6z3chKTVBJLybcE6hnugRGS3/VsugUa2WRWAe+KptmV1aDF
 JBdo7PvHjC2tUTSn6mdp0fdL0TjOjYqmfXl7XwCpvGPrFRdwDfWyvhJQO3KIFd/kT8AEl/8wTf6
 amkvkIFn/rjlOXaGqN3UOx/Hv7KeNv9XHdrsfWnsaP4AgluzshX40jcL95OBcdOdJ/weRpudEOQ
 VDJ5pycMCoManK/8tv6xNl1gjfQt8Vfj10pkjIepiS7+svTWP1mObOSCkRkJjtrydX6PjIYt
Subject: RE: [PATCH v3] hfs: remove BUG() from
 hfs_release_folio()/hfs_test_inode()/hfs_write_inode()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230156

T24gV2VkLCAyMDI1LTA3LTIzIGF0IDExOjE2ICswOTAwLCBUZXRzdW8gSGFuZGEgd3JvdGU6DQo+
IFdpdGggYmVsb3cgY2hhbmdlLCBsZWdpdGltYXRlIEhGUyBmaWxlc3lzdGVtIGltYWdlcyBjYW4g
YmUgbW91bnRlZC4NCj4gDQo+IEJ1dCBpcyBjcmFmdGVkIEhGUyBmaWxlc3lzdGVtIGltYWdlcyBj
YW4gbm90IGJlIG1vdW50ZWQgZXhwZWN0ZWQgcmVzdWx0Pw0KPiANCj4gICAjIGxvc2V0dXAgLWEN
Cj4gICAvZGV2L2xvb3AwOiBbMDAwMV06NzE4NSAoL21lbWZkOnN5emthbGxlciAoZGVsZXRlZCkp
DQo+ICAgIyBtb3VudCAtdCBoZnMgL2Rldi9sb29wMCAvbW50Lw0KPiAgIG1vdW50OiAvbW50OiBm
aWxlc3lzdGVtIHdhcyBtb3VudGVkLCBidXQgYW55IHN1YnNlcXVlbnQgb3BlcmF0aW9uIGZhaWxl
ZDogT3BlcmF0aW9uIG5vdCBwZXJtaXR0ZWQuDQo+ICAgIyBmc2NrLmhmcyAvZGV2L2xvb3AwDQo+
ICAgKiogL2Rldi9sb29wMA0KPiAgICAgIEV4ZWN1dGluZyBmc2NrX2hmcyAodmVyc2lvbiA1NDAu
MS1MaW51eCkuDQo+ICAgKiogQ2hlY2tpbmcgSEZTIHZvbHVtZS4NCj4gICAgICBJbnZhbGlkIGV4
dGVudCBlbnRyeQ0KPiAgICgzLCAwKQ0KPiAgICoqIFRoZSB2b2x1bWUgICBjb3VsZCBub3QgYmUg
dmVyaWZpZWQgY29tcGxldGVseS4NCj4gICAjIG1vdW50IC10IGhmcyAvZGV2L2xvb3AwIC9tbnQv
DQo+ICAgbW91bnQ6IC9tbnQ6IGZpbGVzeXN0ZW0gd2FzIG1vdW50ZWQsIGJ1dCBhbnkgc3Vic2Vx
dWVudCBvcGVyYXRpb24gZmFpbGVkOiBPcGVyYXRpb24gbm90IHBlcm1pdHRlZC4NCj4gDQo+IEFs
c28sIGFyZSBJRHMgd2hpY2ggc2hvdWxkIGJlIGV4Y2x1ZGVkIGZyb20gbWFrZV9iYWRfaW5vZGUo
KSBjb25kaXRpb25zDQo+IHNhbWUgZm9yIEhGU19DRFJfRklMIGFuZCBIRlNfQ0RSX0RJUiA/DQo+
IA0KPiANCj4gLS0tIGEvZnMvaGZzL2lub2RlLmMNCj4gKysrIGIvZnMvaGZzL2lub2RlLmMNCj4g
QEAgLTM1OCw2ICszNTgsOCBAQCBzdGF0aWMgaW50IGhmc19yZWFkX2lub2RlKHN0cnVjdCBpbm9k
ZSAqaW5vZGUsIHZvaWQgKmRhdGEpDQo+ICAgICAgICAgICAgICAgICBpbm9kZS0+aV9vcCA9ICZo
ZnNfZmlsZV9pbm9kZV9vcGVyYXRpb25zOw0KPiAgICAgICAgICAgICAgICAgaW5vZGUtPmlfZm9w
ID0gJmhmc19maWxlX29wZXJhdGlvbnM7DQo+ICAgICAgICAgICAgICAgICBpbm9kZS0+aV9tYXBw
aW5nLT5hX29wcyA9ICZoZnNfYW9wczsNCj4gKyAgICAgICAgICAgICAgIGlmIChpbm9kZS0+aV9p
bm8gPCBIRlNfRklSU1RVU0VSX0NOSUQpDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGdvdG8g
Y2hlY2tfcmVzZXJ2ZWRfaW5vOw0KPiAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ICAgICAgICAg
Y2FzZSBIRlNfQ0RSX0RJUjoNCj4gICAgICAgICAgICAgICAgIGlub2RlLT5pX2lubyA9IGJlMzJf
dG9fY3B1KHJlYy0+ZGlyLkRpcklEKTsNCj4gQEAgLTM2OCw2ICszNzAsMjQgQEAgc3RhdGljIGlu
dCBoZnNfcmVhZF9pbm9kZShzdHJ1Y3QgaW5vZGUgKmlub2RlLCB2b2lkICpkYXRhKQ0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlub2RlX3NldF9hdGltZV90b190cyhp
bm9kZSwgaW5vZGVfc2V0X2N0aW1lX3RvX3RzKGlub2RlLCBoZnNfbV90b191dGltZShyZWMtPmRp
ci5NZERhdCkpKSk7DQo+ICAgICAgICAgICAgICAgICBpbm9kZS0+aV9vcCA9ICZoZnNfZGlyX2lu
b2RlX29wZXJhdGlvbnM7DQo+ICAgICAgICAgICAgICAgICBpbm9kZS0+aV9mb3AgPSAmaGZzX2Rp
cl9vcGVyYXRpb25zOw0KPiArICAgICAgICAgICAgICAgaWYgKGlub2RlLT5pX2lubyA8IEhGU19G
SVJTVFVTRVJfQ05JRCkNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgZ290byBjaGVja19yZXNl
cnZlZF9pbm87DQo+ICsgICAgICAgICAgICAgICBicmVhazsNCj4gKyAgICAgICBkZWZhdWx0Og0K
PiArICAgICAgICAgICAgICAgbWFrZV9iYWRfaW5vZGUoaW5vZGUpOw0KPiArICAgICAgIH0NCj4g
KyAgICAgICByZXR1cm4gMDsNCj4gK2NoZWNrX3Jlc2VydmVkX2lubzoNCj4gKyAgICAgICBzd2l0
Y2ggKGlub2RlLT5pX2lubykgew0KPiArICAgICAgIGNhc2UgSEZTX1BPUl9DTklEOg0KPiArICAg
ICAgIGNhc2UgSEZTX1JPT1RfQ05JRDoNCj4gKyAgICAgICBjYXNlIEhGU19FWFRfQ05JRDoNCj4g
KyAgICAgICBjYXNlIEhGU19DQVRfQ05JRDoNCj4gKyAgICAgICBjYXNlIEhGU19CQURfQ05JRDoN
Cj4gKyAgICAgICBjYXNlIEhGU19BTExPQ19DTklEOg0KPiArICAgICAgIGNhc2UgSEZTX1NUQVJU
X0NOSUQ6DQo+ICsgICAgICAgY2FzZSBIRlNfQVRUUl9DTklEOg0KPiArICAgICAgIGNhc2UgSEZT
X0VYQ0hfQ05JRDoNCj4gICAgICAgICAgICAgICAgIGJyZWFrOw0KPiAgICAgICAgIGRlZmF1bHQ6
DQo+ICAgICAgICAgICAgICAgICBtYWtlX2JhZF9pbm9kZShpbm9kZSk7DQoNCkkgaGF2ZSBtaXNz
ZWQgdGhhdCB0aGlzIGxpc3QgY29udGFpbnMgWzFdOg0KDQojZGVmaW5lIEhGU19QT1JfQ05JRAkJ
MQkvKiBQYXJlbnQgT2YgdGhlIFJvb3QgKi8NCiNkZWZpbmUgSEZTX1JPT1RfQ05JRAkJMgkvKiBS
T09UIGRpcmVjdG9yeSAqLw0KDQpPZiBjb3Vyc2UsIGhmc19yZWFkX2lub2RlKCkgY2FuIGJlIGNh
bGxlZCBmb3IgdGhlIHJvb3QgZGlyZWN0b3J5IGFuZCBwYXJlbnQgb2YNCnRoZSByb290IGNhc2Vz
LiBTbywgSEZTX1BPUl9DTklEIGFuZCBIRlNfUk9PVF9DTklEIGFyZSBsZWdpdGltYXRlIHZhbHVl
cy4NCkhvd2V2ZXIsIHRoZSBvdGhlciBjb25zdGFudHMgY2Fubm90IGJlIHVzZWQgYmVjYXVzZSB0
aGV5IHNob3VsZCBiZSBkZXNjcmliZWQgaW4NCnN1cGVyYmxvY2sgKE1EQikgYW5kIENhdGFsb2cg
RmlsZSBjYW5ub3QgaGF2ZSB0aGUgcmVjb3JkcyBmb3IgdGhlbS4NCg0KVGhhbmtzLA0KU2xhdmEu
DQoNClsxXSBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92Ni4xNi1yYzcvc291cmNl
L2ZzL2hmcy9oZnMuaCNMNDENCg==


Return-Path: <linux-fsdevel+bounces-54035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 414D6AFA834
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 00:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71EA6189B605
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jul 2025 22:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7293C288C1B;
	Sun,  6 Jul 2025 22:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="W8YRF5ew"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9FE846F;
	Sun,  6 Jul 2025 22:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751840996; cv=fail; b=SbD8euABZPNHM9toWgO8e8EwKPdq/VadWNlBcR4qq7klFJejwddO1296VMqqZOvKu6Q91OOq/ZqrneZNF5NcBgQAfMLXm3fjFyA0+1v6HEzmfLUBFNMSlpdGq8OMoIjemJRjAzgmiwwmI+ddH46O4MWv6tDkz669j5EMMBfk1MM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751840996; c=relaxed/simple;
	bh=pfERhGss6EDg1RYvgRw88MhQGTjvOTvi81OP30M6I7M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ms/+IDowBYEavGUJ9WYan91o+ilCfeknb6oFDKbNKXNC03dJ8AUVcUFXsjPJvIuMjHFg1J7GCdcGhf3K/at9GRXJVqt+Y7MvNsktrLbcfLBFKmvefuwKr00CoLlzpJwmPz6+Lm/d6kcTABOtZ0+pFB1PUuzfWLRrB0zyWao9Hg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=W8YRF5ew; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 566JP2kh002839;
	Sun, 6 Jul 2025 15:29:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2025-q2; bh=pfERhGss6EDg1RYvgRw88MhQGTjvOTvi81OP30M6I7M=; b=
	W8YRF5ewlgU42upMf0ejqbowadGy7JpJj+/XBPklRAWBjHuCGa2628mOcFK2cD34
	iPhCvpmV7Q3ctbQxNMRdBf+PDguAFnelwCWIv4Z7qZQSiNzI9R1xJF/mZH2N/EP7
	KnqktTEs3b4r8NcWeEQYsYrx9bPOt1E592bCajcc9Igt0+45ITKlLPVtXQyg1nvo
	hlYLLt2DEM1gefTKq7g1aFw5dhyINg3HUZZVFMhOXwYBFP0fpcsRiLmx+JVbFy0p
	hnvytQkml7XJf+PdjCdjFnFKZou+V9K47jAq0/yzk8/qqrs10BM4YHi3T5XgwBf4
	QLHHP+BpXbxJdr9wUTpg8w==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47qrtvss6h-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 06 Jul 2025 15:29:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XlYLuQ3G7tcCl/PLQPSe7hIUU3S60A21NExOyTTF5SJlfl6D1OBbJduL/oXMpG0f+4PEsjAqE0qjHtg5yam9HGbARhf9B8UIgmlBWldFWf0RftnUfJSxqK7is4D5otuvrV9YwgWNyrzmgGFieDXIWVUy/6lWdc2l4AuQd/ME1q5FMgxTA+DqsBhYT50pKALn0ep6Doj09y4lXdFpwDRJWGTcQKtGlIcjZNEZVdmNBzZ41aL83adHQ9DXgIQcuYryAk3HF9hCEv2uR66M5uvjcGdSEOiczZ2DYbTj8UaKNZofntY5MLxNSwAiQ26DM/c0y+4xd+EfHCk1g0zEY6moRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pfERhGss6EDg1RYvgRw88MhQGTjvOTvi81OP30M6I7M=;
 b=nA+HEbKWYPO2kYKDZfjTnxL/RJKYBAOKuT8WFRIjukgV3dGrv3qUr69mnPJlCXwgTx0Ua3JM8Q30GFpW3dLfIR53GT5+FdyI8e98v8N2MOOFz1pTJ+uCGLNKbdzKr5Ivqab9KL+s3D0DHWHH5kHay817TdKLnT1+kJex/Ghr4Pyu6A09VIjhsXbqH0VA5dct0hHsg8QpupqZ+auI7fXe6mRe6weyDuWU8BDwtw0b6LepjlAFOx5dU47/R3OTl6vk3cw9ijVeoy7vN1YQtN5bQNKPXTTrT0GjyIfO1mJcvNGKVU4zXs9DcycTleowsysPf7gkDUhBJZRMPW6ycapU4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by IA1PR15MB6054.namprd15.prod.outlook.com (2603:10b6:208:44a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Sun, 6 Jul
 2025 22:29:49 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%7]) with mapi id 15.20.8901.024; Sun, 6 Jul 2025
 22:29:49 +0000
From: Song Liu <songliubraving@meta.com>
To: =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
CC: Song Liu <song@kernel.org>, "brauner@kernel.org" <brauner@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "eddyz87@gmail.com"
	<eddyz87@gmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "martin.lau@linux.dev"
	<martin.lau@linux.dev>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jack@suse.cz" <jack@suse.cz>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "mattbobrowski@google.com" <mattbobrowski@google.com>,
        "m@maowtm.org"
	<m@maowtm.org>, "neil@brown.name" <neil@brown.name>,
        =?utf-8?B?R8O8bnRoZXIgTm9hY2s=?= <gnoack@google.com>,
        Jann Horn
	<jannh@google.com>
Subject: Re: [PATCH v5 bpf-next 2/5] landlock: Use path_walk_parent()
Thread-Topic: [PATCH v5 bpf-next 2/5] landlock: Use path_walk_parent()
Thread-Index: AQHb306vhFvWAuyNskacGFvhkKgz3rQg0kIAgABCRgCAALESgIAEBrSA
Date: Sun, 6 Jul 2025 22:29:49 +0000
Message-ID: <6CA51695-CB6C-42D5-80A7-8CF0E84D8F4D@meta.com>
References: <20250617061116.3681325-1-song@kernel.org>
 <20250617061116.3681325-3-song@kernel.org>
 <20250703.ogh0eis8Ahxu@digikod.net>
 <C62BF1A0-8A3C-4B58-8CC8-5BD1A17B1BDB@meta.com>
 <20250704.quio1ceil4Xi@digikod.net>
In-Reply-To: <20250704.quio1ceil4Xi@digikod.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.600.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|IA1PR15MB6054:EE_
x-ms-office365-filtering-correlation-id: 31b5d2fb-fb32-4a7f-45c1-08ddbcdc9e91
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UTkvSkVIUlFrVDRLekUvTFFKdHlBU1EzdG1ob25zd3o4czd4T2V4US9wRzZ4?=
 =?utf-8?B?cngyV2ZOYjcyMXBvUkI5WWwxWnV6ZGpFRTRkcEdaUnN4NkJ0N0ZWWFZhQlNC?=
 =?utf-8?B?N1p5eVY5Q1I2MnNNaWs1VmZCeTZrZkg1Sm1lQzdiQ2JqVXBXSWVzb0xVQzlC?=
 =?utf-8?B?Z2JnR0NKZ09RVEtVQWVrQ2RNc1RlKzczaVlDcW5CN0d3RGFMRGVwQ3dKZnE4?=
 =?utf-8?B?K1RVR3VaamtBclJvcFdqU25wNlBQV0RlaVBLUEc1UG42bUw3dkVWQ2toWUE1?=
 =?utf-8?B?bUFvemgxL0pqUlVxMElXNnkzeEdORldpUkRBNFNmdVhpL2VsOWtoTlg4SkpU?=
 =?utf-8?B?UWJyelNvdVdZTngrSDJ6U1pUNjlFZ1hNeXpWS0xIRzBmNnl5V2NsejVWdnJR?=
 =?utf-8?B?NHErMEFNdEVOdlcxbnhZb1lRaDlCSktOcjZJNzZUeGVPZHZLSTIwWFdRZ0cv?=
 =?utf-8?B?ZmNtLzFmMXQ3Z2dtZVZaOVQycmk5MzBpN1RGSk91M1BlTTBZN0RTYjBpRGYx?=
 =?utf-8?B?Nm1peTBmQTZOQm1ZZ1VnUkdpNEpWT1lxZGpEVDcxWWZYbit3U3FGa3p5b2xY?=
 =?utf-8?B?MzErY0YzYjE2cXVTN0VtS1UwYTJDVFFhNUpLR2V1SUZCaDZ1VkdMNHpNdjJR?=
 =?utf-8?B?bkNiVnVOVmtVdlIxem1Ka0h6bnR6c0JpQ2FzeE90b0VRNlFsalNUeXNyN1p3?=
 =?utf-8?B?VlpjcTBZbHZRekdCRWxiYmkzZ214WVhzT2g0UzFwb1kwSGJMT245aG9vcXBh?=
 =?utf-8?B?WGc3SzdDVnBVaU9LcmJMOCtZT2JiUWY5SndmVUNIckpWeTZORnVZZWgwYk44?=
 =?utf-8?B?dk9ITVB4Y0ZMRTlWMGlQcU9NMVBiZmZPV2JjK1lYRjNVblNSRWJDMjJFL2Jr?=
 =?utf-8?B?Z0xQOXFuaDZWZWlrK0IrYUNVakd5QWhEUlNubVJwRnF3U1V0WjVwL1RKK3Rr?=
 =?utf-8?B?QmhCdmlCeFpsZ05BL1BpTDA0bVd3L09aR2lPVUE4bm9uSDZ0WUR3bW9RbWFo?=
 =?utf-8?B?R2J0MVl6ZHZ4TnMzajBocTFSYmFwd21FTHl5aGhGamd3RFp4ZnB0TjlEdDNQ?=
 =?utf-8?B?VUgvdkhETk9kMzI1aU03VVBGOG1FK3Y1QjVkdFpvejBSZ291TzZxdUJDenVq?=
 =?utf-8?B?b0tycEQraENTenJxZXZTK3RHVnloUDB2cHlBVzRUOG9oT1B5V0NsZjZrR05R?=
 =?utf-8?B?UDNqVEZOZ3BEYS81TFRveHdLdSs4WlZIUXJLYlRjWmJEQ1YxSWVYazdyaTJW?=
 =?utf-8?B?TFo3cHlrZjhWYkptTXhlNXJJMFY5WU9PeDAwWE5TRXNJUjIwdnNlTldaMDNj?=
 =?utf-8?B?c2FHSVUzUjg5ODV1czVLbWdhV1pKVU5FVFY3QXpYaHBFSkJWMjIyM0FPUXJr?=
 =?utf-8?B?UjZQQmdkWEVjMUwrNWpoQ0ovL2d6elRSSmVUWUR6bUFmSndOL1JycTFPL2U5?=
 =?utf-8?B?YmNmZFMrSDd5Ri9WLzFJbUZpcG52cVRXV1UwS1ZQNU1aVTU3VGZjZTJXZDl0?=
 =?utf-8?B?YzQxSmxsRXNzWCt1VlhPcXBwakpXNndTdXhmanFVZGFYY0VFTXZDN0RlSmND?=
 =?utf-8?B?b1YvTER5R0N6UktQeFBOdDN0dzFpUjM5Z21vVlZxOGwrWVZ6Rks3N00vMExR?=
 =?utf-8?B?TDFidGFPaXhmMmdEVWFFOHY0cjZ1c2FxZ1ZFRVUvZE1xODJHaEtyRzhTcFNP?=
 =?utf-8?B?SWNzMHJHaldNUlh2ZmV5NlNlZlMzVjVVeFZ0Q0FZVGRKZXJRUTRLT2lTVy92?=
 =?utf-8?B?WVVpMEtOYktQYThIYXVQQzJLMFpWYkFDWUFYK3pPM1puQVlVWUs0MnhTa3BZ?=
 =?utf-8?B?QWV0SVg1MzhmOVBiRFdLL29hNzJ4bkoreVhwTHpZcU1BbDcvN2xHOWtLbzZD?=
 =?utf-8?B?eTRTUVN6VmdmRnM5TXRUdU5JZExlTjk3L25GUnNGbW4zWForaFlUc0Jsb1Qx?=
 =?utf-8?B?Mit0QUFlZ29qempMWk5DNzg3L1h0TnlpSGJCeUZMY2RvZUFaOWo3RHgrZlFk?=
 =?utf-8?Q?ToR4PkoCfmcw/+g0jOspl80IB+KXbU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b1FLSHlOeUNIcnNXak1CSitnSUVOU3VaOHF1RWJIQmd1SlFvSHZxQmhqN2Rl?=
 =?utf-8?B?NkRIdkF2eGdGUHd6VzRqclFGc1FYeWtZWHc1Y3BBaUNJUzNmMVRFcnBlZnpZ?=
 =?utf-8?B?Y0txZ1ViMEdvOURwdmhsZk55YTlJT01PVVBpWlhyanFKTXh0eUp2Snl4Snc2?=
 =?utf-8?B?TFNPTi84T3RUOUg4Yi9BTGI4Mmx5cXFLbXZtZmE0OXVDTEFWWnNKSEdiOG5J?=
 =?utf-8?B?VzFiT2xweWpPNU9weHVwb2orazhVc21mRVNQT3h3SFlIK2FqYnRSRVNzdGJj?=
 =?utf-8?B?cFp6ZjgySnhIUlBKT3IyNXV2aWNqZkhNaDZ2TzJrdU9qVmd3UXdZdDg2UjN4?=
 =?utf-8?B?dWcrd3VKb1F1K2dxMVBJdDVLVEF6WEFzandZdFpMY2FqZkdtOUh0V21jaXgz?=
 =?utf-8?B?dEFGNkZCMy9UZVNwZEhSU3dsYmhEbVMrckFuZkxNNmVDdXNXOGVsM2tKNTFo?=
 =?utf-8?B?Y1M2OUhOanRFbkdaOW1NT040b2trZ1VZMTJabmQ0bjdZUTJkZVkyWTR4R1du?=
 =?utf-8?B?cGp0YTNtdXRVVnVEVFhDYzM3SGlqS3kvUWFMZG5HTFd2d0lKSUJMWmM3c2w1?=
 =?utf-8?B?Ynhyai9jL1AzaW5PeGNCUmN3dzNORmhLVDEvbWpXMjlYUzJlRGhXM0tYWlFh?=
 =?utf-8?B?MEw3T0dmdDI3TEYrRG8ybmlSaU9ZL1VETGI0dUpiT29GeWhEV0Nad1JId3pt?=
 =?utf-8?B?QnMvdkxueW4yVllmN0pQZCtLUVdYTE5oWUJPa0I4bDRwVTJMMEorM0k4ZW44?=
 =?utf-8?B?YTdXZGFHZ1RyUWpRM21DYkVoQmx0ekRQdTR1bFFkcGhGcDR4UWZPZm50MWZP?=
 =?utf-8?B?TlVwcC9pVlo0VnVkRDI1WHl6UDlMb0kwbXZ2a3BEaFpUT0RkUHhXeHBneGxR?=
 =?utf-8?B?eFVDanVxREVBWHlERDBaMUNPMS92UzhRTmM5VVJRSzk1U0duM3Rib2lraWZV?=
 =?utf-8?B?aGN4RHJCQlhydDNjRFVhUWp5WloyMEtvc3BHV3N1TDR5bS9oNXJEem5lZ1dK?=
 =?utf-8?B?MFlRd1FtSjdHeXNoRGJVdEtpZ1V3KytiTXl1UkFGYWUvWFNWY1FaaU1FUWhO?=
 =?utf-8?B?dTBBc1dja0dzOFJUa0xLR2dRZmRLMWE1eFA0b3JseEVGOUx2dkxXbThtUHdt?=
 =?utf-8?B?dHR2ODFTbTlJYklIVTQ1d3FiVG9TKy9DK1lSVG9jK25veUt0RkIzT3RZcVll?=
 =?utf-8?B?bVRHWC9HbGl4TGI3T1pyUEJXY0V4VHhRSWo2bDNPWjJ2blJGOFEwdnIwN3ZQ?=
 =?utf-8?B?bXp6UTRmSnNyUDRTUXFVRmI5b3RuNTRId1o0aXZObEJVRERqTjNPM1FQNThl?=
 =?utf-8?B?Z1JDMnN3R3JPb0QxZkNIRklyV2x6UFZlUWsvWkZ6ejRlSzFZaWxBbGZSb1I0?=
 =?utf-8?B?YS93MFdCZVJma0xUaE5QRjNETG1pSGdqSmpadml2b2NhWHV1Yk1mdU8wdGRm?=
 =?utf-8?B?bkw0R2ZyOWxDcjVCY2tXQjREc0RrSG9vdG9iN0tnVFE2VWJLWnRKeG8rcDQ5?=
 =?utf-8?B?QWlpVGZjeGxGeTRxeDN1M1BURno2alpua1BPMTlDQTBTU0szOEtYNjZMUjRt?=
 =?utf-8?B?ZXB5NzVQamZINDRqdzhxNjZSN3Q3R2RMejQvQ2tyRkFpbEZWZC85QnhFR2tQ?=
 =?utf-8?B?aHRIV1l5TXNJODRsYjl3dXJBWVpJUG1zUlVSSElZUkNoVHc0VHlwak9BY1J6?=
 =?utf-8?B?OFZmZG9UbFpRM1Z3TTg3QlNoRnNGS3ZyYmZXZnRLOVZHeFlKZmFTaWFwQTlW?=
 =?utf-8?B?SFNVbGZBWVErTjF3ZW5wWHVzUlJ6MXp3RGtOamppK2Z5T1B3cjkwcnVud0E5?=
 =?utf-8?B?OEs4L1RWMVBFWmlIdTZxMHBDdkZMenZOc1VVQnRsbXl5eVhjUGNuV1ZLeTRu?=
 =?utf-8?B?MjRjbTBkc0llYzIrajFEdSs5TnNCYUUydUZacS9wSzRVc1Mxdlk3NHlDdmxy?=
 =?utf-8?B?M3UzZVJ2dGpvM09uVU9Wbm5mZG5mUDluRlJzY2RyL2syRzVteW5sS0Ewb2Rm?=
 =?utf-8?B?VFZWMzJDNCt4S25WTzBoVWJycTdDak82NDNDdXF3cGVDTnZ2OEMrdVNtWUJh?=
 =?utf-8?B?eFdyTWJMMkZibUswaDRQdzZIam9yTWNtTzhORERYWENhSk1HR0cxMDhNVUdJ?=
 =?utf-8?B?YnJmK1JzTGprMFVaS2FuYkNteEI4Vk9rd25mWTY2dE5MODNpMTFZYVYzeXVj?=
 =?utf-8?B?cnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9DE9B15A6D734D4AA64240E544BD700C@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b5d2fb-fb32-4a7f-45c1-08ddbcdc9e91
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2025 22:29:49.5405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rs2MYuHDFSfkpzyEdNEZZgPoKsATbTRDco4TrOGxJwMzdbWG495aN2zSKA4JlBEAqtzq8fMx6wI4EnUS5vEqIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB6054
X-Proofpoint-ORIG-GUID: Re6BE9qwIndK5eso8jgCul7caYNsBxP1
X-Authority-Analysis: v=2.4 cv=TN1FS0la c=1 sm=1 tr=0 ts=686af8e2 cx=c_pps a=OlGsJSUUIKrblIYSkUKehQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=edGIuiaXAAAA:8 a=drOt6m5kAAAA:8 a=aV8UCD9PIQKct8cuzd4A:9 a=QEXdDO2ut3YA:10 a=4kyDAASA-Eebq_PzFVE6:22 a=RMMjzBEyIzXRtoq5n5K6:22
X-Proofpoint-GUID: Re6BE9qwIndK5eso8jgCul7caYNsBxP1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA2MDE0NCBTYWx0ZWRfX2UTjNZuHiDqm HAyilHIDshKRBOGRcuxzuz7oJELxZi3ChWKpRTJf2clm9m5OT8bTE9IOGioVD3TdvRTvQk0lD4j pv/lsMFcNAbuVdTMR+ivhl/Fkm/jMm7IcZK3z3J16KIsZK+ofLwuzeGdGxchZ3n3N+N2Bitq5aQ
 PsncThBr/tm8HaON3o77lI6lXr1nI2pJeEsbDr+kYEQ6AVZKq4yEL9wD0tBRnP+SqKDeKnA/BLj 3BGSzIbWApq5/rEGEk1SRtobVRjF4w063H5045YDwmZlXJS+xgkYPsKAqwH1YYtRY286rXWqNaL 9pill/rY8PKYN8PR6f6RtHUHYJ9GWg67vCzygddmRlbdSwppJ2s9lxpdyVyBgn8nL93zqV5mEhf
 KWh9mIHZ1vatui4Ql9eefsDK04z92nHbFGJNfg0GRfRdNzlJGah3T6jeMVnekDFPUUkmmSbT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_07,2025-07-06_01,2025-03-28_01

DQoNCj4gT24gSnVsIDQsIDIwMjUsIGF0IDI6MDDigK9BTSwgTWlja2HDq2wgU2FsYcO8biA8bWlj
QGRpZ2lrb2QubmV0PiB3cm90ZToNCj4gDQo+IE9uIFRodSwgSnVsIDAzLCAyMDI1IGF0IDEwOjI3
OjAyUE0gKzAwMDAsIFNvbmcgTGl1IHdyb3RlOg0KPj4gSGkgTWlja2HDq2wsDQo+PiANCj4+PiBP
biBKdWwgMywgMjAyNSwgYXQgMTE6MjnigK9BTSwgTWlja2HDq2wgU2FsYcO8biA8bWljQGRpZ2lr
b2QubmV0PiB3cm90ZToNCj4+PiANCj4+PiBPbiBNb24sIEp1biAxNiwgMjAyNSBhdCAxMToxMTox
M1BNIC0wNzAwLCBTb25nIExpdSB3cm90ZToNCj4+Pj4gVXNlIHBhdGhfd2Fsa19wYXJlbnQoKSB0
byB3YWxrIGEgcGF0aCB1cCB0byBpdHMgcGFyZW50Lg0KPj4+PiANCj4+Pj4gTm8gZnVuY3Rpb25h
bCBjaGFuZ2VzIGludGVuZGVkLg0KPj4+IA0KPj4+IFVzaW5nIHRoaXMgaGVscGVyIGFjdHVhbHkg
Zml4ZXMgdGhlIGlzc3VlIGhpZ2hsaWdodGVkIGJ5IEFsLiAgRXZlbiBpZiBpdA0KPj4+IHdhcyBy
ZXBvcnRlZCBhZnRlciB0aGUgZmlyc3QgdmVyc2lvbiBvZiB0aGlzIHBhdGNoIHNlcmllcywgdGhl
IGlzc3VlDQo+Pj4gc2hvdWxkIGJlIGV4cGxhaW5lZCBpbiB0aGUgY29tbWl0IG1lc3NhZ2UgYW5k
IHRoZXNlIHRhZ3Mgc2hvdWxkIGJlDQo+Pj4gYWRkZWQ6DQo+Pj4gDQo+Pj4gUmVwb3J0ZWQtYnk6
IEFsIFZpcm8gPHZpcm9AemVuaXYubGludXgub3JnLnVrPg0KPj4+IENsb3NlczogaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvci8yMDI1MDUyOTIzMTAxOC5HUDIwMjMyMTdAWmVuSVYgIA0KPj4+IEZp
eGVzOiBjYjJjN2QxYTE3NzYgKCJsYW5kbG9jazogU3VwcG9ydCBmaWxlc3lzdGVtIGFjY2Vzcy1j
b250cm9sIikNCj4+PiANCj4+PiBJIGxpa2UgdGhpcyBuZXcgaGVscGVyIGJ1dCB3ZSBzaG91bGQg
aGF2ZSBhIGNsZWFyIHBsYW4gdG8gYmUgYWJsZSB0bw0KPj4+IGNhbGwgc3VjaCBoZWxwZXIgaW4g
YSBSQ1UgcmVhZC1zaWRlIGNyaXRpY2FsIHNlY3Rpb24gYmVmb3JlIHdlIG1lcmdlDQo+Pj4gdGhp
cyBzZXJpZXMuICBXZSdyZSBzdGlsbCB3YWl0aW5nIGZvciBDaHJpc3RpYW4uDQo+Pj4gDQo+Pj4g
SSBzZW50IGEgcGF0Y2ggdG8gZml4IHRoZSBoYW5kbGluZyBvZiBkaXNjb25uZWN0ZWQgZGlyZWN0
b3JpZXMgZm9yDQo+Pj4gTGFuZGxvY2ssIGFuZCBpdCB3aWxsIG5lZWQgdG8gYmUgYmFja3BvcnRl
ZDoNCj4+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNTA3MDExODM4MTIuMzIwMTIz
MS0xLW1pY0BkaWdpa29kLm5ldC8gDQo+Pj4gVW5mb3J0dW5hdGVseSBhIHJlYmFzZSB3b3VsZCBi
ZSBuZWVkZWQgZm9yIHRoZSBwYXRoX3dhbGtfcGFyZW50IHBhdGNoLA0KPj4+IGJ1dCBJIGNhbiB0
YWtlIGl0IGluIG15IHRyZWUgaWYgZXZlcnlvbmUgaXMgT0suDQo+PiANCj4+IFRoZSBmaXggYWJv
dmUgYWxzbyB0b3VjaGVzIFZGUyBjb2RlIChtYWtlcyBwYXRoX2Nvbm5lY3RlZCBhdmFpbGFibGUg
DQo+PiBvdXQgb2YgbmFtZWkuYy4gSXQgcHJvYmFibHkgc2hvdWxkIGFsc28gZ28gdGhyb3VnaCBW
RlMgdHJlZT8gDQo+PiANCj4+IE1heWJlIHlvdSBjYW4gc2VuZCAxLzUgYW5kIDIvNSBvZiB0aGlz
IHNldCAod2l0aCBuZWNlc3NhcnkgY2hhbmdlcykgDQo+PiBhbmQgeW91ciBmaXggdG9nZXRoZXIg
dG8gVkZTIHRyZWUuIFRoZW4sIEkgd2lsbCBzZWUgaG93IHRvIHJvdXRlIHRoZQ0KPj4gQlBGIHNp
ZGUgcGF0Y2hlcy4NCj4gDQo+IFRoYXQgY291bGQgd29yaywgYnV0IGJlY2F1c2UgaXQgd291bGQg
YmUgbXVjaCBtb3JlIExhbmRsb2NrLXNwZWNpZmljDQo+IGNvZGUgdGhhbiBWRlMtc3BlY2lmaWMg
Y29kZSwgYW5kIHRoZXJlIHdpbGwgcHJvYmFibHkgYmUgYSBmZXcgdmVyc2lvbnMNCj4gb2YgbXkg
Zml4ZXMsIEknZCBwcmVmZXIgdG8ga2VlcCB0aGlzIGludG8gbXkgdHJlZSBpZiBWRlMgZm9sa3Mg
YXJlIE9LLg0KPiBCVFcsIG15IGZpeGVzIGFscmVhZHkgdG91Y2ggdGhlIFZGUyBzdWJzeXN0ZW0g
YSBiaXQuDQo+IA0KPiBIb3dldmVyLCBhcyBwb2ludGVkIG91dCBpbiBteSBwcmV2aW91cyBlbWFp
bCwgdGhlIGRpc2Nvbm5lY3RlZCBkaXJlY3RvcnkNCj4gY2FzZSBzaG91bGQgYmUgY2FyZWZ1bGx5
IGNvbnNpZGVyZWQgZm9yIHRoZSBwYXRoX3dhbGtfcGFyZW50KCkgdXNlcnMgdG8NCj4gYXZvaWQg
QlBGIExTTSBwcm9ncmFtcyBoYXZpbmcgdGhlIHNhbWUgaXNzdWUgSSdtIGZpeGluZyBmb3IgTGFu
ZGxvY2suDQo+IFRoZSBzYWZlIGFwcHJvYWNoZXMgSSBjYW4gdGhpbmsgb2YgdG8gYXZvaWQgdGhp
cyBpc3N1ZSBmb3IgQlBGIHByb2dyYW1zDQo+IHdoaWxlIG1ha2luZyB0aGUgaW50ZXJmYWNlIGVm
ZmljaWVudCAoYnkgbm90IGNhbGxpbmcgcGF0aF9jb25uZWN0ZWQoKQ0KPiBhZnRlciBlYWNoIHBh
dGhfd2Fsa19wYXJlbnQoKSBjYWxsKSBpcyB0byBlaXRoZXIgaGF2ZSBzb21lIGtpbmQgb2YNCj4g
aXRlcmF0b3IgYXMgVGluZ21hbyBwcm9wb3NlZCwgb3IgYSBjYWxsYmFjayBmdW5jdGlvbiBhcyBO
ZWlsIHByb3Bvc2VkLg0KPiBUaGUgY2FsbGJhY2sgYXBwcm9hY2ggbG9va3Mgc2ltcGxlciBhbmQg
bW9yZSBmdXR1cmUtcHJvb2YsIGJ1dCBJIGd1ZXNzDQo+IHlvdSdsbCBoYXZlIHRvIG1ha2UgaXQg
Y29tcGF0aWJsZSB3aXRoIHRoZSBlQlBGIHJ1bnRpbWUuICBJIHRoaW5rIHRoZQ0KPiBiZXN0IGFw
cHJvYWNoIHdvdWxkIGJlIHRvIGhhdmUgYSBWRlMgQVBJIHdpdGggYSBjYWxsYmFjaywgYW5kIGEg
QlBGDQo+IGhlbHBlciAobGV2ZXJhZ2luZyB0aGlzIFZGUyBBUEkpIHdpdGggYW4gaXRlcmF0b3Ig
c3RhdGUuDQoNClNpbmNlIHdlIGFyZSBwcm9wb3NpbmcgYW4gb3Blbi1jb2RlZCBCUEYgaXRlcmF0
b3IuIEhhdmluZyBhIHJlYWwgDQpjYWxsYmFjaywgd2hpY2ggaXMgbm8gbG9uZ2VyIGFuIG9wZW4g
Y29kZWQgaXRlcmF0b3IsIHJlcXVpcmVzIG1vcmUNCndvcmsuIEF0IHRoZSBtb21lbnQsIGl0IGlz
IGVhc2llciB0byBqdXN0IGFkZCBhIHBhdGhfY29ubmVjdGVkIGNhbGwNCmluIGJwZl9pdGVyX3Bh
dGhfbmV4dCgpLiANCg0KVGhhbmtzLA0KU29uZw0KDQo=


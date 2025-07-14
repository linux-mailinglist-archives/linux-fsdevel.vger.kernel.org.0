Return-Path: <linux-fsdevel+bounces-54890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F624B0492C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 23:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76D6A1AA0B53
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 21:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7E3278753;
	Mon, 14 Jul 2025 21:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Pq6Y6NMe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E20D273D95;
	Mon, 14 Jul 2025 21:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752527388; cv=fail; b=H9YNQL7zHH7Qgwyh2muPhtQk/iWZ9HPly59RbXrbmXvzWETy9tYUWrMWwPdG5z9Dew7CHFoxApR7rFvfBmQYrsXRY54x7S4bzgzB+Xvjqfv4tUBPq2S3r39H8j71yDWu/A4uJwRgN2xRXCkz+OsWA8Qx/lyBz39BNmo2jlmIK1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752527388; c=relaxed/simple;
	bh=WNHoiXa/1nuO5Aj2Z91LVMv5P5Weh4XyWGyn1Q77IKc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QE8NsMWjFXdJwe35BUqzyuTjHRYkJ6B9GmgS2OhNOH9WmB/qJV4TV3iFbT4IIzNSNJlbYLrIrFYEPop2OdkW08KjeVHR0YxmJgy+MvRMEd08MFDmph+abTEo/t8NwJPBodqkLJNGvY5Mlcx6X5w92vUyuWLotGFbRzZzI+iafAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Pq6Y6NMe; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EJF99u026881;
	Mon, 14 Jul 2025 14:09:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2025-q2; bh=WNHoiXa/1nuO5Aj2Z91LVMv5P5Weh4XyWGyn1Q77IKc=; b=
	Pq6Y6NMe9G/wFB1Yq1PTJkm12vPYEYCuDQBoHV0UOwjp3AmnSSygF3fJBTufIoYw
	THatCKpYqFNa3mEMJl8DyXe2FiQ6EZF04m48WpKjUlfblswN/8JMQR7fLQvSHZFA
	b3yDXq9aeFVRcgVngj85xxQrKq78bgVpzliOZac4xAdAzPAwWSQ9yHE9/tnn26Bx
	Wa20qYFRmypLih5IMsFxM70PHawI3O7wT/sk6uzNHEr7Fuig2wgylcSIUQIydaFO
	VGaGDZt/Zyxv5p8Xizj5Hf7I/eW+R7PERy9oDsentssAY9rK7tlv+jBbjoV3NhWT
	QLN0j8WiGb6Asm32YWcakA==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47vekmgk7h-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 14:09:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UWfHwYkPBfLYAjv6ZzgQZsAvTZmrI0dbKmdpDtEfQD40JL9aMn5n0Xr32LJ1tLsgfvWwp/CqcWor90tKSKcA1U8gHtqH4K3iBNAk4S6fO/rRBRHugWb8eAiy4AmUnr2r1c6TGDNOkTNcTKe8YTfBFGV/NZkJ8ZnDWnTvdY6JCkS1EUpxU3SU1ss45I9EM+2GEmK7PyNC5jV2iMTcsiRLB1scfN0zkKGKLcI8/LkQSqkVsxoKo68uceJgJkVZuHPILcoVE7zPLzHbUn++ex7A0FqXAnPoll0LF5npz+6EEi0hfZw+PeJpBUFq6l2wZYl6+r5bXSBE69DRi4MIIrPcrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNHoiXa/1nuO5Aj2Z91LVMv5P5Weh4XyWGyn1Q77IKc=;
 b=Y1N9FPohQ28oUStptHP4QpcYbXGuZOwxJyfIf3iOr14QI5keWrIWKzrswqAskYuj4468q2A6i5UjaZwfuZ9dqYip3gamX1E9nFI29USRJPQ/+aRFyE52A0DRFb/U3YuFsDhYovH4TAm2O3GWHGiagHdndsCOoD+GzIhz5AExmPah+GP8WW26G6tU/wbNK3TGXUymZgzG2vC9xFGZjglnCiSIfEDSIAVFuMdoqKGgTj7ldC9ZI5SLlHOSAe2hI7X+XxKdVHcc2RtQSgcm9XSC3k5Ss+EQxmHzCVNQFzA9SnpULZP5p08rVe+TQrdesiTxwbn7UHaj2OMJiMZ83lmuoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by IA1PR15MB6245.namprd15.prod.outlook.com (2603:10b6:208:451::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Mon, 14 Jul
 2025 21:09:42 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%7]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 21:09:42 +0000
From: Song Liu <songliubraving@meta.com>
To: NeilBrown <neil@brown.name>
CC: =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Christian Brauner
	<brauner@kernel.org>, Tingmao Wang <m@maowtm.org>,
        Song Liu
	<song@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
        =?utf-8?B?R8O8bnRoZXIgTm9hY2s=?= <gnoack@google.com>,
        Jann Horn
	<jannh@google.com>
Subject: Re: [PATCH v5 bpf-next 0/5] bpf path iterator
Thread-Topic: [PATCH v5 bpf-next 0/5] bpf path iterator
Thread-Index:
 AQHb306ox9XN8K6VdkCbVuOe+nEEeLQMnoWAgAYTUACAADBQgIABBU4AgAClEQCAABGDAIAAECWAgABQToCAAEtZgIAARLiAgACMg4CAEH8tgIAACIOAgAB+hYCAAvcGAIAAF8IAgABRvgCAAAcpAIAAI/SAgABcBICABz+ngA==
Date: Mon, 14 Jul 2025 21:09:42 +0000
Message-ID: <2243B959-AA11-4D24-A6D0-0598E244BE3E@meta.com>
References: <474C8D99-6946-4CFF-A925-157329879DA9@meta.com>
 <175210911389.2234665.8053137657588792026@noble.neil.brown.name>
 <B33A07A6-6133-486D-B333-970E1C4C5CA3@meta.com>
In-Reply-To: <B33A07A6-6133-486D-B333-970E1C4C5CA3@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.600.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|IA1PR15MB6245:EE_
x-ms-office365-filtering-correlation-id: a7cb283d-4011-4b1a-1a50-08ddc31ac063
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VmVwWS9SV09ua3ZqWXZMV0VWaGs3bzJSUUg1UE4xWVhSeGdoeVhHWTQxSXFQ?=
 =?utf-8?B?cGk4MGhqRlVOQTd3M2VRbHZmc1pqMVZZMHMwa1JRTEh2aHdSTWpJM0JCUFBQ?=
 =?utf-8?B?aGZvaWZPeVMvbHJwdHQzTThBaWtWWGsva0Fxd21sdmlmRmJGeUhSWlptQW5o?=
 =?utf-8?B?ZjYwcGswR3lVRWJxUkw5OStBNFZjQ3lVTG9aSS90ZW1aZXN5RlVpb2ZDdXVJ?=
 =?utf-8?B?MTJocW93S1ppRnVWTFZCVUdwUzY4ZlBpNUprbGwvem9SbEtFRzV5NTVXNWVC?=
 =?utf-8?B?ejdiOEt1a1FuYTUxQktkbWZoZWc4U3BZKzlxc0R0MU1IUVlBK1I5ZzZ5MlBF?=
 =?utf-8?B?bDArbmNYN1JmTXExMC9iZmc3b25pL3NLL0xRMnV5NUY2a3F6NUlTaHUxNGZn?=
 =?utf-8?B?VCt2ekIrMnZqdU5MMStyZUpmbkJTaDZPeGEzMVNKYkxDRHhnL1VmQ2k5cE9s?=
 =?utf-8?B?djBDRUVMMnpPMUphQ0hWMzhiYVJkWGZIa01uZ3JTYU9rd2tQS2xBeWtBNGtU?=
 =?utf-8?B?WXVDbDN3MkF2MW9pdmlHbEl4V0hzYTNTcWxOSitWNW8rOHRrcjVIM0VVL3R5?=
 =?utf-8?B?bFQ5WVB2MG4zTGdUTzB0WUpmekVTWEtOcVE1cHQ5VkZ0QzE3REpBemN3NXJs?=
 =?utf-8?B?QVhKVkNrbTE5cVFJNS9DTldjZkc3UDZhN1ZVc2d4Nk1DNWkwOExIZGhXTlRo?=
 =?utf-8?B?dFNCK2JTUlVTSVVhRkFTNUZNbGZaa2pQMnJ0L2ozWDNseUtTNEhJeklxc0o0?=
 =?utf-8?B?YmhKN2t1b0M1QW5rWUdpeS8wbUNrWThsQ2xSdFUyam9WL1JSS3JCako0OUY0?=
 =?utf-8?B?RUZVUklpdkVaR25OUzdSVzA1dE5pM0FqVnFMREZSdVhqdThNTDNSTmp3cVc1?=
 =?utf-8?B?eDh0UVlJWEJGekcyWTVraWw5QXB6Z092SmtmNTdtNCtBai9EUzlZOEtWbHFa?=
 =?utf-8?B?TzVSdnV4MEtnSW54SjB6dkcxK1lzK1VLSGllaEgza3VMdDVYaHFCYWJZMS8w?=
 =?utf-8?B?czMvUTg5cjVJU0k2QWk1NUNjK2cwL21xbnZSYXNZbG5SMFdkMWJMMUwrbnRW?=
 =?utf-8?B?bGNUdW5nZ3RUb0liZUNrTnFIQUZ1ZFk3dzJIbm91emJqQnF1NFhzZVVUUGJo?=
 =?utf-8?B?czRZNUxtSkFMNlY3NDhDN3VWU2xIeXl4OHpicTQzY0doOGlFOXFUUFExd3lF?=
 =?utf-8?B?NVltdGxKb0NxUHl0VHJiOXFOYlcxRUVCQW5YbFpiVktmVk5VSzliVU9QT0JT?=
 =?utf-8?B?OCtKWVJjWWxRVGVaTzkxY0pIZ1lRQ2ZHVTZuK2dUSk5QYUpLQ2t0Y1lRRzJH?=
 =?utf-8?B?QjhFK09tcnhiQnk3QlhveHoyREZrcFJLMER5dmdsWGgzUlZzTmtnSFVJRkR4?=
 =?utf-8?B?UlhUR3pVVlYwVW9WdElwVml2YS9CdzY1MGhBUmpqVExtdWM0VktKQldXSmFZ?=
 =?utf-8?B?UWtGVDZrYW9ESTA0SERkNmZUQnBpZlBBWkZBTFNhY3RFYVQ1aFV0ZWIyQ1BK?=
 =?utf-8?B?THBoemh1UGEvTGtJekdEZzBqRnlXZDgvRjFRL3ZaZ2orRmp0bnBDaC9IS3Ny?=
 =?utf-8?B?KzVSNG5lYmFld2NSSDBZRFc3YVQvTjdPcU42cUNTVHJ3T01zVmd3UTl4UUU1?=
 =?utf-8?B?WUJIbGk4bzM4VUdObytpSFVxNU1HR05FOWxjNUVlL1RRS0NxQXN2YXllNVZK?=
 =?utf-8?B?THU2MFhVeWpKWWlZNVdVa2s3M1IzUnlJVW9CNEhhcVA3WUwyWjcvNWJMTXl3?=
 =?utf-8?B?SU1NVnNIWDE4cTVzcnJGa1JRaVF6dE00a3RuRmx2YjgwZGlpVDduR0kyTnNt?=
 =?utf-8?B?cFFWL0haVktnM2QrTmZtTW9NNVpLZjh6YkVXaElrS2tMT1FTOG5iOUZzVGZM?=
 =?utf-8?B?dTNPQUR5aXhhcWVvMVVpS2QwbU5xMllXZEMrZmxXT08zV1BZdnlyVjBQOFF3?=
 =?utf-8?B?LzY0Mlp6bXh2OUhOTHhQSHAxWjQ4ckJjOHg0UFhXVlNtNmRBTWhLblpaV1A2?=
 =?utf-8?B?YjJKTkxoeE1nPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K0VUZjZxLy9LWVFkZS9oMlVDUk9NQmtHY0ROM2VuaWxSNUhrRjFjWHRkMGR5?=
 =?utf-8?B?TXVWUDdEWkVQRXdzVnplaEpScEVnV2VnM2ttemZ1ZzlEeWZSQTlNQlZaK3RW?=
 =?utf-8?B?N2ZjQ2ZXMkRybXZYUURDTE1PWGJJazdVb01wMFF4M2x5ZGxXWmZVWEM5bCtl?=
 =?utf-8?B?WlQxNFIyV0Y3b3EraDdTUGJ2NWFCYkREMXVTSnJMVlVqZFY1cWl0dUVrZ0Nn?=
 =?utf-8?B?WUVscnZuaTZ0R25VY2tmWUZCTTF3TnpJMFpGMlFSdXUwODYxSGZQb0dteFlQ?=
 =?utf-8?B?Y3U1VDdROHhtb0lWUjBMYUhoUitKV08rQlhSbmVaTTdxeGlMQjBjSVphVUJj?=
 =?utf-8?B?dkErNEpGVVFMd0ZCZkxUWGhWb2ZRbUJhY3F0YWhEZGxGSllWc0RIdFdYV3Nn?=
 =?utf-8?B?UldweklBZ3Q1bXhqNXEwRzdJNkgvSXVMNUsrY3NaN3lzYXBEVENpa0hVYkJ6?=
 =?utf-8?B?UGxBNW91RVFPcFdjYUl2QXNlSnVLcWVrdDdIMkgzVTNPOTdzV3JjcUdFNG1m?=
 =?utf-8?B?c0QvZ0RzQkw0OGdUNFdOSndWQ1ZVNCs3cTBpQ3ZYMHlGS0dWT3NnRVVMS0kx?=
 =?utf-8?B?L3R3NHpkVnlwVHlCTGhhczRnbnh5cFArOVA0ZUdOUTBoVTBBdFRnN3VGLzJk?=
 =?utf-8?B?RVBuUTlXRXQ0aXdOOFhFcFA5MlhOYjVuSllZWTU3SDh3NlFQV1BvTmhkdFdv?=
 =?utf-8?B?YlN0cVc4K0EyQnJnekF2WDU0cDFJTVI4VEg0Yy9nY2QvdnFlblk3WjdUaHV1?=
 =?utf-8?B?WXFQcE5SSDlDaEMvTEtBVlFxb3JzV1JnMDFHdXZVMHcyNXoyNkRtRUJLaC9S?=
 =?utf-8?B?ZWtaNlYyV3BtUVZzclI2TWlvdEZ4Z3FjT3paN0YzNW9CL1BSbmtKM2liS2xG?=
 =?utf-8?B?d3AwRm04UytpUkxlQjEvQVhUWURZWkh4RS85T1ZnVlNVZ01NL3lXWkxIRlBs?=
 =?utf-8?B?VjBaRWdqb21QOWdTWHc0bHM1bk11WVFMS1FGbSsrV2Flb2svRERSN3hMd05J?=
 =?utf-8?B?eWVHdEIvV0pNVzJEZEFNRVhpdmxpYUlZWTVyQktKVlBQUDJwNE1IUUhkMllh?=
 =?utf-8?B?TXdZMDg3NUlUN1lNNlZSUEtZcWo5c3Erc0V2Q0dSektpRjUzemhmYm1zeXBT?=
 =?utf-8?B?ZG1qU2dYRVNKdXhWbE8rYWxQR1VyZ1piTXpNaDgwb1dwWk9HQUNkeTNpZUl4?=
 =?utf-8?B?Q0phak8zb1gvL1I3OW9uK3ZLaFJ4dlJhRmRxL1JtelRDT1R6WU9VU21nZHpM?=
 =?utf-8?B?M0wrOXVMcDMxN2wycGpicElLcC9tMXYyVTI5cUpqcUh2c1pLeWw0K3N3WVpO?=
 =?utf-8?B?YnM3dG44c09SY2xCVGcya0pjRXBWTFJyOTEzT3JseU0reHhmb1RDaWl4MWNn?=
 =?utf-8?B?dDF2OFFrNkRmTXZKUEdwRzhPY0lTNUlQQlU0WlVxbk12OFZoVXp3YW1ORitu?=
 =?utf-8?B?Ymc0SHBpVzc3ejdqMHRqVkJ6SW4zaGs5L0ZlZmF2WXE3MUhyWDAvTHppOGdF?=
 =?utf-8?B?N3E5SVQ4enk2NlR3dzZFVkNWT1U3Z0FUeHVPTjRkcGdRTysxWHpSZ0JLYWFC?=
 =?utf-8?B?SFVMVE4reXcvdEJIUXI3WGI5MDR5RHFGK1c3YnFCeXlCcmtkK1R6VVRXWVpt?=
 =?utf-8?B?Y0RFT3ZqTFBJbURKUEJ1Vm1KcDgvUVhKSFcrRzBiOE1OODd0MVdudGo5cGhS?=
 =?utf-8?B?ZEFNdFRYcnZ3OEpJd0tEN1pzZ2FBY2RCdmxYby9mTVRIMFlMNFBMVm1DQUkw?=
 =?utf-8?B?cW1rbmxaRGlsYkU2N0NUT1Z1UXNtWURMN2JoNjJvM1lZUjBCbG9wYm4vZ09j?=
 =?utf-8?B?SDBPNllkTWhVTndsL0U5eEVwcXEvdkNzN3FDR2hTemlwSk8xS0VMaUIvZWcw?=
 =?utf-8?B?V1lhTTc5dXJFTEFsRmZ3SEZCdEZZemo4TCtXWTRTM1diY3pzMnlzclFFZk5M?=
 =?utf-8?B?empTVHJDQVppZ2I4R3V4WFljczZuQlpZczByZVpYR2NxL2NhL3dlQjNuMWtH?=
 =?utf-8?B?dUs0QVZQWC9IWnk0MTdFc0lIcnZzR1ZVRDdrL2R1WHUzYlkwNDZqZTNWeExX?=
 =?utf-8?B?UTNBY2pmZHNLdFQ4MUxIbjRDMFVBTGJGUUFEdFM0NXIwVFVMbDd3RmhtdnZz?=
 =?utf-8?B?NVNoWEhCUU4rOEVua3lUWlMrci9kLzVxaFVaYXc1YVZFdUg1aVVlQ0ZHdWM3?=
 =?utf-8?B?N0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E18B8FF9C18364FA4576A1E1E3E3092@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a7cb283d-4011-4b1a-1a50-08ddc31ac063
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 21:09:42.0694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rX9HaajfOaSMDMcG13H9kIxR2C5qCInia+Rm32NVJ216F8+xgqUkyY181U02M/vw6x829q389H3/c0NTnOeMbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB6245
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDE0MiBTYWx0ZWRfX20mLo5YbLa5N sTLxHwzUJsuqLSYuW0nGuRSgfcvvvLoedmkX7+eh/N10hPqybpFITbVOFHFp3WyifQgQVYV0ncG VkPRtOgQX3ai31WWvOvzbpcNJZMv6sanW58dUF96mnGa/J/MTgtebCtAsNKxkwaXYPY1pN8OUWQ
 67FYzKLECZ1a6gbkFqXSrRh0KhWE+iNkW1y1VZFMdJtpa1BJs8nkz3M7PJ7jVKGTENSycaVBEKX zi/+mkKklJkEWIqIalOAyC2e/0lP6mVwptsVnBNq+iFjbIYlRKe8McYg1NxEpVxnhI7LU5ShYy/ I40wqvNYGUzg37k2jqOpuzSomyyGSkOSm7fYml+y4BkA3cw87Jrp+sHRrzMap0AXD/njt93vNJj
 ZKd+73wbNC1bMq/A1LF/PVQ8B7uFf7NbU3+qWXxC2rX6KS10nSM1+WdKBwUN9/NNdco7ip8E
X-Authority-Analysis: v=2.4 cv=bNwWIO+Z c=1 sm=1 tr=0 ts=68757218 cx=c_pps a=EpvH1avkcIZxQBnqYGWDjg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=VabnemYjAAAA:8 a=NlMzP3zWO-qX_B_iesIA:9 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: I18k_c3Mwp0awaJP5BqqxsGah6gm-4Nm
X-Proofpoint-ORIG-GUID: I18k_c3Mwp0awaJP5BqqxsGah6gm-4Nm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_02,2025-07-14_01,2025-03-28_01

DQo+IE9uIEp1bCA5LCAyMDI1LCBhdCAxMToyOOKAr1BNLCBTb25nIExpdSA8c29uZ2xpdWJyYXZp
bmdAbWV0YS5jb20+IHdyb3RlOg0KDQpbLi4uXQ0KDQo+Pj4+IEl0IGlzbid0IGNsZWFyIHRvIG1l
IHRoYXQgdmZzX3dhbGtfYW5jZXN0b3JzKCkgbmVlZHMgdG8gcmV0dXJuIGFueXRoaW5nLg0KPj4+
PiBBbGwgdGhlIGNvbW11bmljYXRpb24gaGFwcGVucyB0aHJvdWdoIHdhbGtfY2IoKQ0KPj4+PiAN
Cj4+Pj4gd2Fsa19jYigpIGlzIGNhbGxlZCB3aXRoIGEgcGF0aCwgdGhlIGRhdGEsIGFuZCBhICJt
YXlfc2xlZXAiIGZsYWcuDQo+Pj4+IElmIGl0IG5lZWRzIHRvIHNsZWVwIGJ1dCBtYXlfc2xlZXAg
aXMgbm90IHNldCwgaXQgcmV0dXJucyAiLUVDSElMRCINCj4+Pj4gd2hpY2ggY2F1c2VzIHRoZSB3
YWxrIHRvIHJlc3RhcnQgYW5kIHVzZSByZWZjb3VudHMuDQo+Pj4+IElmIGl0IHdhbnRzIHRvIHN0
b3AsIGl0IHJldHVybnMgMC4NCj4+Pj4gSWYgaXQgd2FudHMgdG8gY29udGludWUsIGl0IHJldHVy
bnMgMS4NCj4+Pj4gSWYgaXQgd2FudHMgYSByZWZlcmVuY2UgdG8gdGhlIHBhdGggdGhlbiBpdCBj
YW4gdXNlIChuZXcpDQo+Pj4+IHZmc19sZWdpdGltaXplX3BhdGgoKSB3aGljaCBtaWdodCBmYWls
Lg0KPj4+PiBJZiBpdCB3YW50cyBhIHJlZmVyZW5jZSB0byB0aGUgcGF0aCBhbmQgbWF5X3NsZWVw
IGlzIHRydWUsIGl0IGNhbiB1c2UNCj4+Pj4gcGF0aF9nZXQoKSB3aGljaCB3b24ndCBmYWlsLg0K
Pj4+PiANCj4+Pj4gV2hlbiByZXR1cm5pbmcgLUVDSElMRCAoZWl0aGVyIGJlY2F1c2Ugb2YgYSBu
ZWVkIHRvIHNsZWVwIG9yIGJlY2F1c2UNCj4+Pj4gdmZzX2xlZ2l0aW1pemVfcGF0aCgpIGZhaWxz
KSwgd2Fsa19jYigpIHdvdWxkIHJlc2V0X2RhdGEoKS4NCj4+PiANCj4+PiBUaGlzIG1pZ2h0IGFj
dHVhbGx5IHdvcmsuIA0KPj4+IA0KPj4+IE15IG9ubHkgY29uY2VybiBpcyB3aXRoIHZmc19sZWdp
dGltaXplX3BhdGguIEl0IGlzIHByb2JhYmx5IHNhZmVyIGlmIA0KPj4+IHdlIG9ubHkgYWxsb3cg
dGFraW5nIHJlZmVyZW5jZXMgd2l0aCBtYXlfc2xlZXA9PXRydWUsIHNvIHRoYXQgcGF0aF9nZXQN
Cj4+PiB3b27igJl0IGZhaWwuIEluIHRoaXMgY2FzZSwgd2Ugd2lsbCBub3QgbmVlZCB3YWxrX2Ni
KCkgdG8gY2FsbCANCj4+PiB2ZnNfbGVnaXRpbWl6ZV9wYXRoLiBJZiB0aGUgdXNlciB3YW50IGEg
cmVmZXJlbmNlLCB0aGUgd2Fsa19jYiB3aWxsIA0KPj4+IGZpcnN0IHJldHVybiAtRUNISUxELCBh
bmQgY2FsbCBwYXRoX2dldCB3aGVuIG1heV9zbGVlcCBpcyB0cnVlLg0KPj4gDQo+PiBXaGF0IGlz
IHlvdXIgY29uY2VybiB3aXRoIHZmc19sZWdpdGltaXplX3BhdGgoKSA/Pw0KPj4gDQo+PiBJJ3Zl
IHNpbmNlIHJlYWxpc2VkIHRoYXQgYWx3YXlzIHJlc3RhcnRpbmcgaW4gcmVzcG9uc2UgdG8gLUVD
SElMRCBpc24ndA0KPj4gbmVjZXNzYXJ5IGFuZCBpc24ndCBob3cgbm9ybWFsIHBhdGgtd2FsayB3
b3Jrcy4gIFJlc3RhcnRpbmcgbWlnaHQgYmUNCj4+IG5lZWRlZCwgYnV0IHRoZSBmaXJzdCByZXNw
b25zZSB0byAtRUNISUxEIGlzIHRvIHRyeSBsZWdpdGltaXplX3BhdGgoKS4NCj4+IElmIHRoYXQg
c3VjY2VlZHMsIHRoZW4gaXQgaXMgc2FmZSB0byBzbGVlcC4NCj4+IFNvIHJldHVybmluZyAtRUNI
SUxEIG1pZ2h0IGp1c3QgcmVzdWx0IGluIHZmc193YWxrX2FuY2VzdG9ycygpIGNhbGxpbmcNCj4+
IGxlZ2l0aW1pemVfcGF0aCgpIGFuZCB0aGVuIGNhbGxpbmcgd2Fsa19jYigpIGFnYWluLiAgV2h5
IG5vdCBoYXZlDQo+PiB3YWxrX2NiKCkgZG8gdGhlIHZmc19sZWdpdGltaXplX3BhdGgoKSBjYWxs
ICh3aGljaCB3aWxsIGFsbW9zdCBhbHdheXMNCj4+IHN1Y2NlZWQgaW4gcHJhY3RpY2UpLg0KPiAN
Cj4gQWZ0ZXIgcmVhZGluZyB0aGUgZW1haWxzIGFuZCB0aGUgY29kZSBtb3JlLCBJIHRoaW5rIEkg
bWlzdW5kZXJzdG9vZCANCj4gd2h5IHdlIG5lZWQgdG8gY2FsbCB2ZnNfbGVnaXRpbWl6ZV9wYXRo
KCkuIFRoZSBnb2FsIG9mIOKAnGxlZ2l0aW1pemXigJ0gDQo+IGlzIHRvIGdldCBhIHJlZmVyZW5j
ZSBvbiBAcGF0aCwgc28gYSByZWZlcmVuY2UtbGVzcyB3YWxrIG1heSBub3QNCj4gbmVlZCBsZWdp
dGltaXplX3BhdGgoKSBhdCBhbGwuIERvIEkgZ2V0IHRoaXMgcmlnaHQgdGhpcyB0aW1lPyANCj4g
DQo+IEhvd2V2ZXIsIEkgc3RpbGwgaGF2ZSBzb21lIGNvbmNlcm4gd2l0aCBsZWdpdGltaXplX3Bh
dGg6IGl0IHJlcXVpcmVzDQo+IG1fc2VxIGFuZCByX3NlcSByZWNvcmRlZCBhdCB0aGUgYmVnaW5u
aW5nIG9mIHRoZSB3YWxrLCBkbyB3ZSB3YW50DQo+IHRvIHBhc3MgdGhvc2UgdG8gd2Fsa19jYigp
PyBJSVVDLCBvbmUgb2YgdGhlIHJlYXNvbiB3ZSBwcmVmZXIgYSANCj4gY2FsbGJhY2sgYmFzZWQg
c29sdXRpb24gaXMgdGhhdCBpdCBkb2VzbuKAmXQgZXhwb3NlIG5hbWVpZGF0YSAob3IgYQ0KPiBz
dWJzZXQgb2YgaXQpLiBMZXR0aW5nIHdhbGtfY2IgdG8gY2FsbCBsZWdpdGltaXplX3BhdGggYXBw
ZWFycyB0byANCj4gZGVmZWF0IHRoaXMgYmVuZWZpdCwgbm8/IA0KPiANCj4gDQo+IEEgc2VwYXJh
dGUgcXVlc3Rpb24gYmVsb3cuIA0KPiANCj4gSSBzdGlsbCBoYXZlIHNvbWUgcXVlc3Rpb24gYWJv
dXQgaG93IHZmc193YWxrX2FuY2VzdG9ycygpIGFuZCB0aGUgDQo+IHdhbGtfY2IoKSBpbnRlcmFj
dC4gTGV04oCZcyBsb29rIGF0IHRoZSBsYW5kbG9jayB1c2UgY2FzZTogdGhlIHVzZXIgDQo+IChs
YW5kbG9jaykganVzdCB3YW50IHRvIGxvb2sgYXQgZWFjaCBhbmNlc3RvciwgYnV0IGRvZXNu4oCZ
dCBuZWVkIHRvIA0KPiB0YWtlIGFueSByZWZlcmVuY2VzLiB3YWxrX2NiKCkgd2lsbCBjaGVjayBA
cGF0aCBhZ2FpbnN0IEByb290LCBhbmQgDQo+IHJldHVybiAwIHdoZW4gQHBhdGggaXMgdGhlIHNh
bWUgYXMgQHJvb3QuIA0KPiANCj4gSUlVQywgaW4gdGhpcyBjYXNlLCB3ZSB3aWxsIHJlY29yZCBt
X3NlcSBhbmQgcl9zZXEgYXQgdGhlIGJlZ2lubmluZw0KPiBvZiB2ZnNfd2Fsa19hbmNlc3RvcnMo
KSwgYW5kIGNoZWNrIHRoZW0gYWdhaW5zdCBtb3VudF9sb2NrIGFuZCANCj4gcmVuYW1lX2xvY2sg
YXQgdGhlIGVuZCBvZiB0aGUgd2Fsay4gKE1heWJlIHdlIGFsc28gbmVlZCB0byBjaGVjayANCj4g
dGhlbSBhdCBzb21lIHBvaW50cyBiZWZvcmUgdGhlIGVuZCBvZiB0aGUgd2Fsaz8pIElmIGVpdGhl
ciBzZXENCj4gY2hhbmdlZCBkdXJpbmcgdGhlIHdhbGssIHdlIG5lZWQgdG8gcmVzdGFydCB0aGUg
d2FsaywgYW5kIHRha2UNCj4gcmVmZXJlbmNlIG9uIGVhY2ggc3RlcC4gRGlkIEkgZ2V0IHRoaXMg
cmlnaHQgc28gZmFyPyANCj4gDQo+IElmIHRoZSBhYm92ZSBpcyByaWdodCwgaGVyZSBhcmUgbXkg
cXVlc3Rpb25zIGFib3V0IHRoZSANCj4gcmVmZXJlbmNlLWxlc3Mgd2FsayBhYm92ZTogDQo+IA0K
PiAxLiBXaGljaCBmdW5jdGlvbiAodmZzX3dhbGtfYW5jZXN0b3JzIG9yIHdhbGtfY2IpIHdpbGwg
Y2hlY2sgbV9zZXEgDQo+ICAgYW5kIHJfc2VxPyBJIHRoaW5rIHZmc193YWxrX2FuY2VzdG9ycyBz
aG91bGQgY2hlY2sgdGhlbS4gDQo+IDIuIFdoZW4gZWl0aGVyIHNlcSBjaGFuZ2VzLCB3aGljaCBm
dW5jdGlvbiB3aWxsIGNhbGwgcmVzZXRfZGF0YT8NCj4gICBJIHRoaW5rIHRoZXJlIGFyZSAzIG9w
dGlvbnMgaGVyZToNCj4gIDIuYTogdmZzX3dhbGtfYW5jZXN0b3JzIGNhbGxzIHJlc2V0X2RhdGEs
IHdoaWNoIHdpbGwgYmUgYW5vdGhlcg0KPiAgICAgICBjYWxsYmFjayBmdW5jdGlvbiB0aGUgY2Fs
bGVyIHBhc3NlcyB0byB2ZnNfd2Fsa19hbmNlc3RvcnMuIA0KPiAgMi5iOiB3YWxrX2NiIHdpbGwg
Y2FsbCByZXNldF9kYXRhKCksIGJ1dCB3ZSBuZWVkIGEgbWVjaGFuaXNtIHRvDQo+ICAgICAgIHRl
bGwgd2Fsa19jYiB0byBkbyBpdCwgbWF5YmUgYSDigJxyZXN0YXJ04oCdIGZsYWc/DQo+ICAyLmM6
IENhbGxlciBvZiB2ZnNfd2Fsa19hbmNlc3RvcnMgd2lsbCBjYWxsIHJlc2V0X2RhdGEoKS4gSW4g
DQo+ICAgICAgIHRoaXMgY2FzZSwgdmZzX3dhbGtfYW5jZXN0b3JzIHdpbGwgcmV0dXJuIC1FQ0hJ
TEQgdG8gaXRzDQo+ICAgICAgIGNhbGxlci4gQnV0IEkgdGhpbmsgdGhpcyBvcHRpb24gaXMgTkFD
S2VkLiANCj4gDQo+IEkgdGhpbmsgdGhlIHJpZ2h0IHNvbHV0aW9uIGlzIHRvIGhhdmUgdmZzX3dh
bGtfYW5jZXN0b3JzIGNoZWNrDQo+IG1fc2VxIGFuZCByX3NlcSwgYW5kIGhhdmUgd2Fsa19jYiBj
YWxsIHJlc2V0X2RhdGEuIEJ1dCB0aGlzIGlzDQo+IERpZmZlcmVudCB0byB0aGUgcHJvcG9zYWwg
YWJvdmUuIA0KPiANCj4gRG8gbXkgcXVlc3Rpb25zIGFib3ZlIG1ha2UgYW55IHNlbnNlPyBPciBt
YXliZSBJIHRvdGFsbHkgDQo+IG1pc3VuZGVyc3Rvb2Qgc29tZXRoaW5nPw0KDQpIaSBOZWlsLCAN
Cg0KRGlkIG15IHF1ZXN0aW9ucy9jb21tZW50cyBhYm92ZSBtYWtlIHNlbnNlPyBJIGFtIGhvcGlu
ZyB3ZSBjYW4gDQphZ3JlZSBvbiBzb21lIGRlc2lnbiBzb29uLiANCg0KQ2hyaXN0aWFuIGFuZCBN
aWNrYcOrbCwgDQoNCkNvdWxkIHlvdSBwbGVhc2UgYWxzbyBzaGFyZSB5b3VyIHRob3VnaHRzIG9u
IHRoaXM/DQoNCkN1cnJlbnQgcmVxdWlyZW1lbnRzIGZyb20gQlBGIHNpZGUgaXMgc3RyYWlnaHRm
b3J3YXJkOiB3ZSBqdXN0DQpuZWVkIGEgbWVjaGFuaXNtIHRvIOKAnHdhbGsgdXAgb25lIGxldmVs
IGFuZCBob2xkIHJlZmVyZW5jZeKAnS4gU28NCm1vc3Qgb2YgdGhlIHJlcXVpcmVtZW50IGNvbWVz
IGZyb20gTGFuZExvY2sgc2lkZS4gDQoNClRoYW5rcywNClNvbmcNCg0K


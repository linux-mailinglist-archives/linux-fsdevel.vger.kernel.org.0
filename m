Return-Path: <linux-fsdevel+bounces-37742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5D19F6BF5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 18:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B80E7A3747
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 17:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BEF1FBCB0;
	Wed, 18 Dec 2024 17:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="m7J2BDw0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98391FBCAE;
	Wed, 18 Dec 2024 17:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734541629; cv=fail; b=tNB2XeFxfZB2P2lhtaLvdSf/S30pWIU7TG7e6tFpOFw0BxQjmpVCMZ5Xorkl34NRhzA5CGLIP5K7PtVLwF3JpIDizrYS0+cfbWYHVZn7sq2x6gHhaLezuIP5fzcU2LyKKedpUDfGMc/TnGXyjU30wixnIS7u1XFvtJehXqbGAks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734541629; c=relaxed/simple;
	bh=1VvR6M/hEp4KT4rZKNwumsncG/5GgdNXKCbjnegFX6E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZoaDEvrRzopRs8PeRsOHh+MwDUae8yjcFFqvfAxEmmdGK/tYSmAor5oxeeuLUfXamW+3IyYUPPLNWax27RmsDHhtoGRv+XkRla3vW8YXJL7m+Z32X37FYRa80X31wpl3IsZqIuqtDfxofWpJIna3p/BsXgcz2Ohl5gT7055G6JA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=m7J2BDw0; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIGRpdu015686;
	Wed, 18 Dec 2024 09:07:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=1VvR6M/hEp4KT4rZKNwumsncG/5GgdNXKCbjnegFX6E=; b=
	m7J2BDw0VmH49dTOat7ch0apSkIsKSUuMd/QVaT0Lxn9aGoBodLwxix7CvmGANOb
	hjksRmSsU7VncbTLM6z6mkQH2oysfjW8wZpqRkKNMSvGaV/oojolW40frBPWucRJ
	FH3Y2N/wf2H6x0NaAZDRhvwi4064K6JSQlP0Rv6Pj3TvbWhge3tBvSwfTqxFR/xC
	3dYnEXnuPaLSrpUO7M4SL5eb3sbCZ/4s1oJZC/N3wY9xtEWEi3p3Tupn0+PCWYWA
	1M0qmd3UmIVBf8AJDc5DtdbXGptogOniUyPfnyg8suWla29xIFM3oP7rRwJOia5N
	06a7R8jnBgRia1EsnQuBHA==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2041.outbound.protection.outlook.com [104.47.58.41])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 43m0fngxmv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 09:07:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kaUHLh5XDqgbHe+SpD3jzK0ygLPqe8yuPqX4jXH5S32bWazNWsQddMh5r06zpkLdHf3/VK37/Py5xgRtwWIQa+5onDK3cKvZBsA0SuAHaZZmHXHAJgvgZVdoHeXJn9ljszBQL3xfH8uEpCEpofwR29IbdHXrHIOMTwGB1niw2tjZmN/eNmcNI0dBTTSDOrF+keJJsWdHNKmIYbY1n0VBztchBcOSWsD6VO6bDzMaQsysQGsysqYUsV7kcJv9fqLmx8vKfhQ1D+d/fmYVKhpBTYIDMuVNl/rStTWsAwowRTK58UV+gH/X/ui6/o8f3EieK79oSFEFxpDDdx75Ct6VXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1VvR6M/hEp4KT4rZKNwumsncG/5GgdNXKCbjnegFX6E=;
 b=xw1A5nk2AmxMoBOclh3gcFc/lRbJH7fEGC0zbpjepruOmSfPBbie4eDv7HKhzlwYXOlTikHxsTWPg04EBsdIX9FJGn2nEK0efuVbQMdj4z/WLCUlK9es+aV9XI1t6SxfvQWjwoKCavH0FYQsA4uss2HQ+VpFiBpqf6KfG6xLqXnx7Egby8nHVVuZ97aXDDqBFowGy5p2boixAaymjyQ5Ql5bnc1/IoIQk7R7P6KEySYKSUKjZyx5kiowBpHi92cPiqEGOnAJXFhc0RY9gVsGSc9N3fGQgwAcWybBtZvJ2QMj35MmcOGcepP1Srfe7W8PJ6zhEGgC33yw2QW69i9abw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SJ0PR15MB4568.namprd15.prod.outlook.com (2603:10b6:a03:379::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 17:07:01 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%7]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 17:07:01 +0000
From: Song Liu <songliubraving@meta.com>
To: Mimi Zohar <zohar@linux.ibm.com>
CC: Casey Schaufler <casey@schaufler-ca.com>, Song Liu <song@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "roberto.sassu@huawei.com"
	<roberto.sassu@huawei.com>,
        "dmitry.kasatkin@gmail.com"
	<dmitry.kasatkin@gmail.com>,
        "eric.snowberg@oracle.com"
	<eric.snowberg@oracle.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com"
	<serge@hallyn.com>,
        Kernel Team <kernel-team@meta.com>,
        "brauner@kernel.org"
	<brauner@kernel.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: [RFC 0/2] ima: evm: Add kernel cmdline options to disable IMA/EVM
Thread-Topic: [RFC 0/2] ima: evm: Add kernel cmdline options to disable
 IMA/EVM
Thread-Index: AQHbUMHZ/pEEoDutDkiUOsUV91UKILLq8+2AgADjVoCAAGWuAA==
Date: Wed, 18 Dec 2024 17:07:01 +0000
Message-ID: <C01F96FE-0E0F-46B1-A50C-42E83543B9E1@fb.com>
References: <20241217202525.1802109-1-song@kernel.org>
 <fc60313a-67b3-4889-b1a6-ba2673b1a67d@schaufler-ca.com>
 <bd5a5029302bc05c2fbe3ee716abb644c568da48.camel@linux.ibm.com>
In-Reply-To: <bd5a5029302bc05c2fbe3ee716abb644c568da48.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.200.121)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|SJ0PR15MB4568:EE_
x-ms-office365-filtering-correlation-id: 647732ef-0ad1-48b0-966b-08dd1f866376
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WlJvemJZVE1zeWNaRGs0d2dxSmdZaWVZRHd4bjRrQWhkM2N1WGpsZW1UaThn?=
 =?utf-8?B?d2tKU1V1YzVhZkowajRvR3EwOUNkeERkUUtCcm1CcUlHUncwNDJpWnAwQk9K?=
 =?utf-8?B?ZDB1eksxYXhoZ0YybzluN3o0SWFLb3FaWDQ1eGJIMFU5Y1J2dnZ1L3I2Uk5j?=
 =?utf-8?B?V0dEMzFaYWUyaUFYT0R5WjY1ZjBRRjUyZGtnSEdVcSs2MlRMYzdWWjdxcnVB?=
 =?utf-8?B?WDBRUUFXMkVDV0tvaENpN2NHYlNJSkhFWFpFQUFWQUtjWVl6YVVxdGh3TEU2?=
 =?utf-8?B?VkpWL1pNaTF0WlFHTDZmbVlxdlJzRW9rZkNEUC8zbG4xbXFxOGpUQjY1RWpD?=
 =?utf-8?B?Uy9Ra1JaR2pBcTYzQ3JZamZ6eENNa3RWOGlvZ21LSTc3RS93QjRHbXdSUXUy?=
 =?utf-8?B?bkcvQ0RydkFYdVRYeXhlVG1pVmlZMVYvNUNEUnV1cktuVXRFN3lMUU9FVXFI?=
 =?utf-8?B?R3l1cTdQaWV1TjVLWGlVN001Yzd3amJ1bVZ3TjJzZGFIeUhVV3VveStKaTl5?=
 =?utf-8?B?aXRXWFlrc3hVSzVId2dVeW1wZm1vTEcreEJNejBISHVNcGlqLzk3VEtTOUpE?=
 =?utf-8?B?WHp4MUY2YWpXaENOWmNhR0VXZFhLYU0wWG9UVjVqSzlkd2VNR3pycWNENjVP?=
 =?utf-8?B?Y0ZVdzVHand5aUNmdVFJNndwTmNLcTZ2UldDTldLK2lZb08xUFJuZkU1Z3ZR?=
 =?utf-8?B?K0QxS3ZGcFdQZ05abUtlNlZLQkV6N1Q4eGFzcEZIMWN5b1BUVWZlbVNvR1Qv?=
 =?utf-8?B?V28yT2ZxQTlkWmZDVGhpQVpXeHVNTThzOHFuSTJDa2JnNDcwbmw2Q29oVUFq?=
 =?utf-8?B?Yy9YU3puQ1UzTFlLcm5NT3BYRFRSUlZTSnlYeVlKdzFBOFEzUm85QUdxQ1I4?=
 =?utf-8?B?SVFQdGlGZDNQRzNDL0pMaVN3OEVQYlhkeTY1cGprYi8zcXYvSDZiMjQrczZU?=
 =?utf-8?B?bkU4RFdoNmdiN0JLdXg5Q0xidUg4d1luM2VlWURrVzEyU2dIMDduQ3JNV3R1?=
 =?utf-8?B?RDJXeDhsMm14ZmE3SFRJZXVPYlBNRXIwL2w3dCsxQzUzRlBwWEJkTytwdDNw?=
 =?utf-8?B?NTk5M25VREE0djdHZWkyUnVFeVpUWnQyUkNwT1ZzaG9mZ2kwZDR1emZHQkZJ?=
 =?utf-8?B?WmNNWitEamNmcDdYbi9oNG8zVEJGek5TaUpEalQwRUZTRG1xbzBWbFlzeUpF?=
 =?utf-8?B?R0lrRmpLc09KeEVJQzV2TVVlQ0M1czd4a3puRzl3M0hGa1M5b2p5UWdFUEtE?=
 =?utf-8?B?MFdyMkRiWW5uTWhIRXpRSXFPdXk3NHhlcnpUNmhSK3NBU0t2K1lXMW1mWEV0?=
 =?utf-8?B?OW9RRTg0Rml3SDZvZ1NPNmlZZUJTT3hOZ1RGR1ZTeWZ2S3pLd01vSmZpYUNS?=
 =?utf-8?B?c0FYUDV2OHBzU0VoUGdKZENNSFE0eXVjamJubGRBYWhLa01CNWwweXk3d0Yr?=
 =?utf-8?B?enUwSW0zb2FoSnFuRHBVY0tnWWdLaFlJWjcvZldkbUorMUpTSEJTZDFLRGI3?=
 =?utf-8?B?TzdHLytvNHgzSS9QRVNvUHJPd2VTZ05zaTVxdXJEYW1NbVd4c3VsTDQrcUhv?=
 =?utf-8?B?dVY5NUxrNWVrYXRlMDhLOG5Ic3M3cGFoQ0hlTFlvSDhxNkdETWNSclF5eWNP?=
 =?utf-8?B?R2YxNkZYLzQ4aDdZcnVIRTYwN2xhaFhtMzk3dnhCV0tTL0M1TnduRXltNjcr?=
 =?utf-8?B?d2Zlb05BMGx2UzFOYzBGaS9GUFBaUGR2clRJUzk1ekZkS2hUc3dhV2t0YzZH?=
 =?utf-8?B?NnNuczY0RXJvYkdXK3J5bXlpaFg3TkZaeEhTUTQrb0IzWU5wQVc2bFo3QUhS?=
 =?utf-8?B?UVBMM2p0NmdtWDZ5SmNzS1VzV3RBSDNZNGlCbnlDT3BqcndJWW1ZN2tveDhL?=
 =?utf-8?B?emZ2bjFBNk1VM1ZJZUlCRi83aGoyK2UyTnRybk1mVWdNWXlJYlBFNXg4d3Fq?=
 =?utf-8?Q?oi9fCh/+iwZFnVjpCJ4+YNjaQXfIfl8O?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?LyswMHhTSU9sdm9LSDJPYm9TNTA4SXlkb2NkVHZVRjZPeVBSa3k4ODJhQUZP?=
 =?utf-8?B?Qm9NMGd0UGVNOWhmRVFYSlUvMm9Velc4Q1BJSlVTWC9FVzV5RWJETEdwUUlJ?=
 =?utf-8?B?L01KN0E2Q2o5SEtDU05EK0RkZlQ0Qnd0eVZ0T3hYMURvcHBIaWUrTVo0dnZQ?=
 =?utf-8?B?a2MwRnBPdFZldi9iZ1RYdGVBMU5qSzlNNjYwbjI2dTZzOGk3bGhnQU9yb1Ux?=
 =?utf-8?B?Wk14bitnSDFacEZXWmNwU0JseXhRYTA1NmF6UG9BNlZSZW1RYmxNRFJsWWhF?=
 =?utf-8?B?c1hxUDRDKy83YjdGbXJLME16ODYrOGJjWFNUZlJSYTl2Ujg0ZkdXSndjLzFY?=
 =?utf-8?B?aGpBRXhNdkM5QXNvTUpHeWUwWkc0YzYxcGMvbERNM1FnRlo3S05zR0hxdG0z?=
 =?utf-8?B?RGZYMTJ2R1pQRUM4aUVNL01tNlF5UW5rQ25senRQTXFyTzVTT2RVRDIvUkU0?=
 =?utf-8?B?bWNmNHZ4T3l4SWFIbUJIWFg5UXJYQ2UzQTM5TCtUV2dlR3dTWHBlT0NaWmJE?=
 =?utf-8?B?NVFsNXVSaUU2MVZxN0lrdVRWWVRpUHdEa0t6ZzV2a0toRlBPek9oZUVQbGpp?=
 =?utf-8?B?a1MyYWx2WDFZYTlFTDhRaWx6YUVjUWU4TmgvbnNkRi9ONWViQk95R0tDbit4?=
 =?utf-8?B?VTdyb2UyZy9XT2pmZzcwNi8xZ0p0SVgzQkdDQkpiWHlmK0FiVmNZaDZLclZn?=
 =?utf-8?B?b0VZbW5tM211M0dFb0tCRk54b2wyNGR3K2taRG1nUjFGWVY4MzlTcDlIRncz?=
 =?utf-8?B?TTNJNm5zNC9RTEtpQStrMW5JbVo2L1Brb2tUejBmaWRCRnFHeUIwR050a0pw?=
 =?utf-8?B?aDcvQTZzckltRCsxb09LUDdsMGlRVW9XUjRXV0hZOFN5d0RCeTJCN0p0aVpM?=
 =?utf-8?B?Zy9KTEg0Zm1HWTNqUUc5Y2o4UVdrUmRoSmQrd0VqVFR2bTVxY2RCMWlyYmZT?=
 =?utf-8?B?ZUMxNEtjUU5HTktzSXg0Q2RhRTQ3Rmpjb29oVHVFU0N4NTNHTTl2b0NIb09u?=
 =?utf-8?B?WE5uclVPUVJjZmFzaE9iZ3pDTFlrRlFlbDRtR3Z4L05YeStSN1ZkeXZQRkxL?=
 =?utf-8?B?VjFBeVkwUWZDNXZXdlhhdFRrOExzbVJDa2dRQjRZbldmS0ErU21DNVUvczhQ?=
 =?utf-8?B?QUlzNXNjbzhvQnJGZE1RVVhiNDBqT1JuYVVWZjJSMkllY1ZUMnJ5RnFjS1Av?=
 =?utf-8?B?SlFXWFIxWGpvR09ud0ZWTjZZN0NwejVnYXhCSncrb2ZDSTVtM2p0RUsxVlJh?=
 =?utf-8?B?UlppV0c5ellXS09Ycmo3aUpHeUZtRDRla2JVZGdwSWxUMXZ6ZHVvMkZNUGVq?=
 =?utf-8?B?WkFOQWN4cE9qSHExNzRYa0NsaG5FdEU5Y25xMzNIS2lGaVZHOUdqWWtEeG9G?=
 =?utf-8?B?OVl6VzZrL0R3UEtyekFaTHNjeEs0S2x0eGR0ZlpuRi9uQklFTTlzcjY1Tk0z?=
 =?utf-8?B?SGRscmhFQ3k2M2hkTlFmYW9ESGdBNUxwRTR6ZTVtNXk1bUIrK05jSjFLdmdF?=
 =?utf-8?B?K0N6TDZhaTNSNytNTW1VR0R1MFMrSjh5TWpDN1MwK05OaDk3Y1ZCVkpTVzNz?=
 =?utf-8?B?T1ZYTFVMaEVJa2s2ZUl5SFkvU1hDYitxcFVOTUM4MW5BU1lyWjJSSkFDZjRU?=
 =?utf-8?B?VXNibFQ3aldhVEpEbzdnY25KVzREd2lQMGwzL0w5QW1kWTVNQlZvdlVMcU1H?=
 =?utf-8?B?T1E1b3I3dHdFUTdSMUxJcmZMYXdtL3l5RnQ1NFIxQ012aWI1OWw3UUhjVWZa?=
 =?utf-8?B?YzZSbGJGRkgrUTJrQm90ZWh3T2NzV3lSVCtweW9pdlZyRytsdHo4QWJjTEI0?=
 =?utf-8?B?Nk12YVYwVmRsN3Z2cUEzZTZXeDJkaTFpNnppTW5hQm0vb0ZsMExaK0dVSjA0?=
 =?utf-8?B?enNtVmpwdjJNRHZKQXJsS3VHYVg2YjIxMnBDdWFmZWRpK2MxNHZlL0hpOW5L?=
 =?utf-8?B?MU9DU05tOFdNb01CWkV6bmdkZ1NjY1I2REFjU3VQRmlMa21GYXJSMUpHR3Fq?=
 =?utf-8?B?N0RNbDBLQXlHS0wyWjFQSXBTK3VONzNQSThyUlc2UGZyb204NGtaVnk3ODg4?=
 =?utf-8?B?RXFKREJ5NlltUFdjaDlnT2s3dUhLZ1JnS1VvK1ZUS0tlZERpTnMyME1OZzVL?=
 =?utf-8?B?djVqRmkyaDBsQWlURFpnTTl2a3J4N2hjVDRMTHhBYmFpYjl3bEpiQmJLV3F0?=
 =?utf-8?Q?BxUlZkJ0mYt42yL3fAzvzGw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0CFA64A33FA7B45AFBBAC6CB3BB4DC6@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 647732ef-0ad1-48b0-966b-08dd1f866376
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 17:07:01.0913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rWggKPJatskIXrh6jKJ36/gan4UTWItUtuH1oHPKpv1Buc1K27ZnSK2yLaJzGAYXIvXKNI3Hapk5dp042bsRFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4568
X-Proofpoint-GUID: mja_yYFgSsRP-Ac6XjXmzgJwZdo_hqBG
X-Proofpoint-ORIG-GUID: mja_yYFgSsRP-Ac6XjXmzgJwZdo_hqBG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

SGkgTWltaSwgDQoNClRoYW5rcyBmb3IgeW91ciBjb21tZW50cyENCg0KPiBPbiBEZWMgMTgsIDIw
MjQsIGF0IDM6MDLigK9BTSwgTWltaSBab2hhciA8em9oYXJAbGludXguaWJtLmNvbT4gd3JvdGU6
DQo+IA0KPiBPbiBUdWUsIDIwMjQtMTItMTcgYXQgMTM6MjkgLTA4MDAsIENhc2V5IFNjaGF1Zmxl
ciB3cm90ZToNCj4+IE9uIDEyLzE3LzIwMjQgMTI6MjUgUE0sIFNvbmcgTGl1IHdyb3RlOg0KPj4+
IFdoaWxlIHJlYWRpbmcgYW5kIHRlc3RpbmcgTFNNIGNvZGUsIEkgZm91bmQgSU1BL0VWTSBjb25z
dW1lIHBlciBpbm9kZQ0KPj4+IHN0b3JhZ2UgZXZlbiB3aGVuIHRoZXkgYXJlIG5vdCBpbiB1c2Uu
IEFkZCBvcHRpb25zIHRvIGRpYWJsZSB0aGVtIGluDQo+Pj4ga2VybmVsIGNvbW1hbmQgbGluZS4g
VGhlIGxvZ2ljIGFuZCBzeW50YXggaXMgbW9zdGx5IGJvcnJvd2VkIGZyb20gYW4NCj4+PiBvbGQg
c2VyaW91cyBbMV0uDQo+PiANCj4+IFdoeSBub3Qgb21pdCBpbWEgYW5kIGV2bSBmcm9tIHRoZSBs
c209IHBhcmFtZXRlcj8NCj4gDQo+IENhc2V5LCBQYXVsLCBhbHdheXMgZW5hYmxpbmcgSU1BICYg
RVZNIGFzIHRoZSBsYXN0IExTTXMsIGlmIGNvbmZpZ3VyZWQsIHdlcmUgdGhlDQo+IGNvbmRpdGlv
bnMgZm9yIG1ha2luZyBJTUEgYW5kIEVWTSBMU01zLiAgVXAgdG8gdGhhdCBwb2ludCwgb25seSB3
aGVuIGFuIGlub2RlDQo+IHdhcyBpbiBwb2xpY3kgZGlkIGl0IGNvbnN1bWUgYW55IG1lbW9yeSAo
cmJ0cmVlKS4gIEknbSBwcmV0dHkgc3VyZSB5b3UgcmVtZW1iZXINCj4gdGhlIHJhdGhlciBoZWF0
ZWQgZGlzY3Vzc2lvbihzKS4NCg0KSSBkaWRuJ3Qga25vdyBhYm91dCB0aGlzIGhpc3RvcnkgdW50
aWwgdG9kYXkuIEkgYXBvbG9naXplIGlmIHRoaXMgDQpSRkMvUEFUQ0ggaXMgbW92aW5nIHRvIHRo
ZSBkaXJlY3Rpb24gYWdhaW5zdCB0aGUgb3JpZ2luYWwgYWdyZWVtZW50LiANCkkgZGlkbid0IG1l
YW4gdG8gYnJlYWsgYW55IGFncmVlbWVudC4gDQoNCk15IG1vdGl2YXRpb24gaXMgYWN0dWFsbHkg
dGhlIHBlciBpbm9kZSBtZW1vcnkgY29uc3VtcHRpb24gb2YgSU1BIA0KYW5kIEVWTS4gT25jZSBl
bmFibGVkLCBFVk0gYXBwZW5kcyBhIHdob2xlIHN0cnVjdCBldm1faWludF9jYWNoZSB0byANCmVh
Y2ggaW5vZGUgdmlhIGlfc2VjdXJpdHkuIElNQSBpcyBiZXR0ZXIgb24gbWVtb3J5IGNvbnN1bXB0
aW9uLCBhcyANCml0IG9ubHkgYWRkcyBhIHBvaW50ZXIgdG8gaV9zZWN1cml0eS4gDQoNCkl0IGFw
cGVhcnMgdG8gbWUgdGhhdCBhIHdheSB0byBkaXNhYmxlIElNQSBhbmQgRVZNIGF0IGJvb3QgdGlt
ZSBjYW4gDQpiZSB1c2VmdWwsIGVzcGVjaWFsbHkgZm9yIGRpc3RybyBrZXJuZWxzLiBCdXQgSSBn
dWVzcyB0aGVyZSBhcmUgDQpyZWFzb25zIHRvIG5vdCBhbGxvdyB0aGlzICh0aHVzIHRoZSBlYXJs
aWVyIGFncmVlbWVudCkuIENvdWxkIHlvdSANCnBsZWFzZSBzaGFyZSB5b3VyIHRob3VnaHRzIG9u
IHRoaXM/DQoNClRoYW5rcywNClNvbmcNCg0K


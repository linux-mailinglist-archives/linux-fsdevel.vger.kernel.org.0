Return-Path: <linux-fsdevel+bounces-52243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AD3AE0A91
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 17:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6993318916B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 15:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000CA236437;
	Thu, 19 Jun 2025 15:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="CrhMadty"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A20812EBE7;
	Thu, 19 Jun 2025 15:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750347100; cv=fail; b=KgStJdlW4YZKqa9tKRqsT+u8KzVJ6lMkyEGvDHcB5cBbJA8xly4MIazjblL4bL2XXhq8dc2s1vnuQkq8+KlgyWJ3WStlamjvMmUXN4W4Rach6owOO5IGVPTBHL6Tf4QhqEcA2S12VIeg/WtGe0FuOz/uPZ62RhTqcJXdUxCCy4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750347100; c=relaxed/simple;
	bh=yFWno1N2IBuaTUM6PhrFabRaipKMCxEomBthN33pTgY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UNUadVNgxEzDgk9IMWln8Za1AbUz8ud5lOmVq9aZrxbVUaI+aL3UYDHaP59fLFc6wgdB3oDAwVtlG654L01jBxSwmOU5r08BycE4g4ZczB/7ONbt1Ewy4gvj7fm5i/lFQKal9b0sLbZmaHvlzlz8iA6fn9FrGfMQzSOcFWBgVX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=CrhMadty; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55JA4nEU012099;
	Thu, 19 Jun 2025 08:31:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=yFWno1N2IBuaTUM6PhrFabRaipKMCxEomBthN33pTgY=; b=
	CrhMadty3CxafNPlY+9nrHc5PRtogDLO8CQovNGWr37Ob3pG6/zT+8FI2HXoYOJd
	VZhJUcXpghpUtH3xDMUrqp+iYCX8yYNOosvZyolcTaOWVY6G/8sUOyPFPtl2eYpl
	XZabIR5DToTRPBTumckPLfB+B9z1pKoRDtvWzdgVaD1Jv8h6rMDkYozRTzJhxWZz
	FTr3fmQy582SD15txOFc4o/ephvshvGRlXocGkRsVtpO5Ljm2MZCSBzeSQkidt2I
	OsMa0VUWB/ORsaWh2CY6Ew+Nw7Jqb52Bq4Mx23EQQQjgxkh170oXLMqjqyFLpfHO
	Q7fvvdPbEd9Zn3K7zMyLvA==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47bq0wbygd-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Jun 2025 08:31:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B7xdlhlndWn25QXfm/7LxWMaOAzJfY2K0OjDIYxUPmnD0vTCjGHpAi3rGk1CxxJDhXuSwKWuPHvmgEYpUDpP/5MIru5dOAF/iUUarxigeoDr3E4ChCI4iodzIoKpKwNUIZHmMaTGKYGV7g/0bq1TKX0On/3NHbnHdOg5laaCZW25dbitMWBz7kK4ORw7Rj5ehNfLkxIjYI2SzGPzALTFzhS8El1v+5Xwcet4mg8HcE80FCQ/dxfCrdce5d8kz9nOaW0g2P5BAzRVNAfr/FZUn8dp64N4n6P+pPfsqx6OTi5y2qI0NU0z/S+lDk8mK5NMn2IUF0BO4xI0JDYks62Plg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFWno1N2IBuaTUM6PhrFabRaipKMCxEomBthN33pTgY=;
 b=g/CBwepN6eCZ3RsPAtTJKekKk+QTO8/uJ1Cv75o3b9dr50wsG52+be5SKnw8fJlnTpKtXZynPiW5zFLGG3skEx+5V5CJoAtDgITduX0xlgPNmOe43DIsnWdfp8/iSQFRs8iqayv37uefKPxSeKh4p+aGmkUOppbEnE5rtAROkSylceA3oy062g7tQzR45T8lGyT8ojNMDG4dQRrA+qcFtMdwb5tqWbrPNbaj48vAQDyh7Mc8HdkHlofVKvDtq6w82w6jMd/wMSP5I4dZ0y0OgdOdBeNFOcd2ZFz5T8OWMplN04ZJL1JMGmjwrXYeLVnuc22gjbmRyY+2O7DBDyxDSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SJ0PR15MB5248.namprd15.prod.outlook.com (2603:10b6:a03:42c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Thu, 19 Jun
 2025 15:31:32 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%6]) with mapi id 15.20.8857.019; Thu, 19 Jun 2025
 15:31:32 +0000
From: Song Liu <songliubraving@meta.com>
To: Christian Brauner <brauner@kernel.org>
CC: Tejun Heo <tj@kernel.org>, Song Liu <song@kernel.org>,
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
        "amir73il@gmail.com"
	<amir73il@gmail.com>,
        "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>,
        "daan.j.demeyer@gmail.com"
	<daan.j.demeyer@gmail.com>
Subject: Re: [PATCH bpf-next 0/4] Introduce bpf_kernfs_read_xattr
Thread-Topic: [PATCH bpf-next 0/4] Introduce bpf_kernfs_read_xattr
Thread-Index: AQHb4KoC8KtJD+px0E+VXWkQ3FQBubQJpQsAgACHaYCAAHCigA==
Date: Thu, 19 Jun 2025 15:31:32 +0000
Message-ID: <4B2C62F3-FF40-4227-A06B-AE575F889D19@meta.com>
References: <20250618233739.189106-1-song@kernel.org>
 <aFNdNv4Bvw6MwlaH@slm.duckdns.org>
 <20250619-zwirn-thunfisch-de6e4891a453@brauner>
In-Reply-To: <20250619-zwirn-thunfisch-de6e4891a453@brauner>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.600.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|SJ0PR15MB5248:EE_
x-ms-office365-filtering-correlation-id: 8d0924e8-0e27-49e2-83ac-08ddaf465e81
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?N0FhNGYrZXIyeUpkWVlaY0FHTHEwb0VMRmtJaWRFSkRSczF3YldhUkRSVjVF?=
 =?utf-8?B?bmFsMldrbkp0dTRoT3l0b242NXVZcmRqemJRSXFtZjBHdWJRVlpxcDFhREt4?=
 =?utf-8?B?QnRCVUQ1eXNoUlZGY3hTblUwMjZhRklrY0ZqMkhZWVBKU2I1R1pGaVBRYWQ1?=
 =?utf-8?B?dmdCNFA0dVlmUHhRdHFwY2IzZ2hxMVhOMEZlRHNmK0VGL2thTm43QXZ0RnZo?=
 =?utf-8?B?YnpEakhsTjRxajZWdWFoWUdaTGs4RW5ZRlRSVlVtbTRib1FpbVNET2d2RTd3?=
 =?utf-8?B?VDJSKzlZWWZwT2ZJNDE4eWNmcVErRXpLbXl6ckNaQ2RRR1lpcFlnT3FkV3dO?=
 =?utf-8?B?V3pIRzN6UXAyZXE5N0VXUzR3b0V0ckpHSy9DN01uSmYyVzBCVW56WmhheGZB?=
 =?utf-8?B?NGVUWDB3WHNONXdUN1JoZEVZbVFhenpwUGc4dy81Q2crV2k1UkdKUUdLZVhW?=
 =?utf-8?B?OUc5ZjlwZ1lqTU9xQW9NMVQrWDlhcUJNVjRweDdHTEJJZHJBVzg4VXorSjlz?=
 =?utf-8?B?cFJBaTJPMGo4MVMvWlFMM095NmQxUVJtMXJ0LzNsY3BxeFAxcWdOWlcreEhT?=
 =?utf-8?B?MVdLbmVCWm14TmZyQnZPSmFuemc0RDhkbEFqNnJMMFYwMDc5ZFJLeHVURTJr?=
 =?utf-8?B?bkEybjJENFJON0dEekF4ZVlLMXBJY28zT0Z6ejRZRWx2RFk1VFY4cTh6WnZF?=
 =?utf-8?B?NWtBdWZPdjJTMlBmKzdyVlBmTndEUDMwa0EyMG9Oa2QwVEgxTk9oRWd1cWUz?=
 =?utf-8?B?VXMwalg0THdmVmUxYkRWTy9sM2RFUlhvWHdFMEE4enowMWZGNjFEY0IxSUFX?=
 =?utf-8?B?dWxPNlQ0Yk1ZeStucTBzZ1hxZHdVRUJQTVBnVlVTQys4djI4THdFNzZ5NkY2?=
 =?utf-8?B?T0Z2b1ZTVjdBdHVIVlIzZUkzZUsvblIzb2crdFhjaGxwOGZFTDROcDZCWDd4?=
 =?utf-8?B?bEo2Q1NBUFNhSmwxaWJHUmsvZjRZdU5kbDByeGMybDVOT3EwbUxSMGxTSk83?=
 =?utf-8?B?dGU0YjFhbUF2TEp0bG04RTdQbk45Q3liN0VwNkw0dTFodFVOV0J2NzhoVGN4?=
 =?utf-8?B?c0dodEZHV3lRUExCN0hLaFdpRDBMVDJsOURCNW8wYzc4WFRDN1lzVDFpTmIr?=
 =?utf-8?B?SzZiK2NSYW9tbU9Nb3RDaXlXRkVTZ2U0ZFdJM1NScGQ3ZzRRdmxHelJmd0lN?=
 =?utf-8?B?dUQremFVRXowcGxYdjQxU0ZuM3huZDllaTBwR042ZFhhWHZMTGpTc1dVVE9P?=
 =?utf-8?B?SFk3TVYzYjRQVDdCL2M2QTlDdEdPalA5NkdyV2FZTWUzL21Feld1TmQvYUZD?=
 =?utf-8?B?SXJHTi80d0UybWFNM3N2U0ZUY2Y0Q2RCZjRsL0VoQzZjdmlZei8wQlFxejRC?=
 =?utf-8?B?T1gyOTNJdGRkTWErR0ZLOXJiZVpGelFRNHBBTTVLNnRNQnVJcS9QUlpIZGwz?=
 =?utf-8?B?cnZkNnU1eDc5bmhOOTBJa3FhMmU2ZGhzOHVyR2pKd085c2dTYkZkbmNvaE5F?=
 =?utf-8?B?bXB3Tm84RER2STJ0QVFESFBYT1RxT0lEdjdsODlEbWR1dlpuZ1Rqb25rN1Yw?=
 =?utf-8?B?NmszSnhqaDV3aGZYWERnSEM1SnZ2WHhyM0dnQy9USTNmbklOQ1BjUTl5bWlw?=
 =?utf-8?B?REt5SStoVnpQOGZFVnI5UUVja3dGRkdPMUVqY2sweVZmMjNab0R2b2NZV1dz?=
 =?utf-8?B?eDVCTW5hdy8wb3hReVBzQzhtMEw1eWtJYklSUFVRSElUdGRjTzRaWThuc083?=
 =?utf-8?B?Q25FR3Noc0o3YmREQkJjc3htV2ZkNjhMVlNUSHpSb2FHN2VKYmFVc04wNG5B?=
 =?utf-8?B?ZDhGTGhmb1lTMVpIdDh1REJxb1M0S1JtUjFvNkVpYVNac2lkQ0RUaUxaRFBm?=
 =?utf-8?B?QUJjUEZDV2RuM202dE5FaUx1eVY3eHBBR0xXbjcyOVcybnRoWXBZa1oxV29G?=
 =?utf-8?B?MVVnSStqYWFrUE5GNzY0NzA3VzVzM1AySDZJc0tBaVBPUUJzMURLTVdLejJ2?=
 =?utf-8?Q?w5dqiGOm18UKlzgOf+irg1W3LqDnfo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cXUwSGhlWUp1dFh4a0xOYkhZOGR1ZFVvMlFJMkdFMU03R2F6R0x5LzBqS1pL?=
 =?utf-8?B?MjJqSnN1UnRYRW9JY2VJTzlRcjRXMkk0SHVPd3BWanNjRVdLckdrS1Njempk?=
 =?utf-8?B?R3NBMktzM0RRSkJ3WDlhVXlxTTFvbXJ4eWJPTlBWK29HNyt2YVVoT2RQT2lp?=
 =?utf-8?B?cU5zZGg4VWN6OXFxRUFkWEJSeTQ2aVJKOGp1Y2NRQlhIcDBoSDQwNzNISjdI?=
 =?utf-8?B?ZkNub3VnNW9KRndLS0ZzMUV4bDNGbkpZSGVYRzlFdWU2UlBNUmNaWlMyNDhT?=
 =?utf-8?B?aUJsMGJWdy9DZ25GeUNrYlNrZTVjYmpvWWEvNWVCQWVBcFpHMlNXb0h1d1hR?=
 =?utf-8?B?dTBuWCtyaERuMDdqSVpCT1p2RGsyL2V3NmJsSlNzWUJucjlnQjF0WGJZSmNz?=
 =?utf-8?B?MDEzNDg0S3dQWWRLZ3hiVUJaOHdoaWwvSlk3QlU4Yy9sM00zd3hrQ203SU1q?=
 =?utf-8?B?SEVLSC91TnBWcmdzdi9uc2s0Z1c3RGppYkNYTEF6M1JLTkd3UDlyb1R2ZHlB?=
 =?utf-8?B?cHk3OWN0dXpVRUlyeEJGUG5SRy9UQnBxT2hiVDhUaVNaNS9hK0ZwODRLb3dq?=
 =?utf-8?B?RTlZQ08vV0s5RDhMZGFGWjFQdFRpNTl0ejh0VXdoKzhMQlhmMHkyVFN5OUR4?=
 =?utf-8?B?QWg3aStnQ0ZkNTFhRjBIbjRvb0UxRTM1c2FpV0dyU1JZWHB5MUdjN2JOcGV5?=
 =?utf-8?B?NFFIZWRiMFQyRlh2cUh6aTdVbTZqb1pFeit5T0p2ZEFXSFVxL216YUpRTlJT?=
 =?utf-8?B?bmEzb3dKZ0xIWmZMaFVpVkJySFhaL1BVZkllSWdyampGNEx4S2RQMDZxVVAy?=
 =?utf-8?B?N0JzL0d4NC9TQ0VNNGk2V3ZvN2NHYVk3R3hkQzNEVDhJd3pBZm1wKzZ1ZVhX?=
 =?utf-8?B?VWVRVTBNS2pWVUMzUVErU1M5aVVQSU9JU294azhTS1hZUnVkaDlsZXp4cFht?=
 =?utf-8?B?K29BWk1uZnEvN1BlMXhXUzJHRDlaZDN1Y05iMVQyZGRsNzNKell4aWUrYTcy?=
 =?utf-8?B?bjFXSEVXTGhwVTUrQnVvV2QxU1NIUG1QNlRYL0ZhZm92dHR6TStHcGxGTmdx?=
 =?utf-8?B?MUNFTElMSGZoU2NUVWtHaXM2Q0s2OG5ST05xdm5UYnQ5SXFRd0kwb0lpT21W?=
 =?utf-8?B?NDhmemJkc0JaazloejV2NWJrNTZWaU42ZWxtNDl3NmNmZXhjZ0xCYU1uR2JP?=
 =?utf-8?B?Nnh4Z2RzZlJuMERQQWhXaXVZY1Ywa3U0NGE3OVdqOURyczdXQmhmNU52TTE0?=
 =?utf-8?B?c2tFcWtoOTYzd1dQSDVCR1JJZ3gvMDVGWE8rUFZoYlR0SWIyWGpuVVV5am51?=
 =?utf-8?B?YkM2emlpZHcyNzM1aWxKOGttcWI1TkZGM3gxTWJKK2htMTQ4R2d5TmVHQzVO?=
 =?utf-8?B?MHNDQm1tUnBUMGxGalBIdkUxT3JSVG80TEpONEh3dkhNUkp2SzBSWnNOTTQ0?=
 =?utf-8?B?VnZVVFhSVTZ4Z3dRZ3IxcFpDblI2bDVEWjlQSTVIUE10V1g1WnMxNDdyTXhn?=
 =?utf-8?B?SjV1aUFJeEpLNzY1YkFiUHhCVFhSRWxBaDR2MUxBMG9UK01KbFZ0aGVDODBP?=
 =?utf-8?B?bmJKb0VPMTdrc2syaFp4VHU0YWV3NCt3RFczbzhyQWkyVThNNHJzdnpwdTNS?=
 =?utf-8?B?VzFENUJXbU0yQUVjeTlpcHN0c211aXd1Vkl2WjhMcHVxeDczQXN4K3hsQU1p?=
 =?utf-8?B?MnYxU0t6QjBxeUV4cGN5dVFVWUpwb2lHWkk4azFVcFN4b2ZuMGd6R0R1SDZw?=
 =?utf-8?B?ZTFhN3VpU2VOTTdqVDRqRW9vemZ0eVE0RWRJMElSSGUrYWtmL3ZtZTVpN3kv?=
 =?utf-8?B?N1hvdUw4dWlZaEExM3c5aWViNmNUUGg3UUF0TlpBb3o0VGZmb0tXVk10RnF2?=
 =?utf-8?B?TWc0MzZ5NE9FTmF2ZEZlZE5ndHE0d29wRzVmT0dleVdUZ0lwckRyOU5UY3Az?=
 =?utf-8?B?M05WcFJndWJJVEhaM2trOHUrVG5nWG0rSWROUjRnZFpMZ29YcG0wclJCTGsz?=
 =?utf-8?B?MzlMazlQNE4ySXJoUU54MlpTM3ViV2NoMnRmM0hBNGRPUVRPWUxJeUhLcmhz?=
 =?utf-8?B?VXlZSGlZOUxCRHQ2ZEtYbG13YnBXQVFqM3hmTUdJeEc3ejRqSmdVN3lodkxl?=
 =?utf-8?B?WmFHbzl5NE1xQmt3RFU2dUp6d0lVcE5PcmpxQXUvQ2lsK1lNMHNTMU9kZjZL?=
 =?utf-8?B?MWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7F372F0FA38444BAC6EF70D67BF7796@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d0924e8-0e27-49e2-83ac-08ddaf465e81
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2025 15:31:32.4236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rZZ+IV7DP8Ev0qAoYZc8XRanor3gYn17F5f8zpjXZ9orzgsO15H7Wh7Xx1yAaQu9ZCd/obc0JcMiPwyMhG3yRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB5248
X-Proofpoint-GUID: tnXvdxp8I63cmM-oUI1GZDw93mNoT0p-
X-Proofpoint-ORIG-GUID: tnXvdxp8I63cmM-oUI1GZDw93mNoT0p-
X-Authority-Analysis: v=2.4 cv=B4y50PtM c=1 sm=1 tr=0 ts=68542d59 cx=c_pps a=9V7jihFXCHj8+gr6vrtDPw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=fsHHmtx0FE9CJ8ZtVzsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDEyOCBTYWx0ZWRfX8d6yl9NRQnD/ 5LynQ/VfZHdNPV81iJULeEM2nF+LDdRcGXYEyEDlLxzWGc8ayJ8I+OnMqnqkyWZ6AKAOcTG46ug aEit/pxGYBzCkXGkb+aR12hV7l/XfXWISYNw+63nY98FP3e0uQt4imgeVM6bNnxIPRoGIFBrWXn
 K9TUg5CPUs6WwrtVAEHYjHkT2krwGQIlkQiknWb2pWfSHFiiZ2q1jCbsYpCFP3hqE8Bg4XFuuao hv0caWurTqM7lU8vraziKubDUtY64VL9xW2mjLZ5SI3qjGLDEyNoxxKd4R+ZplwD91zv5L5mreB PnHEfmjKhXzgfuZcKWuPIHgOriuOQ1nqag4IM42JDUN2ReFT9fVNz19HxiCfyAHTDZZxcWgJqkF
 8C0Zi0lnCQ2/cHfbicV1KBR53ODBP86/YzW1vKVdbslAE+PsnjONlvnOKZe3TLCW2ERwhk1u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_06,2025-06-18_03,2025-03-28_01

DQoNCj4gT24gSnVuIDE5LCAyMDI1LCBhdCAxOjQ44oCvQU0sIENocmlzdGlhbiBCcmF1bmVyIDxi
cmF1bmVyQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gV2VkLCBKdW4gMTgsIDIwMjUgYXQg
MDI6NDM6MzRQTSAtMTAwMCwgVGVqdW4gSGVvIHdyb3RlOg0KPj4gSGVsbG8sDQo+PiANCj4+IE9u
IFdlZCwgSnVuIDE4LCAyMDI1IGF0IDA0OjM3OjM1UE0gLTA3MDAsIFNvbmcgTGl1IHdyb3RlOg0K
Pj4+IEludHJvZHVjZSBhIG5ldyBrZnVuYyBicGZfa2VybmZzX3JlYWRfeGF0dHIsIHdoaWNoIGNh
biByZWFkIHhhdHRyIGZyb20NCj4+PiBrZXJuZnMgbm9kZXMgKGNncm91cGZzLCBmb3IgZXhhbXBs
ZSkuIFRoZSBwcmltYXJ5IHVzZXJzIGFyZSBMU01zLCBmb3INCj4+PiBleGFtcGxlLCBmcm9tIHN5
c3RlbWQuIHNjaGVkX2V4dCBjb3VsZCBhbHNvIHVzZSB4YXR0cnMgb24gY2dyb3VwZnMgbm9kZXMu
DQo+Pj4gSG93ZXZlciwgdGhpcyBpcyBub3QgYWxsb3dlZCB5ZXQsIGJlY2F1c2UgYnBmX2tlcm5m
c19yZWFkX3hhdHRyIGlzIG9ubHkNCj4+PiBhbGxvd2VkIGZyb20gTFNNIGhvb2tzLiBUaGUgcGxh
biBpcyB0byBhZGRyZXNzIHNjaGVkX2V4dCBsYXRlciAob3IgaW4gYQ0KPj4+IGxhdGVyIHJldmlz
aW9uIG9mIHRoaXMgc2V0KS4NCj4+IA0KPj4gSSBkb24ndCB0aGluayBrZXJuZnMgaXMgdGhlIG5h
bWUgd2Ugc2hvdWxkIGJlIGV4cG9zaW5nIHRvIEJQRiB1c2Vycy4gVGhpcyBpcw0KPj4gYW4gaW1w
bGVtZW50YXRpb24gZGV0YWlsIHdoaWNoIG1heSBjaGFuZ2UgaW4gdGhlIGZ1dHVyZS4gSSdkIHJh
dGhlciBtYWtlIGl0DQo+PiBhIGdlbmVyaWMgaW50ZXJmYWNlIG9yIGEgY2dyb3VwIHNwZWNpZmlj
IG9uZS4gVGhlIG5hbWUgImtlcm5mcyIgZG9lc24ndA0KPiANCj4gY2dyb3VwIHNwZWNpZmljLCBw
bGVhc2UuIFRoYXQncyB3aGF0IEkgc3VnZ2VzdGVkIHRvIERhYW4uDQoNCkkgZ3Vlc3MgdGhlcmUg
d2FzIHNvbWUgbWlzdW5kZXJzdGFuZGluZy4gSSB3aWxsIG1ha2UgdGhpcyBjZ3JvdXAgc3BlY2lm
aWMgDQppbiB2Mi4gDQoNClRoYW5rcywNClNvbmcNCg0K


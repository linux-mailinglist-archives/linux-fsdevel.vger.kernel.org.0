Return-Path: <linux-fsdevel+bounces-56442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EAFB175F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 20:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C25AD1C24F15
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 18:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77D123E358;
	Thu, 31 Jul 2025 18:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EmHr3u74"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D78B644;
	Thu, 31 Jul 2025 18:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753985027; cv=fail; b=UsdETCtE/NSdTtNWIG+WDdSaXnX6EPF7F5DER3itRwQ65CRwKURaot5X7KN3l+Ut8TUNi2wD1oncV4usLKS9jBHRHurME6uwYjhphFYCpR0al5gCRpGEew6HlT8rUzQpZJmGTIUpFOCl+qJwTTLAYe+jncvDtuSk/N8L08gnO8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753985027; c=relaxed/simple;
	bh=5Q1ritCsMpPLvpa/dRL9tD2gqWFPA4cY/vd60MuGxNE=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=NNo5MRtxU7YYsibibd3zBezJbe8xZeUAAJeuodvEoFlj7EdEXvTFAuSr2RbQTRGvw8YRPRPZ8dlxHYrzdwdNwMmxWf/LwRH5IsEB/NS7/+pd45BZjgZ2CTWbtp5ah6GaVls51uorzCgMRZvd45erphPxQgOWNy5zCJpsaY4WoUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EmHr3u74; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56VCJe0w002109;
	Thu, 31 Jul 2025 18:03:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=5Q1ritCsMpPLvpa/dRL9tD2gqWFPA4cY/vd60MuGxNE=; b=EmHr3u74
	4hYcflvggXjOESgIh0Rz3MkoJDV3GJdxSgItHFas/szHq8/VxlB+sHi3jrrP7M0p
	WncB4eKKSCGbEwRwBiN2j9aILwelVoDGOsALv9Mba0rbIiRQnU3RC2mjw67D3WNo
	akzPBoZbvWi49z6jzOmFuMgaXQn8fvGli9hs1SGaeLNCWeV4GGAA1VlprR/qIlHV
	aPlGeTROanO165QNNVt9F3okc8T3kS+Rtj+b+7idsToSMWClJHIg1n1VWezg3GM8
	BnMZEyEydxlKlotfUc7RSj8VgYMuF+l/JZotajdZupFQpfP0kKJhbXIUPI1eXazd
	fOGyXGdI/Kwmuw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 486c6j2f2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Jul 2025 18:03:29 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 56VHuZ6O014413;
	Thu, 31 Jul 2025 18:03:28 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 486c6j2f2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Jul 2025 18:03:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4So/2sVb+AVoMOr+2c75sQRLR9xGAAGTL9QceZvyXSXVjJP8IHADkaQmS9h8wsex0S8Lkg1dy00usKKwP7NLyQMObj8h9pBYvKoBIG5KWbozmrNy4voT4zjx/HDTHlrvqejH4z37yefbezCLR2oYoJm0b2YwSPdNW75L6U5FnKBiJ2+L3vckY2GIK5RWe6r9YWiSEF0m6ks+iTSZqSirt69QNeWAhM5qQZ3Zmtg8svPykfDA1jjG2j/sLUO0ly8Nj6e8yDsSKLbQEgbpWSFwAEe+IN/yQYq3KvKzhu3BpQebX5pCZ+NNgdfT/ocaVW99LIw3U40E9yy0OkyP6w/1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Q1ritCsMpPLvpa/dRL9tD2gqWFPA4cY/vd60MuGxNE=;
 b=JwTd0+64Z1MpF5292NH/W0tMQ1Zbh68/TkeWd2B004OKabU2CqF6Z6WkkDz5sgB44KxtN4894PWTqO56H2L8K9vEe3oD2uXq+imlvt5DZTbRctdZGjbf0WhdWXghjh6MUW/MKNc24oK7yqRqMzkI9q6bd+LDqezBFnK/sPNYLt+NywIZXJw6tSJfA+5LvWtnlcyHRFnMcb0qDl0ZTOzH7+4FLE6JIoCb/IO8/gtZozjvYCQYvXQgSiZKjV8zYL6taNWJMvnssjxX9nY9yXewJLNueaMETD8ilRxhBl5iRMUc7rrHVRAX24NAGMW1exJBDmpsJ+WGytC3gHYcKChvYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SJ0PR15MB5821.namprd15.prod.outlook.com (2603:10b6:a03:4e4::8)
 by LV8PR15MB6512.namprd15.prod.outlook.com (2603:10b6:408:1ea::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Thu, 31 Jul
 2025 18:03:23 +0000
Received: from SJ0PR15MB5821.namprd15.prod.outlook.com
 ([fe80::266c:f4fd:cac5:f611]) by SJ0PR15MB5821.namprd15.prod.outlook.com
 ([fe80::266c:f4fd:cac5:f611%4]) with mapi id 15.20.8880.030; Thu, 31 Jul 2025
 18:03:22 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "leocstone@gmail.com" <leocstone@gmail.com>,
        "jack@suse.cz"
	<jack@suse.cz>,
        "penguin-kernel@I-love.SAKURA.ne.jp"
	<penguin-kernel@I-love.SAKURA.ne.jp>,
        "willy@infradead.org"
	<willy@infradead.org>,
        "brauner@kernel.org" <brauner@kernel.org>
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
Thread-Topic: [EXTERNAL] Re: [PATCH v4] hfs: update sanity check of the root
 record
Thread-Index: AQHcAZ226FeYjwYD5E6Yi5amYuG9G7RMh5GA
Date: Thu, 31 Jul 2025 18:03:22 +0000
Message-ID: <f0580422d0d8059b4b5303e56e18700539dda39a.camel@ibm.com>
References: <4c1eb34018cabe33f81b1aa13d5eb0adc44661e7.camel@dubeyko.com>
	 <65009dff-dd9d-4c99-aa53-5e87e2777017@I-love.SAKURA.ne.jp>
	 <e00cff7b-3e87-4522-957f-996cb8ed5b41@I-love.SAKURA.ne.jp>
	 <c99951ae12dc1f5a51b1f6c82bbf7b61b2f12e02.camel@ibm.com>
	 <9a18338da59460bd5c95605d8b10f895a0b7dbb8.camel@ibm.com>
	 <bb8d0438-6db4-4032-ba44-f7b4155d2cef@I-love.SAKURA.ne.jp>
	 <5ef2e2838b0d07d3f05edd2a2a169e7647782de5.camel@ibm.com>
	 <8cb50ca3-8ccc-461e-866c-bb322ef8bfc6@I-love.SAKURA.ne.jp>
	 <d4abeee2-e291-4da4-9e0e-7880a9c213e3@I-love.SAKURA.ne.jp>
	 <650d29da-4f3a-4cfe-b633-ea3b1f27de96@I-love.SAKURA.ne.jp>
	 <6db77f5cb0a35de69a5b6b26719e4ffb3fdac8c5.camel@ibm.com>
	 <1779f2ad-77da-40e3-9ee0-ef6c4cd468fa@I-love.SAKURA.ne.jp>
	 <12de16685af71b513f8027a8bfd14bc0322eb043.camel@ibm.com>
	 <0b9799d4-b938-4843-a863-8e2795d33eca@I-love.SAKURA.ne.jp>
	 <427fcb57-8424-4e52-9f21-7041b2c4ae5b@I-love.SAKURA.ne.jp>
	 <5498a57ea660b5366ef213acd554aba55a5804d1.camel@ibm.com>
	 <57d65c2f-ca35-475d-b950-8fd52b135625@I-love.SAKURA.ne.jp>
In-Reply-To: <57d65c2f-ca35-475d-b950-8fd52b135625@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR15MB5821:EE_|LV8PR15MB6512:EE_
x-ms-office365-filtering-correlation-id: fbf86fed-9094-4eb3-8e61-08ddd05c89e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eldLUElWa0Q3TS9aR1ViU3BPVVdTTHFQQkI5VXJBVFdSNDZDZWJGWG9TaXZ6?=
 =?utf-8?B?Ym1nVjk1Z3JGTlh2TFkrQUs3aHhISml1RDhVOENRS3FZR1UrVmxGcEwwNWo5?=
 =?utf-8?B?S0hXdzNLTDBLYW12UUNGcXZkLzM2bWxJbFVKNnpySmZOQmFSUWNjWWJNS2NV?=
 =?utf-8?B?eXM2eER5ZHFZTmxvT2ljSjJVWVp2TmxkcGE3azBHc0d4K01wYm9XZitLNmdy?=
 =?utf-8?B?eHBNeWQ2b04zekZ5WHJwa0w2ZS9YUHY0NVVPMkwrUHp4MU9OTWxtNC9FQ3l1?=
 =?utf-8?B?eDh4cHo0aXFQdkszR2NHNWgycVZIWlhTaWc3OHhQdHV6d3BoUkNiVUdvcStL?=
 =?utf-8?B?SjNoVjEzQ3VDa1lqOXg5cWZXSWJCWjN3Z0VaVUxvOWxJZTRQWDcvRmoyVlhT?=
 =?utf-8?B?MUxXY2RDYkdtdDRNUlhjWXRaUnlQY0Q4eHFQYnJPcTVGUCs5ODBwSmdXbmtJ?=
 =?utf-8?B?Q1pVYzRoYnJXblhCaGJoT000cXhjQWJmcWpDVzI2UGcyZ01JaEdJMVVSWk9y?=
 =?utf-8?B?dWN5OEJHd0ozVGY5enNqdTFyWFJhOWdaSzArSXBsdHdqbE15QlpSbEJza1NH?=
 =?utf-8?B?dEliZHVTbWYrS2lMOVdVZTJud0RIcVNsVVpnNXFWeVdncHVjU0ZaVEJuRHlI?=
 =?utf-8?B?T1lUMVMxYnhyVTg4RVZROE55ZEl2SFZSVnp6c0JQOHk4K3hoUklWMnpuVWdK?=
 =?utf-8?B?WEl0SzRKSTlmRzUySTNOYW5UZFFTVnlMNXZIL0hOZVVlTjdWREd1NFhoRk5p?=
 =?utf-8?B?aFVxUFA4K0JKTDdXSlpRODFsTlFybmxkNWJSYkNwbVdyS1pVYzU4QkxRd2Zw?=
 =?utf-8?B?T09VOHRwQ1VlRGd4cEZadmxrWERiaHlxb1ZMWjNCZTBoc2Z0cUhGK2RuOTB2?=
 =?utf-8?B?R1dtdTJxS3F4YzZWc2J2MkVnTkM2Qk1uenR3WXFYT3NaYi9RTTR4dWNLaEFv?=
 =?utf-8?B?cE0wU3ZmYkExMkhQK3hFRVdJYUpwem9GWTFqNkFXd3ZKV0dTV1NSaEVoR055?=
 =?utf-8?B?clpSdWw5eGkxb1NVQzRyWlhWR3RtdVZjOGdEVFVuVG5hclVmcGd6MXlyWE11?=
 =?utf-8?B?cWtmTVNkczh6eEF5UjFJblFIUFAvcVNUOTZMRjRtRWxtVmFkR1N2RVlLUHpv?=
 =?utf-8?B?TjBsZlNsZFdHVmxyVk9udGFsb3h4aHJXZVFaM0I5eHBZUmVqMGhLTVBvUFVT?=
 =?utf-8?B?SEdDZmJGOG5sZ2xzQlRKVTg0encyQ010aTBLWng4QmUyUjRiTk16aWZtVXM5?=
 =?utf-8?B?d3ZmRWNiMlJHcG1BcFJaN2dxbVNkdlY1c0prTktFdmtKbnUyT1RKTU5ieTc0?=
 =?utf-8?B?cXp4d2kvZzhGQUxmTktpY1N3d0grcTBXNHgzUStmVFhPZUc1VmJXQVdMYkIy?=
 =?utf-8?B?S3BybU53RFB6a1VxYXRWTEVCSmJHaWJFMm9kbFB2RDRaZUlDRXJHTlNwckRt?=
 =?utf-8?B?MWx4VnhpRmN4WllKM20zdm5QMHJRYW5mTmkvQzVYVEdrbmRSV1IwYVAyVVNE?=
 =?utf-8?B?cU5ZTmp5a1pta3JUVXU5QUY0ZHFycXArME9FKy9YUmZrcURMeENOYmRLcHNX?=
 =?utf-8?B?ZU9La2lwRWdwV1I5Z3RYYThKYlRWemdqQ2MrMmxRakRMTmRLam1NcmVrQVNN?=
 =?utf-8?B?dnNVK1huckVra0Y3QVU2MDFsaC93b3RJREtzNVBSSE1pSHVHRUpCVDV4dUJZ?=
 =?utf-8?B?aytkbWxwOGVHTmFFN3duQzJMeWpWeUlxVUU4Unp6Q0ZEZVRweE92NTBmVXlB?=
 =?utf-8?B?cjBCS3gzcUNhOFZBaEhBMkN3MU5ENkNtUjFzeEJ0aDNVaERSUHNjZlN4anhp?=
 =?utf-8?B?V2toQXgxdDBXMnZzWHRXYWNRekpKUnVaRXNsa01FenB1WisxOHNaNUk2OE9L?=
 =?utf-8?B?Vk1Ic2RaaGl3eEhYSWJEVmFoaWpYaFZlZEJXQU9uZ25hWGtMa21IKzhkMDhH?=
 =?utf-8?B?WDNnRE5GS0k3QlFRY1FNcEVKY3JDME8zeUowOGpDUmdyamc4ZG52ZTBmU3RI?=
 =?utf-8?B?VDRKUGFKNDF3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5821.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NlR4eGJRdGdVWmYyZ2ZvRU1ONEFhTXdjdFViM3pHaURaR3gvYWVsNUJZNGFH?=
 =?utf-8?B?Y1J1ZXQ4aWxoVGo4WFFjTW1yMGJpQytTZDg2NVZ3U3k2QWwxL1hvbVpqZ3ZN?=
 =?utf-8?B?N2k0WFhyMndTL052QUU3MC9MU1VmdDFmS1dkVldYT2RWcEUyM3FFYmF4aGlN?=
 =?utf-8?B?YlpxdUxObkREZXJINUgwMkFzeGo4TGFRQ1Y1Rk0vdjBvVDJUOEhYL2tXcUs4?=
 =?utf-8?B?QnJPOXR5Q3JRN2YwSCsrWDhsMXY3QUN6K0xDVVVqbDFrTVBZWTlXckZMUFJo?=
 =?utf-8?B?RnM1am5xZG9RUGhPM0d2YzVNRWtIWjhzd2tXdXRIQjBWMmFWVm4rTXlnaWVz?=
 =?utf-8?B?aWh4QlBIUXNaemIyMFd6dmxseEY3RTgzR1NmRnVCTXBzVGw5SFV4RHd4R3kx?=
 =?utf-8?B?SUhRVzN0YmF4SnBvNWhlRzhYY2ZJUGQ3OTRnUUJoaG9uVC9OamVNdk4xd3pi?=
 =?utf-8?B?TGZpR3JvV0NTNWpDdFN1K1JIcTJKeHkwT3h5bUZtS085emd1a1J4ZlpMRmtv?=
 =?utf-8?B?dW9TU1hWN1lXUitzcFpOMFhQYWE1d1liZGZFeGpSY2tsSm9WRHJ2TEY4TDRH?=
 =?utf-8?B?WWNwdlZjZm9RcWpUN0lqVjVPQ0hQZ3BwZkxMU1o1VUJOV3VENzFsZVNrTmRz?=
 =?utf-8?B?N2JpeHQ5ZXJ6NGdDS2ZiV0hKOWRrUmRONDBEU09XelRvKzNFNjVMTWd0dFhT?=
 =?utf-8?B?UldlQkJ1czU1YWk2ZDZBOUl3azNsTXQwcGtQYjJ0NWgrek51WUxSRWdMTmJH?=
 =?utf-8?B?UWNTbnZvTW9JbVVXT3h5WS80dXNxRUVoK2tCTXUweHJyRlNTYzdzTkY2ejV5?=
 =?utf-8?B?UXVqczhZMXBNQXoyd1RaODd6b3F1RHZmZUsyMytWa25qa1pCbDZUUFp1Q2U4?=
 =?utf-8?B?Qkx3bDQ1MnlMbmc2QWRSVzlvYWVkdFByVWdQWFBKbXl6N0NGVkY4WDBQeDZP?=
 =?utf-8?B?RExBYXd3M1o3M0Z0WjVvai9CZ1NZYmpKenlPb0VZdkxYWkN4b0txUTE3Tkov?=
 =?utf-8?B?NklmTFhOcDY0VWZGaUUybXFiSGd3YXM5RFJXc2Jwem03VlVkSGZQNmIrd1lU?=
 =?utf-8?B?S3NyblBTanVQSGszQXdkZkMrOUgvakxoVVhVb3cvWHpmWHBud29UZ3pRQWI4?=
 =?utf-8?B?ZENsUW5BSGJSNEx1RHc5TFVndnFGYmNvaTdsTWJGeDlHaHNVL0ExU2JoNEFC?=
 =?utf-8?B?cEFGems3TVlCYlpxcGdvdlZZdUR0QnI1aE1mcVZCa0FXM2NvYnVGY2tRcTJy?=
 =?utf-8?B?SlY4Z21VN292d2VBWDczTy9ibzM0OUgvemRnMzBGZkZTSjliUE1GOXlnTnp5?=
 =?utf-8?B?N2RxKzh1UVlpYzZWelR0MDQwTm44dEpZSTNwRXdIc3Rnd1phcG1VRDRGdnZ4?=
 =?utf-8?B?dDI0QXNDWUFHeTRlRmY4bkhhaVcxTURKazJQRVdJZGpiVmNIdWZzMTlkMVpR?=
 =?utf-8?B?T0tieVdrZC90ZWs5V0FDTkFJTTk2QmZwbmhNNDhZTnd4YWNROHp2VmJnWHJY?=
 =?utf-8?B?MlloTHg1d1E4b1U3YnJFMkRRUUlpRWl1ajNDTUNSaVEzZm1kaXNPK3BKL2gr?=
 =?utf-8?B?YlpsL3RRUnZQeXptTkd2VHVYWjRqUU9qWVdZdnBNSkwrSzEvY25SaU9rQUVi?=
 =?utf-8?B?NWZtWkEwcXVCVEhYRUpuQUMvTnBNdTZwaXB6dzVSNy9EZlVhbWVMTllYRFBl?=
 =?utf-8?B?Q09oOFZRNy92TXdpV3c1OWg1aGhFTmxFSWVOWENZeXlKM1lmVW8rUloxTmp5?=
 =?utf-8?B?alMybEVXVEtFem9FZXo3aWczTUtreXQrelc5V1BIWHdDVWpCdlZuY1lwNXRF?=
 =?utf-8?B?Qm91Ti9LcGxRZytiY0g4dUVYVVpxZytKdDZaR2xKZDI5WXkvM0t2KzVvRU9L?=
 =?utf-8?B?dExjYUxyUEdnSWdvZGl5RXNCUENVOG80UDgzUFBDTGxBbW8xTjRvRWxFck9o?=
 =?utf-8?B?cEw2OUM1cFFCYml5Y21hYnd4MWc4WXRGL2FGU2JLbDlMNFdTV2FTbTdMMC9R?=
 =?utf-8?B?ZDlDTkdURG9ObndQRGVsQ2QwVWZLQkRQSnQ4TW1KbWt3U09MaTAvTWZZalo5?=
 =?utf-8?B?QkloQThnZGZqb2l0WEllRmE2cHhXUWZ4Qm81dEZrTjBNZnUzL0NIT1JxRGpH?=
 =?utf-8?B?OEVtMzNVL25rajVRRGMzZUFhai90by85TFhZM1FyUU1LOGZKQXNsWUUzbkU5?=
 =?utf-8?Q?Yob6ANPeGVPr1UjxHYVKnBc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D728ADE5781D994CAA9F8C3E7AA1FAC7@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5821.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf86fed-9094-4eb3-8e61-08ddd05c89e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2025 18:03:22.5240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QUTdnSiJ1sc55NEUcJTDJhTJTNjz2so/6YYhHTzrYB7mNt2OCrHrz2KoMn5XsoZpGyEOvJMIp0ulX53GjSJssQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR15MB6512
X-Proofpoint-GUID: hEojl0k4rsIeofb7b7pPSpYHW28ZyJUQ
X-Authority-Analysis: v=2.4 cv=Mbtsu4/f c=1 sm=1 tr=0 ts=688baff1 cx=c_pps
 a=iNbKu3seLnfQiesHBt/AFA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=ed1QVOPDWkG3v6p5syEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 0hsEB8ZklnqikVkpSe9IZxxkKladkJNq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDEyNSBTYWx0ZWRfX1wP8ANVeWety
 YgZRTkGUmjWkbNGK6DHSMG1s+l/s2tp3Nvkd+B3xoeN9oC0FnRgUEL/aXVVroFnREhOEaEt5bHn
 6cgWL2BMptF7+ymfc65r1mw02/UctooKFcqA5AMRy4nyeEcyao+E0KfUlegCz3PXJwfIk2KAcdV
 5qKkF++E+hELG7TE7Xm3yLZSqHA3ULFZwjPC5ZBwPbG7/hb89h4AXrC5zr4i6VL8p36oqM/YzvT
 RoiQ7xrxTkwQjMZvadnPBTafgJY6lgemrDRVb5z+DgVKrkuvMdeILkh17YReQvOs9aFfYht3/OH
 dInyjs37jBWP1j7YJY2IOtL101AE1oCvRreIjAj4jTbYanhtZ2MBEkWURbYD45JL95YMr3JNlI5
 l7c7hYVLPX+0BdPRFSZD8IbwCrTXwLlRrd1rVthyCpn0moWkbK2Ik3pzGeB0TSKZQq0EOtE9
Subject: RE: [PATCH v4] hfs: update sanity check of the root record
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_03,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 spamscore=0 mlxscore=0 impostorscore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507310125

T24gVGh1LCAyMDI1LTA3LTMxIGF0IDA3OjAyICswOTAwLCBUZXRzdW8gSGFuZGEgd3JvdGU6DQo+
IE9uIDIwMjUvMDcvMzEgNDoyNCwgVmlhY2hlc2xhdiBEdWJleWtvIHdyb3RlOg0KPiA+IElmIHdl
IGNvbnNpZGVyaW5nIGNhc2UgSEZTX0NEUl9ESVIgaW4gaGZzX3JlYWRfaW5vZGUoKSwgdGhlbiB3
ZSBrbm93IHRoYXQgaXQNCj4gPiBjb3VsZCBiZSBIRlNfUE9SX0NOSUQsIEhGU19ST09UX0NOSUQs
IG9yID49IEhGU19GSVJTVFVTRVJfQ05JRC4gRG8geW91IG1lYW4gdGhhdA0KPiA+IEhGU19QT1Jf
Q05JRCBjb3VsZCBiZSBhIHByb2JsZW0gaW4gaGZzX3dyaXRlX2lub2RlKCk/DQo+IA0KPiBZZXMu
IFBhc3Npbmcgb25lIG9mIDEsIDUgb3IgMTUgaW5zdGVhZCBvZiAyIGZyb20gaGZzX2ZpbGxfc3Vw
ZXIoKSB0cmlnZ2VycyBCVUcoKQ0KPiBpbiBoZnNfd3JpdGVfaW5vZGUoKS4gV2UgKk1VU1QqIHZh
bGlkYXRlIGF0IGhmc19maWxsX3N1cGVyKCksIG9yIGhmc19yZWFkX2lub2RlKCkNCj4gc2hhbGwg
aGF2ZSB0byBhbHNvIHJlamVjdCAxLCA1IGFuZCAxNSAoYW5kIGFzIGEgcmVzdWx0IG9ubHkgYWNj
ZXB0IDIpLg0KDQpUaGUgZml4IHNob3VsZCBiZSBpbiBoZnNfcmVhZF9pbm9kZSgpLiBDdXJyZW50
bHksIHN1Z2dlc3RlZCBzb2x1dGlvbiBoaWRlcyB0aGUNCmlzc3VlIGJ1dCBub3QgZml4IHRoZSBw
cm9ibGVtLiBCZWNhdXNlIGItdHJlZSBub2RlcyBjb3VsZCBjb250YWluIG11bHRpcGxlDQpjb3Jy
dXB0ZWQgcmVjb3Jkcy4gTm93LCB0aGlzIHBhdGNoIGNoZWNrcyBvbmx5IHJlY29yZCBmb3Igcm9v
dCBmb2xkZXIuIExldCdzDQppbWFnaW5lIHRoYXQgcm9vdCBmb2xkZXIgcmVjb3JkIHdpbGwgYmUg
T0sgYnV0IGFub3RoZXIgcmVjb3JkKHMpIHdpbGwgYmUNCmNvcnJ1cHRlZCBpbiBzdWNoIHdheS4g
RmluYWxseSwgd2Ugd2lsbCBoYXZlIHN1Y2Nlc3NmdWwgbW91bnQgYnV0IG9wZXJhdGlvbiB3aXRo
DQpjb3JydXB0ZWQgcmVjb3JkKHMpIHdpbGwgdHJpZ2dlciB0aGlzIGlzc3VlLiBTbywgSSBjYW5u
b3QgY29uc2lkZXIgdGhpcyBwYXRjaCBhcw0KYSBjb21wbGV0ZSBmaXggb2YgdGhlIHByb2JsZW0u
DQoNClRoYW5rcywNClNsYXZhLg0K


Return-Path: <linux-fsdevel+bounces-25190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B71949B43
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 00:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AB161C22B2A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 22:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16842171E6A;
	Tue,  6 Aug 2024 22:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="U2zx6sCM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A090616CD3A;
	Tue,  6 Aug 2024 22:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722982966; cv=fail; b=pcSjc1N/E2dAN9FAvbmU7wIoH2AUvYe/1XyrkgCMAPX1w9vttr6EBITg1iv76V23IB7OUk6REkoz6/+a6s7zYQrj7c8p8D97m+vXbXtG32Y+fsMhkYS68CH6n+y1t36N++MtB6ZEsQYFdhLoMUb2ohadAM26/0YlKlqO8Llq178=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722982966; c=relaxed/simple;
	bh=xhELHgfDwZgDPM7ZpYGdm7lsiAkLaLTCVcF6Bx3goLc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R1QAFq7viDIu+fCZF112vf7DHiLT75kizAz/M2B82lP4+rLqZIJg5j2b0MVjGzV8+xX0FO794XIp1HUutMvs9o+zcKCGD7NwH65fugT7Hh79C6tB8DWw4x4Ssbc8e7ylvRpualgCh5BQVNfBCcU4dEaR4ULUDDZzdZTfh8MAO8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=U2zx6sCM; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 476LeuM8028178;
	Tue, 6 Aug 2024 15:22:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=s2048-2021-q4; bh=xhELHgfDwZgDPM7ZpYGdm7lsiAkLaLTCVcF6Bx3goLc
	=; b=U2zx6sCMGK3lyijCDlrz2lFmnMLu7Ye5I8vJVXa3EJB79Aax/1/rjK64pl9
	SDfnJAgh0TzwwV3WmO17bIDPaF1xs92hXEmcCLTqfHC2fx0KbyDGSgn9mWdghIjB
	LM4qNyjbnoPG+ynpCxkkU2QGxMX3g1+DW+yQwQOebnF038Sviz006MZxTKHyvx4A
	/el8UFnhtDdkqCyKrRIEPcXr1mux/TV8SSllROAR4LVGJNVCE/kxB/M72F8OkZXh
	omvRanP00oDWcjKr0hYei0VTHDN1j6sRT9tjJoNJtmByLCrqducv78px61cZwDhA
	D+r1RI1MkLCvM5dioc5UGi+In2A==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 40usnth401-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Aug 2024 15:22:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QFkIvsj5Utz4kJMBgHkU2SYxRUqOvoE0P48T/2708dSIg1xO5aHNqtnOnTNUmx4tuL2+CI3RMKBkjDz506Q4DOjNwtG5A7R6bQsVjY7oyOJXl3hy+1PbvLkbBpnXnQ+91fKNc+XOI4tjHYps9RYtRxihB/++d2iqmqWzZixtjmmqUqHL6c0+UI8x7X/rugz5PF07ROTelzuzs0fLxIxfvyJkM9IgAVmyuHEN1bpsVbv8YwHJkZGF9R7JVQUVgwNmbf+U5fn0zakU+MnTeTpp+jxP3XhdyeJ5xC34bHFLWtCQZZwJFnjNOxax++YERXcF3WvhXNQa7hh6/D697MmS/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhELHgfDwZgDPM7ZpYGdm7lsiAkLaLTCVcF6Bx3goLc=;
 b=zOr7oahw16KQv03MD2uRiDawhwv30WoiDLS7KIEUlcZnjDnHJ+QKO6Nt87z+z/VfQ8o5dv1CP03TzmWLIGJdFkVenvHmUeIOl/d0z3o2JffFHucGijOSwu7OSop8JkCuVp/5TNNuHae15EV0NpGj3/pTj/+pWAEjo5BBpQ0yZrXJ63gWJ8hv/AUxoq535mx3pbfMpp7WyH/W4i21D86QJXgVuomHViVubm9tGATh+ythQ2ksBl9xNUCnISLAngIx2vADO08wy4h0EIyMtdbLsThvFRoaaP63B/t0D39rATy5GlC8AGfu1TzQ/e6YnPkqqZLI0HlZVmO+JII/V3daog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by DS1PR15MB6708.namprd15.prod.outlook.com (2603:10b6:8:1ef::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Tue, 6 Aug
 2024 22:22:40 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%4]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 22:22:40 +0000
From: Song Liu <songliubraving@meta.com>
To: Song Liu <song@kernel.org>
CC: bpf <bpf@vger.kernel.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        KP Singh
	<kpsingh@kernel.org>, Liam Wisehart <liamwisehart@meta.com>,
        Liang Tang
	<lltang@meta.com>,
        Shankaran Gnanashanmugam <shankaran@meta.com>
Subject: Re: [PATCH v3 bpf-next 3/3] selftests/bpf: Add tests for
 bpf_get_dentry_xattr
Thread-Topic: [PATCH v3 bpf-next 3/3] selftests/bpf: Add tests for
 bpf_get_dentry_xattr
Thread-Index: AQHa6EAEwNYqRdBHGEmRXrEuJwT/LrIazcAA
Date: Tue, 6 Aug 2024 22:22:40 +0000
Message-ID: <86215760-0EEF-449C-983B-A84E57450166@fb.com>
References: <20240806203340.3503805-1-song@kernel.org>
 <20240806203340.3503805-4-song@kernel.org>
In-Reply-To: <20240806203340.3503805-4-song@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|DS1PR15MB6708:EE_
x-ms-office365-filtering-correlation-id: dd6b34bc-ba78-4194-9a78-08dcb6664900
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q2w5Sm5Kdko5N0FnaVV3ZmlYQ3AvYzAzd0xicnVsM3hGWXZaZDJDNUtVbzhw?=
 =?utf-8?B?d2RyeW15VzJwRURJTHl0OTRqWXpJWVh2cmxNU0xub1Zsby95RTEvem1jV3pP?=
 =?utf-8?B?RWg1V1NvaExlSnJDeGtUbEFwdDFzRmdDbUpJa3RwSEtrd3BYazNLQ2w3cTho?=
 =?utf-8?B?NFRxTzdHNWwvOVFPV0s3Mkc5eXZqRWcxKzBjdzR1VjhkUWdwcDMwS0M3TjQy?=
 =?utf-8?B?YXdoYVYxL1gvRWMydUxWYkltTXJaK2dzd1NaOW1XdDZFZVIrejFIYU5ZbWFa?=
 =?utf-8?B?c3U5dTNrLzFIQ1BoYTVZQ1hMZm9wWkppSmFISmh5cHl2WVlwOGtMSGlMNWZv?=
 =?utf-8?B?bmZCYnBOVzVNdzZoT2czUy9iYS9iOVd6NldWd3lXRnRXRWpDSzB3Ri9mTHJi?=
 =?utf-8?B?ckg1TkkwU2oveEdWN0ZoMVo5andibCthR3FEdk5EampDejhYR2ZBYkpNRmtM?=
 =?utf-8?B?Z0k4SGlWRlMvN29lVXhpc1ZoVkJlZXg5VlNaRXNvTWZ0WHpzcTM4eFBKOXdk?=
 =?utf-8?B?eTFvZXpTNWIvZnRHVDV0VW5RWkdpQS9Lc2RBZ2l4OGE5K2NIMEsxVWtOV2Zu?=
 =?utf-8?B?ZEJ4QUpIdXkzK0NzQ21QejVldkw0bXUzajJaK3ArMjNITXk3QmF5M1Q3V0Zq?=
 =?utf-8?B?SmU2M0cyenNpODU0ekRVR0p3M2Q3MWorMDdvT1FvWHpOdTc5enVhR2Vhbmc1?=
 =?utf-8?B?aWZoVHNOZG9lMUlVQmhISzdURDA2UHZVdTIxclIvUGk5MmRGMHZ3Q09PQ0kw?=
 =?utf-8?B?TTZWNUdQMUVPT096dUErcUhFVkJQbVFyMXdaMkJneHNUdmhjaWdPNGdrOVN0?=
 =?utf-8?B?aVRtNExWQXhBVnJES3VGSVF5TExqNkh6MlpuWEJ1WGJwdVhjUTB0VlR4WjhQ?=
 =?utf-8?B?RDJYQ3FEQTJEakhhK2w1VkRFTTZyaHlOUWFzd3kxSmY1SVFjUmRvcUNqbURl?=
 =?utf-8?B?USswM2Z5a2wwbUFidDhrdENYZVp1TXVaSGpCdjZudXZHaG1lRmo0R0o4b1M1?=
 =?utf-8?B?cHNGTk1mZm5zT1g1VWpGZ0o2eGVCcTJscWxETDNpblJ2eVdDbVVZWjYwSHRu?=
 =?utf-8?B?YjZONDNJQUZXZlN6aXREdGg5VnVrdHowT0dmRDB5ekx1N0VFd2R5WVJ4b2VO?=
 =?utf-8?B?SUNDN0c5Qi9wL1BOK1J2aWE5NjdwRjF6VHFkTnNiSWp4VmVFTnB2Z2JFWkNl?=
 =?utf-8?B?N0R3SUNCVytwRkRrM3dFMVJ3SGFJRHhOaFZiR2pLc0pvRjgvZ1V2NG5GZWJG?=
 =?utf-8?B?S1FkQ2NJRENnQ1Jqb00vMjJVNmdNLzd6Y0p5VGRtU2RYSUdqc0JPQVBYdWtn?=
 =?utf-8?B?dklXNkl4dFIxTERsRGxCYlM5WTVTOHVlbXBlYUlJVkorenFtaGlkR3BRTmVB?=
 =?utf-8?B?Q2E1Unl5aHh2L25PL2ZjOWUvalAvcktiNGdLTDFxNFNncllMVGl2Rk5ibldH?=
 =?utf-8?B?VitOb3ZlUm5RN2h6cWlUVHZ6ZS9seTFCemhobUJBNXJ2NitRQ1RhTlUvNDhq?=
 =?utf-8?B?dlk5V1ZsdWZhRzR3Ry91S09FeElGc3dJTGhPKy8zRGNlWDdTSVd4bW1EUDFN?=
 =?utf-8?B?RjVoTThFRVBEMXROOWY2NnExT1JhUlM4UUlHaW9JNlNnZEFJdUZTRWNUZ0hB?=
 =?utf-8?B?enJzdDJwdnIyTkU2NGEwT2hKSHVTeG0vTFNBMmNXUzVBak13U1JuTHJuTk9l?=
 =?utf-8?B?QVViU0hCTUgrQUVWWk1YMzdSeVlMRE9iSk5VWUwyZzdNbnVnNGp3bEhjSEUv?=
 =?utf-8?B?azhPUG5uV204NEk3MTluWk9lRVpDUUdlaGw3c1pqYUNtMzdkZkhHcjIyOTJU?=
 =?utf-8?B?N2tvZXVGWEFOL0lrTEtJZTFuaytUZG11S0xVT2tpSFRFTWZUT2t2Y0lrMDln?=
 =?utf-8?B?bHJ4NGdXb0dGMXozNERWMm0zQml3U3ZWZStmM3E5ZDd0a3c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V0puMVBHMTlGNFpKRjBUOXpYZWJxdnZMd1FtbDRlK3VZWnI4dmRzMmh1OWh2?=
 =?utf-8?B?ejBuOXZ3TE1IQnNUdk4rWGxScHljSXFmOFhuT2E5aTY3NWc1ZlpXNmF3VG5m?=
 =?utf-8?B?aVg4UWtCVmcvZGRJdllVQ3ZBVWRwc3JRSkhQd0JCUGkveXRMQ1c1Q1NFTkZw?=
 =?utf-8?B?akpLRTUrK0UxU1VrTXFNVXlIQ1NPbDV2eUtSNE9pVnBJNWNRQytkVDN3SUhx?=
 =?utf-8?B?Y0tZYUkyQ0lFQTJtbHJ2aTA2ZFJwUForNmJETldxMm42QlJSYTZYRjlsR2Js?=
 =?utf-8?B?MGFJS0YxNWFNSWtOTFJFL1JzZEdQTUJ0RFE3b2cxbHpWYVhpUkxtNmloTU9p?=
 =?utf-8?B?dkh3U0NrRWtmNVg3ZVQyTDBjNjJISUFXa2RXeGJyQys5dnFHdjI4TDFwT0lV?=
 =?utf-8?B?ZThnQlNPRWluUmJHTDZyUCsyVEt1WC9UWVc5ZDVwSERjdHdmRDd2czNrOFdo?=
 =?utf-8?B?YW15VFRxaFlmWmIvb0NBSml6RVR6Y3Rma1FNSXlNKzlzMFZPODlldm9Ya2hM?=
 =?utf-8?B?Ri8xdXk4MzdrSzBTRnh2cHJEQU0xT2J4STV4Wkd5bklBWXpkQUxXUHdyd0tO?=
 =?utf-8?B?UmRuWHUvM05YdFF4d0UvejRBY2d5S1pVZFZ1d2N5R1oxTDVnVXVMVkdaY3FM?=
 =?utf-8?B?c0p6MGMrSWtsT040Y1QyeUhRSDQ4TnRPUG5tK1lJeHdiazE5RXhGUGM5UldQ?=
 =?utf-8?B?aTFWbWNwZWJhNjJEQU5BaDVGREkwWTBqOXVhK1NoRUY0a1Y1L0YzZ0U2WE5Q?=
 =?utf-8?B?YXpRTWdtZmozSm1Oa3lpdWNXZGtKdHJjeUlPamN1cFViZnZINzJXWXVzVjNs?=
 =?utf-8?B?VDJYRld0RVc1ckhSL3pEZSswSXo2c3VGUzlrbUZJWlFTQmRidnM3dHduSUFL?=
 =?utf-8?B?angzWlVHdHd4UDJVTy9FaUhUMStVQjJDSVZnWE11ZzhYMnVmV3A4ZVRyN29r?=
 =?utf-8?B?dDVKTXJXVjFHK0VyZmJKbmI1ZEtkUytibEpiV1lha3c0VEhEN1IvRUR6T0hG?=
 =?utf-8?B?T0YxQUxXaTNYZndRaXlsc3BJVDNFd2ZDaHJBNTkraHVIRk9qMjhmTlNjTUZl?=
 =?utf-8?B?WHdCTy9TRGhFWlJ6V0RVRTRIeVdWU2pPbndjNGpneklqSWZKWDhuUHFnYlZa?=
 =?utf-8?B?WGRNMFNGRmZYZXd5VlorWEQvM3JxeE1QRVNHSVBSTmIrVWxVQnl3VFhvekI0?=
 =?utf-8?B?T2NpQ0p2aXFSa29pU1pDbnFUdVlWR3RkYm50TU9ra3JqQVlWKy9JQmtZdHV4?=
 =?utf-8?B?RUpkZjlSd1hGTi9CNlZMNjZkUUVTREdPcHF5YjJpTkNIWkFuMU5BSldqM1pl?=
 =?utf-8?B?eXdWdzQzbGV2bkQyM0RuUURnQVoydFdFaFFzZ21TMXBueHV0ek5yZTM4ajc0?=
 =?utf-8?B?Rk5ONVp6VDA1bmczeWc0aGd3L0FldXpnUko4ajRtU1QxN0FsYmEzS2gyMDBO?=
 =?utf-8?B?S1N1bkMvK3E0cXZIbmpsSSs0MjdZUDN4V3M0bDVGM0Q2WERMU1kzOExhR2lq?=
 =?utf-8?B?Qm96NW5CdkZWZTYzOS9SaUNGNnc0dkgvVXJTd1o1V254YTN2NlI3cG9GenJs?=
 =?utf-8?B?c3Nyc2FGdEo3Q20wM2tpMVdSa3JUc3VQdlFUdE9EaWpVWmtCeitBSkR0cklD?=
 =?utf-8?B?NkJqTmthZUdBODlkTlYwSDdySy9xa2ZBOEN6NnozT3NQMDFCUHN2dmtwWTVM?=
 =?utf-8?B?OVUzNlUxNlJTbXF2Qy90bWhhalVHRE1rblo0TWpKNTdwTGswY0U5Qm05TU9Y?=
 =?utf-8?B?VTBSa3VrWUxXTUhrb0ZmdEtpWFIxY3lWZFlvSVE5aDI3dTVQbFFGcFltZFJS?=
 =?utf-8?B?ZE53QVlUdTcwRjdTUmppZGxxSFRvWE85UEw4NDhPY1BvT2s4M3F3RVBoTXRh?=
 =?utf-8?B?OWtMbktlTmh6TjJoZmwzYzR6ODk1Z3l0SlU0cFlRcjFFK3BHaDNLS3J6U2ZY?=
 =?utf-8?B?eWtpTkxrdDE4OVgvcUxDaUoxWEhlMzNxTWsySHU3eTJ5a2ZXUW4vaEllQkxy?=
 =?utf-8?B?RElWQVVyKzQrSDRWak9NVmdQVVJTbmlBbVpoYkZSQnprMEF4L01IcTVhSmdz?=
 =?utf-8?B?Tm9MZWlDZEgrYlFNd2JFVnhaY21ra0ZCWE5EVGYwU1hjaDEwRlIzYmRtSGt4?=
 =?utf-8?B?T0U0RmR2ZUgxRjhQNzhwVU5RT1lxM1R3Um1qcG00SE40empIMExQYnVhZ0pp?=
 =?utf-8?B?MEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D3D83C477F765E46A60849BFA312B1FD@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6b34bc-ba78-4194-9a78-08dcb6664900
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2024 22:22:40.7045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7SvdtSdrfsvAZwlJzVTF0Hn00LE5i2jYNhMLPfGfPZ0a17Z1IXXomuGWPUDMlCtzW9f66ywbtcIsUyBL7U+o5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR15MB6708
X-Proofpoint-GUID: XL5mlyA1qK9fDXQuEcw5k2lKCckQ8m4f
X-Proofpoint-ORIG-GUID: XL5mlyA1qK9fDXQuEcw5k2lKCckQ8m4f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_18,2024-08-06_01,2024-05-17_01

DQoNCj4gT24gQXVnIDYsIDIwMjQsIGF0IDE6MzPigK9QTSwgU29uZyBMaXUgPHNvbmdAa2VybmVs
Lm9yZz4gd3JvdGU6DQo+IA0KPiBBZGQgdGVzdCBmb3IgYnBmX2dldF9kZW50cnlfeGF0dHIgb24g
aG9vayBzZWN1cml0eV9pbm9kZV9nZXR4YXR0ci4NCj4gVmVyaWZ5IHRoYXQgdGhlIGtmdW5jIGNh
biByZWFkIHRoZSB4YXR0ci4gQWxzbyB0ZXN0IGZhaWxpbmcgZ2V0eGF0dHINCj4gZnJvbSB1c2Vy
IHNwYWNlIGJ5IHJldHVybmluZyBub24temVybyBmcm9tIHRoZSBMU00gYnBmIHByb2dyYW0uDQo+
IA0KPiBBY2tlZC1ieTogQ2hyaXN0aWFuIEJyYXVuZXIgPGJyYXVuZXJAa2VybmVsLm9yZz4NCj4g
U2lnbmVkLW9mZi1ieTogU29uZyBMaXUgPHNvbmdAa2VybmVsLm9yZz4NCj4gLS0tDQo+IHRvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9icGZfa2Z1bmNzLmggICAgICB8ICA4ICsrKysNCj4gLi4u
L3NlbGZ0ZXN0cy9icGYvcHJvZ190ZXN0cy9mc19rZnVuY3MuYyAgICAgIHwgIDkgKysrKy0NCj4g
Li4uL3NlbGZ0ZXN0cy9icGYvcHJvZ3MvdGVzdF9nZXRfeGF0dHIuYyAgICAgIHwgMzcgKysrKysr
KysrKysrKysrKy0tLQ0KPiAzIGZpbGVzIGNoYW5nZWQsIDQ4IGluc2VydGlvbnMoKyksIDYgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBm
L2JwZl9rZnVuY3MuaCBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9icGZfa2Z1bmNzLmgN
Cj4gaW5kZXggM2I2Njc1YWI0MDg2Li5jZjI1NDIxYzM2YzkgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9icGZfa2Z1bmNzLmgNCj4gKysrIGIvdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvYnBmL2JwZl9rZnVuY3MuaA0KPiBAQCAtNzgsNCArNzgsMTIgQEAgZXh0ZXJu
IGludCBicGZfdmVyaWZ5X3BrY3M3X3NpZ25hdHVyZShzdHJ1Y3QgYnBmX2R5bnB0ciAqZGF0YV9w
dHIsDQo+IA0KPiBleHRlcm4gYm9vbCBicGZfc2Vzc2lvbl9pc19yZXR1cm4odm9pZCkgX19rc3lt
IF9fd2VhazsNCj4gZXh0ZXJuIF9fdTY0ICpicGZfc2Vzc2lvbl9jb29raWUodm9pZCkgX19rc3lt
IF9fd2VhazsNCj4gKw0KPiArLyogRGVzY3JpcHRpb24NCj4gKyAqICBSZXR1cm5zIHhhdHRyIG9m
IGEgZGVudHJ5DQo+ICsgKiBSZXR1cm5zX19icGZfa2Z1bmMNCj4gKyAqICBFcnJvciBjb2RlDQo+
ICsgKi8NCj4gK2V4dGVybiBpbnQgYnBmX2dldF9kZW50cnlfeGF0dHIoc3RydWN0IGRlbnRyeSAq
ZGVudHJ5LCBjb25zdCBjaGFyICpuYW1lLA0KPiArICAgICAgc3RydWN0IGJwZl9keW5wdHIgKnZh
bHVlX3B0cikgX19rc3ltIF9fd2VhazsNCj4gI2VuZGlmDQoNCk9vcHMuLiBmb3Jnb3QgdG8gZGVj
bGFyZSBzdHJ1Y3QgZGVudHJ5LiBMZXQgbWUgZml4IHRoaXMuIFNvcnJ5IGZvciB0aGUgbm9pc2Uu
IA0KDQpUaGFua3MsDQpTb25nDQoNCg==


Return-Path: <linux-fsdevel+bounces-55715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D79DB0E33A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 20:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AC84547E46
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 18:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F1A28003A;
	Tue, 22 Jul 2025 18:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dLc/5Jla"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7785B450FE;
	Tue, 22 Jul 2025 18:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753207727; cv=fail; b=Sy4y4g31tpVyHxjcDkwAX27Ic23tvJL6VEY0WzhsrbJsVNFCQPb2BnTXX/0y6TJpO7NAgryvIEYiLqTABTqti9gT64qYJO13Obeg+HnXD3xTBYNuhqdw8yHCNPWotay6TtArTExhI3WZ8pWwMTk8JKau+FTKvfE76/dRtnEVWCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753207727; c=relaxed/simple;
	bh=pHMDF1lj0ZlsaYd17ufcGBcXNK7cT8ynLBvea1b/BJQ=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=Uw0uTsa6p3vKYO8z0Yr8LBo3sJqQZARlFYep0UZFpOeBgKPFsa7UjskBqjF5DSiJjjGgA23lyLpMmqUqvNZzK394AzVDjYUbQw9PfUkVFUmj7HR9p38UpG6tfQ/Q6GAzIex3nvU50q5uRDykkuTDTfCiOMn75f+J4uFd7rVIPSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dLc/5Jla; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MHshMq005205;
	Tue, 22 Jul 2025 18:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=pHMDF1lj0ZlsaYd17ufcGBcXNK7cT8ynLBvea1b/BJQ=; b=dLc/5Jla
	xUArBsH0HPcIxOTWlFTeFCIJxBfszOu13QZY4ewosVGzeNVglkQ8a+TU5DMDY9JW
	gZpVrDKTy7O/AJvUIvpuAzE+FeLjLRMy5wGKpWFBpVxzgR73oLd/LIRBH10BuXbH
	nt1fbQdHU7qe5i+FV6XEGS8wzne9AJn2oB5a97EQ2gMxSYOwpMsQNd1ZTJzPjmW4
	sMRLYGUIUUmK3z486j5wqY0L/zd328K2p/wrHBFcSrD82PvPthJ+VVhYIS0TJa5J
	EpSaF4I9xbHUqnhDRWqSHrUR3aOAkrAUz9G9/yrUK2TrWBHFrAX0NaMNtCkMLCUG
	uQVVuWk6vY0dpQ==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ff4r31q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 18:08:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XTRel5jfYNWnsAjDSI2v9r++oDJe4NebHZDu/L5DyGzaqUCSXyve2qGhxPkl/z5BUR41f5Cox2560190KAaJBxP88h7wxD9v6vTK8QfGbe5ZBwIk2owYTNQ342WZ6Qked8F0DfCdZfAe6s9Z3eGo80IFcemWthq+9N3Q2vC/CGHSGSqy9j0f1STokAfIApnwRoRMF/Xq7yNry44Ga78W22cvyb2/t9QHhyFhNQP0drYLOhwIQ39HKU8OTLXFEgK7OCgFVB5UPqJJ6SdgUOI4xkJrohfvUROd/NfwphuEcVEgw/6t8KznfvWihq9qAtqZbqK+q2q/OEo1EnmuT4DC8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHMDF1lj0ZlsaYd17ufcGBcXNK7cT8ynLBvea1b/BJQ=;
 b=Bn0MZgjE/sVpGuMy8zk9BYfXvDP6GkFvBzRWlhrUg7dq9nqFtL74nK147ZSTX92puI9nbTrwA5kA4buVXYvM2ZTh338E04Idbm0AHrKHd0T8JpJ6O+G5mvW6gPsmJ2EYJ+nrZDv0oVsl6HJDOPWoXRFOvJwFLnXy/MfJbjQRiqaB1NKkFeyUv0R3Yg6pO1MS10Mu1h/qJBD945217Z+/NAhdXtBVXw+nzSB4Z0VfuD5rugqqoG/ehWAVMP9/HY24MGSIrXEMlGTzP0TnRLA9Sl1gReroXgtcZeSlBnllOuaPAFcipiqf7WymL3n/ly/uy4SJ/lz184XkDEfSko0Drw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DM6PR15MB3943.namprd15.prod.outlook.com (2603:10b6:5:2bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 18:08:09 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8880.026; Tue, 22 Jul 2025
 18:08:09 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "willy@infradead.org" <willy@infradead.org>,
        "penguin-kernel@i-love.sakura.ne.jp" <penguin-kernel@i-love.sakura.ne.jp>
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
 AQHb91IJ4dXLt/uuZkqRbEGinlBUibQ2uTqAgAAmwgCABfRaAIABJ7GAgAAu4ICAAAmKAIAABPwAgAA/FgA=
Date: Tue, 22 Jul 2025 18:08:09 +0000
Message-ID: <9ac7574508df0f96d220cc9c2f51d3192ffff568.camel@ibm.com>
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
In-Reply-To: <aH-enGSS7zWq0jFf@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DM6PR15MB3943:EE_
x-ms-office365-filtering-correlation-id: 785f15b5-fb89-4806-8d5a-08ddc94ab748
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MnhtRWRxQXJUWFJ1eDJaT3RYR1F4UmplbUFZWmN4a0RsTkVqcFRZWEJ0ckVE?=
 =?utf-8?B?TkhoczViS1l0bjFPSkVZei8zaWN3Y3VWUVFlK0ptdmxrbDQ1OXNJNjVQVEFV?=
 =?utf-8?B?NmdmaWdiOTFrby8vMXkzdSs2Zm1UNEx1RGFFOGlKRzZQeGdFQ3N2UjRoeU1i?=
 =?utf-8?B?MkRCVXdUeFphRCtqbWZGN1czYlVvRkpUZWZVR0VkbVU1OVJzQWVRdThCZnR5?=
 =?utf-8?B?K0EzTU1hTklscWhsZnZNbjhrVkYzT1h6SFFrV25QemFPOUlRcE9wWDlnY1dj?=
 =?utf-8?B?c3dMbnNHb1IrQWxUbkt5MklibzVtLzg0NzAxR2hUNE1zQmpVT0pHSHpRVjdW?=
 =?utf-8?B?d2NwRjlURTJrcFZtWG5EZlc1bGdmWmtWNEROVFVJQUpnK01CTi96YlVMM3FF?=
 =?utf-8?B?aXZLMHhXdmhpOGRKUjNUQjNkaEo1YnFzYXNuYXZHTHVtdG9ybUhCUzB5Y2pu?=
 =?utf-8?B?VVVVOG9oZ3p3cHpFSzc0dVZTOWJMY0FGT0ZselpqRzZYd0NGVGNKTUpPK0Zt?=
 =?utf-8?B?cE5JaWdoamhoZVlpYW9ZK2V1cldBemVQQ1diUnJuR0dtWDNEQWlGZkU2V0Ex?=
 =?utf-8?B?NmRWbDJ5eTlyZlFrcmJOSWZ1bWJmeG1EQVQ1WVpkaXVXb2ZTU3lkZWxsbFJ3?=
 =?utf-8?B?ZGt2bC9jYm1KRzQ3OFd0NUhTdjdqVy96Wlh6a0tVeVE3Z243STQzQlV1VmRj?=
 =?utf-8?B?MWFYV1pqbUFqeHBtVW9YZDFJS21wdmt4eUQ0a2xpTGF2WmZHTzNRK3FXZGFo?=
 =?utf-8?B?eHZIYmVCakd1L0V1Q0ZmYkZ3RXdjRnRxRC9qTG80Vjc4U3pvd0g3TnZDbVFR?=
 =?utf-8?B?UUJ2S2ZnSXZjcXpBaEZmcjUwRk5aSFFpME5yUUFVUHJ4NDViL1NxNlNkYnJL?=
 =?utf-8?B?SWE2cXRoU0J0Q0xtT2tpaEZHTjhKa1cwNHFoTDFoN1ZwRUNjcndzQS9TcFpx?=
 =?utf-8?B?cUo2Z2ltL3dEUnBUeEpUZ2xiMGhBNDd0RmJNNUpNMjNOSFFlV0NiNENOT0VQ?=
 =?utf-8?B?Q2l3YnlnWVFuRzIxR1RKR240anN4YUlYcWNWTW1xNitiM3NPdHN3bm9WM1Za?=
 =?utf-8?B?eXpRSHVrTDJXd2IzaWdJSGFBQjl6N3g0RXZxeXJRVkIzUW8wbHZ4ZTlOR3U1?=
 =?utf-8?B?aCtydnRDK1o5UUN3TEJNUUV5RVFXOXR0S2RSNlBoamF1U3E4RlNncXhyRnZp?=
 =?utf-8?B?VG1zbXR0VS94SjN4dFpjZkVrVzJzalphdlFJRUtrMENldHdoeUdURy9pN2xw?=
 =?utf-8?B?QU55THM5S3l1dXpmV0JxQnVlTlN2QmhUbUZ5NVdydXNhNTU4YW5JNFc0WUtJ?=
 =?utf-8?B?Q0VCY2tmQy9NamM5UHE0RUhlOWcxSk0vakpUQ2swZU9qTVNuYStuemFXRE8y?=
 =?utf-8?B?OFVqOGozSHlpcSt4eXN4SnFsTDBxZk5vbWM5cEZNYVhka3J4M3Q2K05YTWtp?=
 =?utf-8?B?K1d6K2w5Z3hseUQvNnVTOHdNMmNwZUZSSC9yQis4ZEE3WEttTkY3K3cvcVJk?=
 =?utf-8?B?Y2hxd1ZyOVJ1QWY2SXdjUVZrSUNSdjFIU1QwSFdKOGxSbGxqVlpVTVZ3d25J?=
 =?utf-8?B?a08xcWlVWUdoRk00WjdNa2pJa1F2clkzYjNySHBKaE1ZaHBIM0RlU0FqSTlx?=
 =?utf-8?B?eVVGNzFHR1A0YU9GbUUzQ0lseUZZU1NGRnZ5M1ZycTRGeVRKNFZ0T09CNU5a?=
 =?utf-8?B?ekZaM3pZVG1xcGwvT3lESytSdjdtQW0vSHVYMGhTd3QrdjVsNXJkR0RwQzlR?=
 =?utf-8?B?L1lTTTlUTjhXYTJzeG9uOWg3RmRkRXpUVnhFVEVEOTlkdFJTSVFzTXBWSnBi?=
 =?utf-8?B?ZWZMa0lqZ2xYYW1iM01OaHBKdkViSEFKa1pMSmszQjlxM29uNlhzYmxDYTFr?=
 =?utf-8?B?NGpzam8zaWZlRTRMYk5CZVpjUnp6VnFFS2Fadm5vUHdMMTBjVDc3eVNkMmpQ?=
 =?utf-8?Q?AKVObPogST4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UkFXVE43RmVQNkJyRGV5dGNFaDc0dGdHTlJTOXpCblpFbzJVcWQrQ2hpMDQ4?=
 =?utf-8?B?TWtzaE5ocC9welRRcWxQczdERVlaNHhWbzVEanRDNjh4MlFnbUxjck1MY0p0?=
 =?utf-8?B?d3ZlN3ltOXRwYXFnVXpGNGt2WXRUanRldmd3UURVS2JjbitzSUV2YUhJQ0dy?=
 =?utf-8?B?WDFOa29kd0VCN1hyZVFUWGNHMlFoSkNkYjhyN2tGN3cvaFAxamFxM2dhWjlR?=
 =?utf-8?B?VGYzaStsb2FwSnUvTEdWWnNLZXZ1UGQwaEd3RHRIVVdFNWZlSGtCOW91Z2Zt?=
 =?utf-8?B?bTJHS3BXcFpRM3IxK3NpeVRTWkZIeDc4VUw2ZTFPaE5tRWxaSUdLTXVncE43?=
 =?utf-8?B?QkYrUS9Hd3FLM216UHhCdndDWDA2aDcvSXg3dGRsSjk3U0ZoMERWb0U2Z3cz?=
 =?utf-8?B?ZExzOFVlYUNHNGpvVlFoMFVySG50MlZoUjBLNkdHeWxQUVpKUGIvWGgvL1NO?=
 =?utf-8?B?WGhLeHlUZkhTejlEa1UxR1lFb3hTa0xQZ3JaOWJDWVYreGNKbDg1bDBEc3Mz?=
 =?utf-8?B?VlRibm1jRzhZeTN6a1Z2ZFhIa296ZFdKQ3hGU1pTRzBBamhPOVI1UkJkKzBp?=
 =?utf-8?B?Z21XRkJwV1k5K0FvVnlkZVZvWkRha0FOZm9jUVZPSEt1SlZMS01ObUN2RDB5?=
 =?utf-8?B?YmdFQU5tSjNaR1NMYlNGMHJDRkw2VUJadXdET282c0FQWC8zcUxybUMwQ2do?=
 =?utf-8?B?b0VLalZlcUEvMU04aXphU0F0TmJXQUQyRmlPeWJVaVVkeVlUQ0piQzBaZzBE?=
 =?utf-8?B?WmJTek1xU2VnRVVGYkt3dno5V1lMMTZnSzdhYkFydkdOYlNONGEyWU9KbHhB?=
 =?utf-8?B?RTRzbEVhVWN1SUUzUEZGT1JoMFd4MGlpaWYzM1Q1NEllN3BCcXBBZTV4WDRw?=
 =?utf-8?B?TThGTEx0N2VVODBjNzM5ZTYyRUx2ZXNENVRMM0JqenVsRmJ2Uy9mQ3RnTkgv?=
 =?utf-8?B?a2VsNDFwalRwbDAzdGswWFNLeUZyTWR4N3Rzc0xEakNnYjFvT0RRcnhzMUZU?=
 =?utf-8?B?STdvWDBIQXl5Wlo3UEFHRzNhN2xNcXZ5TlJkRkkxeTBMMHFPL3E0dlFEaXRt?=
 =?utf-8?B?ZzZpVTlMMHlCOFhxdER3S2NKV1BHUG5CY1JldlRBR1JidlJKdnZEcTVOVGdr?=
 =?utf-8?B?dDdrbnVhbjRmcE1lM2RuSmNlb0poRDh3U1Zmb0tBRUgrSmQwTUYrbHR1RTRs?=
 =?utf-8?B?MndxeGRVSzY3Ni8yMTBrOGQvditPbUhDeVUrNzM1T2RlY2tBSUpFRllqNlQ0?=
 =?utf-8?B?WlhuMUVCUEVLL1QzSitoQldKeEozTHhMbDE5c2Z0eFVQdUJuWVRRZW8vOEZz?=
 =?utf-8?B?ZU5nQVZhdGRuL0ozTDlPSEhpOEhxcSsyNlFUdXFTSTU2d2lmSE85QXhMSVFY?=
 =?utf-8?B?NmkxSkJMSFNST215TStROFZtcERUdHdFZUZjYkpSQ3RhaWNJOUZHZlduMUtE?=
 =?utf-8?B?RDlMYlQzUG90QTFwRS96dXFldEQxaXdhM3hOWjJsTG9TUDRZb0JQUmdpcFpy?=
 =?utf-8?B?Z0tFQ29mK2N3UDY5QVlqMFlhS0EzNUREbk5jdys2SmUzVlBYbmJ5UG5nbFF3?=
 =?utf-8?B?MXhObHNMTHZDTUJtakJQZHFmV1BmOHp2am5FdktteEx1cU15S1J1NVhqY3po?=
 =?utf-8?B?MEcyalJYWmJIa2RUNmxHY1ZCV3dtSm1yaSt6ZnpUUDZtbk96WHhtbVpTOVJZ?=
 =?utf-8?B?ZGVDbHJqQ3dLaTBzbk5Id1pCaG1hanBRVEFLdHFOTTVoOGhXZlVTRTFmNEhU?=
 =?utf-8?B?QTNIUHNmU1pDMEFRRU5IaTEyMGxqaHhaWlR1eW1DaXVpV1RScnFpeU0vVzJY?=
 =?utf-8?B?MEhHYXpPNFZ3bmQ5ZUlPUjNjU1Fpdi9tRkZ2dDVGZ09tQTJIWE9QbE56bkpF?=
 =?utf-8?B?aVk2Y2lERU1jQjJhaE9Hc0dIYWtoVGxoWGNJTEkvcERPQ2ptNnVqS3hqb0lC?=
 =?utf-8?B?cnVmM1ZzMys1NUJWU2lDandqbzZSVkd2blV0VHlxODh0SlZ1RW1peXJXUk8w?=
 =?utf-8?B?Q0dzOUtiSUhtQ2dkUS9tb3Y5N3VtNWhjbXVGdDVscXN2N3RIU3IrcUh3NFRF?=
 =?utf-8?B?dzJMN3lpVERmRzhrQU1XL2ZFai8zZlFvRWd0WGpNM1FTR3BCRjVxTFE3RXhx?=
 =?utf-8?B?MGkrWVkwQTQ1Mi9nbGVpNEsvYjBZR1plYStEclJibW94YVJpeHliTG9vN0w3?=
 =?utf-8?Q?rhnz0w5g+Z2/1QvVQAnDhSI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E2435228531F2409551595BD86B77DC@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 785f15b5-fb89-4806-8d5a-08ddc94ab748
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 18:08:09.5975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i8LZIhkOfWC5Uac/yyuRC3jbaMux+UuKgKghtoKgm3deMU8gtTURyL4vUZGBp/3jIMDIrBLudlKD3iisQg5FYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3943
X-Proofpoint-GUID: K1tfGPvTopO72JzPCj0bZi8IT7bZDSiU
X-Proofpoint-ORIG-GUID: K1tfGPvTopO72JzPCj0bZi8IT7bZDSiU
X-Authority-Analysis: v=2.4 cv=Ae2xH2XG c=1 sm=1 tr=0 ts=687fd39d cx=c_pps
 a=KqyQ1c2F0axk0YoGbn20nQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=P-IC7800AAAA:8
 a=HFN6ewAkfzZh456qsbAA:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDE1NCBTYWx0ZWRfX9iSPhCI29OaS
 9/oazD1KX0W2L4+5lrZpjIwdBwzbmkgjWL29qlq73GB2h18SYx/1utvn9AQLh60p7aqMoHR0o55
 ZbRxHn0wtxBwRxPzfmjAsEpVY0jsFLMner0uC2AZkH5bd6gc4bc8a6YSM1MtuA4W0Y5k/fsIILR
 jvxqWvlXQlLmoIUruHMn815QJcVSStLtitQbxfWD+junWMOPche3puNj39Wgz4OQvFQ2AMQJaRI
 gHHHAe1ntu+zQ0tNScmAU6eVzElWP3On7UoyGfGIlXiFm5UwbPtB4JhaYuYNhd92pYgl0ur1JHm
 mMlfLiWFsQXdQpjnhPUeQas4qncY1Ghbn3mgirpK/ZmZFoOV0EjtdlIntTyHvhHVnX8Iy/DU953
 YaZu5BEuYSl90E3igtfr6BmV9OIQ6ze7w7uSHtd8WnZ9blEDcSttCn/ldXb1BEo94c4kz/qh
Subject: RE: [PATCH v3] hfs: remove BUG() from
 hfs_release_folio()/hfs_test_inode()/hfs_write_inode()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 spamscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220154

T24gVHVlLCAyMDI1LTA3LTIyIGF0IDE1OjIyICswMTAwLCBNYXR0aGV3IFdpbGNveCB3cm90ZToN
Cj4gT24gVHVlLCBKdWwgMjIsIDIwMjUgYXQgMTE6MDQ6MzBQTSArMDkwMCwgVGV0c3VvIEhhbmRh
IHdyb3RlOg0KPiA+IE9uIDIwMjUvMDcvMjIgMjI6MzAsIE1hdHRoZXcgV2lsY294IHdyb3RlOg0K
PiA+ID4gT24gVHVlLCBKdWwgMjIsIDIwMjUgYXQgMDc6NDI6MzVQTSArMDkwMCwgVGV0c3VvIEhh
bmRhIHdyb3RlOg0KPiA+ID4gPiBJIGNhbiB1cGRhdGUgcGF0Y2ggZGVzY3JpcHRpb24gaWYgeW91
IGhhdmUgb25lLCBidXQgSSBkb24ndCBwbGFuIHRvIHRyeSBzb21ldGhpbmcgbGlrZSBiZWxvdy4N
Cj4gPiA+IA0KPiA+ID4gV2h5IG5vdD8gIFBhcGVyaW5nIG92ZXIgdGhlIHVuZGVybHlpbmcgcHJv
YmxlbSBpcyB3aGF0IEkgcmVqZWN0ZWQgaW4gdjEsDQo+ID4gPiBhbmQgaGVyZSB3ZSBhcmUgbW9u
dGhzIGxhdGVyIHdpdGggeW91IHRyeWluZyBhIHY0Lg0KPiA+IA0KPiA+IEJlY2F1c2UgSSBkb24n
dCBrbm93IGhvdyBIRlMvSEZTKyBmaWxlc3lzdGVtcyB3b3JrLg0KDQpUaGUgcGF0Y2ggZGVmaW5p
dGVseSBzaG91bGQgYmUgcmV3b3JrLiBUaGUgcGhyYXNlICJJIGRvbid0IGtub3cgaG93IGl0IHdv
cmtzIg0KY2Fubm90IGJlIGFjY2VwdGVkIGFzIGV4Y3VzZS4gOikNCg0KPiA+IEkganVzdCB3YW50
IHRvIGNsb3NlIHRoZXNlIG5lYXJseSAxMDAwIGRheXMgb2xkIGJ1Z3MuDQo+ID4gDQoNCldlIGFy
ZSBub3QgaW4gYSBodXJyeS4gV2UgbXVzdCBmaXggdGhlIHJlYXNvbiBvZiB0aGUgYnVnIGJ1dA0K
bm90IHRyeSB0byBoaWRlIHRoZSByZWFsIHJlYXNvbiBvZiB0aGUgaXNzdWUuIA0KDQo+ID4gWW91
IGNhbiB3cml0ZSB5b3VyIHBhdGNoZXMuDQo+IA0KPiBJIGRvbid0IHVuZGVyc3RhbmQgdGhpcyBh
dHRpdHVkZSBhdCBhbGwuICBBcmUgeW91IGluIFFBIGFuZCBiZWluZyBwYWlkDQo+IGJ5ICJudW1i
ZXIgb2YgYnVncyBjbG9zZWQgcGVyIHdlZWsiPw0KDQpPSy4gTGV0J3MgcmV0dXJuIHRvIGhmc19y
ZWFkX2lub2RlKCkgYWdhaW4gWzFdLiBXZSBoYXZlIHN1Y2ggbG9naWMgaGVyZToNCg0Kc3dpdGNo
IChyZWMtPnR5cGUpIHsNCgljYXNlIEhGU19DRFJfRklMOg0KPHNraXBwZWQ+DQoJCWlub2RlLT5p
X2lubyA9IGJlMzJfdG9fY3B1KHJlYy0+ZmlsZS5GbE51bSk7DQo8c2tpcHBlZD4NCgkJYnJlYWs7
DQoJY2FzZSBIRlNfQ0RSX0RJUjoNCgkJaW5vZGUtPmlfaW5vID0gYmUzMl90b19jcHUocmVjLT5k
aXIuRGlySUQpOw0KPHNraXBwZWQ+DQoJCWJyZWFrOw0KCWRlZmF1bHQ6DQoJCW1ha2VfYmFkX2lu
b2RlKGlub2RlKTsNCn0NCg0KU28sIGlmIHJlYy0+dHlwZSBpcyBPSyAoSEZTX0NEUl9GSUwsIEhG
U19DRFJfRElSKSB0aGVuIHdlIHByb2Nlc3MNCmEgcGFydGljdWxhciB0eXBlIG9mIHJlY29yZCwg
b3RoZXJ3aXNlLCB3ZSBjcmVhdGUgdGhlIGJhZCBpbm9kZS4gU28sIHdlIHNpbXBseQ0KbmVlZCB0
byBleHRlbmQgdGhpcyBsb2dpYy4gSWYgcmVjLT5maWxlLkZsTnVtIG9yIHJlYy0+ZGlyLkRpcklE
IGlzIGVxdWFsIG9yDQpiaWdnZXIgdGhhbiBIRlNfRklSU1RVU0VSX0NOSUQsIHRoZW4gd2UgY2Fu
IGNyZWF0ZSBub3JtYWwgaW5vZGUuIE90aGVyd2lzZSwNCndlIG5lZWQgdG8gY3JlYXRlIHRoZSBi
YWQgaW5vZGUuIFdlIHNpbXBseSBuZWVkIHRvIGFkZCB0aGUgY2hlY2tpbmcgbG9naWMNCmhlcmUu
IFRldHN1bywgZG9lcyBpdCBtYWtlIHNlbnNlIHRvIHlvdT8gOikgQmVjYXVzZSwgaWYgd2UgaGF2
ZSBjb3JydXB0ZWQgdmFsdWUNCm9mIHJlYy0+ZmlsZS5GbE51bSBvciByZWMtPmRpci5EaXJJRCwg
dGhlbiBpdCBkb2Vzbid0IG1ha2Ugc2Vuc2UgdG8gY3JlYXRlDQp0aGUgbm9ybWFsIGlub2RlIHdp
dGggaW52YWxpZCBpX2luby4gU2ltcGx5LCB0YWtlIGEgbG9vayBoZXJlIFsyXToNCg0KLyogU29t
ZSBzcGVjaWFsIEZpbGUgSUQgbnVtYmVycyAqLw0KI2RlZmluZSBIRlNfUE9SX0NOSUQJCTEJLyog
UGFyZW50IE9mIHRoZSBSb290ICovDQojZGVmaW5lIEhGU19ST09UX0NOSUQJCTIJLyogUk9PVCBk
aXJlY3RvcnkgKi8NCiNkZWZpbmUgSEZTX0VYVF9DTklECQkzCS8qIEVYVGVudHMgQi10cmVlICov
DQojZGVmaW5lIEhGU19DQVRfQ05JRAkJNAkvKiBDQVRhbG9nIEItdHJlZSAqLw0KI2RlZmluZSBI
RlNfQkFEX0NOSUQJCTUJLyogQkFEIGJsb2NrcyBmaWxlICovDQojZGVmaW5lIEhGU19BTExPQ19D
TklECQk2CS8qIEFMTE9DYXRpb24gZmlsZSAoSEZTKykgKi8NCiNkZWZpbmUgSEZTX1NUQVJUX0NO
SUQJCTcJLyogU1RBUlR1cCBmaWxlIChIRlMrKSAqLw0KI2RlZmluZSBIRlNfQVRUUl9DTklECQk4
CS8qIEFUVFJpYnV0ZXMgZmlsZSAoSEZTKykgKi8NCiNkZWZpbmUgSEZTX0VYQ0hfQ05JRAkJMTUJ
LyogRXhjaGFuZ2VGaWxlcyB0ZW1wIGlkICovDQojZGVmaW5lIEhGU19GSVJTVFVTRVJfQ05JRAkx
Ng0KDQpaZXJvIGlub2RlIElEIGlzIGNvbXBsZXRlbHkgaW52YWxpZC4gQW5kIHZhbHVlcyBmcm9t
IDEgLSAxNSBhcmUgcmVzZXJ2ZWQNCmZvciBIRlMgbWV0YWRhdGEgc3RydWN0dXJlcy4NCg0KVGhh
bmtzLA0KU2xhdmEuDQoNClsxXSBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92Ni4x
Ni1yYzYvc291cmNlL2ZzL2hmcy9pbm9kZS5jI0wzNTANClsyXSBodHRwczovL2VsaXhpci5ib290
bGluLmNvbS9saW51eC92Ni4xNi1yYzYvc291cmNlL2ZzL2hmcy9oZnMuaCNMNDANCg==


Return-Path: <linux-fsdevel+bounces-51957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A486DADDB36
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 20:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39D1B7AA516
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 18:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6942EBB84;
	Tue, 17 Jun 2025 18:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CSFxRcCY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92621E98E3;
	Tue, 17 Jun 2025 18:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750184433; cv=fail; b=IcXkRg2gie6rIbzBs14159Ui+0QNzMYa+g7O4T0Mg8e1ydlcwBdekdMGrrqf+GG2G3pBg28BoCeo5GdHfL5wcgTBceRc2wAkTs2yam/KjKY15/2uOKz0TckWAR1Qt2HxvdNdHhXCMVcjiQT9+qBH66+B9N0Krb/UYNGhbKZLC4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750184433; c=relaxed/simple;
	bh=bpGMXN0ybjCYlBkWVn1b3r/I7U1nNWAW+DkHRx7hcUM=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=HFFbQRw2mgsl1Q8Iwwddn3oDKBNdbUlh3v39EekUHEk21ueZBEwcaS8AAOJynzktjWB2YKKMB+riql5cAFrJS0qKB89rHuMJ1D1viYYuHiePLnGGoyL+n5vNwgO09rHQxZtfKuJmN/sz0aMpy+1kcTr57OK6jRAtseTeHqetbag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CSFxRcCY; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HFtMIB024164;
	Tue, 17 Jun 2025 18:20:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=bpGMXN0ybjCYlBkWVn1b3r/I7U1nNWAW+DkHRx7hcUM=; b=CSFxRcCY
	0mViBQ5r6W3Tm3/6BmAPtyehYQy30R35O8XDslKGlPpYY6Reof5iL6i0jByNEnnv
	XUUQvmcrio3pqGSr/ER79kFmqX5djNzzCBWKhP/Q65mPHJC5nb+LqVxGtCvp92WS
	2CHab7i1To3pCnIVEdSs3b9+hOSMtecap/x5YVwlPunjPtq6C8TXzqXaOkO0K1xV
	x820LVX4JzGL9wSHRtqtZmPZva4pmq0U/73uqX07FOrAisjYwsyR+gfWbYRlBIzi
	ExKIroitQwT1eUKhLRF0WQqwBZpaJ0S1SOanU/Lxg+KqZoKluY7A1DiymEz2JiMC
	qqEroH3r8t97cg==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 478ygn9y24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 18:20:30 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A9QmMCUIImGursAEo+L05FZ6RI+LGA/n88yg+9NLZRbFOUISdePyuOtVVkKirRPovpzEMoNUG8bbhinz9UvgtqB82b0vYx59NcZ74Bqr3Fsj9ox8+cjjWId1TrSA35wxiDiB6NOIxdeMgvl1ZFhJ1jNZhjVeoWT+/CUgRernAIeBm1a8L1Rk1ic/vPX5f7HrD3wKNAUlQX3qyvh3ys/3TxJLBx3MJCprK+mpm8P2DZLZ60dQ8k7ZjDeMMYSlCU/7AHET+bEcyQoGYBdGO+JYVADEowEruT58IB4JdNAaH7XekSSod0BBoLxgEvPNCz0h4MsUUAsyLZryaEHK9r5rWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpGMXN0ybjCYlBkWVn1b3r/I7U1nNWAW+DkHRx7hcUM=;
 b=PfZc2ygBWNbs0PaFhdMCNq7VF/cR8bDeb+EaL8RRRlzPh1I8a1BMDuk5fayInu2nanfQ81vpsjcWWSqOsEtcR6fU6KrLPdLNcBFzV56LtWdIhtUXWFG0JHIoLrM7/RCaAdLgapIXWEILKRaTJl3gcYE/IFPCv0SK+4Bu0fBx6vQxvlztmPtDJuY2x/W6Qhi288p2gkV/wUFl9DrzcEyYQEljsV7Lfz8Zt8XcQzQtda+WrBB84EXieIETO8Ty+fG/2teCEvB8KyosvY6USFhqSlqEDlzVhRDrQBCu3xk0SsPRsO7p5vpVjV43FN7IJkIkESmcajg/YABv6QQRfECKog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CY8PR15MB5554.namprd15.prod.outlook.com (2603:10b6:930:96::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 18:20:28 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 18:20:28 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH 1/3] [ceph] parse_longname(): strrchr()
 expects NUL-terminated string
Thread-Index: AQHb3PTK/yyYbNdB2UKS5Tzy82I0NrQHrxaA
Date: Tue, 17 Jun 2025 18:20:27 +0000
Message-ID: <1517ae63870273b539451b4de22df9ac42476591.camel@ibm.com>
References: <20250614062051.GC1880847@ZenIV>
	 <20250614062257.535594-1-viro@zeniv.linux.org.uk>
In-Reply-To: <20250614062257.535594-1-viro@zeniv.linux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CY8PR15MB5554:EE_
x-ms-office365-filtering-correlation-id: e521d248-3616-4832-6216-08ddadcba2d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?amVzTHdpRDExRVFQV1pma0J5QUV3ekIveWVWRHZSSGI5Z1N1dWdUcFFIYVVt?=
 =?utf-8?B?YVBGMXI2aTBmUmZHblBmTzNSRWF1ZUpLckFrdDUyQjkvSVdXa3QxWmVQMVMr?=
 =?utf-8?B?WDFNY3Q0ZGRDRzJLM1lIRmJnQVU1UjhCQ3JLNFlwY0dMVmVhMXFzMnd2c3lx?=
 =?utf-8?B?dEVOTXErM29tdFdYclk4NHRVY2hrbGdzbm9sRWVnZmxELzBIdS9lUTZGMjJ6?=
 =?utf-8?B?dGZiTWNCTzUyYkRCdVlqR3libnFwSjBFU2hJQVNVWWFGQjlCbkU1K2dYQ1hl?=
 =?utf-8?B?WEJIWCtHTEVtejkrelJGbTZSc1RudWxiZlg5Mk5YY1BhdjdCNU5nTDd5TFJW?=
 =?utf-8?B?RGg1Z2g4MmpUTDVoZHJnbEVsMSs2NUF0a3l0TEtRZHRoK01YT1JRN3dGWnpH?=
 =?utf-8?B?TEY2ajFaSjRwUlNER3hDNkZPU1oxY0dRRXYrQUdMMFdKQ1JKVVJtZ2tnL3p1?=
 =?utf-8?B?aEtyWlBoMk0vazdwVlZMLzEvU243bWFqb3N2VnhPWU1lVUg3K3V0T3pYSExa?=
 =?utf-8?B?Y0NPWHBvQ3hhT2lQZ1VjaytibkNiaENqOTI5RVZmY0xSNDkra29vbllGRmZX?=
 =?utf-8?B?aW9Qdk1WOFJVdGV5aDM1Qi9kc2xHY2RHeGhVSDk0UVhqcGlPVzJra1J1QkRv?=
 =?utf-8?B?OXhObkZoN2RBTnp0ckx6OUNGdktPUlJSeTY2NlRrMEhBbFJ4dUVQOHlKREJi?=
 =?utf-8?B?dTY3b2ZkZ1FVRW5LajhQaHJSYUFIWVBCMmNWZ2l2SCt5c2dxbm5qRXlmVlhD?=
 =?utf-8?B?VFhHdDVkc0xrZjR2SDRnbnpBNWg4TldoUGpoZHlzcmd0ZGdHRFpjam0xb1BM?=
 =?utf-8?B?SWt5SU9YVzdMclVGeHFkVWpHNW4zZzFucnF3MXR5TjNsS3JJL2tGcTlMd0R2?=
 =?utf-8?B?c2l4WXJaWEoyckNXQnVSNlMyRm9SZFdjOElFUGNjTkJUc3VTZStZamNwUTky?=
 =?utf-8?B?Mmg3M0kzY05CZHg0bFZ5M3FmTmVvZWY1NmJDbUErMUxJTmphWmxHbHh2dzNq?=
 =?utf-8?B?RnBPMEpkV3BLQkd5RnlidWpLUGR6K1E1QzRsTVg1ZWcwelRDcklWb1dxa3lN?=
 =?utf-8?B?MWVMOHJyeis3aUh1K2xpQlpIM2ljYUNZZThhRGcvd0VUYXJjVTlDTUJ4djhw?=
 =?utf-8?B?R2dYYjcrUFYySmtjVkdQTFArVkJYVStSNjY1Zlh5eUJWQ2ZKV0NxNzY3MjZ1?=
 =?utf-8?B?dXVhNjJZd25STDFISEw0OVV6ZElncjUrWlJGTVNGWXVjaDIxUmhVUFlJS0Mv?=
 =?utf-8?B?bVBvYlV2ZWpqQlUrZ1N6UHF4bmdPTStpN2RYZDhZcUVvWkdyR0J1bDNHdWZz?=
 =?utf-8?B?a0w1QkkvYWl1dmtMdzdEN1BwRVFQNXdJa2I1UDB3VlhYNGNvdVNVOS9ZK3VB?=
 =?utf-8?B?UlYrWU9tUzlSSDZLWERoM2lrYzdXZkt4aWM5ZUdDeWJzSUYwRWRHVENTeUxP?=
 =?utf-8?B?V2JKNzhINjJGYnVjclpVc1BVSWl2TUxxSUFONE1wUDVPMk53elpaZWpVelNZ?=
 =?utf-8?B?cDR4VTdsWC9kL1NoU2x6VnJHT2s1WldudjB6dXc0dUltTjJwbVdQbVNUeHcv?=
 =?utf-8?B?akNJR0lIdFNtcGtCenVsMGUxUEFVRzFKWTI1VkRwOVZaQTkreXNiNWRiUEZE?=
 =?utf-8?B?VTFMZ0xvN0d5cStma2t4aGhvbW5HaVRZVmRUMlAvcXc4MythSFNqOCtXU2pj?=
 =?utf-8?B?THBLdi9oM1ZVQm9yeldVMU9LUkNwS0E4Z2ZwcWFvWVl0WlVJelZUSWRtMG1C?=
 =?utf-8?B?c0xYcDFoZWF1VFVON1FUWFN0d2lUTDlnMzNTWnpkZ2dmdUczN3NmY3JVMm1X?=
 =?utf-8?B?NndJMjBiL2wwamRNb3pCS2ZDczRIKytJTUw1bWxUN2ZyZHFycHBIeWVveDZH?=
 =?utf-8?B?ZmIxUVZGc1FkVVpkblZ3TTlyTDlrVXJDOW1sWnBvbEhvSHN4ODUzMXNsLzVI?=
 =?utf-8?B?VjU1Q0lySDd4aFlTNWdYWURjWkxpYS80ZGgxeXZtOTVnRW4zT1N1dUVCa2xK?=
 =?utf-8?B?emFQZ2dRaE9RPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eFNDR3BvR1ZUMmtNQnp1dUpjUXpyOWZXQXNURUdjK3EwbUNIUkliRCtQSDZ6?=
 =?utf-8?B?SC96ZDZHUGtWeVgvazdwZ1RWRFVJYXdlMWJmL1JBRFJqNmFoNTRhZ0tVbjgx?=
 =?utf-8?B?TkptZXVhNjJQOG0vWW1nQSs4TnJpeDdnRXFzcmwyb3g3QkVSZ3FkQzBtVGY2?=
 =?utf-8?B?QmhMTFhIQ1d0QktWSEtEYUNiQm82c3E4dnhWRVVMSWJRSzhnUlN0UERFcnBh?=
 =?utf-8?B?TVNQY0srT3czZTYzcVBXTXNjTWNDSmpXSDdtQk51VW56cTdIZjljaTNyK1lC?=
 =?utf-8?B?MXVzc29VaklPMndpOFhqWnNUejJNWWVaWmx3a0NEMzlWYlVCOG1KR2dCYnRX?=
 =?utf-8?B?d1Y3MDJSNzYvMm9RemdDb2I2dndGK25UMGxxdWQrWFgzZEVRYVdrNzBqWlFC?=
 =?utf-8?B?cVJZRS9SVU5lb203eDRqdkdCQjZpTi90NkdVaU1mYlE3S3JJZ1dlNmE4eS9t?=
 =?utf-8?B?MFFnY1hEWkl5T2FNY01wQzVIS3Z5dXRkNXdta053Sko0NHNrUU54TkU4Vkx1?=
 =?utf-8?B?M3dWQ3IwMHZ1U2E2Z20xK2ZwZ1cyTXlxNDJlMEZsRDFnSEZFY3hQWE5vRC9S?=
 =?utf-8?B?WmE2ZGNxcU9DTkVQK2JVVXUzTm9PT1dqWGpOaThUV3FYMCtjcGMyVnYrbnBr?=
 =?utf-8?B?b0taRjZzK09OSDZYdXorUVIyd3hoemtFbWxMRmxJS2R2U0IxQWkwaHNlQkdI?=
 =?utf-8?B?dElKZ1JGaHNaWG5ualhVTXhKSXZiUkpxZjI5NEF0bUxRdzFrQk1GMHYzZTE1?=
 =?utf-8?B?STdIRS9xbnRNNVJEdXNVNDF5RWFOVmc3WE41Z3luWVFnQmlSRy9lR29GMDEy?=
 =?utf-8?B?RCtyVmkwTVBJTnZCakF0ZVlKdTVkRmI1TmxKTCtudzNDc3JFUzBRbno4Y0Zz?=
 =?utf-8?B?Yld6Z2drSUxiWHN3dGJyaXlCZ1hTeGl0MHlveVZpTStRcEpFRlhEVm16U3FW?=
 =?utf-8?B?bzUzby93UFpTN200OFIxRU9ucU1taWlsRTZVVFJXSVcvSzJsbFpQdWc1S1RW?=
 =?utf-8?B?ek9FaVNmckVCRjNOSGJkcms4OWZ4WDlKczBSWDdsUWZFRWUrNTFwU1hYcXhK?=
 =?utf-8?B?QkV0U1JXWGVYeVBUZzlOQ1BFaThsODRlN01VT3RKVGtVZi8vQkE4VnB6MG9j?=
 =?utf-8?B?di9pTjMrWjZ1dHVpNmRLRmhPeDBWaG1DNVBVWG45Q3dRZW95UzlUUkVHVEwz?=
 =?utf-8?B?bG5EK1FPbkVXd25VVTErU25mbkYvL2dNMmtyQ29mYUxtWkdqYS9JM3VZQzdY?=
 =?utf-8?B?UTlEY1NIcUNIMlh0K3VuL0JjNzlwN1lkSEZBUFYzcXAxMFY0TkdNa3JuN251?=
 =?utf-8?B?NGlPZ2VySDF1U2k2L254cERhSzYxdW52Yk04QVplSU13dFVmWFk4U2VYK3du?=
 =?utf-8?B?ZEt0T1BLL1Z0YmNhY2t3SHRScTE1SW5pWDRLNkJwSkZVRGFsWFIyWFJQbE5x?=
 =?utf-8?B?VjV1cVY0NUdhUjBzNVJWNU9lMG43VElpczF0OGdrakw4WXNyZGUvWlF4UHcr?=
 =?utf-8?B?Ujd2RFFld3lOOGdTbjB0bk5KRUtEK216dU0rMTNCbzhnS0VRSk5TdTRPd3li?=
 =?utf-8?B?QXBlSGlSQkJPZkJNNjlHbXRRNmE3WHJNbnIvRW9MTmJ3a2ZYNlRiMVNlTkh1?=
 =?utf-8?B?aE1PcW81WURRekFUMThUa1N4RS8relN4K1JteE5DV3I2SGJSbjlDK0NZODRv?=
 =?utf-8?B?U05CdGJPWk53aWNuZzFkTnJ0VTVRQk9PcmRQR3hTODd1SjVRcFFyLzE0OCtv?=
 =?utf-8?B?NmZ3Zjg5VjBZMFdHME8xU1dBTzNqTDRDM0RhdzNmd1B2NEVWNzZ4a0VpaHBs?=
 =?utf-8?B?Q0p1N29iaXN2QnhrdnZPS1NVWHJKa1Q4MjY3UzdEVmhtMGY5UDBLUXRzcEE4?=
 =?utf-8?B?bWI4OEI1M0xJNTRxSEgxRDd0alhJVVk2SGV4OVlmYjh0aFE1K0hRd1hSTUxI?=
 =?utf-8?B?YW9nZkNDRC82R2FOdnF0M3hYR1A3SVJzMWNORlkrVC8vQWYxTjVUZ2Y1S0h1?=
 =?utf-8?B?SjRVSGplT2xlUmp5T0IydllYTW16YnNHUk55alVjQWxXTnJyTFJVcmpNUFNT?=
 =?utf-8?B?Qm42bGV6WUZWVkFNaVp4TnN6dGJuQ1JEU1psMWpCd0ZjYW95Vmoyd1IyeVdO?=
 =?utf-8?B?UkxEVFY4TjlaTUJtUFF5WHZtbzRlb29yeU5LVGU0LzdNejV6RGg3bCtMb0FL?=
 =?utf-8?Q?4THr9mpJo1FDT2IWKcv97kQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE38B18B6D84A94A9B82F1E41B34226C@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e521d248-3616-4832-6216-08ddadcba2d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 18:20:27.7573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Y+3KdCJPOBz+Vsq9SBmizyRS0QPu9NZsqN+szvQQRX9qaXg5S8+TvCXaS9r+XP2bRVJCyQTP4TS8kTMpu7kCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR15MB5554
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDE0NiBTYWx0ZWRfXxwoQt+q+xvgD jIglQRz1YJTJmt6S5wd5cUjz+Uoru5oFdL8wE2RPYZ0vlYoidNrCH+puaTiK4viX/hdpGN7Q2YY GVOwwJY83Dntb7ejY39PFB+TeR7lFKTrAB2Z1Gs+ZIMuXsJHB3H77byEVWfcORwG9iofW2kPsOH
 V67Gia3JX3aZQ3FJ0/boPlbs6yrMhVAh2IuR++G/6sL4yjTSRmsio28RQARo6PxnYnuivTEZE8P uFGucoqSqc5l7rX3qvF8cGVGMs378mLmisbW0uq6K/1fQapzA1Jw7/0VTkuK7NjD/QzhouLm/CN +8TOJw+xj47NvHnRR9aR+j3brH207qd3gusKXyaQYNYXlB58TPeW5lQhg2hYpSHvNSy+nBE6sAs
 +kIydc/373yRe4qywppHFWSQsULjpfw+H04a64E+ihxjRCcsO/WZA3arhs+WzZ8Q0uKtF5U4
X-Authority-Analysis: v=2.4 cv=fYSty1QF c=1 sm=1 tr=0 ts=6851b1ee cx=c_pps a=gvNdZeZLI4sMnB7r/Qo1Rw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=drOt6m5kAAAA:8 a=VnNF1IyMAAAA:8 a=CHUNlfOHq9e8nngb4K0A:9 a=QEXdDO2ut3YA:10 a=RMMjzBEyIzXRtoq5n5K6:22
X-Proofpoint-ORIG-GUID: 9eHtXgQsqOu0-m9t_RvoMkqUBMNVI2IJ
X-Proofpoint-GUID: 9eHtXgQsqOu0-m9t_RvoMkqUBMNVI2IJ
Subject: Re:  [PATCH 1/3] [ceph] parse_longname(): strrchr() expects NUL-terminated
 string
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_08,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506170146

T24gU2F0LCAyMDI1LTA2LTE0IGF0IDA3OjIyICswMTAwLCBBbCBWaXJvIHdyb3RlOg0KPiAuLi4g
YW5kIHBhcnNlX2xvbmduYW1lKCkgaXMgbm90IGd1YXJhbnRlZWQgdGhhdC4gIFRoYXQncyB0aGUg
cmVhc29uDQo+IHdoeSBpdCB1c2VzIGttZW1kdXBfbnVsKCkgdG8gYnVpbGQgdGhlIGFyZ3VtZW50
IGZvciBrc3RydG91NjQoKTsNCj4gdGhlIHByb2JsZW0gaXMsIGtzdHJ0b3U2NCgpIGlzIG5vdCB0
aGUgb25seSB0aGluZyB0aGF0IG5lZWQgaXQuDQo+IA0KPiBKdXN0IGdldCBhIE5VTC10ZXJtaW5h
dGVkIGNvcHkgb2YgdGhlIGVudGlyZSB0aGluZyBhbmQgYmUgZG9uZQ0KPiB3aXRoIHRoYXQuLi4N
Cj4gDQo+IEZpeGVzOiBkZDY2ZGYwMDUzZWYgImNlcGg6IGFkZCBzdXBwb3J0IGZvciBlbmNyeXB0
ZWQgc25hcHNob3QgbmFtZXMiDQo+IFNpZ25lZC1vZmYtYnk6IEFsIFZpcm8gPHZpcm9AemVuaXYu
bGludXgub3JnLnVrPg0KPiAtLS0NCj4gIGZzL2NlcGgvY3J5cHRvLmMgfCAzMSArKysrKysrKysr
KystLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygr
KSwgMTkgZGVsZXRpb25zKC0pDQo+IA0KDQpJIGRpZCBydW4geGZzdGVzdHMgd2l0aCB0aGUgcGF0
Y2ggc2V0LiBJIGRvbid0IHNlZSBhbnkgaXNzdWVzLg0KDQpUZXN0ZWQtYnk6IFZpYWNoZXNsYXYg
RHViZXlrbyA8U2xhdmEuRHViZXlrb0BpYm0uY29tPg0KUmV2aWV3ZWQtYnk6IFZpYWNoZXNsYXYg
RHViZXlrbyA8U2xhdmEuRHViZXlrb0BpYm0uY29tPg0KDQpUaGFua3MsDQpTbGF2YS4NCg0KPiBk
aWZmIC0tZ2l0IGEvZnMvY2VwaC9jcnlwdG8uYyBiL2ZzL2NlcGgvY3J5cHRvLmMNCj4gaW5kZXgg
M2IzYzRkOGQ0MDFlLi45YzcwNjIyNDU4ODAgMTAwNjQ0DQo+IC0tLSBhL2ZzL2NlcGgvY3J5cHRv
LmMNCj4gKysrIGIvZnMvY2VwaC9jcnlwdG8uYw0KPiBAQCAtMjE1LDM1ICsyMTUsMzEgQEAgc3Rh
dGljIHN0cnVjdCBpbm9kZSAqcGFyc2VfbG9uZ25hbWUoY29uc3Qgc3RydWN0IGlub2RlICpwYXJl
bnQsDQo+ICAJc3RydWN0IGNlcGhfY2xpZW50ICpjbCA9IGNlcGhfaW5vZGVfdG9fY2xpZW50KHBh
cmVudCk7DQo+ICAJc3RydWN0IGlub2RlICpkaXIgPSBOVUxMOw0KPiAgCXN0cnVjdCBjZXBoX3Zp
bm8gdmlubyA9IHsgLnNuYXAgPSBDRVBIX05PU05BUCB9Ow0KPiAtCWNoYXIgKmlub2RlX251bWJl
cjsNCj4gLQljaGFyICpuYW1lX2VuZDsNCj4gLQlpbnQgb3JpZ19sZW4gPSAqbmFtZV9sZW47DQo+
ICsJY2hhciAqbmFtZV9lbmQsICppbm9kZV9udW1iZXI7DQo+ICAJaW50IHJldCA9IC1FSU87DQo+
IC0NCj4gKwkvKiBOVUwtdGVybWluYXRlICovDQo+ICsJY2hhciAqc3RyIF9fZnJlZShrZnJlZSkg
PSBrbWVtZHVwX251bChuYW1lLCAqbmFtZV9sZW4sIEdGUF9LRVJORUwpOw0KPiArCWlmICghc3Ry
KQ0KPiArCQlyZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsNCj4gIAkvKiBTa2lwIGluaXRpYWwgJ18n
ICovDQo+IC0JbmFtZSsrOw0KPiAtCW5hbWVfZW5kID0gc3RycmNocihuYW1lLCAnXycpOw0KPiAr
CXN0cisrOw0KPiArCW5hbWVfZW5kID0gc3RycmNocihzdHIsICdfJyk7DQo+ICAJaWYgKCFuYW1l
X2VuZCkgew0KPiAtCQlkb3V0YyhjbCwgImZhaWxlZCB0byBwYXJzZSBsb25nIHNuYXBzaG90IG5h
bWU6ICVzXG4iLCBuYW1lKTsNCj4gKwkJZG91dGMoY2wsICJmYWlsZWQgdG8gcGFyc2UgbG9uZyBz
bmFwc2hvdCBuYW1lOiAlc1xuIiwgc3RyKTsNCj4gIAkJcmV0dXJuIEVSUl9QVFIoLUVJTyk7DQo+
ICAJfQ0KPiAtCSpuYW1lX2xlbiA9IChuYW1lX2VuZCAtIG5hbWUpOw0KPiArCSpuYW1lX2xlbiA9
IChuYW1lX2VuZCAtIHN0cik7DQo+ICAJaWYgKCpuYW1lX2xlbiA8PSAwKSB7DQo+ICAJCXByX2Vy
cl9jbGllbnQoY2wsICJmYWlsZWQgdG8gcGFyc2UgbG9uZyBzbmFwc2hvdCBuYW1lXG4iKTsNCj4g
IAkJcmV0dXJuIEVSUl9QVFIoLUVJTyk7DQo+ICAJfQ0KPiAgDQo+ICAJLyogR2V0IHRoZSBpbm9k
ZSBudW1iZXIgKi8NCj4gLQlpbm9kZV9udW1iZXIgPSBrbWVtZHVwX251bChuYW1lX2VuZCArIDEs
DQo+IC0JCQkJICAgb3JpZ19sZW4gLSAqbmFtZV9sZW4gLSAyLA0KPiAtCQkJCSAgIEdGUF9LRVJO
RUwpOw0KPiAtCWlmICghaW5vZGVfbnVtYmVyKQ0KPiAtCQlyZXR1cm4gRVJSX1BUUigtRU5PTUVN
KTsNCj4gKwlpbm9kZV9udW1iZXIgPSBuYW1lX2VuZCArIDE7DQo+ICAJcmV0ID0ga3N0cnRvdTY0
KGlub2RlX251bWJlciwgMTAsICZ2aW5vLmlubyk7DQo+ICAJaWYgKHJldCkgew0KPiAtCQlkb3V0
YyhjbCwgImZhaWxlZCB0byBwYXJzZSBpbm9kZSBudW1iZXI6ICVzXG4iLCBuYW1lKTsNCj4gLQkJ
ZGlyID0gRVJSX1BUUihyZXQpOw0KPiAtCQlnb3RvIG91dDsNCj4gKwkJZG91dGMoY2wsICJmYWls
ZWQgdG8gcGFyc2UgaW5vZGUgbnVtYmVyOiAlc1xuIiwgc3RyKTsNCj4gKwkJcmV0dXJuIEVSUl9Q
VFIocmV0KTsNCj4gIAl9DQo+ICANCj4gIAkvKiBBbmQgZmluYWxseSB0aGUgaW5vZGUgKi8NCj4g
QEAgLTI1NCw5ICsyNTAsNiBAQCBzdGF0aWMgc3RydWN0IGlub2RlICpwYXJzZV9sb25nbmFtZShj
b25zdCBzdHJ1Y3QgaW5vZGUgKnBhcmVudCwNCj4gIAkJaWYgKElTX0VSUihkaXIpKQ0KPiAgCQkJ
ZG91dGMoY2wsICJjYW4ndCBmaW5kIGlub2RlICVzICglcylcbiIsIGlub2RlX251bWJlciwgbmFt
ZSk7DQo+ICAJfQ0KPiAtDQo+IC1vdXQ6DQo+IC0Ja2ZyZWUoaW5vZGVfbnVtYmVyKTsNCj4gIAly
ZXR1cm4gZGlyOw0KPiAgfQ0KPiAgDQo=


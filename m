Return-Path: <linux-fsdevel+bounces-69713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0926C824E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 20:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58CD13ADBB4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 19:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBF92D73A6;
	Mon, 24 Nov 2025 19:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e8nrCJBh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31421F5EA;
	Mon, 24 Nov 2025 19:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764012586; cv=fail; b=o+XYi3mWMc43sx3SJqmjHSk3eMPT5qvT0Ecu4AEmfciZHeZphXxE/tAZQvc6PdBzhNUntpEw752oNYtgftB1iorUUlWSYlcEdnU0u+ZAFPhZ3BofJfH5uMhrvx5e9fwu8KRkanPJBTlJdeVgUzfpboTo5E+cE5SYv4ENyNmcCnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764012586; c=relaxed/simple;
	bh=/1JxvxWqAmdraPhMNnBBQzcyF+UQNz0lK5YA8zp4boo=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=lcKShwtGpo2nOJkkaY7fhfphGypZWlUtSu36uLjnnZ4KEJo2TlyGbwiRWJrCL4n4fnI2tUqhYR96LI+gfTRVZMyFl2sN+3PVct7zhKIIywLJBr1yj15zuns79devMhkjDm8edIKoY+c5tIexCPakKTzv8L7w6qgLdaskhCeYq9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e8nrCJBh; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AOEUZxD008974;
	Mon, 24 Nov 2025 19:29:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=/1JxvxWqAmdraPhMNnBBQzcyF+UQNz0lK5YA8zp4boo=; b=e8nrCJBh
	X4GeFxo8KMkFDgk5HQmta309HvMzrXHaCPcfqjDTSABzZeeFWrNLe4qoStrBZGQR
	5sbE9Bq5s7urDU8tZWJTj4J5imCjrmuikw4t55Uq4IpQxyg9Wz675clSDpEuHDUi
	LrDfIuOkZbhQ2KEXQWuufGlpWFyOMJx9RmI0DMVw1ls9uyuoK6+NkdFonbe0qE1o
	TWLLYzeyXwBLe7ajYFPXKAzbiHJaE9yePIuETv6EEPvgDuxWu0LvllJxxAUP3VI3
	H7vZNzhJ+FUOWb9QryQt2D4IwisIwok5q7W4ZHBDTrTzSYVIKjXIsfIwfYTG7e7V
	iMcJqruKDdiGfw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak2kpsh6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Nov 2025 19:29:39 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AOJMdwq019397;
	Mon, 24 Nov 2025 19:29:38 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013005.outbound.protection.outlook.com [40.107.201.5])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak2kpsh68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Nov 2025 19:29:38 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Muh5LP6iZyjyLLBbOTNgUSw5/RgpOgH0tJBgDHvbhELEQsSSrcaVki8frSs+4aTEb6PTz8Bv4GBLsisrA/uFm6vEgSdaH21BXXqfdIGR6ZhxL5ANJGFiRXc+tu68A8g1hQ9Qh9XcA4scJ/SPYNDi8mdZmnNvqKgf7tC1O7QoPy47QR/JWbT3jSJB08EAnQS6khMxa/Ug8LmvdxfgqyM0s8FLKcJPyko8SKXji35Nt2lej0SmIzE3qR3wDpwponBz1O/ifHoGAofDyzzsHCoAwbopBzC/EgmNllRrhu9O5oFYYqA0RpPw9vX3LIWRj65ZWvh9nvBjsGdLihurtIJdrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1JxvxWqAmdraPhMNnBBQzcyF+UQNz0lK5YA8zp4boo=;
 b=moAlaWBkgZM2PIfX4aCVNsqIHrDYQEJdjCAZvIcm34ce8dkdSz8J9D/bRodg7cHLMRqARU9XMyKLLZes+HjhYvBiM0N1dz+tBy/V9fldXW4iyFQZ4x1akZKRww5SdhUgaPPO5wjBIq+Uku7wkPODO8YSPHiLc8C2Q3YTene0Nou90FYXLuqKwmztxKQpSX/0ali0RhTCNdcPzrOzB41WwNJh6zBALbTSflLW2VCJFV5TvmzUv1tD5dbfM7LrgNR+FAos7mkISA6RAtGhddb11fqo8OQPWbrE8jtbCBcEPwbTNVMWapSVAhCpTulBeXPtd4N53LMeEBpxU4A1Iaha1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by MW3PR15MB3947.namprd15.prod.outlook.com (2603:10b6:303:49::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 19:29:36 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 19:29:36 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "david.shane.hunter@gmail.com" <david.shane.hunter@gmail.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "jkoolstra@xs4all.nl" <jkoolstra@xs4all.nl>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzbot+17cc9bb6d8d69b4139f0@syzkaller.appspotmail.com"
	<syzbot+17cc9bb6d8d69b4139f0@syzkaller.appspotmail.com>
Thread-Topic: [EXTERNAL] Re: [PATCH] hfs: Replace BUG_ON with error handling
 in hfs_new_inode()
Thread-Index: AQHcW+lhV3QTonXwSUWFv1OgtIuyGbUCOYGA
Date: Mon, 24 Nov 2025 19:29:36 +0000
Message-ID: <0e678a65d147e642a09861ea833efbd40b098d10.camel@ibm.com>
References: <20251103131023.2804655-1-jkoolstra@xs4all.nl>
	 <54e47f6ae96b4ed9bc30bd8c58487fa4d5cb6538.camel@dubeyko.com>
	 <1287044022.2349785.1763841059344@kpc.webmail.kpnmail.nl>
In-Reply-To: <1287044022.2349785.1763841059344@kpc.webmail.kpnmail.nl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|MW3PR15MB3947:EE_
x-ms-office365-filtering-correlation-id: 560107a3-ec76-4a19-301d-08de2b8fcdaa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?T0MwckdQVU8rWjlYOTYyRFlSSnY1T3huUlpaSmNNa2d0SXFrVU5PejZaUHZH?=
 =?utf-8?B?bDlqTU5jZXQ4STU5dzJrVzdVQ2VpQUwrYkZ1THd1M1VPMFJjRzAyNGt1aDNH?=
 =?utf-8?B?RXRtOFYwWmFuUGRxU0RuUXJ3ZlpQMTdnbVdRSGkrN05Rb0FQdElQYVZtVnpn?=
 =?utf-8?B?cDV3am1QNGVwc2VFR3dqbCtzb0MwMjB5OTl6U0lKblIzdHVLbW1uYVBLaFow?=
 =?utf-8?B?M2M4ZjJocEI4R3hSQ2ovTTM0SFZZakNlQ1NqZ0dMQWJHd3VIbGNVM2l5RGxF?=
 =?utf-8?B?SUs1T2dzK0xJbXpLbFBucnpZaUNxRTdhTS9rV0UvSS9ldTduS2RORTk3LzM5?=
 =?utf-8?B?LytvQmhuQkN5QXJqay9SU2txL2hUN2dWeCtjd2JZbjlhMzNjSXkrZzJPOEJx?=
 =?utf-8?B?YVRBZ0ZkdXpWY2VsK2UrWWQvc09WemFEc3JLT3dZcTdyL0thT2JzTEo5Q2Yz?=
 =?utf-8?B?eGlJRWY3WWRKL1pJUlE1YkM0TUIyMzRQa1dPRkJUZWFGdmx3cFpVci9uVk15?=
 =?utf-8?B?bkFJc2toZVgvbHNndHdlaSsxVm53ZHA1UGVPdXpvL29ZRGh1RlZIckp0VEd4?=
 =?utf-8?B?UDlRd0lxck9RMERON3Z4N2hOU0FDcUljRHd4NE0rMm82RXl6Vk1xK2g3V0Jk?=
 =?utf-8?B?dEUzSUlnTC9DbTk1djUyRHpTSXErSUV6SXVkbGtmYWpqMzM5bEg2N2FjZE0v?=
 =?utf-8?B?R3JlT2JpZFlNY2E4WkwxcEF0YmlOYzgxbGlVZTc3U1ZJbEg5eXRRdmFzMmk2?=
 =?utf-8?B?YklwSVZoUzBnS0lCUXUwN3F2d0ZTMGNBV083cFJCRnZRcjJsekJ2REZOejBa?=
 =?utf-8?B?YmkzMDNqMXc4Mi9QYXcrQXpINWxBTVdwZkJoYlhnbnEyd2gwRE9WZW1QWC91?=
 =?utf-8?B?ajQ1UnlwMkpPcGFkQzZ5dmNhN2lFV212S2tZWXBIQ3U1aVB2MURCaG16eVhQ?=
 =?utf-8?B?RHRrT2tWVHVuUlVqSFlRUElNRUU0TDlGTFFnNUhWSzhrT0M0dFRSUnJ4emFY?=
 =?utf-8?B?S3FPbnRpblhaQzNPMW13dE1MUllDL0U0RGZmV2lsaTFSYVlHVUxEaHR0dHVR?=
 =?utf-8?B?a1JvTTIvSFRMYjhvSkJweVR0cHUrTHhCNk1odU4zdXp1ZkJNZFNlL2JxNjMw?=
 =?utf-8?B?eGpOeFJoODFORVhReU5KelV1Z0ZXWTErTUFLb2x3amorZy9Za3BFNHdOWHNx?=
 =?utf-8?B?aXpXTFMyMU1xL25SQ1hJbXZFZWFXR2xTY1RiMVhHZ0hUSTBEaGRZOXp4TXJh?=
 =?utf-8?B?QitVb3BoMFBTS01hdEtJd1hURnlOVkxITDNKc0tYTDZMRE1TakxsVDByNEQv?=
 =?utf-8?B?TU42QkxDUllEd3ZSWGlFaXRzVHJGSElqN2UrWGYwNDBwaUw4SWRuUkV6Kzgr?=
 =?utf-8?B?U2xYUUprVFZ3MTFlVXBwcnU1elRHY3MzSVJyVFE3RnMzclVXRlB6TDltTHJK?=
 =?utf-8?B?SUw0ZDQ0aXlLc3VqVVExclpqNW5wYnplM3p3STc1aE1CTFhteFNuRlh4OXU1?=
 =?utf-8?B?aUhSZTg1Q2V3bTdoYUZORHByYURGUVQ3RVZBQi9sZGZwQ251N0hvR0lhTnZO?=
 =?utf-8?B?elBJNGdQQlh0ejFnbTNaQnRQQ08xc21nbVBwbmhkOTcxaVRKVDdpTGVBNVFp?=
 =?utf-8?B?WjdrbTRyUWc2K20vdXF5aitZY01YMGNpRjVscXdLSlE0R1lnNUlUa1Z1bmc2?=
 =?utf-8?B?UDFWWGZ0ZDBwUGRxRmtQT1g4Wm0rNzFZWHlrVGxrS2JoNDlLN2pqU0tndC9Q?=
 =?utf-8?B?STlSV2pHNVJBOWxQeHpDSy8wQlBjaHA5aSs3eDFjRCtFcnF6aStZOGhKZkJw?=
 =?utf-8?B?Y1FFUUErQkRRWmRzZmhsTnNqZzFNNlNWLzl2cUhzcVFhSStSbmdFWXFiWmNW?=
 =?utf-8?B?YjdkQ2JBcWFrWFBmOGZXOHc2eG1TQ1p4UXlNbkhTTGtXTDFxM3hlZ2RPSkNR?=
 =?utf-8?B?ckpaRDBaYzJiemVLbEM1UENYOVRRdnBXN1BCR0RWRkgwV2ZZem4vRUVTTUxL?=
 =?utf-8?B?bFp2NVdIdFp3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M3FBVmpYSE16RzRicVVIL3pVNWN6b1dvRFQrNEFBQ09scnQrRUpIOXJBVksy?=
 =?utf-8?B?Z1lqSnJXb0ZKbVowUGMzZmNDcDBndmJZcTVLMDl1QjR1WHZOcExwdkJPU3oy?=
 =?utf-8?B?RlM0YnFORUR2bmVwZHV6S3dsQmtOZkx2MXozRWdGUkc2U0xCTnh0d2xhdjBT?=
 =?utf-8?B?Sk9MZ2Y1WFFtQWxpRWNzdlV0cmQ1RHg3dGxhR1pEVUhvOFN1MXRYYnRRWld4?=
 =?utf-8?B?QitYVCtrUE5pT0gzZnNNVVk3K1Q4WnNMMkd4TmN5bi94V0IrN2h5ZmFnTVRC?=
 =?utf-8?B?aTRQVmE4N0NLZ3R4bnlNRit3UjZTNDVPUUcwWkZUTXJJWmkrYk1aKzNZS2Rl?=
 =?utf-8?B?Q1RJbmw5T0o0T2RldjlOYzZHdXlJZWdOOHNQWjdwOTY5TU1IdXlPaVBmcnVn?=
 =?utf-8?B?YW0rMlNpVkE4OWh6WHdWc3VJVjRPYTRXdG5DUHZFWEFKc2JxWkwxdTdMU2wv?=
 =?utf-8?B?ejNkOHRaY2todGpsQTVFNlVUeGQ5MzR6TE40cTlQeFZDQWpHZnFNVzJNcEVH?=
 =?utf-8?B?T0hYYkxBMTVyRGU5ZUtYdG5vSkRoakd2VWd4NzdPeGcwaTFEcHg0eTZZUjZR?=
 =?utf-8?B?d2h0UEtiV09VSnVhNVE2UFNXR2pHVkFnR0xGY09VSVNnNHVYWjlnN3dzTVM0?=
 =?utf-8?B?L0hXNFZkYUp2ODlHZ29YSys1bnpnN0plNk1mS1hIRXZiRUc4TWh1bWZqeXJM?=
 =?utf-8?B?MHYxT1NhR2JkbC9Ob0JzVVA4WXJzTWpRM3V6d0UvdUt2dVRZVDZhTDR6dWhm?=
 =?utf-8?B?TXo4Mkh3L29DcW1PRUpvK2gxc1hscThDampCRURFbitFUW5vdFJZTVhzNFhZ?=
 =?utf-8?B?VlRpOEFNOXluYklsU3NjcEhldVNINzBNWXdkSmVRS1ZWYUU3V0gzMkpsaEpF?=
 =?utf-8?B?VXRUN2NYWU1ZT1FHMjJiUzRvSkp4Z0dWUEtEZ0hBb1ZBRFhwTkY3SExrY3Fa?=
 =?utf-8?B?UzRMcWF2ck4vMm5FMVNwS3pOMDhCNlNQVWRrL3YweHRaeXJ2dmhCMEN3cXlU?=
 =?utf-8?B?Ni9qM1pvYmVHdjgyWDNYMXhxRnd0QXErVVB5ODJDTHo0UzhqMllTeEU0dnF6?=
 =?utf-8?B?RU1HNzZtSVFpem95QlVNSGJPeUNlUkg4U2V6S1E1d2ZOVnQ1dm5uOWJiaWtL?=
 =?utf-8?B?bENHOFlMbGUyamlPcm91eWFBL1dGZEZ5ckowblRDUU4rU2NLVmVLU3U1djhM?=
 =?utf-8?B?Qm8yemlYczYrYW4xN1RLTS9laHZoL0wxNGhiU3FZRDc4U0YzUVl5QkxLNGZ6?=
 =?utf-8?B?aU5EelA5NSt0Y1NJMURReU50NnlXcVZzcFZibVFEMDVycG5lZ2NYVUJvT2JT?=
 =?utf-8?B?UkUyKzFZd3p1TmVRdW5qVzdpTkVuSXBYQ2JvUnVOUWtFTkwvWUc1cThaVFdw?=
 =?utf-8?B?anpxWURJZzlDeTJNSk13cDdxUGVsN1FCOHlrRDBvMlVOQXBTeWMxVTZ2VWN2?=
 =?utf-8?B?M2ZBVHNSdXV5SENBZEc0a0dDb04zN0pVcG9vZ1FpRUR3cHFYV256US9lV1Bx?=
 =?utf-8?B?QmN3eE5hNkFERm1QRm1xdlBMU3RVbEU1aUxuSEU4VW9QQTZ1UEgwT01wOVJi?=
 =?utf-8?B?RitiRWtLMXV2NW1PZkxjam9aRFArZEgrUzNPc0xWR3lQQmhkNis1WnI2WElO?=
 =?utf-8?B?ZFl5aGZxTlhzSEZxVXBCc3ZROUJ4YURNWVZtdUYvWC91cGR1ajZ5QnRqZFJZ?=
 =?utf-8?B?WUw0UmtGVDdOdXNzRjJWMTZsM2xyK0RFOWtVaHFnYXo5bGJSSVlJZUlFWmdt?=
 =?utf-8?B?Q3dxUy9NSmw1cTladjBnVFZQLzZBT3BCTTBtb3JsNllwTjViVHVyWlQ1WnY1?=
 =?utf-8?B?Q0x0SHlZL2JwMFU3ZE03dEVvTlhaU3IxUXhEc2xyeUVWRmhiZ3lFMGdRT2hW?=
 =?utf-8?B?cDVZdUNNRHdLN2UrTTdpbmUvSU5pMWJiM3FleTBpUWRpYjBaeDZMNDF6WnV1?=
 =?utf-8?B?V1VLZy9KTXpBMzVNQ0tZKzB3b3FTMWI5NEROR1dOWVR5bXRLZCtPdVBlU0Zm?=
 =?utf-8?B?dzdvQWtiNmRnQWFzdS9Bd1BaQzM1Qkx6eDNSOE9HNE56YjdUT2cwVG0weDZk?=
 =?utf-8?B?YlBDeDJQZGtOa0R6N21qY1d4MzkyYkQyYlI2K2M0UTFwZndldDdOMU5oSUhE?=
 =?utf-8?B?VTM5SWlRd2hwNXJtRnpjQ1ppYTNMdkhWWkcyM3JtcFpXN2Z1STZ4QzQ3a3BL?=
 =?utf-8?Q?lo8p/zkKG4MarDkmwXtLTdM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F00EF1D04630945B5B1499246BF5AC6@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 560107a3-ec76-4a19-301d-08de2b8fcdaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2025 19:29:36.3471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IfqCv3xOsZ3BbRpLSepTPDQATB0fdpmAxT94lLYuwkNiMzETm0RF8friVkzRkvuuY4YLSSsigI/aeLo5Ts2fBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3947
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAwMCBTYWx0ZWRfX8UdJcC2ApgNY
 C6DxEf0gCsIAoTyElpruWaBpAz8NmH2iJwjEq94ckk6zh4PxXwLYrSROvQ5sJVpkbsPmcgv6EEX
 VWiZfZqQ63JDhYp0qqZHTn+sJa2xsYvId5kWSz2CFO+sA0IvgdwgeQkRqoQfTodjDk++ckBy4QU
 FpqNMHKLBzCQ8/vyBKO/8LkeEvnpDH+wRpeLFpthWoBIB/+REPQ94u2OHseFT+8/Rr/0bQCa6nm
 dAT+scKv/K9NzJ42XWcK3lDNwL3vbUFPKlti4XVv9WoNt47L67ggQxxoY+ltjQWniXrDgP4sfEm
 Y+esaqcKb/qw6wkCHMLaSbzjMGLIC/7Hg3rWtpO95UyiWICiRRgyMR83JivKZjiCfQBFk2nttws
 xooFJDekVAjx6wcpxFUleT3kq05oTw==
X-Authority-Analysis: v=2.4 cv=fJM0HJae c=1 sm=1 tr=0 ts=6924b223 cx=c_pps
 a=RM5EPw/H4l4S9ahloXzS7w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=bn1bZ3M4SwuQCU4-7F0A:9 a=QEXdDO2ut3YA:10 a=-_B0kFfA75AA:10
X-Proofpoint-GUID: gUhbWS-_DP2D3yqIFKUOaXW6h06HTyL7
X-Proofpoint-ORIG-GUID: 0GPum_o4oxCIie4XkDdnOkkE2WVlYgnc
Subject: RE: [PATCH] hfs: Replace BUG_ON with error handling in
 hfs_new_inode()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_07,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511220000

T24gU2F0LCAyMDI1LTExLTIyIGF0IDIwOjUwICswMTAwLCBKb3JpIEtvb2xzdHJhIHdyb3RlOg0K
PiA+IA0KPiA+IEkgYW0gdGVycmlibHkgc29ycnksIEkndmUgbWlzc2VkIHRoZSBwYXRjaC4gQnV0
LCBwbGVhc2UsIHBsZWFzZSwNCj4gPiBwbGVhc2UsIGFkZCBwcmVmaXggJ2hmczonIHRvIHRoZSB0
b3BpYy4gVGhpcyBpcyB0aGUgcmVhc29uIHdoeSBJJ3ZlDQo+ID4gbWlzc2VkIHRoZSBwYXRjaC4g
SSBleHBlY3RlZCB0byBzZWUgc29tZXRoaW5nIGxpa2UgdGhpczoNCj4gPiANCj4gPiBoZnM6IFJl
cGxhY2UgQlVHX09OIHdpdGggZXJyb3IgaGFuZGxpbmcgaW4gaGZzX25ld19pbm9kZSgpDQo+ID4g
DQo+ID4gSSBuZWVkIHRvIHByb2Nlc3MgZG96ZW5zIGVtYWlscyBldmVyeSBkYXkuIFNvLCBpZiBJ
IGRvbid0IHNlZSBwcm9wZXINCj4gPiBrZXl3b3JkIGluIHRoZSB0b3BpYywgdGhlbiBJIHNraXAg
dGhlIGVtYWlscy4NCj4gDQo+IE15IGJhZCwgSSBkaWRuJ3Qga25vdyB0aGlzIGNvbnZlbnRpb24u
IElzIHRoaXMgTEtNTC13aWRlPyBCZWNhdXNlIEkgaGF2ZQ0KPiBhbHNvIGJlZW4gd2FpdGluZyBm
b3IgYSBmZXcgd2Vla3Mgb24gZmVlZGJhY2sgb24gamZzIHBhdGNoZXMuIE5vcm1hbGx5LA0KPiBp
dCB3b3VsZCBub3QgbWF0dGVyLCBidXQgSSBhbSBpbiB0aGUgTGludXggRm91bmRhdGlvbiBLZXJu
ZWwgTWVudG9yc2hpcA0KPiBQcm9ncmFtIGFuZCB3ZSBuZWVkIHRvIGdldCBzZXZlcmFsIHBhdGNo
ZXMgaW4gYmVmb3JlIHRoZSBkZWFkbGluZSB0bw0KPiBzdWNjZWVkIDopDQo+IA0KDQpZb3UgY2Fu
IHRha2UgYSBsb29rIGhlcmUgWzFdLiBVc3VhbGx5LCB5ZXMsIGV2ZXJ5Ym9keSBleHBlY3RzIGtl
cm5lbCBzdWJzeXN0ZW0ncw0KbmFtZSBhcyB0aGUgcHJlZml4Og0KDQpTdWJqZWN0OiBbUEFUQ0gg
MDAxLzEyM10gc3Vic3lzdGVtOiBzdW1tYXJ5IHBocmFzZQ0KDQo+ID4gT0suIEkgc2VlLiBZb3Ug
aGF2ZSBtb2RpZmllZCB0aGUgaGZzX25ld19pbm9kZSgpIHdpdGggdGhlIGdvYWwgdG8NCj4gPiBy
ZXR1cm4gZXJyb3IgY29kZSBpbnN0ZWFkIG9mIE5VTEwuDQo+ID4gDQo+ID4gRnJhbmtseSBzcGVh
a2luZywgSSBhbSBub3Qgc3VyZSB0aGF0IGlub2RlIGlzIE5VTEwsIHRoZW4gaXQgbWVhbnMNCj4g
PiBhbHdheXMgdGhhdCB3ZSBhcmUgb3V0IG9mIG1lbW9yeSAoLUVOT01FTSkuDQo+ID4gDQo+IA0K
PiBJIHRoaW5rIHRoaXMgaXMgY29ycmVjdC4gU2VlIGZvciBpbnN0YW5jZSBmcy9leHQ0L2lhbGxv
Yy5jIGF0IF9fZXh0NF9uZXdfaW5vZGUuDQo+IA0KDQpQcm9iYWJseSwgeW91IGFyZSByaWdodC4g
SSBzaW1wbHkgdG9vayBhIGxvb2sgaW50byBhbGxvY19pbm9kZSgpOg0KDQpzdHJ1Y3QgaW5vZGUg
KmFsbG9jX2lub2RlKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IpDQp7DQoJY29uc3Qgc3RydWN0IHN1
cGVyX29wZXJhdGlvbnMgKm9wcyA9IHNiLT5zX29wOw0KCXN0cnVjdCBpbm9kZSAqaW5vZGU7DQoN
CglpZiAob3BzLT5hbGxvY19pbm9kZSkNCgkJaW5vZGUgPSBvcHMtPmFsbG9jX2lub2RlKHNiKTsN
CgllbHNlDQoJCWlub2RlID0gYWxsb2NfaW5vZGVfc2Ioc2IsIGlub2RlX2NhY2hlcCwgR0ZQX0tF
Uk5FTCk7DQoNCglpZiAoIWlub2RlKQ0KCQlyZXR1cm4gTlVMTDsNCg0KCWlmICh1bmxpa2VseShp
bm9kZV9pbml0X2Fsd2F5cyhzYiwgaW5vZGUpKSkgew0KCQlpZiAob3BzLT5kZXN0cm95X2lub2Rl
KSB7DQoJCQlvcHMtPmRlc3Ryb3lfaW5vZGUoaW5vZGUpOw0KCQkJaWYgKCFvcHMtPmZyZWVfaW5v
ZGUpDQoJCQkJcmV0dXJuIE5VTEw7DQoJCX0NCgkJaW5vZGUtPmZyZWVfaW5vZGUgPSBvcHMtPmZy
ZWVfaW5vZGU7DQoJCWlfY2FsbGJhY2soJmlub2RlLT5pX3JjdSk7DQoJCXJldHVybiBOVUxMOw0K
CX0NCg0KCXJldHVybiBpbm9kZTsNCn0NCg0KU2Vjb25kIHBhcnQgb2YgdGhlIG1ldGhvZCBjb3Vs
ZCByZXR1cm4gTlVMTCBldmVuIGlmIGlub2RlIGhhcyBiZWVuIGFsbG9jYXRlZC4NCkJ1dCB3ZSBj
YW4gY29uc2lkZXIgLUVOT01FTSBpbiBoZnNfbmV3X2lub2RlKCkuIEkgYW0gT0sgd2l0aCB0aGF0
Lg0KDQpUaGFua3MsDQpTbGF2YS4NCg0KPiA+IA0KPiA+IFdoeSBkbyB3ZSB1c2UgLUVOT1NQQyBo
ZXJlPyBJZiBuZXh0X2lkID4gVTMyX01BWCwgdGhlbiBpdCBkb2Vzbid0IG1lYW4NCj4gPiB0aGF0
IHZvbHVtZSBpcyBmdWxsLiBQcm9iYWJseSwgd2UgaGF2ZSBjb3JydXB0ZWQgdm9sdW1lLCB0aGVu
IGNvZGUNCj4gPiBlcnJvciBzaG91bGQgYmUgY29tcGxldGVseSBkaWZmZXJlbnQgKG1heWJlLCAt
RUlPKS4NCj4gPiANCj4gDQo+IGV4dDQgdXNlcyBFRlNDT1JSVVBURUQgd2hpY2ggaXMgZGVmaW5l
ZCBhcyBFVUNMRUFOLCBJIGNhbiBjaGFuZ2UgdGhhdC4NCj4gDQo+IEkgd2Fzbid0IGV4YWN0bHkg
c3VyZSBvZiB0aGUgbGltaXRzIGluIHBsYWNlIGluIGhmcy4gQnV0IGxvb2tpbmcgbW9yZSBjbG9z
ZWx5LA0KPiB0aGVyZSBjYW4gb25seSBiZSA2NSw1MzUgYWxsb2NhdGlvbiBibG9ja3MsIGFuZCBJ
IHRoaW5rIHlvdSBuZWVkIGF0IGxlYXN0IG9uZQ0KPiBwZXIgaW5vZGUuIEJ1dCB0aGVuIHdoeSBh
cmUgdGhlIENOSUQsIG1heCBmaWxlcywgbWF4IGRpcmVjdG9yaWVzIDMyLWJpdCB2YWx1ZXMNCj4g
aW4gdGhlIE1CRD8gV2hhdCBsaW1pdHMgaW5kaWNhdGUgY29ycnVwdGlvbj8NCj4gDQo+IA0KPiA+
IFRoZSAnaGZzOicgcHJlZml4IGlzIG5vdCBuZWNlc3NhcnkgaGVyZS4gSXQgY291bGQgYmUgbm90
IG9ubHkgZmlsZSBidXQNCj4gPiBmb2xkZXIgSUQgdG9vLiBTbywgbWF5YmUsIGl0IG1ha2VzIHNl
bnNlIHRvIG1lbnRpb24gIm5leHQgQ05JRCIuIFRoZQ0KPiA+IHdob2xlIGNvbW1lbnQgbmVlZHMg
dG8gYmUgb24gb25lIGxpbmUuIEFsc28sIEkgYmVsaWV2ZSBpdCBtYWtlcyBzZW5zZQ0KPiA+IHRv
IHJlY29tbWVuZCBydW4gRlNDSyB0b29sIGhlcmUuDQo+ID4gDQo+IA0KPiBXaWxsIGZpeCB0aGlz
Lg0KPiANCj4gPiA+IMKgDQo+ID4gPiDCoHZvaWQgaGZzX2RlbGV0ZV9pbm9kZShzdHJ1Y3QgaW5v
ZGUgKmlub2RlKQ0KPiA+ID4gQEAgLTI1MSw3ICsyNzEsNiBAQCB2b2lkIGhmc19kZWxldGVfaW5v
ZGUoc3RydWN0IGlub2RlICppbm9kZSkNCj4gPiA+IMKgDQo+ID4gPiDCoAloZnNfZGJnKCJpbm8g
JWx1XG4iLCBpbm9kZS0+aV9pbm8pOw0KPiA+ID4gwqAJaWYgKFNfSVNESVIoaW5vZGUtPmlfbW9k
ZSkpIHsNCj4gPiA+IC0JCUJVR19PTihhdG9taWM2NF9yZWFkKCZIRlNfU0Ioc2IpLT5mb2xkZXJf
Y291bnQpID4NCj4gPiA+IFUzMl9NQVgpOw0KPiA+IA0KPiA+IEkgZG9uJ3QgYWdyZWUgd2l0aCBj
b21wbGV0ZSByZW1vdmFsIG9mIHRoaXMgY2hlY2suIEJlY2F1c2UsIHdlIGNvdWxkDQo+ID4gaGF2
ZSBidWdzIGluIGZpbGUgc3lzdGVtIGxvZ2ljIHRoYXQgY2FuIGluY3JlYXNlIGZvbGRlcl9jb3Vu
dA0KPiA+IHdyb25nZnVsbHkgYWJvdmUgVTMyX01BWCBsaW1pdC4NCj4gPiANCj4gPiBTbywgSSBw
cmVmZXIgdG8gaGF2ZSB0aGlzIGNoZWNrIGluIHNvbWUgd2F5LiBFcnJvciBjb2RlIHNvdW5kcyBn
b29kLg0KPiA+IA0KPiANCj4gV2lsbCBhZGQgdGhlc2UgYmFjayB3aXRoIGVycm9yIGhhbmRsaW5n
IGluc3RlYWQgb2YgQlVHX09OLg0KPiANCj4gDQo+IA0KDQpbMV0NCmh0dHBzOi8vZG9jcy5rZXJu
ZWwub3JnL3Byb2Nlc3Mvc3VibWl0dGluZy1wYXRjaGVzLmh0bWwjdGhlLWNhbm9uaWNhbC1wYXRj
aC1mb3JtYXQNCg==


Return-Path: <linux-fsdevel+bounces-69265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 03040C76189
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 20:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 347AB4E1A66
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 19:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6531A2BEC52;
	Thu, 20 Nov 2025 19:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Lt4INDRk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD222652AC
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 19:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763667195; cv=fail; b=NMVqFbm6n1kmFd6j+C3L8RslDNN3YjkV0dDdqm1pY3GOdj65zczYzfvVu6vgLkY+E7vBlWc6CArCn8ft7c6KxLIZ2G/H4mwYqWzHUgYg70hiABB8aMB2LxIOXsXs4J9KXgzpmgGbFqizSbpNYjMQzQlJGlgG9wu/vZHk/Fahmjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763667195; c=relaxed/simple;
	bh=V3t727gKIB1vvI9BoD0ZuXv7GBrfddkyXveFAe7AfMw=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=K9EGKZmMD8P2fUZCMORugZ1UC4k5AuPcc1k/dwIjMESsKyxmDdBiSHQrmspjo+BGeGcKgNowGER+1a9pPzr3Fl4/knn+w5+hH25mjlZemUntLJqyE8kE7xwOrtb+zmIp8oyS6o87INcobZQbh+Auhw1Qq+sZKNTrdwsYuF8/g+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Lt4INDRk; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AKCdWaF007059
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 19:33:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=gdunzPYMfDOsq6trOYJWT8Ntnry9vwKse7kOCojMZ14=; b=Lt4INDRk
	7Yw8ItYUcEY4Zw8SZ2dz5X3dLAxEmSDQqHmzSny4ZiOs5H1cWUN7q4dXzbOL+cAl
	68A3E+I9zHQBLytgUx34GbzeboVWG9UkLJTMovU3MkAJNCtgV6CTlVXlAkfJhDkI
	HQAprbVCAhK0vKiaBjAZeTIbL7td1OktFR6JSLVzSyfHx7SC17b5aFXxLmcbYVvU
	uQ+bdK86Q3jVkWzwgSU/8PFhOHpt2Dgp/JGjpStr+zfT+ccO+ydMh5K6g6nikZrL
	HwJWF1BdNQ11jkvLJhScPKQdurb8uxYMrL88LhkJR3CCdLgd5nYHVWuFuTaGN3/7
	RWdceKJS2xsTYw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejmsxxkv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Nov 2025 19:33:12 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AKJXB5H021524;
	Thu, 20 Nov 2025 19:33:11 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010014.outbound.protection.outlook.com [52.101.193.14])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejmsxxks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Nov 2025 19:33:11 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YUzFkQ1wbMTm/OJ88pzMiqftGMeulLT6eNwWRE5+3l2lIICR+xjB+lK+it+RYVCPCMwR6IUvI2K4CTZ3YlDTMLG0tKg0DSmaC3onH60oOhoWVw1DQ4DRG3NGH68KPdGAjLH0V/PMkKUX1NstoFNuECMQWbMlFV74/VAEVjxLDzz8bcSrLrYOkExZlyUYUyTf1VlBZzHksdowGtj8NGHkpRgvH1kzcybKeA5nyj7B/8LWvEnitiP964LfcNcyDDRvnsYNP9Co740pPssS64drRy7ykc53S2e2iYe/wOR6xCuW7JhjfVWcQ/haCc//IQZskYp4pwXx/cY3YaVpfrrhZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0jHc7hLa1eT0olpN0GjyawFaxIIvp/E4QZ+K2Hy/zjo=;
 b=pVqaXNLkoKoH787y9hGvW7B1/wD2YDeO8N+CRIojTDPqRRFRpXTUK0Aoyy8fnhDqxw3mZp7gMs7NFKaxF8dOJ3BIg12C2HP2jfgxSLAaXxnXVowwmndbFDlMYIpbSjDoO2hNwk9oN3fBZXMS62+Qu7hEtr3d3iWoICru5l8JzvIuj+q264soYDdzP9XdPrn6H4ZTfK/DEdlNteaUngfBwqap6914ibyMyVZPc8F/nd1vrCqbfqOSOVciC171sCaGsAB1tDZRlFgqiq/R4HCqFBXcjsit10MhplEJKt/byu6ibC2kFiswLtj5xyxmptiToWjAlVd8uVe/xGReh756Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by BL1PPF9653440F3.namprd15.prod.outlook.com (2603:10b6:20f:fc04::e35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 19:33:09 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 19:33:09 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "ssrane_b23@ee.vjti.ac.in" <ssrane_b23@ee.vjti.ac.in>
CC: "khalid@kernel.org" <khalid@kernel.org>,
        "linux-kernel-mentees@lists.linux.dev"
	<linux-kernel-mentees@lists.linux.dev>,
        "syzbot+905d785c4923bea2c1db@syzkaller.appspotmail.com"
	<syzbot+905d785c4923bea2c1db@syzkaller.appspotmail.com>,
        "david.hunter.linux@gmail.com" <david.hunter.linux@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH v2] hfsplus: fix uninit-value in
 hfsplus_cat_build_record
Thread-Index: AQHcWk4bwUwdjedfAku5yyABeyjbxLT79GMA
Date: Thu, 20 Nov 2025 19:33:08 +0000
Message-ID: <c53674bcc3ff1e9a6244d6a453653c86aeee1902.camel@ibm.com>
References: <20251120184610.28563-1-ssranevjti@gmail.com>
In-Reply-To: <20251120184610.28563-1-ssranevjti@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|BL1PPF9653440F3:EE_
x-ms-office365-filtering-correlation-id: 42dedb1c-24cb-4560-dbca-08de286ba2c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?R01yc2N2bWJUUTRaemRWMUd5OHZxM3QyejVNcFZnK3ozUTZoZzhNZ0lQY0t2?=
 =?utf-8?B?VTJ5SVU0cE1VQ0I2U3I0SEdkRXFwWXp3ckFWb3I4bG1PYUpnWHdYL2kydkFV?=
 =?utf-8?B?TjR6MXBONlFreEt2NW5qOC84THRrWUxzQy9DN1doSDM0Y2pUNm9LODMySUtz?=
 =?utf-8?B?TTd6SDlRZTdQbllST1U4d1loMS9ZcVFDR2h0R3VvYmFScllGYmNzMEpuZzJs?=
 =?utf-8?B?OW9ubUJFdFppQldpL3JSMTF2b0J3NHFDSlNxT1lzODFPdy9JVUVGV0kwRWcy?=
 =?utf-8?B?MU0vNlF4OC9HUHdYcEYyaVlva0xpZ05jc0Y5djBIOTFrN0tQd0tJU0Q3eHZ2?=
 =?utf-8?B?U2cybmZ4cVF4UmsrSldmZGxUdmwwSUl5SFNiNWhkekNmRENXaUtnTVhkU2I5?=
 =?utf-8?B?a1NDekVQSjEvbnU2Y3h6MUVzNkdHYkhFYkpEbEhjcmdsT1Q3Lzc0MjFYOVhD?=
 =?utf-8?B?eXZ1d3BWSU9iZks5N1pkUnMyNHo0QTNyWmlPbHN1UTJjTHV5TlAvajg5dDFL?=
 =?utf-8?B?WkhwajBwaU4zYU5waFV2eEx5aGdLUHJKTXRrYjBwWmZqZGZ4NHplT0xScFMv?=
 =?utf-8?B?bGhkQWxCODF4Z0pqOGdTdkhsKzU1a21Cbnk0cEpLREtwbkxTeWNoZTRsT0cv?=
 =?utf-8?B?Y2ZlaW1ad2tQc1ZweEVCZjk4RU1QUnlRcHFUTGViRG45ZHVScktldDhTenhs?=
 =?utf-8?B?U0VqS2FTYkg0VEhQb1J6ZzVlVS9VejhMUGxVeWRTdURXdFFtRUhpZE5oTHVw?=
 =?utf-8?B?Q0hMLzdIa3FhS1NCbW9wWjhuYWVJUitWMHhNdUQ4R2ZnTk42eEJ5dTNLSmdr?=
 =?utf-8?B?ZnlLVUpITnhBSTA3NkF4Y1VOcTQwcW5sZDlqZW9wNXQ5Qlppc0k4RWZjSzg2?=
 =?utf-8?B?Z21ralQ4RC9CdDRnOEc1Wkx2L0w5ODB6STZjMGVFOWZDYnl5bHYzdi9pd1BR?=
 =?utf-8?B?QThWZ00zNnVOWm5wRUtXMThTYW9TZE1iN2VnUm9UNjJ0QS9JeThROGtFazZM?=
 =?utf-8?B?QStlaHRHWW90b2g5eVBIc3FJYkJ3L3hCNFVub2ZKREJDMC8vb0JQemFBQVhi?=
 =?utf-8?B?YXl5K3p0ak9NYWU3TkhwVUhXbGs5ckxocWVQVnBqLzNSTXRDanN3d2JEclkw?=
 =?utf-8?B?Y3VRTmFqdUc4VWRCa2pYQUZkQWcwYWVuRm5Vcm5yNndmMytpSXkzRTY4Zy94?=
 =?utf-8?B?cmNTN2x5RVlaeGNaMTJmcnFGY1RKejB2cTZCU1djSnplMUF4dXNERFF2ZzM2?=
 =?utf-8?B?NzF4SlNzNjFkVkZPRkJ0NmxhR2V4VWRLOFlrTDE3Q2ZJWGNob2JlNEdhaW9z?=
 =?utf-8?B?SGlFaEtSOXBXblBLOFlsZ0dPejV5MnkyeVpyUElmOU5UV0wzdWZNS2R5emNT?=
 =?utf-8?B?Z1VzUkdpeWE2L25ZUTVNeWE4ajFLN3ArRlBGYmlWYXVmOC82SkRjd0J6K0tM?=
 =?utf-8?B?MWk1THNyZnVybFduU2dRQWY4SXI0WUNDOWthb25JdmtOa1VNWkI1aUpPaU1v?=
 =?utf-8?B?N1RoN3lqSEUzTnBOYWROWnZoUFVFejM0VG5Ra0pBenpwd202cFFKMlZXN1pM?=
 =?utf-8?B?VlFhSmlrRzcvamVLQS95Q3hTcmQzMUxnaFhLT2FvbXY5QktNRUh4eHFCU0l3?=
 =?utf-8?B?NitVeUlNcVV2U2ZVYkN4eW4rOFB6Y2xPclZEVW1lYVFzRldxdm5JTlFVRDE5?=
 =?utf-8?B?SkdybWRWMUM2ejRydit3cDlVNmd4WGJxQnk3em4wRWFHcjcyZ0p5S2RMeHUw?=
 =?utf-8?B?aGNPaDRaNExPTHk5UFRPbFBXbDdMaEM3M0pJck1hQjNtTzVBeEpLRkI4cGtk?=
 =?utf-8?B?WHZlQ2VXdnlNTmVWcUJjbEdHWFB0ZFhiMEVtdE1ZZmphTUpwQXA2dlVtNVh1?=
 =?utf-8?B?aDJiSXFEKzljZW5sSTEraWxhaGdSWmZEbHV0c2JrSlZQUy9YU0w4N3JISzc2?=
 =?utf-8?B?QnJzeEVETHFNOUNJNmJ5NE0xZzZkYnJSMXBNejVubG1hbnBLUXU0aS95YVhz?=
 =?utf-8?B?NFZlMHUyRVN3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U04vL1hmdU1ud3Z2Zk9xMTE3aVN3eFRiNWxKMjA2QmgzcmR4dDNsek1HUzQ0?=
 =?utf-8?B?TUpBL01jbjhDOWI3QXk1WEE5N1U1SHFKeWJoTE40YnJlL0VtSGJMbGs5Q0cw?=
 =?utf-8?B?c2hhajlIUnRSdkxkVHo0eXo3Nkh1TjVNOWg0T0FkTkcvVm9wMkRXTEVTZjJ3?=
 =?utf-8?B?SjA3S3pkVmJjdlFZVHlPTEtjSU94TmZVL25NRnpjMXRpTzh3a2ZqTi80OXdm?=
 =?utf-8?B?dVAvUFQ4dmR2TkR2ZU5BOHRrTGJ3bXY4ZzhlRUlaZWgxMS9VRWZ1b2dMRkoz?=
 =?utf-8?B?WGxuRlFpeVdmTzZyTU1PN1hCbUVINlI2RFVxYkRyZmJURnk0VWhhdnlEVnhz?=
 =?utf-8?B?QVM2WkphTk9mQWQ4MTJ1ME5pb21jNG0yU1o3dGZzTEI5bVdNN0FzTmZ1ajVV?=
 =?utf-8?B?S01iNmZ3SW91bzEydi92TWhmcy9QTzZhaDNLa1I1NGxUUUZwbzI4cnQ4Kzdq?=
 =?utf-8?B?eCtDVk9GeTRuZnZRSXNMWFdaeDBEb0lFdUs5MGRwWDRoSmxKblpjK0dtUFJD?=
 =?utf-8?B?UHc0NkRJTE55QkpNRU9iK2c2TDl0ekczZlpjUUhPbzRrdUJWcWpSRjhBakpT?=
 =?utf-8?B?M2ovNFVsaUxyYUFxK2RJU3JwUVcwTHZrb3FhNVZDQkg5V2VIbkFTOGFCMXNo?=
 =?utf-8?B?RnFwNzJmbDlOQ1dkSGRsNmhFQmd1WXFnNlNLVm55NlZlcC9xcUtYSnJiT284?=
 =?utf-8?B?WWRIVmV1YXVxOFZBM2x2bHQwUHhNdVpSeXhGenBEUlBPandyUmQ2dE03cSsr?=
 =?utf-8?B?UXFyWER5MlNVQnZ5RGVmN0dFR0Vybm9VczhLQkZ6UEplekx3MGZVQ1ZYdzlw?=
 =?utf-8?B?cmNhRERGZ2FBOHhYZVlkM1d6OExIcWZ2eWJGNDlpdW1kRHUxRWI3aGlSRnZY?=
 =?utf-8?B?VHJHMTdkRTYwOU9HY1FHOU5MTjZ6QjhwdG1yN2ttYnVVa05Bcmoxdkl3eGZR?=
 =?utf-8?B?VUxGT2gxSDBEY1BCWGpGUjNaNHRGQVNqVlRnWkZKNG00R2J3SjNOcGZ4bFgz?=
 =?utf-8?B?L0laL3RZaDNhajdoSzFoQzlrclZyZ20zZFRWemM4dlhlTkhYTUwwL3ZjeDNX?=
 =?utf-8?B?dUsyeWZKUnpUODN5bkpzbVduMyt1UmxIWTh2SENMajhWNTJiSllpMWlhdjc0?=
 =?utf-8?B?Y3dydEEwcHdBT1JRME84bFVaajlqcFhWOXRYQjhjUEJqN0l5S0pmNzVRTDZD?=
 =?utf-8?B?bWdHMm5nV2FSK2luUGJISUlEeDRoR25iOUQ2VEs1bEtxU1pRTmpKZkpidVB1?=
 =?utf-8?B?ZWFlNS8yTFRaNmZFdWpmOHJFZTFGelI2NmFXQ0NkaExGc0Q5MHdoSkxxVjhs?=
 =?utf-8?B?WEZ2ZFB5QWxZWm9FMEd2N0syWWdqNjVDNWpud0ROV2lVMFlscVR1Vjk1WFVx?=
 =?utf-8?B?OHJZdEdlRTVMMUV4L3Jmb2hyL2xpL1ZjRmNvMzVPcXcxRFVQVm5HamlwTzI0?=
 =?utf-8?B?MTVvanZ1RUtCRlUzdjB0TWRuRmVCUGdMb29VUGh0cFJPNTVVY0Y2Qzh5dk1k?=
 =?utf-8?B?b1hXdGFvclJybmxaeWd1N0tXL2w2bmRwNzJQeHdPT3ZwOWdoeEpwYUhkdHhp?=
 =?utf-8?B?NU5kVCtOZGxReDhXSzJQTTlXeVYxbCtnVm5zeFhCWFBod3FTdlRWVFMvRE5N?=
 =?utf-8?B?OUFpVkNIMGVQR3dKbFJ4VHorMHFIZU1EVUJHRzYyOTFVQWpnRlhYMUpiRDVB?=
 =?utf-8?B?R1pGMTZyTE9SSjlqdkxvdWJDbGY0dDVKd0VORDd0VHV6Q2QvMzNydEJWL3Vw?=
 =?utf-8?B?OGtkV3NudUlwd0NiRE00eFQxOEprUEk5bXZQZjRPOEhnd2Y4WnFFa2FCSVV0?=
 =?utf-8?B?SGtMYzErRWIwVk9GUW5NZGtEU3VaTFZzaFFCU1h2QndzMnJrMjNWRWlHL1h5?=
 =?utf-8?B?SnlRT2VwME5Dc3lCY1Z3ZmMzY2JWYytEeUkxdVViZGwvRmRic3dmbW5DU3RU?=
 =?utf-8?B?MzBOWFdVVFdEUFEvNVBZc0kzblRucG1KdkhWMnR2SXFuL2VjTmhxOXRGblZI?=
 =?utf-8?B?S25nUHk0V2ZrQTlZSXN0S0JGSUhVV1VUdis5L2hQa2xZNnVjUzNwMmg3MGsv?=
 =?utf-8?B?V0NxRVlxQTFzalRJL2hPeGtaUTVNTndkd0tCOHpobnNSTHJUMTRqWkFxbG1a?=
 =?utf-8?B?VnlQbEIzRzk5aTM0bjZMN2o3LzJ1R2hqdWNsRjBmZVVhbXFabTI4eFpjVXRY?=
 =?utf-8?Q?Pa98irFlR1K4kcxGJU7jAfI=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42dedb1c-24cb-4560-dbca-08de286ba2c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2025 19:33:09.0687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ylOybg4KWIdOFvmsZV22s79AEyPUU+2H5EvEY4Y2mVONTvltIKpTn6VpqcYa5XlmVfQdMaPyq45udiaScoKRZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PPF9653440F3
X-Proofpoint-ORIG-GUID: PgL7b50eEzxPStf1XY8pCgJ30syQQybt
X-Authority-Analysis: v=2.4 cv=Rv3I7SmK c=1 sm=1 tr=0 ts=691f6cf8 cx=c_pps
 a=gJSDm7Sez3IyWyplfMHn2Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8
 a=0yD75wpxGasYVtNDhQsA:9 a=QEXdDO2ut3YA:10 a=DcSpbTIhAlouE1Uv7lRv:22
 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-GUID: UbqU2aHfpl5eJnuEraibLmjdm9aZCB-Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX6PD1pc9/L2es
 zJ/rsYvwulDNkuB+P0ZW7DyGAxvNq87fyuNElFxWIX3rObKby9HPh8Cf147TMmDaBe69h/mHcCx
 q7Jx8ROg2Tfiu41eU/v6Ln2eCNNLj4pUBiP/6WM5UYTpqPdZDyAWwSY6xLCWYGzzTMo+Ko3jUEA
 FKsNi1Z87ssaXlGRx4kqhvmp2x6FgYIPn13cIjUZZ9WfG++ze7lxSC9HiIcPsPVb8rtDW5DvUp8
 FG4EbkxvJvCZgFtwnWi+Vg/sd+YevRP0rvNjnrnXU23oTaYFb43daTv+J4xZqWRL0aRv2R7wRX9
 lIqLby0eBBWgcrotj7MRa/PhBK7UZiF2ISYSfAbWD45rA9+uywALQJ2H5DCdIxSJon+QKDeOXA0
 Xdk+VWRZbjoSxleZzL9JHBuTgkp+/g==
Content-Type: text/plain; charset="utf-8"
Content-ID: <28A721E5D7F4A24BA9F50B1E5A3F8FA0@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re:  [PATCH v2] hfsplus: fix uninit-value in hfsplus_cat_build_record
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_07,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1011 phishscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032

On Fri, 2025-11-21 at 00:16 +0530, ssrane_b23@ee.vjti.ac.in wrote:
> From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
>=20
> The root cause is in hfsplus_cat_build_record(), which builds catalog

Commit message sounds slightly confusing. The root cause of what?

> entries using the union hfsplus_cat_entry. This union contains three
> members with significantly different sizes:
>=20
>   struct hfsplus_cat_folder folder;    (88 bytes)
>   struct hfsplus_cat_file file;        (248 bytes)
>   struct hfsplus_cat_thread thread;    (520 bytes)
>=20
> The function was only zeroing the specific member being used (folder or
> file), not the entire union. This left significant uninitialized data:
>=20
>   For folders: 520 - 88  =3D 432 bytes uninitialized
>   For files:   520 - 248 =3D 272 bytes uninitialized
>=20
> This uninitialized data was then written to disk via hfs_brec_insert(),

I like the zeroing of whole union. But hfs_brec_insert() operates by key_le=
n and
entry_len:

hfs_bnode_write(node, fd->search_key, data_off, key_len);
hfs_bnode_write(node, entry, data_off + key_len, entry_len);

This values should prevent from writing something out of size folder, file =
or
thread record. Even if we are zeroing the entire union, then we could write
something that not fit to the size of folder, file or thread record. It sou=
nds
to me that we will corrupt the record anyway because it sounds that key_len=
 and
entry_len are incorrect. And if they are incorrect, then we have much bigger
issue here.

So, I am not completely sure that it is complete fix of the issue. Could you
please justify that my point is incorrect here?

It will be good to be sure that FSCK tool is happy. However, if volume is
corrupted intentionally, then it's hard to use the FSCK tool.

Thanks,
Slava.

> read back through the loop device, and eventually copied to userspace
> via filemap_read(), resulting in a leak of kernel stack memory.
> Fix this by zeroing the entire union before initializing the specific
> member. This ensures no uninitialized bytes remain.
>=20
> Reported-by: syzbot+905d785c4923bea2c1db@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D905d785c4923bea2c1db =20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
> ---
> Changes in v2:
> - Corrected format of Fixes tag=20
> - Removed extra blank line before Signed-off-by
>  fs/hfsplus/catalog.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
> index 02c1eee4a4b8..4d42e7139f3b 100644
> --- a/fs/hfsplus/catalog.c
> +++ b/fs/hfsplus/catalog.c
> @@ -111,7 +111,8 @@ static int hfsplus_cat_build_record(hfsplus_cat_entry=
 *entry,
>  		struct hfsplus_cat_folder *folder;
> =20
>  		folder =3D &entry->folder;
> -		memset(folder, 0, sizeof(*folder));
> +		/* Zero the entire union to avoid leaking uninitialized data */
> +		memset(entry, 0, sizeof(*entry));
>  		folder->type =3D cpu_to_be16(HFSPLUS_FOLDER);
>  		if (test_bit(HFSPLUS_SB_HFSX, &sbi->flags))
>  			folder->flags |=3D cpu_to_be16(HFSPLUS_HAS_FOLDER_COUNT);
> @@ -130,7 +131,8 @@ static int hfsplus_cat_build_record(hfsplus_cat_entry=
 *entry,
>  		struct hfsplus_cat_file *file;
> =20
>  		file =3D &entry->file;
> -		memset(file, 0, sizeof(*file));
> +		/* Zero the entire union to avoid leaking uninitialized data */
> +		memset(entry, 0, sizeof(*entry));
>  		file->type =3D cpu_to_be16(HFSPLUS_FILE);
>  		file->flags =3D cpu_to_be16(HFSPLUS_FILE_THREAD_EXISTS);
>  		file->id =3D cpu_to_be32(cnid);


Return-Path: <linux-fsdevel+bounces-71839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92402CD722E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 21:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87EA3304FFC1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 20:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120B5346E52;
	Mon, 22 Dec 2025 20:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SmKuEV5V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B599346A0E;
	Mon, 22 Dec 2025 20:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766435897; cv=fail; b=lcNp9/icrSgh0XWbIVsAsoSaw3SE5133mBTgNvPbgs4y/CKIpN+waIXGuhJyPQfby+fA9QwKSFtuAFjaWA5ituYErRVUzoq5UkYWSx47lLGH0+5qwhllCujtsSBgWyHozG2Wa9CAedxLoWI7Y2nLjgnocb7EonXCBXkYzbIff+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766435897; c=relaxed/simple;
	bh=AOhmbZ1643FF37VXCus7h3gcUvDWrXuU67c4WGSuGn8=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=loP5bHSeZRmXuAgMwZxYxO08n6OBU32zB4jFZbvq+0psds+I0yw1q7mWFNFd6vlTu+bwJX8JelDLhE3Bou6SPu5xZYRaMngfUo6GY2chHtxTOqcezCko7+0HljaLNdokhPprCSSL6d+AG0yVSYCRFsKhu4yldmRiAqKxiyfVCXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SmKuEV5V; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BMClRpv022078;
	Mon, 22 Dec 2025 20:38:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=AOhmbZ1643FF37VXCus7h3gcUvDWrXuU67c4WGSuGn8=; b=SmKuEV5V
	CmAAF9CUPnDVQPAW1sVZp43/tmmAESJVPBnRDsmDJ1XvnU3mzq2WC4SE0/w0dIFd
	gbGCmvKu5Hi8wlgcBJxqOGoJ2HkoXWhgZTG08l87xrf40yCidPspyCpG+vqX4QX0
	TaZWNq1gTtS+OD4rmdNCNuzHt354ZpJIXYGwgH5XJtiQqv+KAc189M40DK9Ww2jD
	CQBdguTl2yYcXqdXXebg7vfDyzM6aCFYnQpuWMYzBLmAHOsNu+vtCIF3TlnVGz96
	wpTzPHo1vBjZdZimnXtgSrbsvvkeXU/RT03fIYSIayOXGlzDt0JOYchf9P2LCMq4
	t3sn3aCykFjWDw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b5j7e1ssg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Dec 2025 20:38:11 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BMKcAln029674;
	Mon, 22 Dec 2025 20:38:10 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010050.outbound.protection.outlook.com [52.101.61.50])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b5j7e1ssc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Dec 2025 20:38:10 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gp99ZckYnUQr/07KOYjfSi61x5ChUM7CWhokIoAy0nH5mZKKCyUQMTg0mlKq3FLXWccHbwUADqok3aQu2w/RbSZhW8YLhiITJIaoXBjqNhdo4SQ6b2Sn0UqzJdPjvcq/06FapaTrA6oGOSZ2lj8Auh6yiojzqRi9X10QGBU9tuWlBFDRl7Xx20+RbIGe57Pqy4y1vg8LoV/LX4kdNwgHX6GlZXdsmMGAjAB7cmTerK9yIiAriWjAQwNFP2Xv84rUCVFhh9BrHh/35eUf+zSOG9VVa+T5cWU8SLTUF2owKiMkb0IjIr/qwnRPnQFlrUsmB6FslNfHEYhZEvBfHjchag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOhmbZ1643FF37VXCus7h3gcUvDWrXuU67c4WGSuGn8=;
 b=u8lx/PI2oyrdLoxPdJO9j7QasVOfx7ubCoNn6W6H40XW79Moi4qBJOl+2DkwAq/OSBuMAnNqyWVbTarFXjwzNvLP7PTNrsLkyVPJdYBXcqaINN5Dch52RUSrc3xL0rcSOpHFqqlnZf/K6T0NWRaUe9LtIj81N2yEf1YtZXZ5TFAAoYeb3VOKaT1Ums8xOyi38qO0k88DPdpLvDmrAQKUMwU2rTnT6FpEitxhG331GDZgmLIoGM6zOklb1N+iHC0wpHW6+88V8bIFgL8gI55so9lRF0GvYyM39BCbXO9ecbqlFHSu0hv340vqoRr+FlfAbJq5i+6EX3Q0sFKhfgmakg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DS0PR15MB5575.namprd15.prod.outlook.com (2603:10b6:8:13f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 20:38:07 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9434.001; Mon, 22 Dec 2025
 20:38:07 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: Patrick Donnelly <pdonnell@redhat.com>
CC: Viacheslav Dubeyko <vdubeyko@redhat.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        Kotresh Hiremath Ravishankar <khiremat@redhat.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Pavan
 Rallabhandi <Pavan.Rallabhandi@ibm.com>
Thread-Topic: [EXTERNAL] Re: [PATCH v2] ceph: fix kernel crash in ceph_open()
Thread-Index: AQHcb5TpmMeL+RYIakuRlVP/l+uM0bUmTK4AgAB3B4CAAql/gIAAOdGAgAR/kQA=
Date: Mon, 22 Dec 2025 20:38:07 +0000
Message-ID: <9f26c090c8c811f8fdffe2d8a1e6baa0ace4031d.camel@ibm.com>
References: <20251215215301.10433-2-slava@dubeyko.com>
	 <CA+2bHPbtGQwxT5AcEhF--AthRTzBS2aCb0mKvM_jCu_g+GM17g@mail.gmail.com>
	 <efbd55b968bdaaa89d3cf29a9e7f593aee9957e0.camel@ibm.com>
	 <CA+2bHPYRUycP0M5m6_XJiBXPEw0SyPCKJNk8P5-9uRSdtdFw4w@mail.gmail.com>
	 <f36a75dbb826b072a2665b89bd60a6d305459bfa.camel@ibm.com>
	 <CA+2bHPYqtgK=7n5+OQ2czX9M5Z9Yrsige4Jj9JJbFdLKPSZGhQ@mail.gmail.com>
In-Reply-To:
 <CA+2bHPYqtgK=7n5+OQ2czX9M5Z9Yrsige4Jj9JJbFdLKPSZGhQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DS0PR15MB5575:EE_
x-ms-office365-filtering-correlation-id: b9aa851a-ef22-49d3-6f76-08de419a0399
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?SnB6b0VKUE51cVI4U0pNVWNLVy9DUmFnTzFhV2tIZk8xV29WQ3hYZXhOSGhI?=
 =?utf-8?B?anhRVVhLbzI4aXdyUmt2S1NUZUhNTXh6d25NNmpkV3d0MWZlaEJlOEtiL3NZ?=
 =?utf-8?B?eHJtdlZaSUt3T3VYQWl0SGMyV2Vod2p1RFI4K2g5ZEtJVC8zZlg1eE0xSHZ0?=
 =?utf-8?B?em4xSk9lZStPeUR5UWQvK3JvVllvRml2RVJmNm9kQW9FY1k0VnllS2lUd1c5?=
 =?utf-8?B?Wm5xU3pubmwycHNKT2w4ek5aUmg3OWRGVnJOOG5zOXFXMTdZcGJQV0YrRW03?=
 =?utf-8?B?ZzN2Wi9PSWF1SStmZC9xclcxdGxQQlJra1VIRWVqV29BSFNWcG1VR1RHRmZx?=
 =?utf-8?B?TWdYaWJ4eFNPVythRHJkN3pvemEvMUtid3VTNy8wSWhobzQ5SzJhbXZYQy9Z?=
 =?utf-8?B?cGpNOWZCYjEwRUJKRitkeUZlK3V2UUZnTlNXbFhzcFBXZmRUMW1FeWhEZURi?=
 =?utf-8?B?cFBCVzJMbURMUG94YUpjL2UxcGFQQnlkNlowZXMveGExeGVOWVdDL2VwbnhM?=
 =?utf-8?B?VUF0QkYxblp3UTJLSm9NMlpJc1Z3Ymd6a3ZXZ2dZQUtjUmd0MkI5NERzdEg4?=
 =?utf-8?B?NXhER05XVlBQd1FDNnBzT0Z0UHNvdkdRbWhLUU5od3RPV1hOVWthS1lFK213?=
 =?utf-8?B?djBLM1ZXUGRBWU9pVHM3d1BKYzRHcDh0cjMzK3JIUHppMjhhUG9WL3p1L0Zl?=
 =?utf-8?B?OWRWWmNmeU0zamxhMFJDNDN2eUZNTU13V2dReUJCVHVJd2Vqelg1UW1TZTRl?=
 =?utf-8?B?QndjT2hSbTBLanN5ME1KYnBvdU43dlVVOHN0OWxWTlJ1S0VKSWk2RXAvWGw2?=
 =?utf-8?B?VWhFMGZXNHBkYkV6UEk1U293Qm1QYk5laGFZSE4vRkFabXZpVW9HL1BjODAw?=
 =?utf-8?B?NzI3cUZQRFZ2NE12M0tTZTZzTTYvZHlidVZ6d0UrcEE1NEJQSkZhYjZ3ZThl?=
 =?utf-8?B?R2x4WnZxeWdjSUYydDFlaVpBd3kxa01UZnVEZ3NPd1UyUmpPSDdQUjRwY040?=
 =?utf-8?B?OTNlQ24vc05JYlNWeC9UYjBMOHVjT3Fqbm96bFdiMDVPWEdFaTNWU1g5dWFH?=
 =?utf-8?B?cnNDYkx4Y0lhWUl1UXFPcm9RZE1mWm9UU1daaVQ2TjNBMEg0Rzh2VW5XSDU4?=
 =?utf-8?B?bzJlRldtY0s0UkZXTW9oc2RtZUFlNHN2VGNnNmlGaFlHSmsxYXZKY1J2Yk9L?=
 =?utf-8?B?bkxMT2p1dVdVOUYwUW1qanQwbHBzMmpRNTdPdVdGWjBYYjQvWE1OKzdPTlo1?=
 =?utf-8?B?d3JlNjlrNE9EbGl4VFhjcG5vRHIrdy83QWt5UkU0cUdlVnhBc3dMdTVpTlB5?=
 =?utf-8?B?Wkh4NDRqdFpnS3lrc1ZkWXIrLy9mNHhWVGhJRkRvNFhHR2Y4ODZOZVBWa2VC?=
 =?utf-8?B?b1k0YlMvT0FEOUpkL1F0bVBwcStoVkpzMTVKc2tBek01UlJTYVhDcm0vc1or?=
 =?utf-8?B?L3ZtTUxjYTdZMHhEQ2cyNkk1RVlsdnFuNzI2aGZlMXdkaEpnelVCTFFDd3B6?=
 =?utf-8?B?elE1UjB6ZENkWFNSUk5XY1BwZ01zZGgvaE1VWHdvM2hvb3F2REhtWGtmb1Nm?=
 =?utf-8?B?K1BMdVcyb2VrY3diMWNhSWFJeUNyZ08xNHl2MWNmMkxOZDJIVWlvZ041ZGkz?=
 =?utf-8?B?YkF6eG9XSTlrd0tSdXppQ2k3WHpaelVxSjlLSDZvb2NzRzd3OHA1OCtDRTFt?=
 =?utf-8?B?SDVhc0QxMG9ST1hWcldvYmdCeGdKWE5kTW1KeVBDcUFYSXJLWU9TdXp2OUlW?=
 =?utf-8?B?M0R1Zk9KSjlwMnl4R21HZ1B2WENDUm8zZmNSN3pJaVV6VUsyZk4zL05nSnF0?=
 =?utf-8?B?T0FOcWVubTVTTnJ3cDFwZTl0WHZHN1dySDdCRmc5OStqUDZYbUFVa0lKd082?=
 =?utf-8?B?RDZGbXVtcHpYOXlxQkhWZkUxNzZjVE15d040aEtYK092OTY4MkpKQ2NwcGd0?=
 =?utf-8?B?Qno3NmxWcDBCMk9KNmZNNHgrUDU0YzhxRndiajdVSnc3TEhONUlJUWhVaWRx?=
 =?utf-8?B?V3hNRGxLcmwrVnVmSmFTbFY2OWRXWEhoQmZIMUxrcFoxWTJqVDN2Zkh3K2Vm?=
 =?utf-8?Q?d57bw3?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S3BuS1cveEw3N2Vpc0RjYnlPYW1DMkVPZjlWcU5Fb2VmN0M3dUR5Z2pUKzh6?=
 =?utf-8?B?MmQ5VG0zeko1VHgvZXIyOU1HSVRQU0Q1Qy9FaWtUbGlGSVEvd0JIOXhwdS9D?=
 =?utf-8?B?N2ExdUsxWWFrVFRmQTBMb0dQQzZMR1JKQnA3ZGlWWnVobEdZVmlGdGpXTmh3?=
 =?utf-8?B?QkJMZGxQeWY2WkpUQU13THo4TkM2OU95czRieDYwSGdNSDFkNEJGMkZ1MC95?=
 =?utf-8?B?U1psQVdIdkFCczNIUy9jMkZwK0drWFg1bUZDZVQ2NUV4dlpzdnBqcS80NitH?=
 =?utf-8?B?aU9uWHZWOGRDOUxjNjNTZlBjUEFFZFBQQWpsam1uc1B1NjArZTE0Mm45Tmx4?=
 =?utf-8?B?U3p3clRYUXpFN2pHMFdyWXM3UUhWVVl2QW1ha2UrQWZRTkdhZDJYeHlrVkNQ?=
 =?utf-8?B?VnZqNjBYdkRoNHZjVVdHQ2hLYTVrYXdKOGo3SDVRV1NGdVBQOTl2dGk5ZnA3?=
 =?utf-8?B?TU1tK3lFanIrK2U5bC9pMnhnZExFR1R0dkVJdjJ2cU8xMVZnWnliUWVaT0FR?=
 =?utf-8?B?RW9IekxFaE9pOUdodm9za2V5a1RlSWttcTBUZmhOQ29Qc1FGM1k0MFZrSXpu?=
 =?utf-8?B?TDRCcGw0SnU3dWI5VUVnUEpNQTZPUGJ5dTlBQlJKd1RGQncxb1pBQ3NhZE56?=
 =?utf-8?B?bzBCMnd3dEtnZU04elBiVFZtTVZEU21ibk45Q1J0UEltTmpJZlhuMHBzQmgv?=
 =?utf-8?B?OFg2VU1xSlVuMUNWMHNKUkVjdHBwTG0rWUtCcE9FQjVmSEtSN0NJalVQdzJC?=
 =?utf-8?B?ZWQvVWRmSS9nZWhxWkM2cGVvb0U5U216T0pMRDJWVThOUGozMXRPcXVHSmRj?=
 =?utf-8?B?SjhNbzNpYlErSis4clI2UzkrSTFLUllIbXJqMEZZNDZJVjZkTFJqaFRTZmZS?=
 =?utf-8?B?c3dleDAzNHM4NkJzSnNjU3hLbDlFTTNJa3d4TUx0OFJpQmhNSjFPb2tmalNR?=
 =?utf-8?B?aGJ2bE5IWmRzYXk5ejBlNDN6UnZqTS9KMzJQa2pKMHZHWTlIdXR6dHB2V296?=
 =?utf-8?B?eEExdndDN2RpaU1NVTR1N2pxcm92TWs0NVlNVWlnWFFJNWZaa2JucmZLZ3R5?=
 =?utf-8?B?NlBza3FuOFJXeVh0YmFCalhvUzU3SnJVWk5GeU5qVDVVUHowTWdYdXN5V2Vs?=
 =?utf-8?B?OHFidisvZDZ3ejE3UHAwaTZ4aVJTZ3pRb0t1YURqLzczT3BIWks3bVFwMUpW?=
 =?utf-8?B?dWtyajdoMWFmeVUyRHhMSWxOYk45aCt3REFCejVEMUFHZzVhM3JuYmIrek9N?=
 =?utf-8?B?R0x3SnN2bmZBRkt4Tks5eXlTQlc1UlFhbWNBclgyL1hwaDhPaFJUOVBQd05u?=
 =?utf-8?B?cjF3QTQ0cWVZdXNWR2wrUnlvN2tvUGxoRU1GaVVnK2Z4TjdkT296d0hmdEYr?=
 =?utf-8?B?eWtuMVJxaWl6R05NTjU4NmVySXZQZllZUGxnNzRIcDZ5UEdhU0ZWcVM5THE0?=
 =?utf-8?B?QTNRbjZKL1NwZkEzdmgwNklQTktEZmFSWVZQalUwcTl0WFJsQU9RSmdPRkVp?=
 =?utf-8?B?NHl3dDhTRVdhQ0NwMzArSW9sSWtPWmFzTzVDM0FTZkpYdzlyWnpFSUd4dkNE?=
 =?utf-8?B?Uk9lM0o1VTVBTU5NTHB0d003a09kVzQ0S0RtNTBRUU03ckJ1Mk5mR0F6ZC9s?=
 =?utf-8?B?elp0NjBkblBYUjBnMWx6SXVuWktEMnNPcHdxdEs2NWdGTDVrZjFDWGZWRG5k?=
 =?utf-8?B?S3JKLzBuU1ZQZnV5MG42Tkd3R3hnbXhscktUVHhMUkcvN2FHVHhYdklkWmw1?=
 =?utf-8?B?VHhFZEZIeU92bWNaRTRtR044VThvdWFTRzBWdHhTRmZmWTJKR1ZHcXpibHhZ?=
 =?utf-8?B?TkdUa09Sa0VVaU1DanhpZlA4bis0eE0yUER2MmdQVTRtd1hYU0lyN0MzRDUv?=
 =?utf-8?B?YzRHUS9GTkRlR25WK3VRM1NreTZSeHFYRmJ5bmJ4V2R2UW93OG00RzRvSmRD?=
 =?utf-8?B?SXhRQ29sVkIxNVJ2bHVoZkhuQ3dKWEU3akFJZTVsQ1ZwUDFpY0ZFYnp3SldP?=
 =?utf-8?B?b3AwRUFhVTV3OEtDYkpFOWoxcnUrMTZXT3BMRUFBT1hoMUxRUFU5UXgxU2tK?=
 =?utf-8?B?NDhCS2tPNzE2eVJZcjJnUFhYNWhLS0UwMWxUanNPall1SjAxRzVhSDlISG9a?=
 =?utf-8?B?dThrM3FwajQzQkdSTzZSUDlqNDJML3U1c3dVc3hFVC9sRmQ3azlLNFBMWkVV?=
 =?utf-8?B?cDBGR29HanhoYkdRQU9OanZrUk5Tc2RNUVZTeFBFb0FmUEZvTVdYUmFSNTVQ?=
 =?utf-8?B?dk1VcngyTGZSSEJCWnNGeXNWMVc3T2FncTJHdGlBc21MSDM0UHk5dENjc3JM?=
 =?utf-8?B?a2tLSVdNVGVJb1RRNW1lSytNTEJBRWsyVVloSC8zNlR1NGpPV3VZMU1zWkp1?=
 =?utf-8?Q?SERmeekwIG9kUwlcDAfCpwxynepJTapU+TLeF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE20FABC234D564C82C5CFD7EC746207@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b9aa851a-ef22-49d3-6f76-08de419a0399
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2025 20:38:07.3881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pvw6YuRUStmc/Zmn1EDC7SPwgP9cta9WFdP2SXTpREaiNm2UVg233WO0JhevLZorHwA7zcJypFU5jGiekQtEZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB5575
X-Authority-Analysis: v=2.4 cv=G8YR0tk5 c=1 sm=1 tr=0 ts=6949ac33 cx=c_pps
 a=0CigaX/e8+d28YZ4T1vruA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=Vf4vKfAvgbl90p0K0asA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: jvvB2OZS2H_4Qa1wnM932BS_crDsfYFq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDE4NiBTYWx0ZWRfXwu1C0dvvnf51
 xFqWujuNiMvfy9kqdDal8AR+tiP/hJJ0lRLTwU6J0vLmantpEZ2503acBfJA+AR+ESurPhE4RAr
 nMhV1DZdywU49ImaCPxfDicytQlAHdLGeRTNm31FiyaK4x0A3g68VDfkEIaejWCN5DSwKYlffkO
 PWC339359K0ZtnoUk0zexIWqdZsUPdANY94R2ic17g+/92KmfMgdORk+jvX59LngtSlqleA+x2L
 uMWbqN1jdNlR8c/FsuEZuSrIY1T3vksG3Fs6mQHSsuwvr3I0QBcXqNlFVTyxI9ECOAsbuGESzOU
 tUvV2ZvDb/l2AOoRVw7NzioxRR9i+UDJ4YWdEK/kcCpKpzLbM5yxgfG3V/ljYvH9AyTOPoE9xz1
 R2fVq+/BwqF3HymqHOxol56130ej86FlfAkTMQm1c31qJCXYhP5UE/0t8lGIzmsUqa8jLVUOuPb
 7QMESdwXNlBc+m4Hbrw==
X-Proofpoint-GUID: 6j3jF2xPTflM1tnlWxom9wDy_aYQlPWj
Subject: RE: [PATCH v2] ceph: fix kernel crash in ceph_open()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-22_03,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2512220186

T24gRnJpLCAyMDI1LTEyLTE5IGF0IDE4OjU2IC0wNTAwLCBQYXRyaWNrIERvbm5lbGx5IHdyb3Rl
Og0KPiBPbiBGcmksIERlYyAxOSwgMjAyNSBhdCAzOjI54oCvUE0gVmlhY2hlc2xhdiBEdWJleWtv
DQo+IDxTbGF2YS5EdWJleWtvQGlibS5jb20+IHdyb3RlOg0KPiA+IE9yLCBkbyB5b3UgbWVhbiBv
ZiB1c2luZyBuYW1lc3BhY2VfZXF1YWxzKCkgbG9naWMgZm9yIGNvbXBhcmluZw0KPiA+IG9mIGF1
dGgtPm1hdGNoLmZzX25hbWUgYW5kIGZzX25hbWU/DQo+IA0KPiBUaGlzIG9uZS4gKEJ1dCBhZnRl
ciBkaXNjdXNzaW9uIHdpdGggSWx5YSwgeW91IHByb2JhYmx5IHNob3VsZCBqdXN0DQo+IG1ha2Ug
YSBuZXcgcHJvY2VkdXJlIGZvciB0aGUgbWF0Y2hpbmcgbG9naWMgd2hpY2ggaW1wbGVtZW50cyAi
KiIgb25seQ0KPiBmb3IgdGhpcyBjaGFuZ2UuKQ0KDQpJIGFtIG5vdCBzdXJlIHRoYXQgSSBhbSBj
b21wbGV0ZWx5IGZvbGxvdyB0byB5b3VyIHBvaW50LiBCdXQsIGxldCBtZSBwcmVwYXJlDQphIG5l
dyB2ZXJzaW9uIG9mIHRoZSBwYXRjaCBhbmQgd2UgY2FuIGNvbnRpbnVlIGRpc2N1c3Npb24gdGhl
cmUuIDopDQoNClRoYW5rcywNClNsYXZhLg0K


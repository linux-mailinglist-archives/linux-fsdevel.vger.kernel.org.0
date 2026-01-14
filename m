Return-Path: <linux-fsdevel+bounces-73807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB10D2109B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 20:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC6CD30478DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 19:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4F4348886;
	Wed, 14 Jan 2026 19:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VeyWY+54"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0BB346E5D
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 19:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768418995; cv=fail; b=UbpLg7obJhtnehjN3EujFBWOKVVEBdYFsBnQ6gMKIFgcHIJ/n4rvcU5fTUIadaUnP0OZ1SxN2pZij8Jxw2pN4rSvVs7TkCeD2qxE/PJEL16k+CBIUNoLZ0PpgIRqpdMhjjj762qLNgv72YRtU2e4Z7qs9SnZtgivU2WXzMa91R4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768418995; c=relaxed/simple;
	bh=7+GNt2WqCpGBZ9ed8aurbivKLlYyxVLYeXWWzf5y2gg=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=SCY94ZWnUD3rLBKBVhziIQ3TbicnxAMu0HBV1R+aliZ2tK3sJ+7HtPKZQAINcfLtJlGTocy/KELimHeHbnGRViban5CBHyq64JJ/Ng3kRad0fz7zXdLpdpwd5iWVeN5suz9484KTNvnGD9Rpo+MefWhtiazh/xHcbPNv8s0W8ZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VeyWY+54; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60E8YR1N009533
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 19:29:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=b0abmAh9TIBfFM6udzRaISEBIvTyltmYTjOiV9ksKMY=; b=VeyWY+54
	mmWtIKAha3C6WJ3HWFcFfuOBTtqsLdzn1GLdGCtOtF9LfR/Q9Rvp0pqHcpokrTi7
	3M9FdQluT58A1/L0TDyQqeJ4mXcwf6gxU17S1Lk7SLbEMEJO/JHj9+6e9fMwDgxS
	Rw1MHblpDDZydWGPdkSeQuBMDBkGWupGSS1xiW/9Mz711v9HQIup0I+GDlSSlA7J
	aAp47qANyVmeOOxs0HLcTz0he3t9/jJnxi1nhwxBmScEIA5eZgahT5Jygm7HpUg0
	pQ+GeFKgFd8AioEqBIaUW2mt4vSgoMgTp3rHeIDUkoiSPW9OaxC6nyXMWBclRiNx
	b2vQduhYLrn8yA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkeg4k44e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 19:29:53 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60EJTqXf006150
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 19:29:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkeg4k446-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 19:29:52 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60EJEwID009369;
	Wed, 14 Jan 2026 19:29:51 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010015.outbound.protection.outlook.com [52.101.201.15])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkeg4k444-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 19:29:51 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d3UYOZR/cBxIbl8QFDEkFLrLBNfYPELBHn9w0gaAev9vUT/SL7WofcqBx40MafQ7Dqrm/yONd3ILM06Qz/p+64zLjFVb8Tk9YeeCnDWFlRWoSteIux60Y4dBI7RqFTWnSCTkDeZfKmYf6gKSmbhRMoN28BLP4hFR5ZKnJyYF60pD6x8R9IgNKutNrpJO+pju2TvRixbr+ik2M8/4DJNyNIWSayQH5quQYYPg5C9Olebd2nHldF/ZuwbBSTanrvu+iH4OwwA8HZYKz5dmIPZZ0/zL0xrxoNY7tWn5Lk4v7OAAOmo83QqkYkKAQOQLRV/v26jLIMcaGLNXJ+kCarTYkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6JP5CZp8J5tD/mtFKQuOo83kOFKMxnNwLBlqmw/8OCg=;
 b=N4uHycFdnqS6kz/dablGi0AflBvu1xt/U2Zn6oD9UGmFTy3mXlxbjJJ3iK2wuS/2W3MbrfKPi0aUg06p68cmkH4D9ZS3/zYdDPOcmny0Hr4P9QUyhOScM30xBUcZK+TpLo6bOerANI/gSKdb50PckjQKhsnHV3LkMUyEyXg/uF428vFC8sGmC8sjhDxLzUPmsGk+KBaJj5KgqOd25m/Fmh2qtk6CtBxUgnCPsCiyp79pfeziXF0PBCGJYOomilayzvMKUMZ9xpU4DJAeVKMZXm8VAMUr100pI2gdJeeQhEAto+khOzi9gB9BUJZWoEul2JH+qnc/6yy5im8WMnkavA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH0PR15MB4527.namprd15.prod.outlook.com (2603:10b6:510:87::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 19:29:45 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9520.003; Wed, 14 Jan 2026
 19:29:45 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "wangjinchao600@gmail.com" <wangjinchao600@gmail.com>
CC: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "syzbot+1e3ff4b07c16ca0f6fe2@syzkaller.appspotmail.com"
	<syzbot+1e3ff4b07c16ca0f6fe2@syzkaller.appspotmail.com>
Thread-Topic: [EXTERNAL] Re: [RFC PATCH] fs/hfs: fix ABBA deadlock in
 hfs_mdb_commit
Thread-Index: AQHchQJlsj80quEwJ0uCe1jfsMW4jLVSDkAA
Date: Wed, 14 Jan 2026 19:29:45 +0000
Message-ID: <d382b5c97a71d769598fd32bc22cae9f960fea70.camel@ibm.com>
References: <68b0240f.a00a0220.1337b0.0006.GAE@google.com>
	 <20260113081952.2431735-1-wangjinchao600@gmail.com>
	 <a2b8144a25206fba69e59e805d93c05444080132.camel@ibm.com>
	 <aWcHhTiUrDppotRg@ndev>
In-Reply-To: <aWcHhTiUrDppotRg@ndev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH0PR15MB4527:EE_
x-ms-office365-filtering-correlation-id: 62a2dea0-ce46-42f8-5354-08de53a34651
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?QzVUNUtpRzlNRmQvWkE0cHh5dTg4cVkvK1R4UnNoR1ZvTWMvaU5NbkFoZFNP?=
 =?utf-8?B?WG9vZ1B2SElyL2RyOFNxRSt0UWM2WWwxQTgzYUNJRy8rYlM2dFNlNmg4SkFn?=
 =?utf-8?B?b3BHWjNHOXJ5QUNnMDJLVWFaZFJ1MFBJWHY4Z2theHBOYWVLVExGU3dEd2FX?=
 =?utf-8?B?bDVTSGM4dVlHU3p4V1JBcWdRRkdoM0MxSFl0Wk82cXdFN296YWNnTEI4NU1o?=
 =?utf-8?B?djY5MGVMSVBxR2RnaGJmcTd5RFFreWdxd1BUdnNEbUhPYXpuWU14aGF0T1ZH?=
 =?utf-8?B?MXFBUVV0RThoeUNOQXRmdFh0U2ZiZkpONHJTOUsxWkw1RUhsdHFEZFdrdlZE?=
 =?utf-8?B?RHNSZGxxOXpML0V2Zzhzc1lDSDBJcHpoQ3JiWG5KM1pBeDRiZTNPSngxTWVa?=
 =?utf-8?B?VndsdW5FSUtLL3RtaVJaL1laOUpJcnhXOW5uZlhJRVJhczlmMWtxQnR3SVZX?=
 =?utf-8?B?dXBaSmtwREc1T2RXbWIrL0xjTm03VnF1RVdmRzVYZXNWaHJGTkRkeG9xUUZI?=
 =?utf-8?B?SGxlbncwcVQrbDNmcFdOVzk1V1VkWjUxVjVkaFdYRTUwUlVMdnBHT1d6TDNN?=
 =?utf-8?B?YzgxRWpGenBCYUFtQ1VMR3V6Q0ZxUkRFWU9QQkFsOTBneDR3UDU4Q2Izd2NG?=
 =?utf-8?B?M0pyZVZ2a0ozOXo3SzMvaWh5eE01bXg0L3dHU2pabGk1bG9pSnhEbXk4clVQ?=
 =?utf-8?B?UHYrcHZaeTFmZFBienhkNFpJOHJpQ2VNZllsOGFyQ0N3R0x2RzhFSHR5aDMx?=
 =?utf-8?B?SE1wQXRhU2lWQlFRVERLQm9iOEVjc2lFUTNKdk9zMTl3MEhCaFloMDBubUZW?=
 =?utf-8?B?Mzl2VzFLRGs5Z3diK1RsMElPSnNFSDhNZi9jbUpUOWZMOEs4WmNqKzViVjFn?=
 =?utf-8?B?TmswaUpaNFFRMUhVS2t0S0F2TGdvdW9sUHhrSzM1T1p2YTRuMERsVjlTb2R6?=
 =?utf-8?B?cHFJcjNRL0xGOXMzaWFkbEtCQkt0ckJoamtBLzVDcllsTkhkSGQzZWJ5Nkpq?=
 =?utf-8?B?VXNuYjg3ZVN2L05pbUVZZFlVUXVTRDVIYTBOSXFoK0t2SWlYaExqVWxkdWJS?=
 =?utf-8?B?VmJPbkJnQ05rMkVWRkVzeld5ZkE4UU9CVTZhbzZvcmUwZ0pFellUR0lIdmVh?=
 =?utf-8?B?RkRTSWFGQ2ozN1EvRStkdGI3T2x1R1lnVngrY1F1eXUvK01lbTZlcHJ2NXgw?=
 =?utf-8?B?MVJIdFRud09qRWYwVTFjdW42U3hQRGZ2WmhWVW9SSjZlM3dVSXZEREJuYVhh?=
 =?utf-8?B?bDJ0OC81OXExSEg3OGVFMXRwRzlJYy9pSHcrUmw0VlB5ZnN2ZXpOcmFMRXBH?=
 =?utf-8?B?dTd2bWlWY09kNnh1UTYzU21tc3ZqZE1LK1dhZkxrRlFsOVFQajZPNE1RUjA4?=
 =?utf-8?B?b052QmUyRFc3cVozdk0wMU1SWGNKUWtRVmFMbmR0enNacEloYXZhZEZ4YVpU?=
 =?utf-8?B?bWhjYjdyampvV25JdnlaM253eUNPUW1jY2FTNVZoVi9oMW9wSmkxci9DK1FB?=
 =?utf-8?B?K1F6OWpxTjQyUE5PVEMzT29pdjlJNFFqMFFGeEhrUW1pSllpYnVMVmFhSG5Q?=
 =?utf-8?B?cWRkVitwQU1DRnUxMzJmL0phd3Yxcm1kbnQxaHNwWkdWU0xYTE8vdlJuUEhL?=
 =?utf-8?B?dkhzZlorVjBocDNPblNvVUlLRFo3c3dwUUZzeU9ScC9XS2lJanJvVmk1eW9F?=
 =?utf-8?B?RlhHUVpva3dkRjFJUHdGYkpCV0xHZXB3TTZRUllTeWNYR1FhemtNRkhSSXcw?=
 =?utf-8?B?cFZZdWVkTnBuK1lnL0o0L1RjMC94QTVXd1lFclJlNjNOcUsrdUxPTzQ5a2lC?=
 =?utf-8?B?RlN5c1N6NmR0ZzlGM0ptU0xmOTJWUGIyWVdpOEtscVRnTUY5aEJ5YU85MWJq?=
 =?utf-8?B?QkNWOVJyWXNydE5hZXIzSTNVTGxvUVFnUFpraC94Y1lOWlY3V3E3dU9sb2lx?=
 =?utf-8?B?SThnY1BJVTdGZEVtMzl2RVVLUFhwSnVZank4ZkM1bjhSOTZ4bHF4VHZycDdL?=
 =?utf-8?B?aTI5dXhLa3hzNUx1Q2lhTE11dGJmdGovRVYxUmJ1dEk1dXpxNVN5Ykh6cTB4?=
 =?utf-8?B?WjBzVGlmV29IRGdGZm5YOUYxMFYzaVlmZ0lvYVRVWUVYa2dKNi82WldTS2s4?=
 =?utf-8?Q?8/V9Q85GgxuCUSFGheeJCfnhP?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SFE1QVppTTdSOTdkREhrRzZHOGg0dkE1RU1jRUU5WUpxT1VlcGtCZnR5cWlM?=
 =?utf-8?B?M0R0QUk3OUNFWS9EVzNGbTQ4SjNKakRpS0ZIVlVEL0wzQXRZbGJTdDlYam0z?=
 =?utf-8?B?T25aVnZxTnNhUWt1UU1GWG04Ny9yU1J6RGFTYzAzNk1lem9IdFNhM1owUk5j?=
 =?utf-8?B?TURZRERxK1EvUU1KdVZKSlN4d1BGR29pZDJXbzJIWVI3Nzg0TTdwZWpxNGZl?=
 =?utf-8?B?NmxmMFpRWXF1ck9HZzJ5WmJ2cmVKNHUzQ2pyN0hjM2FsU2tidnUwdEtVLzJ4?=
 =?utf-8?B?Z3h5NmFyVWU2dFFwTWs2Rk4zV2JUZUNodzNtZmZuSUQ1ZHRuV205ZENsWTlD?=
 =?utf-8?B?OTBoNGFzSzV3QXdLSGYwTWNrRnRjQXdGd3dTSmVYeWl2bjRzQmdma1dtS0Nj?=
 =?utf-8?B?QU9lS0dvR01XVjl1alB6dUQyaDZTZ0E0NFZ3RjF1UWpCMmpyR1RpTWc3NHll?=
 =?utf-8?B?RW0wOHBEQ1dQRG9LTm1WdjVnZGFrM0o5WFRaVkN2ZEZVeTBQRVlBTE85dGNZ?=
 =?utf-8?B?eFpFS2JMd25tN0VRdUdqbk5SSUNwMFRlOWhtQjM5cldicEZXZnZ1dnJYSW5Z?=
 =?utf-8?B?dlBhOWtBL050NXlERDhWZ1REam1zQVExTkxiY2xFTDZ3bmZaaTRwZ3B4ek11?=
 =?utf-8?B?MG5YYVhad3AvOE5QZFdIWFErdVlzT2xDcURiMFhGa3ZpL1RYQ2RhTEpKczNB?=
 =?utf-8?B?OGlYN0NaT1VybU02YWIzZnpUUEJxbjhOUGozVW1BNjNNTXVOL0YveElCZXE3?=
 =?utf-8?B?Z1BwTE1GS0dSSm1XOTdCMHJYdG9uaDVyaHBTNUpQNU8rRlRoK05DeWdxNXNO?=
 =?utf-8?B?cTdqcTZlaC9BamYvd0tSZG5uV3c4VEpiK0Z0L21zQnJoM2hwUUwwdnBDcHo2?=
 =?utf-8?B?SndsVkVSU0FvMW4xL29mSWxaYVVCaFhVUTM1TS92R050Mkdjdll6b3ZLbFFI?=
 =?utf-8?B?ZCtjQUVtYTdZVzRMdXRCeVRmeVRTSmRhMGRyTWd5L09pdWxlalBYMkpraXBp?=
 =?utf-8?B?aXI3TlFVL0hHQ0dvcWYrY3MzSnkwWnhXSVk0Q3gyUkFMWS8vdDRNVnVMSGRI?=
 =?utf-8?B?Ym1SOHFxSGZkYjBYYW5QQWJqaThUcTRIVCtJU0MwMXRodmRaakhsNk0vSWhz?=
 =?utf-8?B?V3JYUkttNGdQMFVJUEUxRFBWRmFWbWZhT2pHV2hDQ0RWaUhkYXFuNVgzNHNR?=
 =?utf-8?B?RmlzbjJVS3hGb1MzWTljWDR1RWdac2Znelk5bGpoaUJCZjExb256TjlQeUxF?=
 =?utf-8?B?OXB4M2Y2ZTc1a09EMno3ZTVkTElpU0M2aUp2V3ZRbnBVOEx3d09HMGtjR1Jj?=
 =?utf-8?B?WlIyY2hXWkdpcFFXUlFRMnljVmpVTVU5SmlOdU1kMjZUOE5WKzU1WEtVSzlz?=
 =?utf-8?B?ZE1HeXBkY3RDYUdyOStnaFhKY1o3aUsxUGptNWpHM2l6enI1aW44dGVPYlI2?=
 =?utf-8?B?OVlDRTY3RERVV1VlVTZIcVNUbGVoV25FQmhCckxJYks0WHJPSk9sSlJNcEcx?=
 =?utf-8?B?Witqa01KQkoyNVBPdlJoa1N4WTNoYjlpQUh6TzJLcWhqSjFpVlZ4OHljZ2ov?=
 =?utf-8?B?Y2Y4VGlENEpZRGxUMUVIL1Z2U0wyVmhkRTBUNGR3Y1VGWkRKRjVUaU1tOXNO?=
 =?utf-8?B?ZXNvTCtQT0l5bEFuMlhGZUtuWE1JSHdpUWtKeGtOaGNPWGZ6OXRYYzZ2aVdS?=
 =?utf-8?B?TnZrZ29BQUpyRHgvVFlaK2FkazNTUHZoMjdRa2toRDlWdHpiZGJqODd5MmFk?=
 =?utf-8?B?clJlSWhSYlFjRFVENGQ5V0h4M1NKOFV5d2NQUEZGSmE2SVd1TUNTY2Vqbkcw?=
 =?utf-8?B?SytSNnhZT2hUdzF3U2ErYVZBcTR5cnIxYktJM2cvZ1owLzVsV3Y3NTBCOEVW?=
 =?utf-8?B?WmNyVi92NXA2VHhuT0ZDbk1Bd2dMNTNNMjdCS1RQeXZCdTRGVHBvVzBDbldH?=
 =?utf-8?B?NW1zQ1AzUFZQT2RURGc0V3c1VnNhaEFUcWFIcVNBK01DWEx6SFplNGhEM0ox?=
 =?utf-8?B?TUc4SHRVNnhJM1o2MDdXYVdvYVRlSUNUL1U5NFhPWGpwNjAwSFpKdW9VZDJs?=
 =?utf-8?B?ZUY1K3dmd2FGZmNRSktpeHpnb242cTNWRzBDd1BCN0VacDBWeUo3d0x6U3hs?=
 =?utf-8?B?THFQa3c2V0w3N2w1KzZLVnkwNnA4aHB3M2V0R1o0aGVEbWQ4UjhYK1RvQnd2?=
 =?utf-8?B?ZEllQUlCTmdzc1hWNXJLbTZsRklyc01tN1hiNElBN1o2d081THRnZjIvYy9m?=
 =?utf-8?B?WEdYZGYra1REb1BEVUFHQWVDc3Mrb0xmWGtlZHhmZ0lManZXUldJUDNUL3lV?=
 =?utf-8?B?YlIwdmJhN1dONERqMHNJWHNVdE03YUpWWTg5VjdkcXFzSlBoYTdQY1JiSTV5?=
 =?utf-8?Q?YDkKZl6mlKALQGILST1PuYIljxQHVilIIbA/v?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a2dea0-ce46-42f8-5354-08de53a34651
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2026 19:29:45.6678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iAebFoEpzbjFNZ7LIiLbdFV91EgO0F5rlKCcCAcpsViAwKScYOMVPAXd950/fJ8DSh22n6WOHWzNrbFrJRHSGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4527
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDE2MCBTYWx0ZWRfXzzbP6MV56ekw
 9qopCp6OdMFXGkJS3eaoeyQFlcPpiFrPHPFAev9YsVJ3SsuQIMx1ad9BV7n6wrVXck5GiqjZeFb
 HMIBBFHBtDiegmPcFsRNjHKcZF2rluriicewKBq+Skt5y8uObmG9fd7/Li6gmeLAAR1oSFEFZFV
 e4lpCAeYMLuGlk+knqrcBQV6s5OxKmpeanvEGdzfDAby+G8UQAt1baRaK7gbt/wOsPHIlxfjgfC
 ie3Pq4kKILxD8oGek0qIGy/ivCdURPzlEQFZI3+qv8FamRGUe3K3oTqrxFSXkNCKlJw+cJ5+8sO
 FQmfjJu9kJaQCNmcJs70LZjNG2w9f91247cdgMBzWJvTcJy1iwNrLSl+gXSvPbcztHvxLATVcrf
 TwWhIrsC3bgnZxPBgszg/gQaNuC/j9lo4S00LcKTBZpORpN5pJ1a9bYPbzeSeD76zBL2AESWOo3
 m05xgIKQiJoHBhLo2CA==
X-Proofpoint-ORIG-GUID: guAdrutZN8ANPDbfv9XK9dh9v6gkY2OI
X-Authority-Analysis: v=2.4 cv=B/60EetM c=1 sm=1 tr=0 ts=6967eeb0 cx=c_pps
 a=as7enBq54CXVX8P5rkIU3g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=P-IC7800AAAA:8 a=edf1wS77AAAA:8
 a=AchGawCBGeAxUm4FBz8A:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
 a=DcSpbTIhAlouE1Uv7lRv:22
X-Proofpoint-GUID: GUvaifmrJNwr3PwR2oG5pJiTMF07_RQi
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C2F37950050494C96B05C449BDCFCC0@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [RFC PATCH] fs/hfs: fix ABBA deadlock in hfs_mdb_commit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_06,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0
 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=2 engine=8.19.0-2512120000 definitions=main-2601140160

On Wed, 2026-01-14 at 11:03 +0800, Jinchao Wang wrote:
> On Tue, Jan 13, 2026 at 08:52:45PM +0000, Viacheslav Dubeyko wrote:
> > On Tue, 2026-01-13 at 16:19 +0800, Jinchao Wang wrote:
> > > syzbot reported a hung task in hfs_mdb_commit where a deadlock occurs
> > > between the MDB buffer lock and the folio lock.
> > >=20
> > > The deadlock happens because hfs_mdb_commit() holds the mdb_bh
> > > lock while calling sb_bread(), which attempts to acquire the lock
> > > on the same folio.
> >=20
> > I don't quite to follow to your logic. We have only one sb_bread() [1] =
in
> > hfs_mdb_commit(). This read is trying to extract the volume bitmap. How=
 is it
> > possible that superblock and volume bitmap is located at the same folio=
? Are you
> > sure? Which size of the folio do you imply here?
> >=20
> > Also, it your logic is correct, then we never could be able to mount/un=
mount or
> > run any operations on HFS volumes because of likewise deadlock. However=
, I can
> > run xfstests on HFS volume.
> >=20
> > [1] https://elixir.bootlin.com/linux/v6.19-rc5/source/fs/hfs/mdb.c#L324=
 =20
>=20
> Hi Viacheslav,
>=20
> After reviewing your feedback, I realized that my previous RFC was not in
> the correct format. It was not intended to be a final, merge-ready patch,
> but rather a record of the analysis and trial fixes conducted so far.
> I apologize for the confusion caused by my previous email.
>=20
> The details are reorganized as follows:
>=20
> - Observation
> - Analysis
> - Verification
> - Conclusion
>=20
> Observation
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Syzbot report: https://syzkaller.appspot.com/bug?extid=3D1e3ff4b07c16ca0f=
6fe2 =20
>=20
> For this version:
> > time             |  kernel    | Commit       | Syzkaller |
> > 2025/12/20 17:03 | linux-next | cc3aa43b44bd | d6526ea3  |
>=20
> Crash log: https://syzkaller.appspot.com/text?tag=3DCrashLog&x=3D12909b1a=
580000 =20
>=20
> The report indicates hung tasks within the hfs context.
>=20
> Analysis
> =3D=3D=3D=3D=3D=3D=3D=3D
> In the crash log, the lockdep information requires adjustment based on th=
e call stack.
> After adjustment, a deadlock is identified:
>=20
> task syz.1.1902:8009
> - held &disk->open_mutex
> - held foio lock
> - wait lock_buffer(bh)
> Partial call trace:
> ->blkdev_writepages()
>         ->writeback_iter()
>                 ->writeback_get_folio()
>                         ->folio_lock(folio)
>         ->block_write_full_folio()
>                 __block_write_full_folio()
>                         ->lock_buffer(bh)
>=20
> task syz.0.1904:8010
> - held &type->s_umount_key#66 down_read
> - held lock_buffer(HFS_SB(sb)->mdb_bh);
> - wait folio
> Partial call trace:
> hfs_mdb_commit
>         ->lock_buffer(HFS_SB(sb)->mdb_bh);
>         ->bh =3D sb_bread(sb, block);
>                 ...->folio_lock(folio)
>=20
>=20
> Other hung tasks are secondary effects of this deadlock. The issue
> is reproducible in my local environment usuing the syz-reproducer.
>=20
> Verification
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Two patches are verified against the syz-reproducer.
> Neither reproduce the deadlock.
>=20
> Option 1: Removing `un/lock_buffer(HFS_SB(sb)->mdb_bh)`
> ------------------------------------------------------
>=20
> diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
> index 53f3fae60217..c641adb94e6f 100644
> --- a/fs/hfs/mdb.c
> +++ b/fs/hfs/mdb.c
> @@ -268,7 +268,6 @@ void hfs_mdb_commit(struct super_block *sb)
>         if (sb_rdonly(sb))
>                 return;
>=20
> -       lock_buffer(HFS_SB(sb)->mdb_bh);
>         if (test_and_clear_bit(HFS_FLG_MDB_DIRTY, &HFS_SB(sb)->flags)) {
>                 /* These parameters may have been modified, so write them=
 back */
>                 mdb->drLsMod =3D hfs_mtime();
> @@ -340,7 +339,6 @@ void hfs_mdb_commit(struct super_block *sb)
>                         size -=3D len;
>                 }
>         }
> -       unlock_buffer(HFS_SB(sb)->mdb_bh);
>  }
>=20
>=20
> Options 2: Moving `unlock_buffer(HFS_SB(sb)->mdb_bh)`
> --------------------------------------------------------
>=20
> diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
> index 53f3fae60217..ec534c630c7e 100644
> --- a/fs/hfs/mdb.c
> +++ b/fs/hfs/mdb.c
> @@ -309,6 +309,7 @@ void hfs_mdb_commit(struct super_block *sb)
>                 sync_dirty_buffer(HFS_SB(sb)->alt_mdb_bh);
>         }
> =20
> +       unlock_buffer(HFS_SB(sb)->mdb_bh);
>         if (test_and_clear_bit(HFS_FLG_BITMAP_DIRTY, &HFS_SB(sb)->flags))=
 {
>                 struct buffer_head *bh;
>                 sector_t block;
> @@ -340,7 +341,6 @@ void hfs_mdb_commit(struct super_block *sb)
>                         size -=3D len;
>                 }
>         }
> -       unlock_buffer(HFS_SB(sb)->mdb_bh);
>  }
>=20
> Conclusion
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> The analysis and verification confirms that the hung tasks are caused by
> the deadlock between `lock_buffer(HFS_SB(sb)->mdb_bh)` and `sb_bread(sb, =
block)`.

First of all, we need to answer this question: How is it
possible that superblock and volume bitmap is located at the same folio or
logical block? In normal case, the superblock and volume bitmap should not =
be
located in the same logical block. It sounds to me that you have corrupted
volume and this is why this logic [1] finally overlap with superblock locat=
ion:

block =3D be16_to_cpu(HFS_SB(sb)->mdb->drVBMSt) + HFS_SB(sb)->part_start;
off =3D (block << HFS_SECTOR_SIZE_BITS) & (sb->s_blocksize - 1);
block >>=3D sb->s_blocksize_bits - HFS_SECTOR_SIZE_BITS;

I assume that superblock is corrupted and the mdb->drVBMSt [2] has incorrect
metadata. As a result, we have this deadlock situation. The fix should be n=
ot
here but we need to add some sanity check of mdb->drVBMSt somewhere in
hfs_fill_super() workflow.

Could you please check my vision?

Thanks,
Slava.

[1] https://elixir.bootlin.com/linux/v6.19-rc5/source/fs/hfs/mdb.c#L318
[2]
https://elixir.bootlin.com/linux/v6.19-rc5/source/include/linux/hfs_common.=
h#L196


Return-Path: <linux-fsdevel+bounces-74537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C62D3B8E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 21:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 200663020817
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 20:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1802F747A;
	Mon, 19 Jan 2026 20:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I9siDhMN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BEE2F4A14;
	Mon, 19 Jan 2026 20:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768856174; cv=fail; b=llbBv9WLResQm/ETCdSjjW+peTVen0XNRmqxpqaRlpZsrjr1mkCfcU84zvaV3djLNkdQayK/pbDhM6xt9OlCVqN6FH4Q/FEaiy6eGNwX129RFVMGSmRaokjSJ8cLr3q8lSt/PNVH14GIQt9FPejp4BLwmC1yQCz8mYPnXZbT2k4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768856174; c=relaxed/simple;
	bh=nv5m7WgrJWP2UHnjNKYgzOxUM1JWmBwVt+xcNRHePf0=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=fcFH550acfOrwToczgSO4BZ0Z68IaIm1InK1fUw16KvneqgL23UtJ40wuBih7/5nrW7fgvWETDW2n+P6MfGI5zufDKNahm4AETAoQNq+BrIA2GGmTgvWQ7UDWzPjMl/uuVkgsZqRHVSLWSsY+2D3Pn37CzQ0DdgsuxLhGGDsfdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=I9siDhMN; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60JDdeRu024682;
	Mon, 19 Jan 2026 20:55:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=nv5m7WgrJWP2UHnjNKYgzOxUM1JWmBwVt+xcNRHePf0=; b=I9siDhMN
	3sdLhscM7RYaclbdFNw2Lf/bKKNjpxzTUqAbs6YJL3v60mW3iRw0FUiP0/DOLWs0
	cuCtULXNjjce6pbveqgqWOetDFRVdoogEJGazoGFVX+pqMj+WirDb808mnlfcxrX
	rhiqO/yElOtf+BVzOe57dFrI2vO29nZ4nf1hEuXZyFcABWJ4MKoM6gSJ3Z6EBLnI
	FdWFazVECPmm1tE3qD/nU20AU2zLD/ZxDjxP94kpOIUnt7tP3laRUBLeervxezNm
	ch2Vr5Or+q1jgiqy/lWB1magFpgHKfJUWrpu8XOvY/z0SMpCrjynKSZDatNZjBmU
	99XkmnQOYYGZvg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bqyuk1ynp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 20:55:58 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60JKpPaj026397;
	Mon, 19 Jan 2026 20:55:58 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011004.outbound.protection.outlook.com [40.107.208.4])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bqyuk1ynk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 20:55:58 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WwcLblx0jgIWm0a0CyukRX2fxrwjxcfDtz4bJWqt2TuNXpo3irDbqowY7Cd0FmO2bkpQtX2qa0GFsMNqpoHjrw2CNe3tE6Uw/NkC+9hCQ+FA0+epSFgcZRS6fwte99DXkv55Pa1tQsNbxTeuK2fzOxMOCXbduRO+5UzCVX5JIATJK+2AlgsBt1wsBdj17UmoP6ojzjnyBqW1PpqqiHfCoIUlm3TKzd5dxBBIpNP44nsc/2qJNHFyRh5XB+G7M7o8+1qCBDenXhPSF1Nt9dqRTKnseQ/iOLL4U1nmt0Z9nUqR0vrYczcLazX95t1+6O6K5GxAlhvNTgR71dmnFItmTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nv5m7WgrJWP2UHnjNKYgzOxUM1JWmBwVt+xcNRHePf0=;
 b=ebOnTh/ONNqOklhARjpW2Qafc03K+dDEH7XRkREeYrgjKhPP+3Jh1zQZZT0NFy7IENTV8iKWDQT7mTf1eM4oLA7B2WfE7BMdB5Y9bESht6wp/rpu2ucwnV/EkzkFrra9HaCQReqaMqZlBv7YFmMZDzScgug3gJJUczXMMFaZnvQltBOh+D64HU/ZiM0bofXKfDl2u1lWriaYCi2PIvJ1lJfDmE3iifsMzdHkz4N71G/n7RYRGR2z1X4UQeS4drIQPqSePuLhoDyqpjZ7UwbSgXNQ9AYz4MxzxDojq7V65y6B+62sXPbaNsNp+QPIYBNH5LDdq81KapaKfWaiVioElQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DS0PR15MB5627.namprd15.prod.outlook.com (2603:10b6:8:14d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 20:55:51 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9520.010; Mon, 19 Jan 2026
 20:55:51 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "brauner@kernel.org" <brauner@kernel.org>,
        "mehdi.benhadjkhelifa@gmail.com" <mehdi.benhadjkhelifa@gmail.com>
CC: "jack@suse.cz" <jack@suse.cz>, "khalid@kernel.org" <khalid@kernel.org>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "david.hunter.linux@gmail.com" <david.hunter.linux@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kernel-mentees@lists.linuxfoundation.org"
	<linux-kernel-mentees@lists.linuxfoundation.org>,
        "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>,
        "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>,
        "syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com"
	<syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>
Thread-Topic: [EXTERNAL] Re: [PATCH v2] fs/hfs: fix s_fs_info leak on
 setup_bdev_super() failure
Thread-Index:
 AQHcXtteFGhLPrTb/UieBFUI+djHs7UFH4+AgABrQ4CAAK/KgIAAvdEAgAKmrwCAA5NDgIBJ1JuAgAMS84CAABTXgP//9iiAgAA0OID///UigA==
Date: Mon, 19 Jan 2026 20:55:51 +0000
Message-ID: <1bfac55095419b8c5d9dd73dbf9b8b94c74b264a.camel@ibm.com>
References: <20251119073845.18578-1-mehdi.benhadjkhelifa@gmail.com>
	 <c19c6ebedf52f0362648a32c0eabdc823746438f.camel@ibm.com>
	 <20251126-gebaggert-anpacken-d0d9fb10b9bc@brauner>
	 <04d3810e-3d1b-4af2-a39b-0459cb466838@gmail.com>
	 <56521c02f410d15a11076ebba1ce00e081951c3f.camel@ibm.com>
	 <20251127-semmel-lastkraftwagen-9f2c7f6e16dd@brauner>
	 <4bb136bae5c04bc07e75ddf108ada7e7480afacc.camel@ibm.com>
	 <59b833d7-4a97-4703-86ef-c163d70b3836@gmail.com>
	 <9061911554697106be2703189f02e5765f3df229.camel@ibm.com>
	 <7d38a29d-9d81-42e0-99c1-b6a09afe61fd@gmail.com>
	 <8a96ddbefd84ed0917afc13f91ee0f33ea2e0c10.camel@ibm.com>
	 <4e65ea7b-79aa-4c36-a8ea-0ca84966d089@gmail.com>
	 <d714e0652f920cecebf5fdcf0023a440cbd1df4e.camel@ibm.com>
	 <4d545c3f-50cf-4ad4-8427-35f87398838e@gmail.com>
In-Reply-To: <4d545c3f-50cf-4ad4-8427-35f87398838e@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DS0PR15MB5627:EE_
x-ms-office365-filtering-correlation-id: 09a0f126-7238-47db-2f34-08de579d219f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?YVlxNmdIbVVOelFhWGN3Z3NSMkFFRVBJeW1FR1I3OWxuVDFqV2FEaVJ4RGVl?=
 =?utf-8?B?R2xHdXJOeWhETkl3cE9udk9UejVyK2FsY1JRTS9TZGF4bDQ0VjBoaWh6bVpL?=
 =?utf-8?B?c1p5SGZ4b1RMb3k3anlmR1JOQlVhSjVnK1Nwb2VsQmNSaWtzS0VmemVIajBx?=
 =?utf-8?B?OE9aVlFSMVRJMTFLRDJxbU51WDF1Q3U1cFV6MURLcWFTQUZMeUhMN25LNTlq?=
 =?utf-8?B?UkdhdGtNaHlZdmdnS295aUdPZHV6cmZGWlBhVWNIaEVLZ2l4eGp4elNGMVRB?=
 =?utf-8?B?b3dMK0wwYkYyUDRwNkJzUWlJVzZDbUZBbmZNR0Q4bmp6enNNc0JKMG1NQ3Vz?=
 =?utf-8?B?QzhQNGF6dTVyd2o2QU40SzBCaVVRbG5rU1FWL2JSRGYwdVRnMEVwUGV6b0ZC?=
 =?utf-8?B?RFIyN2lVNmk0bDNoNzlBMVdaK0lDcm5zcXpRSzViankwV2lHN3R6bnBVWlNQ?=
 =?utf-8?B?NUI1elJmNTV0VFp0NzBiTW5HWURDOERERExQWTl2c0owUm5rZ29zZjBwcm5Z?=
 =?utf-8?B?aE9NeXpqWHA1NmlNOXpkU0JQMjh0c0hVby9EOTRpVThVYmI2WU9LTWNSRmUv?=
 =?utf-8?B?bS9Wb2g1K3VKRmwwZzlrRVphWFU1ZHlVY0JqOWxwWGJTQUZjcDMzNWFpMThD?=
 =?utf-8?B?OGJoQzNnajIxa1ZXOEtDbk1ybTllSUVNUndsZUxPL0JYcWdsTDJXc3BxZnRi?=
 =?utf-8?B?NU53T2pJZWw4TkF3WWZadEVBYnExdkRJM3VGL1Q3dUVCMEhJMEhiVTlzU1U0?=
 =?utf-8?B?M0tlT2NXS3ZCYWRWVmZvSXh2STltdHE3R0FxUTRVTCtLVWxYa3pPc3R6QVgr?=
 =?utf-8?B?QTl1YndyRzNzL2ZlczdvUlNkSWZidWxqNjZyS0pJcVA4WFppUTVBQWZaMkN2?=
 =?utf-8?B?Tkl5blFldEVnSUJYOGsrSlMxeUhENW80SmkyTlNUck51V0ZJUFBMdURCbUdn?=
 =?utf-8?B?aTJiTjRoTWl4eGRZc1lDM1RNd1dONjZJMThhejExOEJkNFlmc0RwczIwdVZZ?=
 =?utf-8?B?dE43NDFLL2xnRXIvQWt1V0tUb3RTQXlrQUsyOHFBWEVjbWU4VkNxWUNRZjJZ?=
 =?utf-8?B?OWxCaWsvYzVLaTBFNjlTb0M4Q0VzUitoUy94SlZuYXFLaUFITmVvYmhLMVZp?=
 =?utf-8?B?VGFvcXh4bDZrUm5HQkprR0pJQTJUQ1c4Zi9XMWNrTlZ0QTFJU0VzMDRUMnVD?=
 =?utf-8?B?NnBJbE0zNjJ4ek9ZNlR3dG5FWExXN09BTGpWNWtHcU9Td1JneGZWOWY3U0xY?=
 =?utf-8?B?Mk12K092VGc0cXFEeHNZbjFaQ1ZuY2h2VWpjNFVVdjNaeFRTN21NYXBYN29U?=
 =?utf-8?B?aDZPeExsL1BEMWcyd01yc3o0Y3NDWjRKcm5lbnh1NVpONGlxbE1GWlJpd0FG?=
 =?utf-8?B?QWNBbjdjZ2I0dWVNTHdrcFZKbHR0SDBOeGkxV2lUZ1k0enVYZ1NhMTBsQitP?=
 =?utf-8?B?UUpFb0R5dS9abXh2elFYZnFETW5vRjBNdGRoZmVWMFlJREw1SkdiVU9BcG5r?=
 =?utf-8?B?ZW1PZnRMZWVuTm5VM3BDM216Sjk2SkNDSDlvVkF3UmtKbUlObzAyQ3lwSlBa?=
 =?utf-8?B?bFIybTNBQlNCNzhNQ0NZTEdML1ZETkVDRDF4VHFNcFo3V1d3MmVOTXliU1R0?=
 =?utf-8?B?cmdoQ3RCUU5veDQ3aExLUHVmdm4vQUd0UzNYQ1BNYlVqWXkzb0RrZXVvMk5Y?=
 =?utf-8?B?NEx4WXRBdEJqSnE5WXBoUTg3c3U3WWdVRE9NZVFYVUFqTDNyZDJWQlQ0T1ZT?=
 =?utf-8?B?bmMzYWk4djlHdEtCeCtDVlUwK3FmVXRjak5xejF1aEprSlZuV05iWE1yeVlC?=
 =?utf-8?B?bzUxU3pTMG1Fb0JBTXdGcmE2TW9HcVZmdy9RSWlqNmFUQjlBN3I0bzBaSVRi?=
 =?utf-8?B?ZFZwQ2hPNm4yR2Z5TjlHWVU1Z01VRGJPTUhaRUJLbUh6UVErYlZFQVcvbXpE?=
 =?utf-8?B?QVF0UGJPS1JpMlZldSt0WWYyVWZZZDhReHFxMk9GK0FlazBOMHpRQWFXTmVR?=
 =?utf-8?B?S0RGTUNzZnlMdXY1MWY0ZVF2aXFYcHg4RTRJenB5UFQycksrWmNSUkpsM1kz?=
 =?utf-8?B?SGxsTGQ4RTBlM25VUjlZSUNMNjF2UDdIVEo5aXBHeGJ4Sm1nKzA1Z0pKZDFJ?=
 =?utf-8?B?U3VLdlhtUnVVSXlZQU5rR0pjZUNDVHBGdm5aN0FMMTFSR09ubHUrWll5QWhS?=
 =?utf-8?Q?Z13C8eKtPIiTKAV1XgvzTEU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dkdVcWltQXhxQ1pCSFdWTUNXVzI1OGwzb2N0eHZ1VXNwT2h5VlVSVVl5ZkRJ?=
 =?utf-8?B?VjdMU2dZSGthdWpXbFcrMjRJT1FsRU9TOXNHVXBiNU1ONVViNlZLQyt5Z3J1?=
 =?utf-8?B?VUQ3dzI2NHJ6UUJkdjh4YzY2b0E5TW4wdGllLytuNktzWWZHL1FEOStvQW1H?=
 =?utf-8?B?bGZ1Zmk4YXdNMmhPRERxcjh6NWhOb1RuS1BGWSsvY0tkM1MzMGZTeldVTXdl?=
 =?utf-8?B?YVJ6cHArRVQ0Q1dXMzZKRGZDbnVySENBM2ZyczhSN1QyTVBTSVg1RWRSRHo0?=
 =?utf-8?B?NlNxS05XV0NNcXFxdG9hOTFhdWYrQWFDeC93eTc3cG8ycEMvTHRPeWhIc2hI?=
 =?utf-8?B?MnBBREg4U1FOejRKS0ZjdVFLYnVQaW9hR09wSmhRVWZjMEZEVUtVVXBzT1Zm?=
 =?utf-8?B?c0g1bTJEcjUrVXczNDVRMllaaDY5VE1XMlNYckRibzc4S09oWE9KM3R4OGsx?=
 =?utf-8?B?TDBZSzlreU5Cc29JMk9LSjRIQXBQNUVsVTlHSHVCbDJESnJQQUNYVXNpOUpU?=
 =?utf-8?B?UHNjYXZybHZETHVVSUFBMUY1NWRXNE10Ulp1WmFZVUdPc25KVFk5SnU4Qlo4?=
 =?utf-8?B?MVcvckl2Zm5FVU44OHF5R3VBNjI1Y3hhNHllTDBzL3o3dndFRVBNTHBpSGI4?=
 =?utf-8?B?MENvVy9sdGpNbTFsbmJoNTZNdjlES3RGWkRCT2syTENMVUVWUWhaSk9UZ3lN?=
 =?utf-8?B?enVmbHVrN2RvUmtuYk4xYUx6bHV2TzExcEozTDBHcGx2MHhDWVlWU281VWdJ?=
 =?utf-8?B?SVlUaURKdTNtTExvbk44aEtkS01MQlg0RG5WNTNqckNPaUNwbHNTMURqZFR5?=
 =?utf-8?B?TzNXc0NHUXluM055VVdQSkRFa1BCUFl6ZmM0cThYOEw2VHkycjM5ZEtBZnhy?=
 =?utf-8?B?OXdoMHVBUnRCZittZkVlalgvRlUwNkNVR3lOMDVCRGl1aHZ1NENWNXZ4Vytr?=
 =?utf-8?B?ZVV1L3lzUkpicVYvMkxhYmNRTTJDN0VjaDdlWkFlMWhoaWNydGxqQmtPL1VT?=
 =?utf-8?B?OVhqTVhuRldtOVp0YjJsM0pYclVscnowTlJRRTFjK0tSbkFrNzlHV2hKUGlU?=
 =?utf-8?B?bHMyWnpwSlg3VTFUQ0RBREhNZ1djM3RKRHBMeDZLT1ZDUjBoRTh0eE92NHUv?=
 =?utf-8?B?VEVTMERkZXBxU2NFV2EzMFlZVktMVkx3aVR0Vks1VnA2Yms0VHl3L0U2SG14?=
 =?utf-8?B?TjVMNW9JY0FoOU1aWW9BcXd6bzJpbWE0SUdMNGMvK0FSbFF4MjEwVmZFK2FI?=
 =?utf-8?B?cUxSTXEyVi9lcFJXak1JTGppdlYvVzB0L3lsWWljSVNLU1BGdHhpWk5NTHc3?=
 =?utf-8?B?dmZzbnJIbmhZbnpUUmYyaEVhYXRhZ21hV3BYYkpEais5ZXRXc0xFdkZzZ1dm?=
 =?utf-8?B?RTVjNERFV3lCZ0ZheUlsZnIxRWlHYjdXaVZpY3V0NUFLM2FNRlliRWU4UThB?=
 =?utf-8?B?Yi9wcElHQitwaWZHK043YWhVenl3N21ZYVcyMXJRK0dLTng5Ui9Pb2tCdzhS?=
 =?utf-8?B?cXgyV1BaOG91VUhEb1BjNEc0cnd3SWZZUE5HcFBvbTFYTUxNcUdkdmphcEZB?=
 =?utf-8?B?d2xJSDhzOThYWTNxVkt4bzNkQ1BOdHROTzZ6NmhsY0ltSHV2c2F0andqOXhD?=
 =?utf-8?B?Ky9UV2VPMnRKbjhtRlVhdzJybDIrcUE3L043RkdWVTlVUGo4UDJNL3dad3pE?=
 =?utf-8?B?TWxvTzJaWFJ5dW42VzdTNTVMQ051UGdSM2hQZTgveld0amNtWU1BSVM0OFJp?=
 =?utf-8?B?NllFK0hZUDR0Y0dSMlZaSDRSUVZRcEVMdHFkYU5lZnBXMUw2bmlKNjdaeDFa?=
 =?utf-8?B?czhGQzhCSzkxdTRHTldxVG9iUU84UW41SEUrbDJwM1hqUUxFcGhNQkFzREhh?=
 =?utf-8?B?bzEwSkNvYzNHRDF3M1JSVitqektXWTNNZ1lCS04wbUFDRXA1RmU2Y0NQT1NI?=
 =?utf-8?B?dEMweFYzMnVHQzVocFpoaml1OVF3MEF6Vi9Fd1ZCbFRRS1FmVDc2TEFEd1Uz?=
 =?utf-8?B?cUxUMWdaY0RNa2ppakl2SS9rU1IwR2h5TWY0TThZR3BpUURoRlc4Q1pEV1Vz?=
 =?utf-8?B?RERHZUp6Zm1NcDMyZ0ZWVytRZVJmMXJyMm80dDJRZW5lQWF0a3cxSFJXNUFn?=
 =?utf-8?B?d2tBdStObXZ3QTB3OTVqVkNTVmR4RHhTOG1ySkNlakJCNng5YkQvZVBnUHBj?=
 =?utf-8?B?RGZaYkJpNWRTRExTVThiVFgxS0RIVWVyKzdwcWF2QjdqVEl0dUFMSng5cG1z?=
 =?utf-8?B?ckVxVDl4bUs3a0VDS0Iwd1NkUnVVbjU3VVJ3alVFL2xkRERuQ3lVcWpHRUF3?=
 =?utf-8?B?WDRiUUlKaVlrWGhLVlhMWXFaVjlla1htRGM3UUtEV2dZd1BqMWl6MFllTGI5?=
 =?utf-8?Q?wOIAGD8lvQ2MRFG0yWMJAomkR9qmff2I8DUs3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <344A5170F27347458B35ED4F4739A5A5@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a0f126-7238-47db-2f34-08de579d219f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2026 20:55:51.8389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: moAQw9tj52lfGdGrSPV0foth23HlqKX0O9kIfHw+j2N5Uaj9hdBPWMjaStCdSw9TYvXg1is0zCOvbEgm/x/R0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB5627
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDE3NCBTYWx0ZWRfX5hIQntHXUPlI
 9hY1S7hVwZ6PnzEDCm6kUzeyfGIld2vz7qkhfzO98gPjh3/9hGKKiA4KPWbLYmaEU1Orp7xoooE
 HxmLqpik8atxAcnrVVNlLyO9FHR35AcYmHC/zSv8p8BUecJePd2CVviOGvOoSdsyrpRMVeLXYiv
 3KHmKk7JeInlzvhuACMpIPN/1v44955G1YUNOq2X6zDn1MvNxHA4rGy9/R6fKq72y+me6s965KT
 u4ezQJGiUVKgwcTKPp+qE0K82gjD2h0CS+xM+AVIdyCuhFtb96Vmb0g3ymiQxITWWVC5RfkNFyY
 Z96/MGGgOt7N4tO3fWEbm8dsSXTS+lZWT/kU0ugSY0UW0Dblgw9Kw3truLuodHuy/xjxuautaiJ
 ZXZjl+cRPI3VehHIP5sYV7OiXQ8z9mfMDQeMcMg0NUA9iEAwI6GXsMxVYTDoIDLDbdjDaPXZSoJ
 gFunCJDLMQBozS11i4w==
X-Authority-Analysis: v=2.4 cv=bsBBxUai c=1 sm=1 tr=0 ts=696e9a5f cx=c_pps
 a=4d7Nl6fXTlayLABBLko2Iw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=ObUGpDGwhYDOwRBkJTgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 2mZ1bmaz7wY5KEZnyCtok5NVB4YrE_Lw
X-Proofpoint-GUID: hXwYFhygrPfq3VNIEIHKlRn2yHXVEK7D
Subject: RE: [PATCH v2] fs/hfs: fix s_fs_info leak on setup_bdev_super()
 failure
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_05,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601190174

T24gTW9uLCAyMDI2LTAxLTE5IGF0IDIyOjM0ICswMTAwLCBNZWhkaSBCZW4gSGFkaiBLaGVsaWZh
IHdyb3RlOg0KPiBPbiAxLzE5LzI2IDc6MjcgUE0sIFZpYWNoZXNsYXYgRHViZXlrbyB3cm90ZToN
Cj4gPiANCg0KPHNraXBwZWQ+DQoNCj4gPiANCj4gSSBoYXZlIHJhbiB4ZnN0ZXN0cyBvbiBib3Ro
IG15IGRlc2t0b3AgYW5kIGxhcHRvcCBvbiB0aGUgZm9yLW5leHQgYnJhbmNoIA0KPiBmb3IgdGhl
IHJlcG9zaXRvcnkgdGhhdCB5b3UgaGF2ZSBtZW50aW9ubmVkIGFuZCBJIGRpZG4ndCBoYXZlIGFu
eSBjcmFzaCANCj4gb3IgaXNzdWUuIEhlcmUgaXMgdGhlIHRlc3QgcmVzdWx0cyhpZGVudGljYWwg
Zm9yIGJvdGggZGVza3RvcCBhbmQgbGFwdG9wKToNCj4gRlNUWVAgICAgICAgICAtLSBoZnNwbHVz
DQo+IFBMQVRGT1JNICAgICAgLS0gTGludXgveDg2XzY0IGJoayA2LjE5LjAtcmMxLTAwMDA4LWdl
ZDg4ODljYTIxYjYgIzEgU01QIA0KPiBQUkVFTVBUX0RZTkFNSUMgTW9uIEphbiAxOSAyMDo1Mzo1
OCBDRVQgMjAyNg0KPiBNS0ZTX09QVElPTlMgIC0tIC9kZXYvbG9vcDENCj4gTU9VTlRfT1BUSU9O
UyAtLSAvZGV2L2xvb3AxIC9tbnQvc2NyYXRjaA0KPiANCj4gZ2VuZXJpYy8wMDEgIDJzIC4uLiAg
MnMNCj4gZ2VuZXJpYy8wMDIgIDFzIC4uLiAgMXMNCj4gPHNraXA+DQo+IEZhaWxlZCA1MSBvZiA3
NzIgdGVzdHMNCj4gDQoNClRoZSA1MSBmYWlsZWQgeGZzdGVzdHMgaXMgZXhwZWN0ZWQgc2l0dWF0
aW9uLiBIb3dldmVyLCBpZiB5b3UgYXBwbHkgWzEsMl0gb24NCnhmc3Rlc3RzIGNvZGUgYmFzZSwg
dGhlbiB5b3UgY291bGQgaGF2ZSBhcm91bmQgMzEgZmFpbGVkIHhmZXN0c3RzIGZvciBIRlMrLg0K
DQpUaGFua3MsDQpTbGF2YS4NCg0KPiBNYW55IHRlc3RzIHdlcmUgc2tpcHBlZCBvZiBjb3Vyc2Uu
IElmIHlvdSB3YW50IGZ1bGwgb3V0cHV0IEkgY2FuIHNlbmQgDQo+IHlvdSB0aGF0LkJ1dCBmb3Ig
bm93IHRoZSBpc3N1ZSBzZWVtIHRvIGJlIHJlc29sdmVkIChmb3IgaGZzcGx1cyBhdCBsZWFzdCAN
Cj4gSSdtIG5vdCBzdXJlIGFib3V0IGhmcyBzaW5jZSBJIHN0aWxsIGNhbid0IHRlc3QgaXQgb24g
bXkgc3lzdGVtKS4NCj4gVGhhbmtzIGZvciB5b3VyIGVmZm9ydHMgc2xhdmEuDQo+IA0KPiANCg0K
WzFdDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1mc2RldmVsLzIwMjYwMTE4MTgwNTE5
LnhkZGR3b2tlMnRleTZvZ3RAZGVsbC1wZXI3NTAtMDYtdm0tMDgucmh0cy5lbmcucGVrMi5yZWRo
YXQuY29tLw0KWzJdDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1mc2RldmVsLzIwMjUx
MjMxMjI0OTM3LnV1NjdsNzZjeXRjZDM2bnNAZGVsbC1wZXI3NTAtMDYtdm0tMDgucmh0cy5lbmcu
cGVrMi5yZWRoYXQuY29tLw0K


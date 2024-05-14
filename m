Return-Path: <linux-fsdevel+bounces-19403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0C28C4A52
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 02:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78A78B23C85
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 00:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D65628;
	Tue, 14 May 2024 00:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YydNCKcU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cvCyhHzH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF5C8473;
	Tue, 14 May 2024 00:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715645063; cv=fail; b=j6N+g9xX1AKaQl98AXGFnITsktD/+pk6ufl9nSIp2FaMGAFV9pZAZe0kR29OgobXzOUaQ04N+jW0598N3RHum9tyEMFaiXRtayqR2MfStbNjOy6DIAjSS6RgQm8gmta9QTQVSBYU7D6OyUwg3AVqrYJhLr5M/S73cax0kPSmRj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715645063; c=relaxed/simple;
	bh=8xUpM5bn33zzA+aHrLuQVDyHisgsVffQRSrA7UXPjjk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=LFxUb1d+HQLc2DSqeMLQ5ddynOIRWWTo+X+XMhSZDz6tSbrq3Wdxf8KPrTz5rroN9iyyM/0h85FDV1O2Lv8A4TiDTt4G1t0uapojhrH3rP4dBoJce0vTzkvW6j4hZIJkLfLaXBt6WViiMWgMRt809tCzOEPDqq/A51A4wWNJmj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YydNCKcU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cvCyhHzH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44DNhs02026990;
	Tue, 14 May 2024 00:04:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=6p3YluQOFlYFKWvfGwfkJV/wINV1i87K9gce7nlmCEQ=;
 b=YydNCKcUKwGjaNOeU5c6Z8W0dEhMpgSrE+F1Digeani+RW57VAEF6+4obsWHxHTvQ4wB
 khohH8w30b8K6vDGHmSz+NvXDKxPjSM/GmM0MfE7XsEKszisMBZhGf+U18RV/ZXcWCHk
 OZ34M6FQ6nrQzaaAlWTwY+gAsRZpZwUQqufVCAau0MTPuNIPVv8TnCtiJe/Mx+PIJM7E
 hBbRgoFzyj5QRdYYDrbucAFv/XL1xiKZSglFPPLMBUR7HbuJVrSaMkoDkl5+UNOseTp5
 hVzqUqO6Xkp3Ggv8rfjsHETu0yQmM3gF8At48vUVdMxCiQ+nxdeWfzzMGg2hgZKseHKg 1A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3t4f88rt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 00:04:16 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44DMFB2C019284;
	Tue, 14 May 2024 00:04:16 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y3r842m30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 00:04:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwRiqel4LuFbmKP1pY/ZAxDV0AAqGWzcAJZsUQ6tX97J4G4nfuW8X+E+9q6OU3fI4DKvZd8SJbi7bOgiFO8TFi9DNFYNyfDUWJbmghnyLS+22rnoQF/ipH19XKQkl1ijbxCyOHmZ+x5RDh/LDqubD9Pn/yJLvtHS4rEHBgrUzHejmY8qQX74abkXmHkUSQkDoYlp8JFvIMqyBv767Wn+4lYOFgOPELJEJ4Fd8nVw6STx4rU4VVJTmz1qu7eD36l7lbiPUExlR9ZWeK9u4vhJA893G1x6me7mrlQHcnBWEL0cK91yOhqxlyiDPDHqriQlQt8ITErMWZ3Gq4tuNNcRdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6p3YluQOFlYFKWvfGwfkJV/wINV1i87K9gce7nlmCEQ=;
 b=iTdpagURnbBOLD4oJ5x3meYerM8jKKdiyUn2NmSZ3pR7pYPUEro5Vv32T6tiGnDpugxjl+rXDGFKQVPoz42wDFk+cegELUrapc++6khc4mWB+YzBL58L0PbTF6DlO9CwlVtVsYGPTDQ5wAfonhKURdI1dyMj5Rf5qXqISO6c58Vd5Ehbn/c1pSolIQi1gdHCEpYZy+C0ZvH79GFHfkMg/6sE2njUutCq98PqalEX/rkxbG2C44/DtKYqXJVyXrSi2NLOMkNHc02Y8FfoiuD9qxfpeTyj4Fyecz0GWJIgZ+647nvT5XVG6GSaXfQDOT4OWv9whUTssIuwvUtinTjaCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6p3YluQOFlYFKWvfGwfkJV/wINV1i87K9gce7nlmCEQ=;
 b=cvCyhHzHOLniqv+gkDiM4XruM2FkfLQ6LJpK8EOABuoWVOOjVx17y5BWRncdOnyWT383ZBTBnebm1kTI7U9uhTdfh0CWq3DC/L6PRL8tu44Vt7ROJbHC1OBWpgKV3/AUoH4pUOKhMrQX3FkSpA17T0mgZEAov/l9zPKXbE+W/Dk=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by MW4PR10MB5809.namprd10.prod.outlook.com (2603:10b6:303:185::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 00:04:14 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%3]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 00:04:14 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] fsnotify: clear PARENT_WATCHED flags lazily
In-Reply-To: <CAOQ4uxjKdkXLi6w2az9a3dnEkX1-w771ZUz1Lr2ToFFUGvf8Ng@mail.gmail.com>
References: <20240510221901.520546-1-stephen.s.brennan@oracle.com>
 <CAOQ4uxjKdkXLi6w2az9a3dnEkX1-w771ZUz1Lr2ToFFUGvf8Ng@mail.gmail.com>
Date: Mon, 13 May 2024 17:04:12 -0700
Message-ID: <87bk59gsxv.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR08CA0061.namprd08.prod.outlook.com
 (2603:10b6:a03:117::38) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|MW4PR10MB5809:EE_
X-MS-Office365-Filtering-Correlation-Id: fb5d8127-69a7-4bb9-3f00-08dc73a963a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Qzh1bU1IMTJuYXh6VkI4Qyt1alhJQWhOV2VnYjVDd2RTUzhzVHNqTUI5RWV4?=
 =?utf-8?B?TElFMVBCZVFDbU85V2RJTFlEaFNFbytoNllXMkIxa2ZyRmRXWlIzaU5LVlpP?=
 =?utf-8?B?MG9GY1NLMVp1TUtkMGpPQi9BNyt6U3gwQ1RFbWphb3RaWHhCLy9vaTc3VEc5?=
 =?utf-8?B?OHBlU1p5dml2U01QQWNURXBxRGIrb01vWGhTZGxncWVmb1R6S203dG1lRXlI?=
 =?utf-8?B?ZXJMUVNwcnFYa3VEMk5pMzBrVUVsMkcvYWFOQStwK3NVc3RvbXIwVVorUDVy?=
 =?utf-8?B?cDJ1VXJCblF4N0JXS3NvblVNMVg1WktoTHZ1aUFRY0lPUmU2YzNWQTVCVzVo?=
 =?utf-8?B?UEUyakVkcU9PSE1Uc2RrVWlqdFp1SnE4WWQvRktoaFRrR29zMFVSNDJHVktk?=
 =?utf-8?B?eU1YdzAweXhZYStCbzBNUDJjUU9VUTd1VkJZSHFtbnh2K3BUWTZISE1kaEVr?=
 =?utf-8?B?aHVaY011S2sxb2FyZWlyekZDcnQranFkekJTYXpaUEI4ODlCb0h3U3BmMVlB?=
 =?utf-8?B?YjdkUTkyS1NjMFZZRnI5SktUQ1kxcGlPMUVKb2QwTFI4Z3BaalU3LzNYSTBU?=
 =?utf-8?B?Mm9pUlN4TmFGUHpIdnJkUlZ2VUJrajBNQ3hEczl4d09jbk1Tb0pocEpQV2Rk?=
 =?utf-8?B?aVlmN1RhQ00xZWVNL2U2aVdIWG50ZjBWR0FDS1lHeUhBUXBrcWQ5c3FOSmNN?=
 =?utf-8?B?QThsMnpWeW9WTUtoemtlK3pOWHIyQzlVb3FqSXhvekVsOU1TSGFjNFFUZ0tp?=
 =?utf-8?B?c1gzSncrYTVXZXczalc4ckc4b0FxSmpVd1R3bmowYk5wVFB6QW1TY3VtYjhu?=
 =?utf-8?B?eWRYSzhQTnVCeWRzR3Fib09TUE5NWDlmVkhCcTlSY3pLUjdWdExyWXhuK1Rj?=
 =?utf-8?B?WDlZTytrMGk4cDRTRFZrUzllMHFCdkc2UUdoZkl0TkZXSmpudFplY2tERGRE?=
 =?utf-8?B?OVhpQXpsS2VZeWxaRFpTNmlEMFBVbWtBdXk5eTN1WWJLR0hJeFZ4cXdtLzh3?=
 =?utf-8?B?YU9PZGJMRzNVT05mQ1lRREFFOFQzZzZXdk5LcWtwNDl1NEduMmFtajJCOUhO?=
 =?utf-8?B?LzFTUXBWa1RPYUF5d2kvTEJndE5JaFVyNlN3NmZTYTRRMjhYeFNVc3hmNHph?=
 =?utf-8?B?bDNlQkk2b2tOQytuUVR4L1lJVGJ6L044bS9jL2dYdnVNWk15WFRmWnVqeVZo?=
 =?utf-8?B?UEZVcElKeWVJU2dVdHVZRTlKY0dJNWhjU2ltU05jWWdFbWZHUXFBV0dRK3dl?=
 =?utf-8?B?NDRRRVB2bm1uN0huVHZjUmhiWUdUMU5qUGxJcTVQOFdsaDN2TWczMjBmN3hQ?=
 =?utf-8?B?SXk0Rk9jWUpOZ1pNWjM5bmJmNWJ6ZVRubmF5UFZhc2xvRGlRb2pJTGpXMGx4?=
 =?utf-8?B?WVIrMHYwMTRpa3FHdkNTOUZra1FLVE05dnBrdTFwT21XamFMS0hiS3NudUI3?=
 =?utf-8?B?cnFML2t3ZnltR09mU2FOSzI3VXZuQlFUdHFRQnE5NUQyYXlXN0JDRDVkYkV2?=
 =?utf-8?B?SzkxRVN6M2VMVUhYeTVyU3lHRFczRmgzZzdxQmlLVHRWRnRuRkFhUmJOcjVY?=
 =?utf-8?B?YXd5MzExQmFtTnRtckNadXFveDk2NzdMRXI4SE44MFBGNU9Ka0JCWXAwRFd6?=
 =?utf-8?Q?mcDTKMsgSv/nyN3ngLcFv1xA89UyY7D+N6xbgn4Of0Vs=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dWF5U3dHenlUaE42OUFsMnNUQzdBeGh6TVprQWt1R1hwMlhMZ0tRUWZ4K0lr?=
 =?utf-8?B?cGl2OGk3cDcxb3ZDUGdlYm1HdStyMy9oeGVMdDFOQ21ZcG1SWS9JdlRCdUJK?=
 =?utf-8?B?aFk1enpMUVcrSEg0RFpsd0Q0YVJiRnIrT3djdHV5MkorUXBjMmlKNWZTQkJC?=
 =?utf-8?B?eDg1WFpUMEo5MlN0b2RqSXROMEdzZzYraWRwT1dOYWEwNWFSNllhOFRaWENP?=
 =?utf-8?B?bUNwdUhOUlNram1ZUmdGNnhEVVFjd0huMDh5b3BwdTViL0EyWmZCLzRrbXk3?=
 =?utf-8?B?VndFTzJ3UUEwZUhpR0VsSW80Ym1hYmI1eDFwcjlsd09NR3NycllzaEVZUmRQ?=
 =?utf-8?B?U2FGekxIK1BrTUV1OWZSN25Od3FIZXNTSGljSzR2Zm1veXYvQ2tFU1dnNCt4?=
 =?utf-8?B?WnBkKzgyRzc5S3pkSE5JNTJQS29EbDEyamRzZmp6dlNWSFRKWlBSZGptYWJT?=
 =?utf-8?B?cUZnMFlzV1hmRWZ3aUgxNnlvT0l0WnhVM1lOcHhUTlNNZ01HeFFkaUlhZUFR?=
 =?utf-8?B?U2x2c3p0bG45c1QvR3pMeWNpT3pKcGF3dDBxR1lDbnhISXBpeDRwekVkdDJt?=
 =?utf-8?B?SDYzc0lheUFVclRXdmNXRHVrRmhiSXUzN2xiY01VQUYwL0tTOVllam0rSWRq?=
 =?utf-8?B?NytHeWpuWldndVdiU0J6SjFBQmpyWE1MYmRmdFBOOGI4M3lmOHZZRGVWSGp2?=
 =?utf-8?B?cXE1RGxKNzBTaVdLVWloQkFEUVVnM1hGcnBvcGdSRTJCdzhCOWhManZnckZJ?=
 =?utf-8?B?WVdxR0k1UVppTy8vV21iV0t0RDErQU9EbWxoV21JbWlyRi9TdUd3NzVlL3pv?=
 =?utf-8?B?R1I5c3d5RDRvK2pHSWI2Y3loQTlQRndVOUFOOHJheXJYcUVzSGJNcUtHTWNy?=
 =?utf-8?B?cXQ2QjBjVUkvVDNUWVZ4Z1g1aTN4MFIzY3VjcGJkdXlsRXkxWTNjM2J3eEgz?=
 =?utf-8?B?OGwrT0hmd25iRkVMTVlXTWZ2MGlZQXkwS09zT2tWOXk1NnhRbmZEcEJPNWlB?=
 =?utf-8?B?VUtsVlNHN1RaVDJjZk5wWGI5MDJKUWZqN0daaGQ4TitPQjNoR08zYU5Hc2V0?=
 =?utf-8?B?aEYzUC9JNDlGYXM5MnRsYTFVYUNkMG9Uc3dDOFg0eXNUVlhUUnZNM1VieDJY?=
 =?utf-8?B?SENxRm4vaFBrYk9rQTYrdklhdkFpNWZMbENmanlmOFRPcUZQMjRBMnNHS0xr?=
 =?utf-8?B?NDR1RXJpYTliS2N0WHRheFhBZFpTSXErNXd6VHFSUi9aeEdvM2ZPTlFhaUhr?=
 =?utf-8?B?Y1dKK0xDalBjVlNldFB3VStsbFF3aXR1M0ZsckJSYjVTNGVHZjk5dGNVOXc4?=
 =?utf-8?B?SWZIUE1PU1Q4dGFQUWpYL3dNbzI4ZnU4RVRSVFNaNnc3SkZiN290T1hpOXhB?=
 =?utf-8?B?UzUzTjUyZ3BTNXRoYlJQQzZNZFkyWVVUY3VtL0Y4RmsyUWRhK2YvcjFSNDNm?=
 =?utf-8?B?L1lIUjZIMURNdVliS2VET1JiTTZDWFJrQzhZTm1MVzlpb0JDVmpBSmxGRFFk?=
 =?utf-8?B?TW5KQitvUlZkd0t1TXVsZjNoQldYTVhpelA4UFZkeWx5VTJ1RlhVQUVGYXdj?=
 =?utf-8?B?bGxMRUR3YlYrK1lTb1lQN1daZmtNd0dpdHlkN08vcHQ1dGJzVnhRUHc1dTdZ?=
 =?utf-8?B?YkxJMWpkN1ZGTThMdGl0eW1JRFViTmlWT0ZFNG5STWpkbHdUYmRUSDNkTHBX?=
 =?utf-8?B?QUYwaFE5Uk1LU1FucmN4WFhWVElTMzhWSGlJRFUwTEdsbHo5S3ZhK3NtMFFl?=
 =?utf-8?B?L1U3emVIV3gwZ0lVWFVKYlRvYkUyeTNma0pPR094MUk3WmNOMnFCdnl0Wmd0?=
 =?utf-8?B?UCtVT1ZWN3Q4NWRkeHNFTVVFY1Z2RElnUG9HWDBPWTRsRlVZcERFZEJkZVFy?=
 =?utf-8?B?dW5KVjlXL3ZZNDRyMElPbnBhMkF5bXo4VkJIOVRibGNwV0trcXRrNmJaZkwr?=
 =?utf-8?B?SGw1WG9oRWV0eFRmenp5R0RNNDZpY0Nybnh3SUt6Z1VhcVpRQ2t2SVZJNEdH?=
 =?utf-8?B?eGVHQllwbnRGMEtERzRkMXNzMGtWcnowOVBBTkpxL3FTT3lYVUJNbkNtN0NV?=
 =?utf-8?B?T3A4VGlQeHd3bVN5cHdMUmJNYnZ3ZHJCZ1E3Z2RpdFJwRkZTZEZMaHN6bElY?=
 =?utf-8?B?T1hVUCtBWFJPUjVXdjV0K3NUVldRY1k3NDlXYmVoYkhXUzN2ajkveWNWZGln?=
 =?utf-8?B?ZVp3c20ybngyejlUZXo5NEpnc0VQM1dpbE85VXlzb2MrNE4xM3d6WjVsSGxJ?=
 =?utf-8?Q?vTWp5f8fj5Q+yu3ruDj3J649pLKlbYSXfvp8bfMiYE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	rq2RZO2uXwGH8LxgErjIx/WLHNR81uTmoGVhfw3xGvLIoT75x4ghcMLV06LIYrqoJ6GQ4TzcxGGtbTeqK/yvVZTkTR16tPsjnhzuHOho6IyHdZ1qyuwFQs+ypcHXtqHpbMv6a8vnkpObP43/KRX+7LM5001HrQ2LqUG/TDDUWNcpXqAMemrJtz+QWj47jWQTHMbILQKVLvTRXrPa0EWsrK2TilLIGGLuqBui1Ec9iVaTZORNHXhSkbSeUesOIqAOCZlazq5127Fjun0qkX+dcQZeq4v4Q2fGvH50eQQba6xXqCGI6WjbBajpacCy3g6Z/o0rqMY37i7XWPIOhPbrYSeJWssiqG4wtsLE0Lsvr8xSPw1pjxz9PMhMr/I41uODsGxcod1tHOdCrx3oQVJIBgmyVDVO1kRfneq5bDwVRUaekTt8sR2Xy1Mk8UwwQCDGShjYQBLnBmSaIYYBjsQustAZ5Ik9egKDSyH6hLiXF+fmpf0weehZ784+oUo+3/KjpjnJz9OspP1HG9frzJr4CE1V843hGjM73/iF1/FTIx+g7DaMZ3SIXI0PR4YSHl85NkjVwDyy6warYy6jAlhjVmV9A9vzm9FqDHePnNXbskI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb5d8127-69a7-4bb9-3f00-08dc73a963a9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 00:04:13.9697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ngM7c8V7mbh8gUDPPuNO1JXMT9vV3lfbt7juBR+iWpoHEimgFL9Su6rl7XnKSIB8LIFPvkTHzbbU4WJmLrbFpr9ybjQAEfmADiNuzY/2j4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5809
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_17,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405130165
X-Proofpoint-ORIG-GUID: ZAFd65XRq7SPrQ7NUgAQ4wy7FHCP6HLD
X-Proofpoint-GUID: ZAFd65XRq7SPrQ7NUgAQ4wy7FHCP6HLD

Amir Goldstein <amir73il@gmail.com> writes:

> On Fri, May 10, 2024 at 6:21=E2=80=AFPM Stephen Brennan
> <stephen.s.brennan@oracle.com> wrote:
>>
>> Hi Amir, Jan, et al,
>
> Hi Stephen,
>
>>
>> It's been a while since I worked with you on the patch series[1] that ai=
med to
>> make __fsnotify_update_child_dentry_flags() a sleepable function. That w=
ork got
>> to a point that it was close to ready, but there were some locking issue=
s which
>> Jan found, and the kernel test robot reported, and I didn't find myself =
able to
>> tackle them in the amount of time I had.
>>
>> But looking back on that series, I think I threw out the baby with the
>> bathwater. While I may not have resolved the locking issues associated w=
ith the
>> larger change, there was one patch which Amir shared, that probably reso=
lves
>> more than 90% of the issues that people may see. I'm sending that here, =
since it
>> still applies to the latest master branch, and I think it's a very good =
idea.
>>
>> To refresh you, the underlying issue I was trying to resolve was when
>> directories have many dentries (frequently, a ton of negative dentries),=
 the
>> __fsnotify_update_child_dentry_flags() operation can take a while, and i=
t
>> happens under spinlock.
>>
>> Case #1 - if the directory has tens of millions of dentries, then you co=
uld get
>> a soft lockup from a single call to this function. I have seen some case=
s where
>> a single directory had this many dentries, but it's pretty rare.
>>
>> Case #2 - suppose you have a system with many CPUs and a busy directory.=
 Suppose
>> the directory watch is removed. The caller will begin executing
>> __fsnotify_update_child_dentry_flags() to clear the PARENT_WATCHED flag,=
 but in
>> parallel, many other CPUs could wind up in __fsnotify_parent() and decid=
e that
>> they, too, must call __fsnotify_update_child_dentry_flags() to clear the=
 flags.
>> These CPUs will all spin waiting their turn, at which point they'll re-d=
o the
>> long (and likely, useless) call. Even if the original call only took a s=
econd or
>> two, if you have a dozen or so CPUs that end up in that call, some CPUs =
will
>> spin a long time.
>>
>> Amir's patch to clear PARENT_WATCHED flags lazily resolves that easily. =
In
>> __fsnotify_parent(), if callers notice that the parent is no longer watc=
hing,
>> they merely update the flags for the current dentry (not all the other
>> children). The __fsnotify_recalc_mask() function further avoids excess c=
alls by
>> only updating children if the parent started watching. This easily handl=
es case
>> #2 above. Perhaps case #1 could still cause issues, for the cases of tru=
ly huge
>> dentry counts, but we shouldn't let "perfect" get in the way of "good en=
ough" :)
>>
>
> The story sounds good :)
> Only thing I am worried about is: was case #2 tested to prove that
> the patch really imploves in practice and not only in theory?
>
> I am not asking that you write a test for this or even a reproducer
> just evidence that you collected from a case where improvement is observe=
d
> and measurable.

I had not done so when you sent this, but I should have done it
beforehand. In any case, now I have. I got my hands on a 384-CPU machine
and extended my negative dentry creation tool so that it can run a
workload in which it constantly runs "open()" followed by "close()" on
1000 files in the same directory, per thread (so a total of 384,000
files, a large but not unreasonable amount of dentries).

Then I simply run "inotifywait /path/to/dir" a few times. Without the
patch, softlockups are easy to reproduce. With the patch, I haven't been
able to get a single soft lockup.

https://github.com/brenns10/kernel_stuff/tree/master/negdentcreate

    make
    mkdir test

    # create 384k files inside "test"
    ./negdentcreate -p test -c 384000 -t 384 -o create

    # start a loop opening and closing those files
    negdentcreate -p test -c 384000 -t 384 -o open -l

    # in another window:
    inotifywait test

Stephen

>
> Thanks,
> Amir.
>
>> [1]: https://lore.kernel.org/all/20221013222719.277923-1-stephen.s.brenn=
an@oracle.com/
>>
>> Amir Goldstein (1):
>>   fsnotify: clear PARENT_WATCHED flags lazily
>>
>>  fs/notify/fsnotify.c             | 26 ++++++++++++++++++++------
>>  fs/notify/fsnotify.h             |  3 ++-
>>  fs/notify/mark.c                 | 32 +++++++++++++++++++++++++++++---
>>  include/linux/fsnotify_backend.h |  8 +++++---
>>  4 files changed, 56 insertions(+), 13 deletions(-)
>>
>> --
>> 2.43.0
>>


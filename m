Return-Path: <linux-fsdevel+bounces-51333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E3EAD5A05
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 17:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB5CA1731DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 15:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77F91AAA2F;
	Wed, 11 Jun 2025 15:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rf3E4Kr6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xjFd1Z3s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E641A23B7;
	Wed, 11 Jun 2025 15:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749654701; cv=fail; b=QqO2vM0iKiYtn/30skhGEuszpxnThX/4veYFleOVD3KPsrxHLQnN2FDOjMponZpzsuV+aiLmnF/bofDSidVBcmfJqDDpMnqOdjRH5PaDKk/RutsuteT3QTU4gbACpA+v0nezD+A8ESFesS27l95LAgKlX2BAGZIo7iuSTSQk2rU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749654701; c=relaxed/simple;
	bh=EvWZ2bAGXBxQwgF6kzfWb9qVdE+W8FVTN7aEyBgxffg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U+7DuKGA7R4i07H1P3qu5mtcEVVgi1QGNOQzNOqdAW/VJiUnklISfCTLhDWbI0QKjfRVWEQR+GoYqdx1Zs4YHBGm4aZR55nM8jw6x8kycs4ZSbJxFfiNlPFBaNsNPshTHOohJmr12pcuIOF4zOwMr2Tta2f8EB5b7H/eEM4kiuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Rf3E4Kr6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xjFd1Z3s; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BEfZKx006968;
	Wed, 11 Jun 2025 15:11:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=G3qp7lQVSG42AL1jCk9dHZhsXUERPt/yrG/87in3OCU=; b=
	Rf3E4Kr60gohM6MXCP6zxfvdpGrYt34+rK4dmiwTAPyMuySOyA4TbxBkleidZ5AO
	sPgujfO/rEzC351a7W2yPCjZJYy34LHe4oTdwEwgoLvzG320Z2WJ459fe4UnQm+N
	6obLRquWfvWS+SuQ/sVu3Ig37AGIEd2Lm/W1bdD+3zpF0u4fSPN9D5DEZxS2jcx3
	ixXeEGBuEarW6LxZ0qSTwFX1h4JL7HaTmzMj1PWNBzpoLx2ec1rk8kCcvIslKOZF
	xzH/jDqotT71euQXkWmpJQP31LXqfvE+748wbbuwxdAJOSNvevZ9MR5k6RpabeUM
	paV1zJskSvplo5il7RPaGA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474dad7ptd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 15:11:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55BErwjU007733;
	Wed, 11 Jun 2025 15:11:34 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bva31qk-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 15:11:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wxctIgoTqMh0mnXYLF2s65OLlW+CA8N5zoTBo2tlj7eWu8oQYmKEqcQAV6OwyWgVofwPRkqY4luW27v2xk6PpDnyPxj1apXWXfbKbf0GhsfhHiSloftrnWAVMXdupy46kI2FWQEaowGRNNs8dCOMQ1pt5Ymo8N6LV66RF6ewXjPBflhZVsQhrY+zcuAAZNE5hsu/36xezRgAQwGcPMgPMiMnVa6xpTGHWyQZJKM/2aln+77XlmiLGMbmVyR9mb3bz13QpAPK15uGYnJZiapsaOtko3UXJw6ShoUTSiPJXAhpLfF1/kBVuKM4pDfs9Te4DOzQbu3Grnr45QnOSVeXXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3qp7lQVSG42AL1jCk9dHZhsXUERPt/yrG/87in3OCU=;
 b=Ta3J2fv4GShESYqrdflI9382vEXNtaAGqHqoJdcgbXWM9jKeNr3a8oN2RPPOnrOuKF7HID2A2LUqO5qcmpxsWUSe5034GOksYaB1L3aA1jng8IbfpqjF7gggMVw9OaID+iN7QQ5EH3UBiNfmPLBIYC8DzLO0CWXAs5fcwZuMEDcFrjiGV00fDxBKJah7Yvhqwa7z3oE4PSJYhFzlrBb0xvxNxcXqZPEvKs8Kq28Hvd3M9qBGU1xgolm7GiTwNWBKUsYrNrcFYvO0QEfwKOZek+koBgejG1PH2fWutom0cGY4lG4z/8mAQQe6yqh7deHEtIRyTf7wI8MR0/55ArISMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3qp7lQVSG42AL1jCk9dHZhsXUERPt/yrG/87in3OCU=;
 b=xjFd1Z3sc7+aEuJGL0EXAolaVNFhIwQZh1Pj7QQFeNVkjhbErdg8aoLzbOV9E+7SJygOXw4dZhJAIkPyComiu7GoHNuH3l1mKv6YW2qqW7DLqB4AU8sj4rafpGVBBC1n6YZLqtyzjp1kl2X0ki+wNtmPIfqdhF6tyM66Mn5KQoI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV8PR10MB7824.namprd10.prod.outlook.com (2603:10b6:408:1e7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 11 Jun
 2025 15:11:30 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 15:11:30 +0000
Message-ID: <27bc1d2d-7cc8-449c-9e4c-3a515631fa87@oracle.com>
Date: Wed, 11 Jun 2025 11:11:28 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] NFSD: leverage DIO alignment to selectively issue
 O_DIRECT reads and writes
To: Jeff Layton <jlayton@kernel.org>, Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <20250610205737.63343-1-snitzer@kernel.org>
 <20250610205737.63343-6-snitzer@kernel.org>
 <36698c20-599a-4968-a06c-310204474fe8@oracle.com>
 <21a1a0e28349824cc0a2937f719ec38d27089e3b.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <21a1a0e28349824cc0a2937f719ec38d27089e3b.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::13) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|LV8PR10MB7824:EE_
X-MS-Office365-Filtering-Correlation-Id: a42b8b79-57a1-4114-619e-08dda8fa3ebb
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?cUZCZVhSWGR3ZG9vL2NZcUdPVzAxcURQSVZHUUYzVEIrVXJvQkhMRDEwZ1Vn?=
 =?utf-8?B?Qy9oNk43ckRjOUVHeUJESExYd1lDWEUzMW5HQTBVdjhZYjUzVGsvNnVtam1h?=
 =?utf-8?B?aGRCdWcvNCtiRWcwaGdrb0xkRTB2SGVrZjg2aW82QWRUMyt5aGt0U2RzNFZv?=
 =?utf-8?B?WTJxTFhkQ0RBSlJUdEFQYTFpQzhzS1BaL3JEejlUTWo1UmZLdzhtYW9Xc0pB?=
 =?utf-8?B?U1BXNkcrV3hTK0lFS3RZQ0UyVWxmWUFrM3pGRHZld2hlT1dtc3pjWXhIWVE0?=
 =?utf-8?B?V1lkVFFIMFVBZ1NwQ0pKLy9HU1V5UzI2aGR6TmJUZUZ3eGkxWHdjZ3gvM3pL?=
 =?utf-8?B?OVBuamE2RW1hM00yR2tHc2ZKVURnMjlPc3FrTjFVS3hsT1lQaEJwN3ZRTjc2?=
 =?utf-8?B?Wmw4Y1p4Z2pLQUNoMzVRaFhidXNQZk9zbXhlUVpDN1ArRUFHQkU3R2poR3Rv?=
 =?utf-8?B?WkZYV0hhNWNVRkpBaWRTeDRxd1p0aWxBTm81UWhadDhXQ1FoZlUrSHh3N0NL?=
 =?utf-8?B?OURWc3dJc2xpYmVERHNJeGlYQkUrQVRXRHZ6OHNFc2kyZFg3c0JsOE5pdVZx?=
 =?utf-8?B?YkJCa0N6M1MyWnpsVzNHZndkRzY1Y2hjWnNNREpJaXV1MytFdi90NnIrMWF1?=
 =?utf-8?B?VGJ0TzAyMnQ5MzgwNllQQlFzVlIrTCtORmpST3IxbDdkRXd4WGx3VXI3bkt4?=
 =?utf-8?B?T2NzM3BDSDMrTTlvVit5N05hZ09BM1FTY3EyTEpiZ2ZjdEViVW9VWERrSU9T?=
 =?utf-8?B?NGRTdDk1eUJleUR1bEJOeUZXZWhrMTdPWXJJU2RlRmFjeC9jY2ZENnRMeCtC?=
 =?utf-8?B?U3hGSUtsdkcxNzkwYVVJd2c1Mll6czFUYW9WVm9UWnF2THNidXBQZWc1ajQ3?=
 =?utf-8?B?WUtjM2ZFSTFmRnUzVVZHYzNGRVBQTWVSZ042QldwUTFkWFE4aXprNE51U1RS?=
 =?utf-8?B?UEtWVUM3UnNsVmVPbnlRa2tMOEpTWHgveDFZZzRzSkxlclFNNmpxRkx2TVhz?=
 =?utf-8?B?WmhqbzV2YjdSL2xHakJ2enM5Tmd5VS9EaHplTTkwenZHaU9aVmNIeVd2TTBk?=
 =?utf-8?B?VmlLd25jYXpsWnplNHVQOGJBWlR3T1BXamZsRHZ1UFYyQXlGTkcwOE5PcDB2?=
 =?utf-8?B?Q243bWFjUFJwS1gxMmVvZDdrZVR5ek1iVFYvR3c2VXhXeDg4NkU1WTNvT3hU?=
 =?utf-8?B?aFBqb3UvSmRtSVZCc1NlN3JubVA2clFwMGNQNDFDa0RnNWNZYlg4bHlPbXpL?=
 =?utf-8?B?VFFhYkdGeERvd3lsTk96WS82cE1uVlUyVlJ4YUxZcjZtdUtUUWVtQ3VCYUs2?=
 =?utf-8?B?V0Z5Slc1WTdwZHcwa0JtQjh5dEdEazJWU0Q2dEtWVDdBZFpTZmFGRjRFckhh?=
 =?utf-8?B?YzBZeFBRRS9waXJNcHhGZDBwT2RMRVZHSFRoZ2hUaFVlZHNiUWtkL0YzNXR4?=
 =?utf-8?B?d0dyWkE3eWpZNGZYTVhWUFYyYXZSMXZTRFJxVXpwUGt2NG02TGtzNzNiZXkx?=
 =?utf-8?B?aTFYSUFHVUJVWEd5Kzhzd2xzcFlCMVlpRSttMksvYThvTW1Yc1RaZnhsMDZk?=
 =?utf-8?B?NUxFSGdaOFRuZGM2UjVYdHlIM2JlcGFUMXFrd3BOVGJZbWhaRXcvOE05WjZ1?=
 =?utf-8?B?cThhOXZ5eTI2VnhGNHlOZTI4UzJXak5pNkQwYWwzcWVKNk5GVjFhQ1docndN?=
 =?utf-8?B?N3lWSFd5VTNXeEdZZjlFT1ZBZ1JXUUxnM29kQTRZK1RWSXNiVlpHK2V6VndF?=
 =?utf-8?B?QUY3dm1EVlIyWklGcW04ZUN2R1hzcXpDSit2YTVWV0tqZzQ2N21JeUNQSmJ0?=
 =?utf-8?B?RWIrODhyVmNLamZsZUZ3UVEyeTBoczhpaG1ld2g5NjUwUUtzYTFnWjIyc0FM?=
 =?utf-8?B?R3BPWnZzRzN6eEx3RSsvbU5RNE9qcW8yZHRuY2lOT293ZHFxYUR3Y0dTUS9x?=
 =?utf-8?Q?oFmem01G7wo=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?eE04TmFFUFQvdCtuL0w2MHppSU1wQjhoQUZvNVI4VXFyZjU2QUxrbENXVytV?=
 =?utf-8?B?ZS9xYTlGaGIySTJtUEVVSG81Y3pMQ2NuUmxEK1lzTEowVjJBMmtUTDBGS1NW?=
 =?utf-8?B?N2pzY3JJUDBZVFVrNE5PYUZhdjJmRjJYVW53dUp0OTFQT1lyeE5nS2syOWM5?=
 =?utf-8?B?anB4QUJwS0oyVmJiU1NnR2FkTUQzUDFkNSt2QlBhYU04d3lKNnlaSGtHMTFx?=
 =?utf-8?B?cUFVWkVmWEhXZG9Ydi85dkFPVTcyOEc2Nm84Ri9HNHNkMVJ4dTVQSnByODdD?=
 =?utf-8?B?Y1RXcUQwZUlMSGMyNUZJRWdQR0U3UWN1ME9hd2Q1U1JpUmh3R0FpSWU5emxl?=
 =?utf-8?B?TE5ZYk0rNXkwVmRxYjdhWGdsREowalZnQW8wa1o3TnlQekVUTklkcWh1TklZ?=
 =?utf-8?B?MjFraUk5MjJkNWJXQnRuNmZ3eVdWczZ3SEJ5ZUhKUVR3VjVOTFU1U2ptem1F?=
 =?utf-8?B?QjhaRUZuRVlZaVFMelRzSWZkWndoYlB2VElLby93cGdrZU9CUGNHZDRaQjA0?=
 =?utf-8?B?MDhWWkNkYlFMUlk0UUZrSGE3YUlhVGlYNWlOY0prWFZqVHR4WE5iWDMrTXl1?=
 =?utf-8?B?clBjT0dDdDV6RmJueVlRSTJTMjRxR0RyUllXOXhPRm95NW1YL0NSamtyMG9z?=
 =?utf-8?B?SE84RnZuOTBLVThJa2pSZCtrVXFNZ0JMMXdxQnFVM0xoQnRXeDFNRlNDL21z?=
 =?utf-8?B?TTY1ZmF2Z2ZRZ09xWElTcmkrS3QxblR2UHR4MWowSHJIWXRMSHFuRGVGWjJk?=
 =?utf-8?B?RkhDZTJzdEgwd2NoeHVwZ1ZHQ0VrUGE1LzAzeVlwYURmTDYwRE9IRlBNeER6?=
 =?utf-8?B?WEVYK0VhUHc0NWpYZzFSOEdSditzSXJVRzFlUmo0RjlJYzBRSWE3Z0JiV2o2?=
 =?utf-8?B?bURKV1FBM3ppcUp1d2t3aytVRXpSekNKbTd3V29oUHdmcjA1UGQvcDNJN0Fv?=
 =?utf-8?B?Qmd4emI0bWtlZXkyMCtUWHBLeVpwbk9BOVVxUkdNVktTYndJa29jRWZQRkdq?=
 =?utf-8?B?eHlIS0ZVTUlwY1pLOEx2SmVjdlI1RGo3Tm1IZ0x0OWdEYjhRRHR6T3E0RDMw?=
 =?utf-8?B?UUFrYTViSFF0R2N6OHZab1pWK2VxbmY5T2loRHg0N1IxNHlsR2REQWVsMUp2?=
 =?utf-8?B?bnhZd1AzMktQWS9uaEJpMjdPMUwxYit3NGRVRHZiVTlTelBjRDJDODZCeThr?=
 =?utf-8?B?REIrOXRhOEg4YlpFbUZBYnNOUERpT29RNFNUNjMxVzFZOVlMcTRTa2daZ1BV?=
 =?utf-8?B?RDVJK09aSEZySFYvQ215Q0dQT0NEVFFkWU5XcFVpWUZud08wZERyWkFtZkx0?=
 =?utf-8?B?azNUbXhJVVpHUHNLS3hXR3gzcmVjaFBoSHZXdU55UGloTm40MElZVE1QeERo?=
 =?utf-8?B?bUhGM3B0RFRidkZhR0k0c0w3SThsQis3bkRjUzh6UXpGS1FYUloxdXM1ZlBp?=
 =?utf-8?B?V3pmTHc4V1FNcmFZR1pPejJGbUpjVU16RHFmbXM4NHFUZ2VGdHZWSGpsUURD?=
 =?utf-8?B?ZGQ3eExMLzRESTRyMURQaFFwU3dFZDhobWgvVHJ2dFl4bXJLTjVGR2cvZ1dY?=
 =?utf-8?B?M2FuWEk1bml6VHcrQjJ5Rm9yUnNhODRGVDZkeDJuWmVqZ2Izd0JlRGRvL2sv?=
 =?utf-8?B?SVVIZGJxcVdpVyswZThWSC9WZlpodkJiSy93TjdoNjhtZlBKWFZrdWVaQWRv?=
 =?utf-8?B?anJvVFN1eTZBdU8yQU9DTFFsc1hnNnU1QmNmN2x0MjNqRzBhZHVaMFNpRzV4?=
 =?utf-8?B?bmFKaFYvb0tTUmR1NDNqMCtuWmZvaXhLMVdyaTNkU3MrTHdUNnRFNlZicXRE?=
 =?utf-8?B?YisvOVk5YndLNE45SHZDWThPcllKaE5PZmd2MmFERTNpVGpTcmZQM0Vlanp0?=
 =?utf-8?B?U1Y0UWtOYWJQYUFyZ0wrOVZhT05MNS9KRTJmVjAwLzRDdHc0ajNNSEllT0dt?=
 =?utf-8?B?Rk5IS2xOaUZSMjZOOEZJbEY1OFJLM3BPSjhndTRWSG9wMkczT3JMKzBSTUNz?=
 =?utf-8?B?akN5MmNReHgrUmJySVBsZ2RndEpIcE9hblF0TlhFZ1JwYytTYnNqRGozOHlK?=
 =?utf-8?B?N2ZobllUenBacjEvejVoTVpjc2xFUmNYL2J3Ly8zcHFqMGloSDJZQ2FwZno1?=
 =?utf-8?B?MWZneGZ2K2hDQ3ArdG5vaVpwaWVXRjBqUlp0QXFOTk5qVEJUdmRjOGJjV01N?=
 =?utf-8?B?VUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	k7A6zS523SZ85YEHHRxM8DSqomvdCqs5f3LIiNGWKHj2qdB+aFOWp52tQ4qQCdgTXVLlA04s9PY55rlJm5OiQSN2+WjhCVyqTT/U94GSbeZojx8+b0TeLAEtCuSZ5eBy1KDNz9BETBfGQWrkE6VX8UjA4aXXg/ZzT5Wu1/Rmd5ANDtxdHInMcxVcDlA/jq7MAcpZntRTdbcnbi7U95ckSINcD5bSKHGcTpSZs4oY3+eAwS4UUE76SWc6IeNMdc+vMfXGC6N3/xa9MuMZeJIfbkF+Q5BRa66SEem0+4PeqUnryX6cl0tQI6mMJ/BaIoM+slnCPjmywdIGRq1EmUs2gjy/4gSXS2nQ0NAj1Ed3KwOS1lti0KtCQfWGpHzQk0QjpX6IfsPbh3iso3zfUnewTJcc6b6xlCl/ArWPjapoBHAfAbcbdT0BV6xY77GT7mU8M0MyNkn9vABIAODtitpr2na0Ac5GAhXLVRs5UHIaT112nCy3eYbDYw98Rdz1g1oCX+Slmfxlax0Yjw7stozFLFSYGYc9R7PmPFHwxx+0SQvEdiiZs2Mb90VsNiQbaGoFhen4jYSigKbit8myc3PST4e4PCY6uJjvG+mbxZTfM2c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a42b8b79-57a1-4114-619e-08dda8fa3ebb
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 15:11:30.5463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xaA8iPEZvDneVne+erSWI/DxeNME//jHGhTPfQRXazZe0i7YOZ3W7bvugdxuPTMW/mb8ywPO4qrvDcF3O+W7uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7824
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_05,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506110127
X-Proofpoint-ORIG-GUID: EZzEGRiZqyR51ppQhQ5hFsN61wxjgBub
X-Authority-Analysis: v=2.4 cv=EJwG00ZC c=1 sm=1 tr=0 ts=68499ca6 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=KjBAp0zKM1Ny_CNXsYEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDEyNyBTYWx0ZWRfX0eLeQV9r3SoQ k7vdPfakniYJ4Tl+8usmLryBhVEVi4Y+JNzLu7p1NPZpc/3vuBJtz/94zsnXTOP1KEddeEEZT+9 wrnfoRHu9+UlhU+bbT+kT4d/mC9NWejKH8DJ6bcklr/TVSWDIG0fockhBQkH2NoZJjZvud/mLv7
 6KHxn0jM+zwWwsr/dgk4sune+dUYzAp73vi0cwKPHy6sIGePCzyXGgNQzSNuV/UxkmGrhx25pWX 63H+/sEwSRPzFN8jy0xVMXn1HAlvRfrKKm98atj8MaEKIXIKf8KrHP1m7C8tcTfOTugJMVVpGuw SOw0mSDAY4lJLI84GWxxctdX6DD9c9ngxwBGkWc3vNTyyEokdCN+Ig0K8hG4O+/LVzbD132Le2S
 epPegfFA1BgoeLHu0GSMBlIOeFquRs3ZEN2TR36VOnNyTaX034ShSTqmQ++gCBGz1+rQzzBB
X-Proofpoint-GUID: EZzEGRiZqyR51ppQhQ5hFsN61wxjgBub

On 6/11/25 11:07 AM, Jeff Layton wrote:
> On Wed, 2025-06-11 at 10:42 -0400, Chuck Lever wrote:
>> On 6/10/25 4:57 PM, Mike Snitzer wrote:
>>> IO must be aligned, otherwise it falls back to using buffered IO.
>>>
>>> RWF_DONTCACHE is _not_ currently used for misaligned IO (even when
>>> nfsd/enable-dontcache=1) because it works against us (due to RMW
>>> needing to read without benefit of cache), whereas buffered IO enables
>>> misaligned IO to be more performant.
>>>
>>> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
>>> ---
>>>  fs/nfsd/vfs.c | 40 ++++++++++++++++++++++++++++++++++++----
>>>  1 file changed, 36 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>>> index e7cc8c6dfbad..a942609e3ab9 100644
>>> --- a/fs/nfsd/vfs.c
>>> +++ b/fs/nfsd/vfs.c
>>> @@ -1064,6 +1064,22 @@ __be32 nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>>  	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
>>>  }
>>>  
>>> +static bool is_dio_aligned(const struct iov_iter *iter, loff_t offset,
>>> +			   const u32 blocksize)
>>> +{
>>> +	u32 blocksize_mask;
>>> +
>>> +	if (!blocksize)
>>> +		return false;
>>> +
>>> +	blocksize_mask = blocksize - 1;
>>> +	if ((offset & blocksize_mask) ||
>>> +	    (iov_iter_alignment(iter) & blocksize_mask))
>>> +		return false;
>>> +
>>> +	return true;
>>> +}
>>> +
>>>  /**
>>>   * nfsd_iter_read - Perform a VFS read using an iterator
>>>   * @rqstp: RPC transaction context
>>> @@ -1107,8 +1123,16 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>>  	trace_nfsd_read_vector(rqstp, fhp, offset, *count);
>>>  	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, *count);
>>>  
>>> -	if (nfsd_enable_dontcache)
>>> -		flags |= RWF_DONTCACHE;
>>> +	if (nfsd_enable_dontcache) {
>>> +		if (is_dio_aligned(&iter, offset, nf->nf_dio_read_offset_align))
>>> +			flags |= RWF_DIRECT;
>>> +		/* FIXME: not using RWF_DONTCACHE for misaligned IO because it works
>>> +		 * against us (due to RMW needing to read without benefit of cache),
>>> +		 * whereas buffered IO enables misaligned IO to be more performant.
>>> +		 */
>>> +		//else
>>> +		//	flags |= RWF_DONTCACHE;
>>> +	}
>>>  
>>>  	host_err = vfs_iter_read(file, &iter, &ppos, flags);
>>>  	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
>>> @@ -1217,8 +1241,16 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>>  	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
>>>  	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
>>>  
>>> -	if (nfsd_enable_dontcache)
>>> -		flags |= RWF_DONTCACHE;
>>> +	if (nfsd_enable_dontcache) {
>>> +		if (is_dio_aligned(&iter, offset, nf->nf_dio_offset_align))
>>> +			flags |= RWF_DIRECT;
>>> +		/* FIXME: not using RWF_DONTCACHE for misaligned IO because it works
>>> +		 * against us (due to RMW needing to read without benefit of cache),
>>> +		 * whereas buffered IO enables misaligned IO to be more performant.
>>> +		 */
>>> +		//else
>>> +		//	flags |= RWF_DONTCACHE;
>>> +	}
>>
>> IMO adding RWF_DONTCACHE first then replacing it later in the series
>> with a form of O_DIRECT is confusing. Also, why add RWF_DONTCACHE here
>> and then take it away "because it doesn't work"?
>>
>> But OK, your series is really a proof-of-concept. Something to work out
>> before it is merge-ready, I guess.
>>
>> It is much more likely for NFS READ requests to be properly aligned.
>> Clients are generally good about that. NFS WRITE request alignment
>> is going to be arbitrary. Fwiw.
>>
>> However, one thing we discussed at bake-a-thon was what to do about
>> unstable WRITEs. For unstable WRITEs, the server has to cache the
>> write data at least until the client sends a COMMIT. Otherwise the
>> server will have to convert all UNSTABLE writes to FILE_SYNC writes,
>> and that can have performance implications.
>>
> 
> If we're doing synchronous, direct I/O writes then why not just respond
> with FILE_SYNC? The write should be on the platter by the time it
> returns.

Because "platter". On some devices, writes are slow.

For some workloads, unstable is faster. I have an experimental series
that makes NFSD convert all NFS WRITEs to FILE_SYNC. It was not an
across the board win, even with an NVMe-backed file system.


>> One thing you might consider is to continue using the page cache for
>> unstable WRITEs, and then use fadvise DONTNEED after a successful
>> COMMIT operation to reduce page cache footprint. Unstable writes to
>> the same range of the file might be a problem, however.
> 
> Since the client sends almost everything UNSTABLE, that would probably
> erase most of the performance win. The only reason I can see to use
> buffered I/O in this mode would be because we had to deal with an
> unaligned write and need to do a RMW cycle on a block.
> 
> The big question is whether mixing buffered and direct I/O writes like
> this is safe across all exportable filesystems. I'm not yet convinced
> of that.

Agreed, that deserves careful scrutiny.


-- 
Chuck Lever


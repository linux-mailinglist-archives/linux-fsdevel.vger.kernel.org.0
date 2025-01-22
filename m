Return-Path: <linux-fsdevel+bounces-39826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B7CA1901E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 11:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCED61689BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 10:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A8F211494;
	Wed, 22 Jan 2025 10:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W2sjaF9x";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="E6v+1gL+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E661C4604;
	Wed, 22 Jan 2025 10:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737542752; cv=fail; b=bDAsiIIlQgSfuf++0sNDDinEFKkCmcm+tEJuPCgl6NVWRkM20QaCd6/qhGxDFNTFtLM05QEV+gIdXcVTQjDAiyqZfGFmwDsCsbHI/pgJZVCFhRN1ude49MPm8iQ6k/SLOKdlKZOlgwNUtZjY4YWd+p7UpvTHEzma8Bi5BUeWyMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737542752; c=relaxed/simple;
	bh=ICHAhBJtFMHee1HB/kUbMEKFwwtKXVQzobZ1OzDouok=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c8aH71CHLR06oDsPjRGYTpKiLO4dtIKaJWeR0Irgy7OnPaHYIQDmx/+wVSsVv2dl0xOoywb/R2nXW9plyH7wW/7CxUlncw1Q6OHKji4udJk0UkK1B/aNcFmZQmznjOOEYznSEk9vLCay66C+SVaofqiZMVOpcASgKjaB6ngCeVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W2sjaF9x; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=E6v+1gL+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50M1Mtg1006230;
	Wed, 22 Jan 2025 10:45:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=oQFRfvAjjK1WnonD3p6rrmuwUGVJbdaNbkJQa6oaln0=; b=
	W2sjaF9xLT59TtwiiMdn7pUI8VfxaeDrCWZ9TIVZOk3Fond4gBrfR/sCwF5Ea3Hv
	rYBGBLIWFlUggyokxsvjulnHg+5nxUQYU+jDc0r2RrFTpJMQrDwGLRB9Kpu4ksb3
	TGz7302X0ySP/ttd0lfKD/FXoVHcLd2UVK5Fn9R6/kk7j1kHEyw+rxKxqSw2WA7j
	SI5N0GAXk8yXwrwVPgjq6M6GmL0Ey2HYQxvTRMtk0jMwOQ4hsa3vqbZQBb7evlz2
	GlC8+Kp2uZ8D9DTRBzgSlFY/oFDQbSuS8NKDoNkbZMWK04aLTrxBcOTPpvHfjIS5
	gE0xd5J3ajkfdISm7wFTXg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485tm7gwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 10:45:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50MADZYA005423;
	Wed, 22 Jan 2025 10:45:39 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 449195fhk7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 10:45:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T2L7HxJoemMQdozlGWVqqudSpzvdnd3TvSrqOnzBWlUb9336dyTGNTyLVQ2XqovMzJ8eHexUHZVv2+5KBtwGxJqj2dAIEFffsgZpBIEcOGAwF/HPK81jpBNqgEHJxA8bdEzzwP2vay1mIozzHTGev0m6mHGcEnk7oykA4OdFE2Mo01GuwF05vR/EZirkghHeVOobZBJeCNOl7f20ZPDqnx51Mg5teQIMgRtfn9IvveLwck6gWG4uBnR2AfnZRF9syMpPYp4BktpAQ6UdRd04Wb0537rTIo5w5nSQquBwRuXa9h8LsjoqxkCxURWyZpRx2sSXRz7ncJk4UUQNpS157Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQFRfvAjjK1WnonD3p6rrmuwUGVJbdaNbkJQa6oaln0=;
 b=w6uSeo4hc8f6zC8StYgbctsszsGmehoiAI1I11XtCkle58ItQMZ/5sdPdixPGBSeFQQRPbky3+ebVTvK9YzKCB6JmnEjT/W95rLGRKcK9nXqY09rBgMCTOJwejriIJQRaf6SaB1pjs0aVANxiQON+jLqUbxx1HkMETMDPZoOqaMe9hoJV6iw2oyUButG99ykrc6ZKQZc6lhg2K0OgXLaDs0jaZPK1cM/M1G0wwiRDwzaD20Bk84qed7ualOLjBuJKhoetIxINzzbjb78jmgxGTJDAQHXWyrgLr4yg+7oMGttvZgV6Eu9inoxwGbth/7zKUxNzG16myrvSiq1yYNnKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQFRfvAjjK1WnonD3p6rrmuwUGVJbdaNbkJQa6oaln0=;
 b=E6v+1gL+exAZQxPdiFs25uW8ZtKjaj9MJ645watw9LsPOYxDKI/8/SNPSC53F0qTM4ZdyiM1Rs7INrdgYl0YfvEkvfn3Qhq+Rr3IW6bhH5XTzTXRSXE/W8qXg+sQk+p9i1Si4EVYxx5KYOuHX0CKRzO7wep8HfY/EnpV6NOaSkc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Wed, 22 Jan
 2025 10:45:37 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 10:45:36 +0000
Message-ID: <0c0753fb-8a35-42a6-8698-b141b1e561ca@oracle.com>
Date: Wed, 22 Jan 2025 10:45:34 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] iomap: Lift blocksize restriction on atomic writes
To: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>, brauner@kernel.org, cem@kernel.org,
        dchinner@redhat.com, ritesh.list@gmail.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.petersen@oracle.com
References: <20241204154344.3034362-1-john.g.garry@oracle.com>
 <20241204154344.3034362-2-john.g.garry@oracle.com>
 <Z1C9IfLgB_jDCF18@dread.disaster.area>
 <3ab6000e-030d-435a-88c3-9026171ae9f1@oracle.com>
 <Z1IX2dFida3coOxe@dread.disaster.area>
 <20241212013433.GC6678@frogsfrogsfrogs>
 <Z4Xq6WuQpVOU7BmS@dread.disaster.area>
 <20250114235726.GA3566461@frogsfrogsfrogs> <20250116065225.GA25695@lst.de>
 <20250117184934.GI1611770@frogsfrogsfrogs> <20250122064247.GA31374@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250122064247.GA31374@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0538.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::8) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB5893:EE_
X-MS-Office365-Filtering-Correlation-Id: e0ffec09-5b75-455c-cf18-08dd3ad1e7ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVVMU1BMRTQ2RGdPMHgva01wQ1JiVzJWczdzWVl1RlEzL2VmMFNYWWxSdE56?=
 =?utf-8?B?Y2FlOC84aHJXU1E2dXEzSjA3ZmdERWJmR01pb2hVT2hUanF2SStWMC9OdkFO?=
 =?utf-8?B?eVN0UUxLVGtOSEhHNlFBV1hzcVRaNlVacVZ2dWlWZVA4OWdPQnRoUkVXT0x6?=
 =?utf-8?B?YjR0eHlFbThteGR3RmR6cHVGR29neDZJZWNFWnUrakFWYVFJWEw0UHBtdG9l?=
 =?utf-8?B?YVlmNGd1UHhuT3BzVEQ3MmVuK25udkVqSGdqemZSd1VrSmZKNnBnVnMzNnJQ?=
 =?utf-8?B?NTQ3Um9vVnhRR2NjTkhQa2Q3WngxU1d3M2tBRDdBU2o4YktWUEtUbGJWNk1L?=
 =?utf-8?B?aFRnWkVmMDJiV29TSlA2cTQ2aHkvTzdJVUxCcTR0RldLWHBzdjdPVDJTbE1S?=
 =?utf-8?B?dklycmloK2FwU2k3SW5aZzg0cFFoNEYvMkswS1dwNVE2QVEzYzFUbGtNdW9O?=
 =?utf-8?B?STl1aUtNdWUvb2gyK2I4c25uQjNWdUVtdnZqZVhGMGlVV3JVWlNLUTJ0NzVz?=
 =?utf-8?B?d2dEZjZkdmFSdGhvemRTSlhYRFlqNXVkbWtqZUdWQjR0MTR2SHBVV0xsU1U0?=
 =?utf-8?B?eGttbzJXakEwTjByRG5mZ2lzRzIvaTJtNFp5MTdXNnVsNXlRcHZKYm9xeFFv?=
 =?utf-8?B?UlBabjQ5NDF4bjhyeTB2Ylh5ZU1DbTJFWGhmYVZ1RWIxQlpmMUIvcFlqdmxz?=
 =?utf-8?B?WVlBMWZUUy8rWnN1V0xwRStONlRLT3k3U1hlVWxyWWhCQXF6NnA4aDMzQWNw?=
 =?utf-8?B?ZGRYQ2dSV2ZrS1pHYU5WQnRrVEFiSE00dkw4VWw1M3lXQTBOVG94U1F1TEY4?=
 =?utf-8?B?WnBIaEdIN2ZKdmlET1ljT2ZUZWhINDFyU2tHc2NQNTNwTEtiTDU4TDBEbVZ4?=
 =?utf-8?B?WmkxcnFMUDRUdDd1WXpjREwwUGprbmdzQ1FvdFdjWFE5M0lSVDRhVEVkNUdR?=
 =?utf-8?B?SWV2Z3FxNjd2S3pzZGlmSm16OStiN25FS2pseGNBbGE0bmxscDRLUHMwd29h?=
 =?utf-8?B?NExmdjlucTdtTjdkTlFDK294NXFvZFFYZ1hzVkw4SmNxdUR4RnNnOUw0bmo1?=
 =?utf-8?B?NUhsTy8vTUpIMjNrYzJoV3hCSE8rcWpSTTVzREZtU0Fqd2ZCSmZGdTlla1I4?=
 =?utf-8?B?Vkl6RjBMZlYzcHJsRmZPZk9yazZ5UFE3cGNvRWEyUExKa0xzT01HZ0djcHRH?=
 =?utf-8?B?TlZoMGZXalgxZUg5ZFpQSXpjMGdXUDNaUG9xZHRISFpoekFNSGE5dmpYVHdX?=
 =?utf-8?B?dTVJdy9qdXZLMW4zQnhveWFSamlwck1rS1pONTljRkI3U1FMYUNmNm5pUUtx?=
 =?utf-8?B?TytkV3cxNFNoR2xXaU5zWWsvY09oRm04Q1NHcWR6eUIwUCszNEFleXNvaXYv?=
 =?utf-8?B?NytIRzlzd0NMejZwYS9qS1hjSEYvRmF0TTI4TEhGRmNybTArN25SMUJ4Sy9S?=
 =?utf-8?B?czE1RkNrUHQwbGZTWGdKU1hyOVMrakhCeDdyOHhhRE1wSUJTNGk4RGZzb1dB?=
 =?utf-8?B?UEtPMGFNQWk3djdNTExNeGdtMHlxaWI3aitXVWVmMDNnTThyZFVlUHd1eHZZ?=
 =?utf-8?B?NXpsdEVPMGNQQkVYcmlBVm9mQmh2eUxsdmJ1Q3hLTGwvUHFmdWtXb3Z3RUlY?=
 =?utf-8?B?VGw2THZEL28xZmNPdUFCYjMzVktqdXVxSDdnYlBBanpUMVh0N094SXAyQTU0?=
 =?utf-8?B?Yjl5VGpBMVdlb3FlaEdKd3psY3RVdWtkcTNSWllIRi81a0xPU1ljMCtIQmxO?=
 =?utf-8?B?OE44TnlGR21CNXBJcklybEc0VUpTU2hadE9ZZ0tnTUdQbmxyT0U2VkpvWWVJ?=
 =?utf-8?B?ZTJMaVF6b1JCcDVySmJPak4veXRlTU80QWI3bEp0LzAwQ2RJdk56bWEwT1hm?=
 =?utf-8?Q?Y3MLmGpwpmWxS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkZ1aU1TNThlL01rZk14SDRMd0JrVkJrN0xnUGoxckFxa3VkOEI2LzVncnFS?=
 =?utf-8?B?bkhtV1BvVW5hdnFkYWRyMjhidDh0bVNRTm9nVkVOaHJHUGhkU0hvTm9raXBl?=
 =?utf-8?B?bWNqcDhPeHp2MC9TZkVxL3ZhT2lkNVFuZW11dS94UGJQZVpEd2NRWWNxQzYw?=
 =?utf-8?B?UFJkYW90Qm9GbXNQQ2o2dTBJMWZVeHNmcnc5WlU5bkc4a2kwNWZwSXVzVm84?=
 =?utf-8?B?VXM1V0NpZjB6RkxPZ3I0RDBhVU9jeE5HOXRNWDhRVzNuOHYzQVpWYWt3dXZB?=
 =?utf-8?B?UHpMNFNhU3BxMC9jcGM2cW1VWFRxNkZDMFBWeUVSUUJKZ0M4UXVFM3BHR1Nq?=
 =?utf-8?B?ZWFKc1h1bHdySERLUXJ0SHluMzZLTWZDVGFjUHNzQ1pjYmpITHB6VUY0NTJC?=
 =?utf-8?B?UnBnOE4wUkw1cnVpSy9jR0VjekUvbkp2YVMydy80YklaNWN1S1NhNy91TDkx?=
 =?utf-8?B?MDQ3UDVtSW92K1pTTmNsUVIwOEpwRlEvcUJJQlg2bTQ3QVdBWEhiNDRyY0M1?=
 =?utf-8?B?cUlyME1iRGlCYUdOQVJNaEtjNTZ4QlpNM0JHTEJwWit0WHltRzRUWi9hVHZO?=
 =?utf-8?B?N1drTFovbWlJUkJYM05Xa0RzVWhaT3dueWNBd0JVd1U3eEVLSExVd1p3ZGs4?=
 =?utf-8?B?TDRSbWtMaUQrWWthak1Ga1RhMG4rSXUraldXeTVOREhYWWh0M0NkcU93Nlp0?=
 =?utf-8?B?NXlJVitaWkVVZmZ1NmhobGYvYnVLNHBveFFLY292Qk1jcE1MUE5EdCtvMkdC?=
 =?utf-8?B?c1NMajRMb3R5b2g2emlIdlNybnNTU213OEZXSk5ZcHcyTlZaT0VzbkdkSDFF?=
 =?utf-8?B?N0xQNjh1S1lQRjVVajFRU1NFM05oeVlNeC9nUGVLdXpzOCt4TjJTZ3lrdmRX?=
 =?utf-8?B?cWdTUEVhOFVISWxCNjM4bXVhWjE2TENFdktsUEltWVhMTnFTNzRyam9DUUlY?=
 =?utf-8?B?R3BxZitrWVl1OGVIemI0OFZHaDgxcWpvY3lIYkQvY1VWWlRhRk51enBuUjBF?=
 =?utf-8?B?MlF3ZjJOaEo4R1dtak1RZEpqdWlONkxLNjVJWitWYnhBRnlIMmRZUXhFaDZv?=
 =?utf-8?B?Vkp3Ylg4cVB1V01uM05wazMrSkY2ZVVyWlljenZlWmFxaHdLcFgzV1BmdUx1?=
 =?utf-8?B?UjZ5VkN6V096WUxtVGtXVU9JbGQ0Ymd1NXVZZlc4NlVXdDhMSk40WGI3M2Ji?=
 =?utf-8?B?SG9zU29lS2I5OUxuOGxnN0sxYXN5YitSTEJLK25ldWhmelJvei9wVndraXhp?=
 =?utf-8?B?SE1Pa3YydGFvR3paS0t0YUxXMXNwSmZCTHBFMmNkUUFtbW4xQk5icG9lN2sy?=
 =?utf-8?B?RTZWRDRYaGlPV1lLUlZ3VjVkKy9xV29XdkJ3eHJFK3V0ZFpKTVk5SzJQZ3Jy?=
 =?utf-8?B?eFdQVloxdDBwZ3VrbVRxY0NxemU2RS9ncEpXUytxbVFGU0dHdzBsMkhpdDdO?=
 =?utf-8?B?ZVBHSGI3YnFlOEpEL3ZBOWlxeEtFZ3RVSTVDTVVVVGRKZ21BV25QUjhQN2Na?=
 =?utf-8?B?SU1vdWVzR2UxL3ZZTW53T1EzcTFURkYwNXd1cmx2S0psK3B6ck5xSytBVXRG?=
 =?utf-8?B?dUtUVVI5dTNoNnhWc2w5WUxsMS9HZFNGbUozOHU0SWEvWVNVYVU1VWxuc0pL?=
 =?utf-8?B?SVpKdXR3cndEMGt4NFU5akd4YmpBYTl4d1BFREtUZFZPRU1KYXBma1ZFdk9p?=
 =?utf-8?B?WUpPSVVBZ2s3bXU3UGZNWlFmMis3c0FQTndGT3lOQ1JDekg0bGk1aFNlWDFu?=
 =?utf-8?B?eVo4ak5tRVRPeWc3bTBrWUcrUTU0QnR5RlFKeERjWTk3MVVHUUl4SVBnaEQx?=
 =?utf-8?B?QzgwUEhxVHNVV05DSC8rL0dDKzhHNVN5dzBNSEpIOC9scU1INWVYU3ZDd1Fj?=
 =?utf-8?B?bFdJdlcyN2htejJBK2xCeEx4N3UzZU1KdWEwNFpJVkFsMkw1STA3U3lxN0FT?=
 =?utf-8?B?eE5rblhBTjM1MTZnNmR6YksxZS9INVgvRGMrR1VWMEJGRkdKL0JVaFNHSEhD?=
 =?utf-8?B?Uk9nLzhXUkNrb3A1UGRmb1BBTHJSZG9mWE9xOXhibDY2SE90MTVtdUFCdzQ3?=
 =?utf-8?B?TUVEei9Ga282VWJheE5WeXAxTDNtRU9FVCsyQUlBUDhJUFdDOHV3bENZK2dj?=
 =?utf-8?B?NGFjR0hPRHg3RXFia0k2c0grTW1VNUtpUTBIS29qQmdtS3dCek9RdXBoK1hQ?=
 =?utf-8?B?K2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UP4p7Fl49oPu70FCB6aZT5UubEIE8zzkS6+WPbtZOHVzFZNVCfRNLPX1DzLW0vn0xzPAcXgKV6VVQvy275NMEyIDQ9u1ekLcjUY0MhFeDXqHJRCKCtV04ImCqma3aSfueg6NTkokk5j2eEVG6EUG7k65KtEng1Q4VI/3s9HjFPMKN1qAPiRajKdxJms8HdhbAM6bHEc5xDouz2TOYn1afhJPH2R+OKxmO+WP5DRroX/5hFLLqKQwJRvRZ//Kj8TPZ/0EnDl1MuQuNV70ecbE0IiJVCMSTBbVtwymdCec/7N2NotuoIiCaCOe6ErVjQNgixKkwX3PeQZe1yzIXje5E5FapLYjmria3Tu04hHQPmtmM/YEUqtFqdLd0XsV3O4MHP3r14LnzxO/hV0WfT4aMXvt0wwKO/SzE8Btn9FV8EkFnguT5BqiYdRN2028SfFZoCp0zFq+ABQZS5pMBXqteD9iX5amDmUF0eeVfoJgs/r+uP0w4Kuvk8crAtYRkRVOpMyIj6nNHoBOVRMS49bcDTTOrsvOKkkrKmqRGyBkWVX1dF036A9yI1Kk2Vsj5y6LOrk9gf0E78jtTG1avY7NQgz5e5KlHZv0nrlN8Z75668=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ffec09-5b75-455c-cf18-08dd3ad1e7ae
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 10:45:36.8290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rvNNh04YE5vtBw5fTLTgh4TqLuBC0SJEVG648QGAPLuDtqgmAW3RHJ2STrnKhomsrIHV5KV8ANEP9NuIVhM8Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5893
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_04,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501220078
X-Proofpoint-ORIG-GUID: U99SPWkZVrsyGhLvTWgTCpX2oQ-JIRar
X-Proofpoint-GUID: U99SPWkZVrsyGhLvTWgTCpX2oQ-JIRar

On 22/01/2025 06:42, Christoph Hellwig wrote:
> On Fri, Jan 17, 2025 at 10:49:34AM -0800, Darrick J. Wong wrote:
>> The trouble is that the br_startoff attribute of cow staging mappings
>> aren't persisted on disk anywhere, which is why exchange-range can't
>> handle the cow fork.  You could open an O_TMPFILE and swap between the
>> two files, though that gets expensive per-io unless you're willing to
>> stash that temp file somewhere.
> 
> Needing another inode is better than trying to steal ranges from the
> actual inode we're operating on.  But we might just need a different
> kind of COW staging for that.
> 
>>
>> At this point I think we should slap the usual EXPERIMENTAL warning on
>> atomic writes through xfs and let John land the simplest multi-fsblock
>> untorn write support, which only handles the corner case where all the
>> stars are <cough> aligned; and then make an exchange-range prototype
>> and/or all the other forcealign stuff.
> 
> That is the worst of all possible outcomes.  Combing up with an
> atomic API that fails for random reasons only on aged file systems
> is literally the worst thing we can do.  NAK.
> 
> 

I did my own quick PoC to use CoW for misaligned blocks atomic writes 
fallback.

I am finding that the block allocator is often giving misaligned blocks 
wrt atomic write length, like this:

# xfs_bmap -v mnt/file
mnt/file:
  EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL FLAGS
    0: [0..20479]:      192..20671        0 (192..20671)     20480 000000
#
#
#xfs_io -d -C "pwrite -b 64k -V 1 -A -D 0 64k" mnt/file
#xfs_bmap -v mnt/file
mnt/file:
  EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL FLAGS
    0: [0..127]:        20672..20799      0 (20672..20799)     128 000000
    1: [128..20479]:    320..20671        0 (320..20671)     20352 000000
#
#xfs_io -d -C "pwrite -b 64k -V 1 -A -D 0 64k" mnt/file
#xfs_bmap -v mnt/file
mnt/file:
  EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL FLAGS
    0: [0..127]:        20928..21055      0 (20928..21055)     128 000000
    1: [128..20479]:    320..20671        0 (320..20671)     20352 000000

In this case we would not use HW offload (as no start blocks are 
64K-aligned), which will affect performance.

Since we are not considering forcealign ATM, can we still consider some 
other alignment hint to the block allocator? It could be similar to how 
stripe alignment is handled.

Some other thoughts:
- I am not sure what atomic write unit max we would now use.
- Anything written back with CoW/exchange range will need FUA to ensure 
that the write is fully persisted. Otherwise I think that not using FUA 
could mean that the data is reported written by the disk but may only be 
partially persisted from a power fail later.


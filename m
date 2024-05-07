Return-Path: <linux-fsdevel+bounces-18937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B28928BEB1F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 20:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A8ABB267A4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 18:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C79F16D4CA;
	Tue,  7 May 2024 18:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JKLb4slz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RALhuHHP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7821316D331;
	Tue,  7 May 2024 18:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715105194; cv=fail; b=TpjJYvbTfDifnMVlzINv3O41CpUSVhsNiAsU00bMEWe1kSCnC48K0VQUlNjMMni5dzQoPOmqRulF/M3+8O2EYqBLlLK2Do5ffv0H3SHoSzK2CLVxwG237ckU5aNvsaCTd4yTmCc8dfdTlp2lG2kgAGtWuGkslIe5qI2SV+1SMYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715105194; c=relaxed/simple;
	bh=mq5Hcv8F8pfZVQ5AmD8sVbkF9anKaTmzad7lHr+KSys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m2qMqukSe6NLG6yHHCA+LshytjOU/n3h/xiXI41qbcHIpEZrNyZvG09WX4MVOjXZYZBC2U4W0c0tbzhN2CnTg4nfz+h/ryyTef2kPIW3+ZJ8ajaboVQgt6iLZwBQYvJQPMCQs2FQDX3jLaaXiijEolGoYbcRKHHWUABfvo388Bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JKLb4slz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RALhuHHP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 447GQu7X004006;
	Tue, 7 May 2024 18:06:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=8hHnZirFkr6cipfmE54WYWWi3pKFJd5igW1TzeZJlMQ=;
 b=JKLb4slzBLxkOBVUZzXcLS9xyF/3k8/qjQn2/cGzsZiCC6uRO4uvrDEjrntP9CW2IuKR
 thFFih3BpMFtiz0ewD9jYU5Va1cQ3+t+2xtrMWC8o8ltg1TUCIbfgyWik6FNvLt9Rs5O
 iVoEF3i8GpB1ySH5GMKwhn6ZZWAk46yKm8zw5MEA7CojzzgPqnVvhJ2/R6e/++PQbPUi
 XWShO9C5pjNHWyjlz8knDUFX+VeRwlhtHvvs5cOVJqM+2GQeWDh0AUVfauMBq5xT9SdI
 pRWHKRNdfS/QRnDf4AkLfC7CyJwJwkPm0ztCwbX7NkjZxRWuOqtXfj4ztOPbxdSe0cYX Iw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwcwbwpd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 18:06:16 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 447HFM4W039432;
	Tue, 7 May 2024 18:06:15 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbf7cwg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 18:06:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbLI+ot1EDZPuRDBDE/Mpy6qy9j9pkrjj9yziq4dqCD54v2SlrQAxNxg6bpEPy8N+4xBuY6934uSUTQV2MsvHULPz5VpR2tHmYEv8QYXTG8CHq071HdmBWW3wTO3LAP2BWCMtHw2j8R6rrpZQkrFxV0Q0t3HnseWIERnWcd2UmbMDwDXgZ0ESPOtKHDyHtddAvFgu3uHLEVgBoNASacGTEqzvZBLz9gxn0+bi84XtPeNgXkv8O1vd3UkjJFbndTimohoDc4xOPSLFuAvd8rZXO/Bv8kNQHX2LsTsrNEDqSV568mFPK38y7XfIEze/OEELg9pOo0CwVgIcPG5fLcRjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hHnZirFkr6cipfmE54WYWWi3pKFJd5igW1TzeZJlMQ=;
 b=YLL8Ar1P1lLQuM7VDePRoNAznrEm2tHGUkGUcOKDeXbj+mDLLQlYmhnDLuZMgrPTsd1o0rc+MfGlroUmzWC2WEZSTwscxu5315WicxPlYtxNO9WJArXyAhuseINjsKBy4X2Bz6pUye4HU7pXIGNu/En3J8knnZcwr76ClTUZBAZdV3bSsvyRUkVY03iT35ZtTRCw+Ch9lnc2sKseykKXGjWBaNFx5EKBq0ejKiBGFQJI1zAgbZwLoueLilP8LSBbEDVoodbGZU4WOP1wbSE5LOYqpK9MN/DdbcU+zrOqQlFpAS4i31zpqbhLLqOg0lMM7sgdhPBA4BsTV0uTcR+YYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hHnZirFkr6cipfmE54WYWWi3pKFJd5igW1TzeZJlMQ=;
 b=RALhuHHPA6y1eIo/QYqO0pdmyIDvMed17kcbYFjGW9vWO2qn3CzZiZQyPTSEzmdjt2SuwVC7L9qoaquah22L7IxUTpUfRHItaT/nzWYCSJD2/ZI+i/jQKydoXVh0JvL48Bw68go9KikfFsU0vleNOuIIFpoSSTP0P7gtl4QZFjU=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SJ0PR10MB5630.namprd10.prod.outlook.com (2603:10b6:a03:3d2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 18:06:12 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 18:06:12 +0000
Date: Tue, 7 May 2024 14:06:10 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Andrii Nakryiko <andrii@kernel.org>,
        linux-fsdevel@vger.kernel.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 5/5] selftests/bpf: a simple benchmark tool for
 /proc/<pid>/maps APIs
Message-ID: <qa3ffj62mrdrskqg33atupnphc6il6ygdzbtknpky4xfhilqg2@mqojpw2vwbul>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-mm@kvack.org, Suren Baghdasaryan <surenb@google.com>, 
	Matthew Wilcox <willy@infradead.org>
References: <20240504003006.3303334-1-andrii@kernel.org>
 <20240504003006.3303334-6-andrii@kernel.org>
 <2024050425-setting-enhance-3bcd@gregkh>
 <CAEf4BzbiTQk6pLPQj=p9d18YW4fgn9k2V=zk6nUYAOK975J=xg@mail.gmail.com>
 <cgpi2vaxveiytrtywsd4qynxnm3qqur3xlmbzcqqgoap6oxcjv@wjxukapfjowc>
 <CAEf4BzZQexjTvROUMkNb2MMB2scmjJHNRunA-NqeNzfo-yYh9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAEf4BzZQexjTvROUMkNb2MMB2scmjJHNRunA-NqeNzfo-yYh9g@mail.gmail.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0043.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::25) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SJ0PR10MB5630:EE_
X-MS-Office365-Filtering-Correlation-Id: 59b593db-c736-40ba-6162-08dc6ec06148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VHVXTGZaNk1OSGx3VEF2TWxzcmlVcWs2aGpyaTN1RVMxbXU1MVBJa0tnVG4x?=
 =?utf-8?B?VTRZeXpnd1hCMWgzVkNFYjdTYlRmRlNERTlDVlpMNmljbWFFMEtjVGZreWkz?=
 =?utf-8?B?UGZZZldyYkV2ZEl5UzZidjJqZEtKYnN6UURJdEMrbzU3TGFMeVJsVFFCS1ZV?=
 =?utf-8?B?cjYvSXJ4VE5rU0cwV0VZVUZLMm1rT0FNY0dqYklrQndFVEJ2Rm5JcUcwVHdq?=
 =?utf-8?B?L3NSZHJzZ3BpR1ljYlhvN0tVczJmTlRsMElrK2NEZ2lsMzYzNldBOHNMVDBV?=
 =?utf-8?B?aUZoVExFQ1lQNDFjMUc3QVdEeHBEWGE1NmxnYXE0cFQ5MUFIY1hIR2hBWDFm?=
 =?utf-8?B?L050WUxrcXhLMVl3N1ArdnpmYThXVStpRXYzR05xU0hMS05FSXNQMy9OZTFk?=
 =?utf-8?B?Z2VzYlRialFsT3J1VzZvc1VwYVoxWEs5WHY0blJhQjcwVEV5OU9ISllFL3Vx?=
 =?utf-8?B?Q2ZaekJhSUNEWllrQ3JHY3RpOEtZWlZpdXVKY3hlclFqUVlkdVMxM0VEbGl5?=
 =?utf-8?B?NlZPM1IwYVZJVGlvSkRmWVd0a1hQTkJDenYzdXlIbkpxUWZMeERQamNiZlBC?=
 =?utf-8?B?Mngxa3ZPMWNpdGNsRUZ4R1JLN3JRMHFHMXFYR0VTTzk0Tis0OVVRY1NseVN1?=
 =?utf-8?B?WkZUODlHdllmWGd4YncrSW0xcWZVanZkdG5aeCtyY3pCQi9yNHFYR010b1Nn?=
 =?utf-8?B?diswNyt5TGgyeXU1dml6aTh5eENoMXd6eUM0R2Z5bExxTnZ5TUhBR0FYeXkr?=
 =?utf-8?B?OE1RL1puQlhKejF3ODhTRlF5N2prOXQrOEU0WlRpVW53NWtBR0RVSTFOMkVC?=
 =?utf-8?B?cWZOc2p4OWcrUnR4MUgxeHU5cjFPYjNVU2tQZFVNT2gxbGdXcFlCRXhLL3Z4?=
 =?utf-8?B?R2ZNNURmRUg1Z0Q2MmgvdzFZbTRRSDZENGk2QmErS3FTZVNFd0xyYnY4WTNl?=
 =?utf-8?B?YmlSYVZyS2s2TlM3Um1NbGttUytOOHNRVzRRSHhqY09SRzUrak9FZ3dqN1Mw?=
 =?utf-8?B?YzZ1NmptSklibHVBNlBQT29uVkJZcDJhd2NLLzkxZHZ2VkdZMmp1VFRYczd3?=
 =?utf-8?B?S0VEQXZvODhVNzBuOS9GYkt1ZTE5eVhiM0ZuNERuMGtIZS9WQmZBNWFkYWRh?=
 =?utf-8?B?dUg2c0wvMU9nOGQybG94SWppSVdDZ0VMYTdNWmF6WU85NjFHaHo4RkVlclU1?=
 =?utf-8?B?QUU1c0I3TThkSzcwQWZQek9aU0tUbUF5bnYrUjJic1UvcUhtY2NHZnc0WDJP?=
 =?utf-8?B?cG9KZG12emVTRjhwbjlueWR4dGhNc3pKYWlCMUxRV1N3MWhmY3ZWLzA2a3or?=
 =?utf-8?B?SW9aeGltMDRZOWdjVmVEZ1lyN3o1VC95bVNZK2QxcU9rZUNiaS9vUUZFRWhC?=
 =?utf-8?B?MXJhdFVNWnZtQVZtdTVmajByY051VHI0WFlnRUQvZ0hnWUJNRW1rMCsxenpW?=
 =?utf-8?B?aGFETm10UnRnUVhRZHhjdHA5WDU1U1FBZHRBWGR0M09HNGxWSTVGR1JlZUxn?=
 =?utf-8?B?VjVxelFOaHBSZnVOeEo4bVVRVitQaXhZczE0S3AvNjhlR01qKzNIeFVNMURz?=
 =?utf-8?B?M1VyZS9TUzR2bUhpa2lkems5TlRsdThiVWQ2TmtkaTJaMmczOEtUWlZtTzho?=
 =?utf-8?B?V3lhYUY2ckY2cTJJM0VObkpYUUNlcTdXS0ZPTFN3dVROTDV5NmNVWmc3dHdn?=
 =?utf-8?B?SWV0ODVrNTJXUWY5RllaMkpzQlJOUUtTZkQrQ1Q0L2JaOEpJZGh2V3V3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RVZ0dkVCYWZkMnBRc3ZFTWdCdDYrUnZ6WEQxMHVOR1g1SEM3UnhBZzNUTVF0?=
 =?utf-8?B?OXVqMWVUU0drNXdTeSttT1RjUmhuOWp2azluUGRwalVnVjZkSDlpZUp0bmY2?=
 =?utf-8?B?WFd3eVZyd1Q4S21wRzFTd2VkaXV6VG50VGM2QmMycGpyeGxyYndqTmlYbkVr?=
 =?utf-8?B?Mk9ZVHROalpDVzlxT0FuYzduWnZOQ3hCSzB1S2NLemdNYjRGNEZMNXZuaTNp?=
 =?utf-8?B?S3UrQmhvd09PYm94QkhPMnY1QlRjYlVoM3FWM0JwZFpIb1k0SGdjNFg1dno3?=
 =?utf-8?B?STBpcTRxcHdHeGl0VFB2UkhiSXY0cktOTFV3TU1namVjdlNUMC8rNEtWMmhV?=
 =?utf-8?B?Ky9nSUZjRlMydTVkZHl5d3lNM2F2MlVhS3l2ZXV5OThRY1pQeDRuZkhBdjFp?=
 =?utf-8?B?Vkt3L3RweFhGdGRLQWZxN0FrakxCa2xIL01vTDRUZmJ3blBQbkRaa1ZDTWpM?=
 =?utf-8?B?TGkyVGxWWE1QWm5sYnB0UnovUEYvNlVBTmt5WTBrRG1DQzc2MTY3Wk1xMkhh?=
 =?utf-8?B?cDdGQzFrMUFPUis3bFdxdDVYS09BdVgyZUJsL21GSEM5eEdVa0RFTzZNNDZR?=
 =?utf-8?B?OHRsU1IydzMxbm5XVXFwMGNZTE5IM2JjMFNVcUZKaWh6NUlOVGovczJIYzZV?=
 =?utf-8?B?TlZRaTA5M3JWeUhndzZxN2NTbmdTMTdQYnFuVGJQazFOdlRHamM3SThSQ1g1?=
 =?utf-8?B?S1liRTk3SEVralNaUFZFRGwvZ3B4RTZzOHNvdEo5Yzd1RVREcy9yaVFkNkdS?=
 =?utf-8?B?WDQvZGJHQU9kWG90YVlleGQxTTRsTGhHWnJYbmd1M1JPZHlpU0JiSWZuVVIz?=
 =?utf-8?B?MUJYZG52aFR0T3VrakZMUVN2VTQrYXI3OHU2ckh0N3p1Wjk5OHBsN2c2WDhz?=
 =?utf-8?B?dE1aQ09TRnF4aG9QaXJFbTE0ZFpJVEdtMGMrLyt1QUl1UGZpamNUeEU5eit3?=
 =?utf-8?B?OVd3b2I5Yld6MktZWmhWdlBlQXlzK3F5UWVpNTNWUmFCak1kUTBnNGZCam0r?=
 =?utf-8?B?aWlaVkVNbmZseU1qaDNxTWVrQlFFd2JENjFKL3lKaEE3WThtMCt6QkRnMjV3?=
 =?utf-8?B?OUpaUHE4QXpNcWd1RlAxVXFtTXhBZmk3a3JIUFExMTB2WE5zd3hILzBBdWhp?=
 =?utf-8?B?Yy82Z201cEdXQS8wMU5LMUIyQmQxQkZuaU1zdlliQk9KRDlONCtwbitoRDhk?=
 =?utf-8?B?NHFHcGF1WGpGQlBwQmI4Y3puc2RkZVdNdUhVaDViZDBrdWswWmdwa0pUVVJy?=
 =?utf-8?B?NWVqTnBXNzhkOTl5Sm5pMVJKYzJsQm4wdUsvZ0R3aW04dnFKSkdpaHhGd2c1?=
 =?utf-8?B?cndZNXN4RWpBZ1g4VWRFOEgzTjVqNFZBUy84cDc3ekJuWmI4MDlJYVE4V25m?=
 =?utf-8?B?cTRSemtqUUEzanRHS0lLVlVjdExUaWlzRjd2U0FHT3EybU1QMXR0TElUMXJV?=
 =?utf-8?B?OTVCTURreWl3aTRBOXNWQVBtVzdrZ0lmd0NWdzNRWHlqZ0Y1dWl1TTVOWHVX?=
 =?utf-8?B?b0hBY09FdnVmVFRRQThwYklFSzlPUHFGNW1YeEtaSFByMmpEcHdJVXVpOXlK?=
 =?utf-8?B?cjV0U25CazQ0azFobk1LUjlrcHhDY0FZT0ZTOU03MFdhV0tlbHVsTm5CM3Q5?=
 =?utf-8?B?SzhTOUJpT0FpK2hRLytaNnd0UzJhWDBIRDN6UDFYUFFJME5Oa3YvSnQ2K2Vw?=
 =?utf-8?B?eXlISDNNeVVUS3Qrb0pScjdMdEp3QVIrTUwyTUd0Zm5sV0ZOM1IzM3BhVHdh?=
 =?utf-8?B?K3dPdmMvaG1uU25PdURSc2NXK2ZBRjJLK2lGcGVwQm5BR0RIL29lZ2RGZ2Zz?=
 =?utf-8?B?ODZxV1hGQUN3M1JCYlhrRUpQSGprWGhFa0V6NzBYcXFHeklDTU92b1VlK09I?=
 =?utf-8?B?LzUvZ1VKaEVQSUVXbVRITXhXd3N6dGdYTG9PTnk4OXhFK0JWNkNKK2lzTlZk?=
 =?utf-8?B?aGE4S2JMQSsvbXRQUFBQUTJFQ1RNckM2T1o4ZG1tZDJnUUUyMUpoazQyTTNF?=
 =?utf-8?B?YUJMN1Q5MWVDcStkUE01THM1cHlmNTdISC90bWpLOUwvMC9HVE8reGpVY3Jp?=
 =?utf-8?B?c1NrR3lvbjVPOVdSME5pYmJENjd2QWY1ZEdTWk1RWm1QMXNXY1RGMmZDY0VG?=
 =?utf-8?B?eTRjWm5CSnM5TUlGMXkyZGxGWVB3cEtCaGNIaGhWNW5WOTJaVzdiU2pIUVpL?=
 =?utf-8?B?RVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	XQ/2h4+yPlDcybLGvsy6x2RQw7mNe8utbBlZmXNZJW5Uf3W68l+K9TUAAjYwRNGwPlqpXg4pImTRAlVt7XQlCeZoS4Ocx+j21aHQzJOo6aASjqy7OIZNxPiGi84Q2qfTkXQbr60PvCrEOtN0PB3GslrgJkvr5VvMeLwWuC60T/l/TizkbkLJh9wdSShOVcXZt1rlfR0beLVqzOOkdkHLSY3vdsV8bdY3uQ983WEuENGiEICjaPBLhqWhrpCcPmGPdPub9vp1f+diaCCJR4xq7PpLyNs/rclwN5a1sXJ6Wu57N4/tGdIEN1+0W9Debo6Lhil0wQnc3YixEshX8OkoEzg9onUNn47AXuaqP80nMnSf+8rvB0oSRx9eTzXwp9K35QPehTbsA0KESthWoRjquDjvxCidx3LXOsCjM2BdK67Ar70hDDfB7oK0zSO0e0hC/LJMIhSBFv7kwj7pJdlcw33k78zP8cvRtF91wsPi96gBN81CxVVhU0Px7Ky+P+bY7NV9oZw2bY9OHLA5F00Aozo8L5Y+Ect2z8f3+xFMvpQj0uUIDfjGZJVjsEA5UCKl0Yz5+NP22U5e9Fx1vQrGLXlx8DleLlOqseKX7P8hWMM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b593db-c736-40ba-6162-08dc6ec06148
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 18:06:12.5868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8beP/GMIhv4f9W9oC/ZTdRFGlut3juAzkRg2uFx1fLS8+c343Zu7JGthrgv4GW5d8YtzQfYySCnNtoFeuIqx1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5630
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_10,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405070126
X-Proofpoint-GUID: aLifSHoZIe8smT9ThtJrqRJKb_Y5kiIr
X-Proofpoint-ORIG-GUID: aLifSHoZIe8smT9ThtJrqRJKb_Y5kiIr

* Andrii Nakryiko <andrii.nakryiko@gmail.com> [240507 12:28]:
> On Tue, May 7, 2024 at 8:49=E2=80=AFAM Liam R. Howlett <Liam.Howlett@orac=
le.com> wrote:
> >
> > .. Adding Suren & Willy to the Cc
> >
> > * Andrii Nakryiko <andrii.nakryiko@gmail.com> [240504 18:14]:
> > > On Sat, May 4, 2024 at 8:32=E2=80=AFAM Greg KH <gregkh@linuxfoundatio=
n.org> wrote:
> > > >
> > > > On Fri, May 03, 2024 at 05:30:06PM -0700, Andrii Nakryiko wrote:
> > > > > I also did an strace run of both cases. In text-based one the too=
l did
> > > > > 68 read() syscalls, fetching up to 4KB of data in one go.
> > > >
> > > > Why not fetch more at once?
> > > >
> > >
> > > I didn't expect to be interrogated so much on the performance of the
> > > text parsing front, sorry. :) You can probably tune this, but where i=
s
> > > the reasonable limit? 64KB? 256KB? 1MB? See below for some more
> > > production numbers.
> >
> > The reason the file reads are limited to 4KB is because this file is
> > used for monitoring processes.  We have a significant number of
> > organisations polling this file so frequently that the mmap lock
> > contention becomes an issue. (reading a file is free, right?)  People
> > also tend to try to figure out why a process is slow by reading this
> > file - which amplifies the lock contention.
> >
> > What happens today is that the lock is yielded after 4KB to allow time
> > for mmap writes to happen.  This also means your data may be
> > inconsistent from one 4KB block to the next (the write may be around
> > this boundary).
> >
> > This new interface also takes the lock in do_procmap_query() and does
> > the 4kb blocks as well.  Extending this size means more time spent
> > blocking mmap writes, but a more consistent view of the world (less
> > "tearing" of the addresses).
>=20
> Hold on. There is no 4KB in the new ioctl-based API I'm adding. It
> does a single VMA look up (presumably O(logN) operation) using a
> single vma_iter_init(addr) + vma_next() call on vma_iterator.

Sorry, I read this:

+	if (usize > PAGE_SIZE)
+		return -E2BIG;

And thought you were going to return many vmas in that buffer.  I see
now that you are doing one copy at a time.

>=20
> As for the mmap_read_lock_killable() (is that what we are talking
> about?), I'm happy to use anything else available, please give me a
> pointer. But I suspect given how fast and small this new API is,
> mmap_read_lock_killable() in it is not comparable to holding it for
> producing /proc/<pid>/maps contents.

Yes, mmap_read_lock_killable() is the mmap lock (formally known as the
mmap sem).

You can see examples of avoiding the mmap lock by use of rcu in
mm/memory.c lock_vma_under_rcu() which is used in the fault path.
userfaultfd has an example as well. But again, remember that not all
archs have this functionality, so you'd need to fall back to full mmap
locking.

Certainly a single lookup and copy will be faster than a 4k buffer
filling copy, but you will be walking the tree O(n) times, where n is
the vma count.  This isn't as efficient as multiple lookups in a row as
we will re-walk from the top of the tree. You will also need to contend
with the fact that the chance of the vmas changing between calls is much
higher here too - if that's an issue. Neither of these issues go away
with use of the rcu locking instead of the mmap lock, but we can be
quite certain that we won't cause locking contention.

Thanks,
Liam



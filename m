Return-Path: <linux-fsdevel+bounces-32172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B249A1C29
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 09:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54264B210E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 07:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913671D3560;
	Thu, 17 Oct 2024 07:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Co1fgChE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eVHilfkj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDC81D0DCE;
	Thu, 17 Oct 2024 07:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729151871; cv=fail; b=VQgqkbaCveOP/XaE2bSAP5XTVML+qLy5heZjFNv/XIK2GZ4C6YACCRBaRycAZUTBjBJmyxdruDtpWmVwZsKOjXzHx0wd9hD1Bjvl1zYSTPyoHY1FcrHIg4EkSKWO5eNMTtWkktLGey/WPVoOYYanMu/JaBEccI5PCp1EYeLz0jA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729151871; c=relaxed/simple;
	bh=opXXFntkiYIQb3pUqUZDILr3IU2pRv62ZpBBTy8cMsE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F7Ryi+SXzQvBygUu/nAj2LrhxH3S9lexMm+5FkP+fUm//3SHjeQDTcS70rNW5e+CvdhoQYBpka8YEi+zE10DBUC0NiY4d3W1hVy6lOq5rDmRKGv4w44ASxC7B2e7F7P2SofRGAok8aslAwHuRhtvBYVy4sBlm0dpvaPO+In4EyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Co1fgChE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eVHilfkj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49H7fegv031840;
	Thu, 17 Oct 2024 07:57:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=sw6l1YwLNGaScWzfHEA5bPsN60Wyweat1b3iiVwG3zE=; b=
	Co1fgChE72XFwPC0sEqjLDIbD+rzp4DD0Wb4v9xw6ddoORi44LBgDOLEtpT5zTRK
	BmZN/XIy5m3tfV6ERsKzZbTx6K5JKik9NS8yX65e/QmOTdsESKK34N5A+M1k/iaJ
	vqyCQyJCms0gnWt4/H+oLCmPnFCpzGaC5JSRiCeMWaF1Qb/3WAhPaQCi5cRRxvHU
	x5wDWiG/gmhFQiOweSxaPbzKywxiiURFzNNGktHQPMMRz59yo6po7rv9KZgeY0SU
	IbyGlCFCR2wGCdm2a1X9ou/Go2UKDMJNvdL218YgH5L7MXbh9VDZpa8Cy/6P+E0u
	pXiwnGWTHUJRuZ/Vh6IoAg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427hntdphd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 07:57:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49H68Iei038773;
	Thu, 17 Oct 2024 07:57:32 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjganp9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 07:57:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gsr90SoaNxTE8lbdqzZwI6HhndoXtU7Ehm8SL7LaJbdeJdNPemi2w1KhhUrPiA9+YJh+ywhbmxf+aTXlkrDINPf1aOZqJvolP64veyQ1pYosqgLMmvVFd0TYrwSz128bEFBoBlFRQHN4qDqSf08n+l1pJLdPps0mwYfjfmRMzL9p3sXZYowQQr8gX0Jf7h+p8dTL6FQy69shhwfaFidkPauSm/mjPtjByib9Xw2xSJgLuamtkxTAWxqgC/denZK84SN+aLuRt25Y1hfHayqcwDhIKgdW2fghdXjW5dcVkU7KpUUdQf8JuTfmgXe/cRNe7Ccp0tdVRulavYQk1vCHAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sw6l1YwLNGaScWzfHEA5bPsN60Wyweat1b3iiVwG3zE=;
 b=tIlyJRyr3GRrMfnLftGTpaSU1P+jek8wtSCxaKwTOb2mfLj0FoBKMWaQsmXIIDmjHXkz4aE7iIoaHbJ9ELGZ1zQTV8eYhE4NQ7wX3cr46voaAVaIHrTZ+VUcWaUwXWTAI1/0mnvF9tbDV0HdxZPm2jJ1RrDLbtCiarT4znf6bjMjjC6BEZIEuYfwvYzaBBaO/CdNsOB93Hw9f+f2pckxR5A54Ua5FMTvquI3FIqGICaTznlaSE0kELiOhq6fxxkcrsgm/fXkoTpCViVyGFQ4MLw7gWjwzSJbQwSJHiW8PgqGUDj0I/Sf/aKcpeLia9sc7hGQAsSSbI5/b+bpOXDaYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sw6l1YwLNGaScWzfHEA5bPsN60Wyweat1b3iiVwG3zE=;
 b=eVHilfkjR4RV8NlfQoqJ8ZhDHI1hQvdgxhDji3l+fRE3sbCCocEsNC2rscHPhKWPXk7cSSiih3VzV3+ClgRBfIO+sJ9V7E7/8SsoYM+9tL9uQ0U5pt5q443zuFiesvhxrtGmGKxWFKplexq0KArrVEspO837jcYGd13P37UorY4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH2PR10MB4136.namprd10.prod.outlook.com (2603:10b6:610:7f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Thu, 17 Oct
 2024 07:57:30 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 07:57:30 +0000
Message-ID: <be4d6b51-30b2-4669-aca8-29263d7eef97@oracle.com>
Date: Thu, 17 Oct 2024 08:57:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 5/8] fs: iomap: Atomic write support
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: axboe@kernel.dk, brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
        dchinner@redhat.com, hch@lst.de, cem@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com
References: <20241016100325.3534494-1-john.g.garry@oracle.com>
 <20241016100325.3534494-6-john.g.garry@oracle.com>
 <20241016200347.GP21853@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241016200347.GP21853@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0050.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::30) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH2PR10MB4136:EE_
X-MS-Office365-Filtering-Correlation-Id: fb8dee1a-5017-42da-d080-08dcee81598b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHhZVlFSUU41Y3hOQW42dndaMFMxM2hIdWg1NStVNktnNWpsU01LblFmazJ5?=
 =?utf-8?B?ZzlEV25IU1JLTW5oVGxHbDBhQ29FTlUySGZXd1JxbGNCTUo5VGx2d05NRkUy?=
 =?utf-8?B?cTRkQ2QyaGpkTmFldUhPaVJ3VzI1VVZuemVVOTNuRnl1NFN5cTBISFlvSFJo?=
 =?utf-8?B?TFU1bkhZNXp2K1VpRGIzZCtPeXVlNHVlb3BYN200OFp3WVNnbnBUZmQ3Tndv?=
 =?utf-8?B?S25KQXJ5cFhCQktjc1ZMaWgrUVRZalZ0TElJSjI3ZFo1QndIK1pnOVNaQU1v?=
 =?utf-8?B?NWdRd2JFRktZWUJKTHUwdHovKzR6K2RDL0diSks2L0VOdDQxYmZlM0lwNVZq?=
 =?utf-8?B?OFdGMFNkZnhIUjg5WEFvWFZMeXZ0RzlVUHI3K0E0RUkwN2VwVEtTRjVsbnBV?=
 =?utf-8?B?VUxmREx6ZktZNHQyai9FOWtxL05ibWNqcUZIOFJlNkVyUXRaWXhDVDhhS3RZ?=
 =?utf-8?B?Q2p0aHVGaFZFTHh4bEJseEVjWkV5QUtBZm9mMUd2SXBzSnpLekx1RVAzZVVC?=
 =?utf-8?B?NHRRWEdZY0c5UkRlZktEN0JYcThaOEd4c1VWZmEyVUFudG0rditVNkNmOGlT?=
 =?utf-8?B?V25MdWUvOUlGbjl6aUtHYlZIMENQR2c5SFBicFJsNWd6aVYxSWhMdWxyKys3?=
 =?utf-8?B?ZnZMZzlwWjdKMnBxNHQrZ1pjTTZ4VGdLMmtSeDZCTy9DalZtLzlUd1JleVg0?=
 =?utf-8?B?dEM2My9JUlRuR2Z5d1dhMFNBNjBva0xMTmNiOTdYRmVkQ0liK2ZmTjBTTGxt?=
 =?utf-8?B?Uk5MRTRmQjYyQ096cjZWTmVpVmkwaElvYklZalF0dVpoRWhjamRWbTl5d0Mx?=
 =?utf-8?B?RTRObjltZ3UvT3dhTmZ4VmNKRG9QTG0yeHgvV0w3Y3lnZllyV2VmUCt5bkxZ?=
 =?utf-8?B?dC95MGZLbXhZRVlpQ01WR0R3Qk0rZHdnTDRWTFJrUGxxVU1qRmJWUVh5bWlV?=
 =?utf-8?B?MnYxaW9zM1RKTFhLVTZuVERoYzcwNWttMURKL1VVSStkbmU3eE85Y0hQbmN1?=
 =?utf-8?B?NUMwRUFTMWlBNjl2dG1PejM4N21WL3NwZjRMamFoeUhWVlpGU1BHNDN3d3d3?=
 =?utf-8?B?SEl4QjdIQmlEM2dMbklwK3R3akg1YnFiQXBuNHhKSWt1T1FaRnpkU2NyUjJJ?=
 =?utf-8?B?R1R0Ymxxek4vaW5ZRTdsUTQwMG5TeHVOV1FCblZZb1dONUFPMlNSeUxucXpw?=
 =?utf-8?B?TGd0eThUcmU0dEVrRW5PeUNnWVJXc3FrbTk1S3pOeC9Ia0ZXQm12OW14SGRj?=
 =?utf-8?B?ZExIWWVJc3lZOTR4T0dReS9aa2pRV3huRmlrbHhCM2p2bG02cTdjL3hFMjkv?=
 =?utf-8?B?QmFsYXFiWXdxa3FSbk5TWXAxMTJOc2V2Z1VqOUJlZU5aYWlFRG94K0Y0SUU0?=
 =?utf-8?B?ejlzMDRUK1JIZnJDL1Z0RXZhUmZNczhyK2c0VVA1MVhBM00xWVYzTU02U1VI?=
 =?utf-8?B?Y1hyZUpBb1dMbHVlYUNTK0ErR3FLOGFlUGlONm1yVTdzMTk0WXZhNGowY0NC?=
 =?utf-8?B?ejFmK2RuQ2w3bHJUbHFER3hrUXlhK1FuMGFEUTgzc0Z6Mml2dFkyYi9CdHN6?=
 =?utf-8?B?aTZBTWxEOUF3TmM3OFlPdmZRNENsWVI3RHh1Ynp5YUJMNXV3dHZhQUs0YW95?=
 =?utf-8?B?bVF0Ym9WMm10YnZSWnZHVjkyOVl0b01JV1ZBa3ZsRTVlWkk4dzdldzEyK3Ru?=
 =?utf-8?B?T2FnNEFLTWdIbTc5elplZEZ1cjRWYVNoNXNwakZoUEkrdEV5bDlwVFVWL2JL?=
 =?utf-8?Q?2KjcVawAtv6NvM7HakiQrg8ooLIaR/ZW/IE5uVP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHc0NnFYM2ZrcDNzVHlqbHRMTmtiZ3dpV2x4NndFd1k1cFg2VUpjUEFlWWt2?=
 =?utf-8?B?K3pDSVhPRjY4bDkySkJDQ0o4Tk81ckFzSmlReC9qZTc5cEgrQytUSk1zLzVX?=
 =?utf-8?B?ZFlPcGR4ZXN5V1RpVnVQR2QvNDNhRWhMYXA5bUJoRXp4MzFvUmZwTnlKL0lh?=
 =?utf-8?B?RXZ3ZjR6eDh5MDhNbGxiM0VWTTNXU2Vicm9nT1ZOMS9mV0lBUUdiWVZuYkta?=
 =?utf-8?B?Si9zVFFjZUJpdW81SnFJZXREWTFxaFQ1Qng0SXNQVEUweFhZSHVqWWhvVll4?=
 =?utf-8?B?SkltOFNGb2gxbDNuT0ZwKzRLaXNjTk9ZNTY4aWdwZUNCUFBIM0FrYVpuZkF3?=
 =?utf-8?B?WU8xWmttdVdlYTZuWjVMM1N1SndBaWROVHlaKzF4NURraTM2eG82NkplQUxo?=
 =?utf-8?B?aDVDSitkWnkvV29FK2N5UEpqcHVSRlRUNVRYMkI4SFJNb29wQVVPTkFMNC9u?=
 =?utf-8?B?cUpicG5JVDZaakt6SC9lUFVlVWQ3R3YyWWhIVmRwNzZHSEFCblB5UkFqd2ps?=
 =?utf-8?B?SEcwSXg5MytHNVNLNzZvdDROL0s4VGJLdlkwRmJXY21pTnZwYmVKV1p5enF1?=
 =?utf-8?B?YUFSS3V2dXRxZFA3UzE3UzBwSWZXb3Rram5oaDRTZnZSWXE4MzVINm5Lc0d4?=
 =?utf-8?B?d0pNbThleFIyNzJ2RVVjYlIrM3VDZ2JEZXBnSEFEdmZzWmFoenpMcWxOMlB4?=
 =?utf-8?B?L01LUjdXWE1pZWxrVURZUzdVclFiRTlTdmhBSDR4cDRhSVlOZEdwM1hKcWh4?=
 =?utf-8?B?WXgwQUt4Q0lrRldPcUo4bnJKdWZ2QjY0NDVlSm5YNmJDLzF3NUdXVThHTFlW?=
 =?utf-8?B?VUM3ODRub0ozZ09JRHRzYnBWM1phNFJaZGhURFFLWU5uQVB0akNkTEVsUU5F?=
 =?utf-8?B?R01sVFdWM01PY3JUTzltVytjMmFHc09EQzBoZTRtOGVKT2dyVkdRcUpDMjZG?=
 =?utf-8?B?MUJiK3dYNFAxZUltN0tXeHBDOHNINU9oNklEWnRLWlAvcnl2N3AvVktDRTA4?=
 =?utf-8?B?RTk4THp0dkM4VjZESTFVdUQ0NUVnWjFLazVlYnhIUUNPTWswNmZBck1NVXlH?=
 =?utf-8?B?cDlORzVWc1ovRDIyQTVUMFRTQjZjWU9MZCtCZExrRFY4ZFM1OVRKNTNHUDBp?=
 =?utf-8?B?VlA3NVcwa3lRekVBNFVWNUhRRjdDSnlPanhhY25lWXpRdjFnTHFwbksvdUhy?=
 =?utf-8?B?TzZsNHdBb0hCOTRocXpEL2NqL003N0tMSFBiM2pLbVlIcHpiQXFabHBGR3VX?=
 =?utf-8?B?Y1U2M2phbGVDVnhRelIrYzlKd1FnQ1hrZ1laVXJBTk5lRVlQSEI5QU1YRCs1?=
 =?utf-8?B?WlpmR3p4dzZLSEhuY0NSYk9YRFIyNVpsdUV6MW00eTlLWVdabktKekd2Nlha?=
 =?utf-8?B?QWREalJGZm1naDRZQy9odEFmMDRrWEdxSGt6U2dVa1owVDJDVHoyNVB3eFRw?=
 =?utf-8?B?VGtvU2NycFZYM2NZVi9Ob0RzT21MOGNOWFhhSk5yUWVuQjFQd3BhZWliSlZP?=
 =?utf-8?B?M1hENEtQR2RlSHFZRXVxQVZRNHhMVHN0R3JGb01qNyt2VkwwUUtkQTlQRXhX?=
 =?utf-8?B?K2VZSXZnYUlocDhHQklFT292WHRlbkN3L1RLZXNTY3FiREFiV29sMDlZa1E5?=
 =?utf-8?B?N2piOVBrTE41alNadlZ2Y3B1bFlKbkd0SXdzZU55ME50Y2J5NHI2bURwYldi?=
 =?utf-8?B?d29Id05tMDl0M3ZLOE92a05Bb0lEUlBuajdpV09Ob3BrV3ZqdVZhenZFbnNE?=
 =?utf-8?B?dmxXNjBFK082d1J1cXVGWElGVExiYWJBc29tZjNRY2phbW16WU1heGRySU9S?=
 =?utf-8?B?RGxGL1JTa2taemZEUWU0NXZlMzlYWEpKNVhzbW5nK1BWRXVGS1pWN000REVO?=
 =?utf-8?B?U3FjOGZCVUlQOCtRUFNHRFNRdzRkSUVtc3YyL1Ura1NYRVpoWS9OOEh2QytC?=
 =?utf-8?B?UUs1RC9QVVRTaFhieVdRKzIrczcrY0RTb1RNR05QUDY0RVZRMWpZOVVmMm5G?=
 =?utf-8?B?eitoWE14R09RMzFjRmpBVEVNejFNTkNkYUd0a2FxeGxpMUZHRmR6ZUxLbHV1?=
 =?utf-8?B?Qmwyc1RObDNFS3E4NmlGaFlUazYxbjkwa1h1RGdkL2J0M2h4MCtqTGlCUjRU?=
 =?utf-8?B?enlMYmthVFF2a0Z0UVQyOEZkbGtrQTE4OFRSYU9Ib1lKM2FSVlcyUmRoWmMx?=
 =?utf-8?B?TVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CM40EXhBpfYrIgMYx/nszXOaBWjpYPWFpUcqwtpdTYD37gPWVno6py8k4hZJj6Bo5phwtFEvpJT3Rzy48tIUp1wroi5ysdMrGyBBTSklijr2fb0OTmHa0E3XD/NJsqLJ7VWoHDHZlmEPspBHQF+Lov9OkjZkPrGf57HvBeaet9YVTB8iZefGPSHNtw+LVddgRiMqT9rKzkqU0qyewQWVQImNByfMKjEyy1z5OIQhgPkCC+CTqAN2QXly2bEn1lfpT39loNOO2ykfanTqjPrkWzAk5uiIBrdh0u+A4Kdn7KcNQigVVweE2tDQKgotLizQdKVsQyAYBWMTZbDWIVj8ofI0wmokC1u2swbHKux65aHjmp7CGHOsH96/zHbA11mq8LD3jICUC+MAFIZJt1go6rsYeXGk+0jEIQm+U1RFBfuIEv2VsrIOc5Dq/hIdD/iW9EbnMCflxyYy+63X8xU9S80XFsyQFws76teHagmwec3T+hdVs1sFeQpCnhrCUoPH84CHU/X/lNxHVPPT3Fmc35g5r5secAZgnogFDOQubNx1zirmYtcwA085MzVXGAQ4GA1B48itHUefjzyhKaLmZ1L9zQ/6UqQU3d88ruknHuA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb8dee1a-5017-42da-d080-08dcee81598b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 07:57:30.2575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jOcU7d+OBIulagipB8YCk/Ot78QGq3z7sM53WAD/GacYOd2On4du9HQO34wOh4wOicWUQnSLq8z4PvIkIWulzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4136
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_06,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170052
X-Proofpoint-ORIG-GUID: _J-DfTqkPzY2G9EbBrDkH0KBI0pbqIp-
X-Proofpoint-GUID: _J-DfTqkPzY2G9EbBrDkH0KBI0pbqIp-

On 16/10/2024 21:03, Darrick J. Wong wrote:
>> diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
>> index b93115ab8748..5f382076db67 100644
>> --- a/Documentation/filesystems/iomap/operations.rst
>> +++ b/Documentation/filesystems/iomap/operations.rst
>> @@ -513,6 +513,17 @@ IOMAP_WRITE`` with any combination of the following enhancements:
>>      if the mapping is unwritten and the filesystem cannot handle zeroing
>>      the unaligned regions without exposing stale contents.
>>   
>> + * ``IOMAP_ATOMIC``: This write is being issued with torn-write
>> +   protection. Only a single bio can be created for the write, and the
> Dumb nit:        ^^ start new sentences on a new line like the rest of
> the file, please.
> 

ok, np

> With that fixed,
> Reviewed-by: Darrick J. Wong<djwong@kernel.org>

cheers


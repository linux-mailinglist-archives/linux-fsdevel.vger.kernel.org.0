Return-Path: <linux-fsdevel+bounces-43588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BDDA59183
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 11:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACFCC3ACACE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 10:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C28227574;
	Mon, 10 Mar 2025 10:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X19LS9Kr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="f683MFxj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCD0226CF4;
	Mon, 10 Mar 2025 10:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741603505; cv=fail; b=KFjfwiXdNxve9w4BnbC8LUTQua24H538OAqx6y2thBbjV+Q9x1hyfFquQRCqGftvmAGYJaNycBlL0ZTtDG8CEvZdSBCq7s4tYmb3x/JgOb2M5c7NzcuxKFf6SlbxiUQmAtc8LboBKvBnVhveRDbLHsM82MBYjSWFTHhSEfFoqqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741603505; c=relaxed/simple;
	bh=mFPfFpkn3bqb/nC9WzPt7TAfcU1pDQpC9C8iOIglmww=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Yzg79WdPQeeGQaLkExSuECe0IsGs4FlXMchd3kAx144oDS132Q2oxJXWaNdJs+Odt8KYdFIKo0sowg8VPhYDd3p095o7JfHE0t53goW+KPrJ127hCYbILO31c/KAEvdIUx5CnhCpCwG8nHLUeqD4ufoSXcBQTAlCrapgrlJLQjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X19LS9Kr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=f683MFxj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52A9Bg5a027593;
	Mon, 10 Mar 2025 10:44:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=CPfu5NMvn4G04bXBkdvUiwOPXW1KH8Nv8owX8YY5jmg=; b=
	X19LS9KroMSLlt2wjjbRJcDGh0YsYctSBVSTnpjoYHxAF7r6FTwraJwOakSc4yqw
	Bc3X2YbqQFMZXXWUGERL6CW1DRlZ6XcAUDa9r4hjOCfD6WevLavOYOmuyQHKgime
	pUqjVn1B10qPhnC/gq3RdxonPCJS6nBjTlSXm3xyF2o5O3M7EthEwlNkzGv7uxvy
	IUfcqBVaRimNkQEdsIufISOPrMIK/RtgIF7SV/VBIvQUpra+D7tR5CrCc1g6+oDZ
	Jggk/0oJaY3thzaHTVjODOrUpUH90VqxA2ufvI6Wy535SUW83Dk998emDw1Sy0Wv
	AIG89EAL4TM4H4woKkHF+g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458cg0taen-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 10:44:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52AAcGCs019322;
	Mon, 10 Mar 2025 10:44:52 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 458cbdw792-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 10:44:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wk1bvZ7M/kTzDQ+DjgPHanVFe0+85WrAMsA9lcTCp0xzLNE5sMWpYj4fLSqWDXrDbUXS3TZ8nhyKjaAuDulwO9oJztKSMUZoPX9avskFFNdF9DrG2reYhEAbA/X0z7bMEr1kMJwaVCEQ/I7kNyEpm1fW5VgzuzI5giNtZ6hBK1l1ddRtEYvwO9Q23k1xz4KoThtgu1M9NK4R3QBCWo5gZFWs+T4gpENktPgbZ9K1WFywws9Tq2C7Uon0Zt1W3TzbVNOZMXCmLodrTubqbl1E3VJwK3E4rU35MHFCgbav1OyDERo4YETYzgVW0v912Lr1Wn12ZCSIjcUKBuoFNP4TzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPfu5NMvn4G04bXBkdvUiwOPXW1KH8Nv8owX8YY5jmg=;
 b=trzpK3JORGjeVc9f1e8BVl8zSpnHroVGrdnqnyudSSVfdZre8Q9CC1as4IWAh4gjHQohcibKpGzqgp+SyskdD0aQVttb0p45KlEoX13l5VtMX1ahJS7LODMkXNfezSByFSjnXjn5IoMQT1zOkQ1PcQRfmvzE4mVtANSloNMGq9avDTqBGqpmbp06VBKzZU/kI1phem5E//GlCS2ZrHiIkUXLfeFeYZ6FTJVGW6uCCL9+Rz+/d/59K9HnWu5Seeljfyx67Zv6QXr2uWtpWwCFze45mRVE9wNRsHOT8Y5WtVULmMnV+pqsTdGCPAIhC6hvr69veC0vICAsD8HrERmIrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPfu5NMvn4G04bXBkdvUiwOPXW1KH8Nv8owX8YY5jmg=;
 b=f683MFxjlKpDPtcjOTgnqxZ+UvFJZJFFFTATY59hus+pH75d9firn3uazpar8PE8ty5E5I8znFSoxeVkllt/hw2SIbpTMhUDhRQsg572EE3PoAQN7l/l7bPhtyEAu9FluQtYWCLen8UnGTrdnNhvmeA4lp0YxpQjD9grd4h+2UE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM6PR10MB4362.namprd10.prod.outlook.com (2603:10b6:5:21a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Mon, 10 Mar
 2025 10:44:50 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 10:44:50 +0000
Message-ID: <4da6ae74-e431-4bc7-82f8-a621bb8905c1@oracle.com>
Date: Mon, 10 Mar 2025 10:44:47 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/12] iomap: Support SW-based atomic writes
To: Dave Chinner <david@fromorbit.com>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org
References: <20250303171120.2837067-1-john.g.garry@oracle.com>
 <20250303171120.2837067-6-john.g.garry@oracle.com>
 <Z84NTP5tyHEVLNbA@dread.disaster.area>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Z84NTP5tyHEVLNbA@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0093.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::33) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM6PR10MB4362:EE_
X-MS-Office365-Filtering-Correlation-Id: c1fc2103-3a5e-4a82-5dd9-08dd5fc0958a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dnZvcytnZTN2OXdoRWNVL2J5alZ5RFFTZFMyN0FOdk9PZHROSEYwS3duUU9C?=
 =?utf-8?B?eUkxRHNRRExTY0xqUFNLZm9TeVM3Rlk5SDh3YjhVRjdlQ1FxMHhRNXNnb29E?=
 =?utf-8?B?ZEVzdkI5NXFUTkdHWk9xN0JmUnNOT0ZYQXBCNEFkTUQ5ZUhnSForRlMwV1U2?=
 =?utf-8?B?MXFZUW1CZFl4MlV3V1J0a0JEVW1iWjRsQWlBcU9ONzM5ZTkyQTlHREtiOTYz?=
 =?utf-8?B?NjhNVWJqcm9qYXNGekRaK0NUbGQ3VnZnWm95aG11bkZHMjk4ZjgvQ0xyQXBT?=
 =?utf-8?B?eW9NTmI4M2wvZFNCTjJRZDA0UVZtaGxpYWJyOGdJQU9vbHBZQ1gyaUZrZUc3?=
 =?utf-8?B?WTNsMG9TVElPdEpjWDlpWnAyRW93UGtaOXJENHVUQkQ5V2U5bGNQUkREU2d5?=
 =?utf-8?B?WXgrWDV2bEIwNW8rc0wzUU5SYmxwWHVQTFpHK2lRYkVQU1Fjdmo4UHJ0eXJB?=
 =?utf-8?B?cVhmZEQzTitaM3VTZThNVlliSXBCRU9Ed2NuRXM0VVdITHE2cE1qKzJJL0N4?=
 =?utf-8?B?ZEtjTjNYU3hveGlBVXVlWmIzUDEzU2ttTkdZUDNjYWQvb2UvT044R2ZxU3la?=
 =?utf-8?B?MytQWDBWVC9RWG0vRkVCdDBSM3NSWmlZclZMWEMydHNyYkV2QS8wOUQxS0wx?=
 =?utf-8?B?S1plZUs1Z09Vc0xENmQ0dlFJb3AzUVNqQm5iRnV4Z0pjSnBUSlYramRUbEIr?=
 =?utf-8?B?bEwwajBtZU02aVI3NTk2VWFQeWcvN2RPamVXeFlLUjVaZE1SbmdhK3VDSWM2?=
 =?utf-8?B?Y21kVzdnbUFPYUZFVkNsMEZaSVFSZS95NXA4S3FITk9kbCtkbHRpOFlJMWJP?=
 =?utf-8?B?MDFlT25iM2ZqY3R5RVBacnhlcHlhOTRQbHpzZ1E0ZHlBMFZ4SEdKVXBNK3Rn?=
 =?utf-8?B?dmxlRmptNXp6a21VWnlESGVwUC9jdmVJZFd5NE1PYXRLS2lRN2dtN0VVOHpz?=
 =?utf-8?B?czIrajlmalNMcEdtRVJBS2pSQkc5bEQ2alN4REY5blIva0tyQnkzVmJKdTkr?=
 =?utf-8?B?QnVKayszemt0VUxiRzdzdHVkUEl6TXYwTGY1MWxuY3NmN3N0eEs3alNSU2E0?=
 =?utf-8?B?U3pDdS90WFd3Q1Q3QlRPYThmK211eXRNa29BY3BqTWNna1k3Nnhnc1JVa1J2?=
 =?utf-8?B?dHF1azlYZUszOVkwTHI3OE92YTlDY3JoQ2ZPUVdkWmR5ZXFGOE1yODVaVzZl?=
 =?utf-8?B?ZTduRWFnWGEyRGNwb0ZmNGpCNTFDYVdka2xqWFNnRU43TmdRS2gwdFFRWGYy?=
 =?utf-8?B?VHpnc1pacUZCeEZaV3RWWm9CZ3JMLzk5UFY0K2UzbXdlV0JCMGJIbGs0S0dZ?=
 =?utf-8?B?SFJndFFRWlpVTjJOYzRRNDBvanQzVENTdE9EdkM0dzkwRXBodExlN2VUczlK?=
 =?utf-8?B?K1lJcEtzNERRaUxLMDZRUXd0QUpPTml1WVNnMmFHSXF1LytJMlk4VDNWT2wv?=
 =?utf-8?B?N1FLYnZ3dUR6MWN1S0tmUkpKZWQ4Rm00dXdNYk9NbEtPQmlTL1MxcHFZOW82?=
 =?utf-8?B?bTdaMDlZb0ZYVmUrd3EzV1kxdzBEU1ozeC9heUZYeGd6dmlPMkJBdGRxTjQx?=
 =?utf-8?B?OXZXamF6VVBqT1lISGdGWmlwZnZOQXJnSGZFQ3lLVVBhWTBuejJHbUJVb1JX?=
 =?utf-8?B?WXROME9xUlh5bk5jOHhjUWVFbEhCd3lvc0I0aFh1MHUwY0gwS2RZdkFicERu?=
 =?utf-8?B?TTVvd0hsM0tHbTcvUkNBYm1RU0VZOGFtT09DTzMzWEQ3WG5QWEt6dVdXSStl?=
 =?utf-8?B?aWtQZE5NcDNNdk44aUxOZXZpdFBPVElxd0RGVm41VUFuZEJwdnpZcGczUHZq?=
 =?utf-8?B?MHJTUkxFaUhEeEZqa2N2YlArNTJMeGdoRHpadXhEM1psb3gvVUxKMUM5Tnlr?=
 =?utf-8?Q?j02+wKxR0pivQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejNyVkdkWWtiRmxxYlN0cVhtdGxxWWNVTnkrSkQ4eWQ1WGJ1Zk9KT3pWZ1JP?=
 =?utf-8?B?dDZkdldNc3ZoUzFKV2tRTmozZ096cHF0dXp3U0d1T204M2Y0Vk5yQlE3RGRG?=
 =?utf-8?B?YlRaMmZCWXBDZVQxa0tvWHlzZEtlem9TRVEwaHlkeGtad0Z1VytySHBGYzJB?=
 =?utf-8?B?VU5aRnpSRklSTXE0L2pScUpmUVlVbVcyaVc1Wlc0S3p0blVKNkJmVzF6M1BB?=
 =?utf-8?B?RysyOTh5aWtzTzZSZ2V2bGxGdGRybi96eG8yaG91d0h3bWR4bE9qV29oaHBh?=
 =?utf-8?B?ZUdCMWV1Z3pIV0UwV20zZkRaM2RoeFJJc0txT2hROVNQYUlVSmhjVldBc01E?=
 =?utf-8?B?bm1IUmtVQ1BjZzUxeWJaNnNXVzEzd3puSHQ2RGxDZzdtV1laTHdnWkM5UVJG?=
 =?utf-8?B?czNyZDVMallRQVZNMmpJREFJM1kvUkszdWRHY3pzK1VLcWRLQ1BBWnErZXV3?=
 =?utf-8?B?REJGeitDMWZKRCtyZGpaUVR4Rm5nQ3dpSjNvZlB0NDRJM25VaEZkVExubmli?=
 =?utf-8?B?K25IcG9wQlZqZEtoWjcyY3NwdWp6TmV0RnJlRlBES25nRHJtY0o3QTBqNlNw?=
 =?utf-8?B?VkNSY1c4eUgxMzZHZkNFKzRPNHF5QTcyNkdsMnNudGRCRVdwbkJ3TVA4bGV4?=
 =?utf-8?B?Z0ZoWHMrWjF2SVB5a3JOMnQ1ZTdWeElRTVpCai8xMWl3WWdkU3Q0a0RVZjBh?=
 =?utf-8?B?REVnSjNBTW13Zlg5ZFNITWZEVTVCRmF0WUZqS2crZmZMYVpmc2hNZVBzajV2?=
 =?utf-8?B?U3JYQUpFdWtmS2tHV1FQTnNvdUM1OU5KQlVrQnhEWmVOQmpnVVZac0ZxRmgz?=
 =?utf-8?B?Tm1VN2pUQUdKQmYxOHowWHhhUTlYcEM2bEZYcHA4UXZVNEF3UzhLOS82Ylhm?=
 =?utf-8?B?akI0akJlU0crWHFvVXVQdVB3SUlOU2JDZllXV21IY2JlTDVVYk1Rc056YWRC?=
 =?utf-8?B?Z2UwdzRkRENkRVdqTTNKOWN5TnV2Nm9MWVphSkdDNk96MG5VUEt6M1MyV2JI?=
 =?utf-8?B?b3NYMm9FMEJRRVhTNE5oaXFjemhEbmJPY2Y5d2RET2NrOVdNSEZ6aEJWZTI4?=
 =?utf-8?B?VEFxMEJGdHJLZGQwTDQxZGRwV25iT0JaMFk2bXl5OXJ3cWhWMnF3NUM0NUdj?=
 =?utf-8?B?ZXArQmJQSEV1S2tZTi9qOEtPL05yNVFNVitqRkZubGl2T2pFWkc0WXJ4cGov?=
 =?utf-8?B?a1VGR0dsT3RYZGtKcVZXRjBxbU5LWGtiSUY1Uk5ubzc5K1c0aFRkSU8ySUZt?=
 =?utf-8?B?SlNyNTBETnV1YVd0a1BvNVMycFo2Qlpzd0NrMklBUnZIQ0FwdHJNSEh1THdV?=
 =?utf-8?B?QjFsM2ljaGVBNXh4ZnkwaFlLV3hGOS9xM0w3RDBSdi9KOW1XN3VQTUxzZy9G?=
 =?utf-8?B?Z1VFSE93MDk1TnhENmxMWGphengzSXQ2ZWcvK1AvYmw3UzVtakRRYnYzMFgw?=
 =?utf-8?B?SzJVOFR1NDZ0c1BSWEhsWHZRUzVCN1lsWUYrdjBUTGRKVys0RVZsbDFFMm1X?=
 =?utf-8?B?MVRaTCs4WFBZOG0rVi8vdWRSVHlOVXRrUjRlRHZOV2RxdjE1TytyQ3FqSHpV?=
 =?utf-8?B?Q05oY01sa3BVU01yTzQ1WVd3TFRxdmNpUXJCVHVyWHFXV0hxMk5sSzBvR1Nj?=
 =?utf-8?B?b25QVFQ1bnppTzhDeHNqRHJWK0s5dnFscjUrNjRoRFR6b1hrZmtVbzFJWDNX?=
 =?utf-8?B?RW9PUGJDdk11RElwYW1QMzFzVlpLcmYzazlIbjVZeW9OVWtWNlZnblZsUldZ?=
 =?utf-8?B?QXBUeVNETDNtVzVMekp0dFFvYVBvUU1ub3V0ZFhLRXRqakdnZUpWYnl5MVdy?=
 =?utf-8?B?N1lURlk2NTQ0dk01K2V3eUFWRTJab1pFQTFEMFhOVTZtbkVtcHg1aFN6RC9V?=
 =?utf-8?B?U1NPRnpFK0hDZ1JCbFlIWnRkQUE5bGhBR1pEUDNNUWptUHN5aFNObkMxcXFB?=
 =?utf-8?B?VWphS2owdStsSVRvOGgxVlhOcDRmVUtISDRCVjBKVWhxcDZYSEZiWlMzSTBB?=
 =?utf-8?B?dTRaSko0S3F2K1NleGJRWXdDL0JEWCtBN2hrOFpDQ1J3d0hTcE9iY1MzcnBQ?=
 =?utf-8?B?NHBTR0dVQkJwN2dvV3dYaEtXa1lmcE9UU1hFVklRWFRVZTdrMUE3ZGErMjdW?=
 =?utf-8?B?bng0MmIydGwwcEhNYVNNUnRNTGs1WHAyZ1VLUjNJRjlaSWpwRFNaVWh5SnZy?=
 =?utf-8?B?dUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yiOK+hRhPWCOp8JabK9ypiqUwXa1w88ZKFx4q7crlZxVFfGxnoTpaU7o5hh/ncMyPxLzq7A9Z5WHo1gqdiRbs5HRIIiL34QM8QW2Twh05PoosQ2oZDs575ds9lsVYtatGmSsrvoZRZ5gvADif/uPD7qE8tgc0qRT7OM5hbcuV8t7cTDQrRKSMeUzSBvprJObPE4PhbVl5nnfgwHw4C/72bSf/yMsjroaRrTjBrHzMiBAs2vWbtbN+Pr18LU7DLWjh5W9kazlTCFbLD7qje6KXv/n7xqfy/ZfvOOnBXkyZZaW9Zi5Ow/OQZ4BWqTvitUs4AG1YOT99P8yGvUb7eeTUw6l7g2MQCXQy7EIpuXjQjSJhaYB5moWAnzgbQzGfzJ3HQiZjOgV/ZCZm95251JUZqFYwp2wTIUdmeHpgKqFRMz47pmBvNFSK2IkGpGstfUhBqcOtF9etvlhIzjUlBI3EvZylmClmQNsbFVwBdR1dP9gFAm0Ys0Ist6/jVO0NOlXXSRlNqA9f5pFAO2r8Yipd+4VKtbZMiW/2bWOZuNSKNHLllg6Lsosm2FrSQWM1us57eoZqv1D6+ab8Ck/QsHJd7LLnfx7Mme7+ZrFXobLhos=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1fc2103-3a5e-4a82-5dd9-08dd5fc0958a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 10:44:50.8167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YwVJEQ7DQVSDdcvXKvuh7TOMoLXNhoJbmly+IPtOwiHb0so7VUIcD8VZceSgdGnojjWXeM2SvRNPjZFFE7JSPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4362
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_04,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503100085
X-Proofpoint-GUID: QhgGFwgwcMiO2Vtn9aXap8PdtLkI7qeJ
X-Proofpoint-ORIG-GUID: QhgGFwgwcMiO2Vtn9aXap8PdtLkI7qeJ

On 09/03/2025 21:51, Dave Chinner wrote:
> Mon, Mar 03, 2025 at 05:11:13PM +0000, John Garry wrote:
>> Currently atomic write support requires dedicated HW support. This imposes
>> a restriction on the filesystem that disk blocks need to be aligned and
>> contiguously mapped to FS blocks to issue atomic writes.
>>
>> XFS has no method to guarantee FS block alignment for regular,
>> non-RT files. As such, atomic writes are currently limited to 1x FS block
>> there.
>>
>> To deal with the scenario that we are issuing an atomic write over
>> misaligned or discontiguous data blocks - and raise the atomic write size
>> limit - support a SW-based software emulated atomic write mode. For XFS,
>> this SW-based atomic writes would use CoW support to issue emulated untorn
>> writes.
>>
>> It is the responsibility of the FS to detect discontiguous atomic writes
>> and switch to IOMAP_DIO_ATOMIC_SW mode and retry the write. Indeed,
>> SW-based atomic writes could be used always when the mounted bdev does
>> not support HW offload, but this strategy is not initially expected to be
>> used.
> So now seeing how these are are to be used, these aren't "hardware"
> and "software" atomic IOs. They are block layer vs filesystem atomic
> IOs.
> 
> We can do atomic IOs in software in the block layer drivers (think
> loop or dm-thinp) rather than off-loading to storage hardware.
> 
> Hence I think these really need to be named after the layer that
> will provide the atomic IO guarantees, because "hw" and "sw" as they
> are currently used are not correct. e.g something like
> IOMAP_FS_ATOMIC and IOMAP_BDEV_ATOMIC which indicates which layer
> should be providing the atomic IO constraints and guarantees.

I'd prefer IOMAP_REQ_ATOMIC instead (of IOMAP_BDEV_ATOMIC), as we are 
using REQ_ATOMIC for those BIOs only. Anything which the block layer and 
below does with REQ_ATOMIC is its business, as long as it guarantees 
atomic submission. But I am not overly keen on that name, as it clashes 
with block layer names (naturally).

And IOMAP_FS_ATOMIC seems a bit vague, but I can't think of anything else.

Darrick, any opinion on this?

Cheers,
John


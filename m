Return-Path: <linux-fsdevel+bounces-32863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 634A09AFD31
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 10:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84AE51C2307F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 08:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14F81D2B3E;
	Fri, 25 Oct 2024 08:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rjg6mHDp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UAb3FjIx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECB51B6CF6;
	Fri, 25 Oct 2024 08:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729846392; cv=fail; b=HkFAORsCvDofA3lr1B4AjeoiHY0bOWhkkgWjKoDMjTx5VEP4nT3I+VsL2tvwBTcT2LFiZwhE/CEOhwU3PKd+0/8r9F0Y2C8xpKfkAOE9smg3CIVMT4ZJ+EFDHCm7AxtVMvlnUeopjrKuH3pu4phI9L5g669tXedfUKLLM0U5iw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729846392; c=relaxed/simple;
	bh=/BJGOw2MDmMJYV5j4yU+ydS2YL0uEwFFtm9a8XOvuf8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AK2M82bJxvm3/GupQSRzYfveId21FL7q1K6xz/xeCtxyAvs8ZjEyAxvmpLXpIxVZYOkfgvMbL3nk/66ukTVohvldyZ1Tap3T7XPefOOCIMubOE5B6PFwUV4cOsF0d+QkFEQRObdScoxbhL53FEITaoIu0DxEHfCl8UaVgXh2mpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Rjg6mHDp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UAb3FjIx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49P8Bjb4009872;
	Fri, 25 Oct 2024 08:52:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=JFdc7u6+G5A1tc2Tdvv6qX6gBZshUGcH65T07yZKVAQ=; b=
	Rjg6mHDp12IS2XW5Iu7A5gAsQ5b5JhLoSiiyFUudmH5Hk4h4jLJwu9KSf6OI02aI
	k1VyHu/ecavt2oqQclc/Qg9+nD+hFIzlj9+C4K0MOQCwSjuoS/6Qqm7TpCkDwWW2
	KLFgaya21XT/1UKIjYm3dxwFZh98bCc7F7tDGYgQrA2XtkSjVlukIsXE/+ozWeqT
	otBSlWhwxnuSNd2vyA0vcdFcykYGQxLtc/Lvj3NUsh5QL85rC1X1qz69qNtetdJK
	Jqy46iB4OLTs4DsEIM5is8GyjClUPWmQWIE2gTk7kJ0bRn4WMJyl6qD/Cim8TSm8
	Od7cc1vp+q/+Y+/4Vnk3uQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42cqv3kkh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 08:52:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49P6kHrN018552;
	Fri, 25 Oct 2024 08:52:45 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhn4f2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 08:52:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZutWsM7zEsTkIOeQwl52EPk8wi/Uyh6d7KspAHRaKHilNWMKIFtu8P2XBRKXdeT7Lp8jc+fEiP78KCJePhIkKPKltIU7h0S9xu1R7zjwQFRfDCQ6r6VpZTewCPFLUCWdwhII4MNPgURfVSMo6fLMM9unjmcO9Pe5RsDu+GhIf6Iw5UPiodW9hY0iHKUGNTmT/ACbGcv/mf6jCihFedkzbhbNCHGMF8/vZHS/hG99nRCzz05uMl/jCmwGQSA1gEZqqteIUAFY0cH66fhBiFJDCAc4EHV33fteetJ87EgyNvTB86swlqZ7K9ATNeRXr0j7pOcYqJYcMI1PTFeEWPdE4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFdc7u6+G5A1tc2Tdvv6qX6gBZshUGcH65T07yZKVAQ=;
 b=BQknTq7yDjC3i+slKDioohRCtoJh7GpwH8vjxW54sAjLHzSg+hnjXnRm8aoM6FuRu87SNhWkc/HhLe1pMFocMDV1ADQy5Tuz4ez9pEGpQT+62Se4LesSxompaM05TgTgNYnn0UG7G08OGhym/ciMIZ4HysRHfhrI/enox5B8RyFpIBqhfHGY6QdDZOAq2XMCqCgNo4AAD4AhTBMbUVgRGN2OFOgzEsUkzQvLxBN/9QLlydorW8/hzVznBr27C1rpmQh7U2caF+luCzhXdEIaaKoCrrFaR0WcPfy88IzIvBl4Bv01U+caDpk3qq1PmDeOn7oHJ2YEAyH264hu6kJYiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFdc7u6+G5A1tc2Tdvv6qX6gBZshUGcH65T07yZKVAQ=;
 b=UAb3FjIxYKwvaKg9pxM+FJpF1BAGcMjJiKpPILoPntn1mBG4WaCfT2BM/itNWo8dGJW+SrHhmDPp7j7mIy8QAH4DYr0ENcfg2sMJDWTWWiEX9tIPpKMs29VmIkBYtWHZykc7iQYm3UXwWS8pu+rvABCWGMOOH2ce9+/sS5wMnBY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB6391.namprd10.prod.outlook.com (2603:10b6:806:257::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 08:52:43 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 08:52:43 +0000
Message-ID: <1efb8d6d-ba2e-499d-abc5-e4f9a1e54e89@oracle.com>
Date: Fri, 25 Oct 2024 09:52:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] iomap: Lift blocksize restriction on atomic writes
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Christoph Hellwig
 <hch@infradead.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <cover.1729825985.git.ritesh.list@gmail.com>
 <f5bd55d32031b49bdd9e2c6d073787d1ac4b6d78.1729825985.git.ritesh.list@gmail.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <f5bd55d32031b49bdd9e2c6d073787d1ac4b6d78.1729825985.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0013.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB6391:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a4ee48f-923f-4f47-c814-08dcf4d263a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?am1uV2FkR2ZRZ3lzWDNlMHV2RW03NHZMemdDQWVrLzRwY29LbmxzUGRBMm1D?=
 =?utf-8?B?QjdaUUEzUXM3WTZMejJnN3gvelN3cGtwS3djNlE4M3M0RHJmVkF0QUdWcTl3?=
 =?utf-8?B?VTd0NUVjUGtQcW96OU9PaTBqSnFNaG4vTHFNSnd0U3BIVU9Fbk55WGxSeVl5?=
 =?utf-8?B?Q0dnWUpuaytMRk5UOFVabCtld3NCY29vOHpDMUFGYjNrNkt4VlJhcm84MG9J?=
 =?utf-8?B?dVVrVVFZRUNYS0FZdDNvbVA0OTNkRjl5cjZzWk9id2IwZGpIdHFOanpKVDlF?=
 =?utf-8?B?dWVVTk5yWE9QWEFKNlRaKzhwUW51d3doeTFOUE5kMlhtRU9MWVY5alp1eUgy?=
 =?utf-8?B?dTV4ZmFKS2R5YnorbFYvdy9qSGVLa0NNL0lFTi9UMkJTdmRYU1cvRDRHZHQx?=
 =?utf-8?B?OWxjRWI3NXkveXN0KytWNGlKa3lVZ29VdHZiWXdKd0FNMWZMNGlXWmxISTdi?=
 =?utf-8?B?NkI4dDl4dkJuSm5veDloQkZnbTdOVE9RNUk2SE04Wk4zdXA0NXRUa1hFcklX?=
 =?utf-8?B?OTBTS0RTTW9KUksxaVU3cHdORCt2UXhQRmRzSFA3ZXNCMTV1aHc2TEU0ZnBl?=
 =?utf-8?B?dE5ZYVRObVRvZ1IvQVFka3k2WktOQm5oNlN5MGE4S282ZHhoL2ZzcVZMTUJN?=
 =?utf-8?B?V1FTYU81eG1PZG9qVVZvRVhrWWNyWVV5YmE3SmE3Vmt5eEdqNUVNeW05WE8r?=
 =?utf-8?B?cE1HNCs1aWNhRXJjUkxlQ1RJdUc3R2dwQnNPellLU05JTzQ4L0g0a2NmNm1y?=
 =?utf-8?B?L2EyeE13MDFmb0kvUkFxUGYyNVlMZjN4aEJtdWdBOXVHMCtyMlk4c0ZIc28x?=
 =?utf-8?B?anI1SFdjaWtOQlNlQ0JDQWhFbVJKb0RIa3ZNck12WENJNFdXRU9Lek96bU9p?=
 =?utf-8?B?emVncXBhS0JBRHJyR0hWamtVOTdFZ2ltSmQrUGx6TzVFWUYwSTAwMDkra3Qw?=
 =?utf-8?B?MGJSWWJNZ1lvb242RDlobXczZll2SXF1QnNZRlRkL0dxM3k0cjVWSmc5em9J?=
 =?utf-8?B?N3hOM0doWnlIdkdLaytSTVZwT2FkUXRDL0RUVDZsdnV6cTRVV29WS0V2LzQx?=
 =?utf-8?B?QXJmM0d5NUFCbGtscEg1Q2JYdjNoQzBGMlJQTmg2QStrNWZ5SjBxL2Ewb3V2?=
 =?utf-8?B?bGd1NGhtbk5pNndGV3hkWEhIK2x4ZHg1dGdQRVR2VkxCZGRzNTlmWFkrN3dO?=
 =?utf-8?B?NExqamNhY3FQcUNSdTdwTWoxdk1weE9kdVNtNERwNDVjRmE5c2RGa2VDWi9W?=
 =?utf-8?B?bnFJZjJ1eEtiVW9EMjJJZFFPbjVtNmptcE01c2FJUXI2QWJ5SlZBcHhiL2NL?=
 =?utf-8?B?TzRjLzJVbDlyNWhVNEFIVEsxaUtyTXRFa3ozd000RzgrVm03KzNtTytjanpp?=
 =?utf-8?B?TGtJMlpBSWgwQzlSOWNKTzkyaGlPRE8rQVRwQmh3MXZDdEErU29BR3ZpcWNn?=
 =?utf-8?B?d0xNZ3ovMzV1YnAzZ3lsZHR1Z2tOS1p1cDB0SkdUTkNra2paZUJsa2phREVl?=
 =?utf-8?B?ekdsUzlrejJJOThBRC9XUTVpN09uRW9uWUtpYkFGZk93S3B5VW1DNkJrWnVr?=
 =?utf-8?B?ZzZvQ2I1RHJncGg2NHh0Wk5zWjZ1c3NMVmZrRU5ydVVDUzQ0STdPcHZKRU52?=
 =?utf-8?B?RmFNME1oRGJhY016UkVuZk5oK2Zzd2p1NG82dXlITGc5dWpvUVhqVTFtVVFv?=
 =?utf-8?B?ZFNud2JnclRHR0ZuRExsaU1mREVPWENXOC9JaGZKRXBKZWgxL3ZUTFQ4Y210?=
 =?utf-8?Q?O1HfmSqEbg7PmPKT+IgGV+wfHw/xTap+aQtB3p2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGpYOWVsTGdPT0RCNFBsZ3FYKzc5UHNhVkUrR0FKTGNCWGgrNzJOdzFIK0pV?=
 =?utf-8?B?TThCVkpPN0JpNmR4YzBadzZPQ05mUEVFek13ZlhSUzF5TlpDcmlIQ1BJS1Ns?=
 =?utf-8?B?ZUpRcXpCRWQzZkZ1YkhVSVkvTmNDQnRlMWQrY3BPWlQ5NTZPWXNnTE44SVQz?=
 =?utf-8?B?SEtiTGdXZmVuRE8yWWpLbDlHT0JPUzNCd3lKZnlMMHNRdkJyckpUaFpmY2dC?=
 =?utf-8?B?QW42WDZqSUZMN2N6K1hhOUdseENQZEhwMyt4dHREOUtIUHVNY0xXM2Z6c0Jt?=
 =?utf-8?B?TWJsNnZ0SVQ1cWVpRU5HUmtLMkZrWDFRTU4zN3pjalVpRGVTRTVrR2tNQ0lJ?=
 =?utf-8?B?aEVJalQvUVBLSnROTWsreGh6YXVTeHhLQ1E2TWY4ZUZCcW5YM0hTeG5SYlAy?=
 =?utf-8?B?RG9pSFZkUlMwcXNhdi90NDdwdzhZaEh2eFF3SlNrVGdNTThIWkI5bXdEZ1NO?=
 =?utf-8?B?VGpwcjZybUJJbmlpU0ZTay8rT3dibHl1czRQVnRiVVFNazlBWG84dXdBVy9r?=
 =?utf-8?B?NUZ6NG5scGRFVDd6ZDdpKy9qdVVGNXl0U3lhSFFyR0FBSkVDNXhpZFRCR1Jh?=
 =?utf-8?B?alhUL0NGTmtMd0Z2V3FCMzJnN0JpU050dFJGb1R5NVB6TjRWZkdWN3JOTFBT?=
 =?utf-8?B?QWt0QW9Hb1hsZzcwakZEdkdnU2FHajE5bldkYjM1ekVsZjFQWHFrUktKeVFm?=
 =?utf-8?B?TENLaDgyUmRiUjg4czR3RzJNL2pwWlFxbmdqWDZHdjc3ZHB2SFBNVkk4SUhm?=
 =?utf-8?B?QVh1T2NlZ1liakJCenN5K0hZZWpEY3JNY08vY0dWaW45USt1bHZyNWN6MEZE?=
 =?utf-8?B?aWVjUlR3YVhXV1puV0lMYTBnZ0Z2OUN5WkRLUnBhWTZtUHpxTEpWUHMzQmJH?=
 =?utf-8?B?TURPc0MzRkZ2S2hicWo3aWJydXVHZkNkelJMeExiNFN5NW5YKzdmcXVlOGhQ?=
 =?utf-8?B?dHQwRFR6UDhTRHhaWCtNRFZnS2RBRVZYUmRDMHlEeVV6MkNydFVLbkN0SlJt?=
 =?utf-8?B?Y2Z1TVFKRUFkNUh5T3N6cC9NQUVJUEs5UDhJYjQ2QTFwR0w5eHVIV3FHV2Jy?=
 =?utf-8?B?OFhpN0R6cDlwUlM2WW85Q28yVk9mQUEvSi9kV2hIcStLR1NXV1NRanpKOTVS?=
 =?utf-8?B?dHpTcElDOGlncWpHRm8xUlQzYml6dTFVSk92cW5lRGpkOEt0SGFJNWIyNmYx?=
 =?utf-8?B?ajVSd2xRQ3ZvS3BaUXJCTzY4Z0doSFZoa21leDVXTjVpcVVzcmgxR2N3R2pZ?=
 =?utf-8?B?NklNN0tscjlFcW4xNmpiY1pNRGIrcWw1WmNJejArazZwd3JMV2FWeW85NWpE?=
 =?utf-8?B?YXNaTW5iVkRLVEdWSXFKTUViR2NubEp5TGxKb25tUTFGaVJiMmRyTUppbmtV?=
 =?utf-8?B?c1VUcDJpYlBpb01CMExPQ3o0bkhuTjJqRDBFK2t6WUUzMTE3OEdsY3lOM012?=
 =?utf-8?B?WGl1WXVEZWltK1p4dy9wY3NtcU45a1FoS3FwREhQc2dMcUVIeUtlYWN5VDFF?=
 =?utf-8?B?U0ZJTE1taEZUTXFyRnBwL2FXNVBVMC9yTkVDekNFRStpUGJlWUlUVTMrTjNG?=
 =?utf-8?B?YUloNkw3NFExZ3ZWZXQyU2dsM1c5azg3eStjT2kzemxuMHZHQUJOeGl3YVdk?=
 =?utf-8?B?UjNkS000SDNTczJxVFUreDNXYTBFRVpmMmJNT1NKTlVWNEhSU05QZWFabXlI?=
 =?utf-8?B?K2RNVkYxSTZ6UDVHNHpTWDNVZEFDU2xWSjlwb1hrTmp0RjVrYTlkUXBWUjB3?=
 =?utf-8?B?VUhJSTVYb3JNaEwyVkdOR2kxLzhPWGZ1ZXFoMWt6cmV1NWxoSHBXT0ZUSEtV?=
 =?utf-8?B?cnlDWGtLbmt3NU9OZExmekpsSHA0N1RGdGk3MDNrbTFqdzFUODdVLzVVOHFP?=
 =?utf-8?B?TWtyRm1HdStZNCtqTFZsSEZJZ0JUZ3lFVEs3d0piZEFtSVZQN2hXNU80LzIy?=
 =?utf-8?B?eUdnTVd0bEdFOU8wMTZ3QzlHWE9nQ1VySFNjcHhrOUtwSUR0QjBWTGdISlpm?=
 =?utf-8?B?cXNtSEJpaTE1b2lyeVR1UzBzQmhyZk9TUlEzSDhjaTZPa0ZXVnVBOW9GWDhX?=
 =?utf-8?B?ZGhUcms4cUxkeFZpY1Y3SVRDNm4xQ3VuRG1iR0xxeGcxMTkxVFA2OURQWThG?=
 =?utf-8?Q?6uCY7eRQ2eAuUkj7vy99BwtqQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NC3k0TWrcfdedVzoow9NQBAd4h0HbYoKTPn8F+iLrhaLZVS+Z4j4ZXQhUJHMcykf6jp+LbZDiWB1dOVu/230kHUYPuuv9UcgTKbixJL0UfP+ybj2DI/yGWEqxaTywWWj0VDLP9BvxFBXUcL099VAcos5h9XpTTOcChcQdV9g1PDyPgPs+ZJalYHoGCg6bpie7DVLgihKZwMvRkqdnNPaOEgtFqTq0kp7Y9rams6a19EAXGGoaopvygZ4KxQttSiSbBg4nedpF2XbyiaH6fGEmdk+w2ByIFuOvAyBoOnIFMNKAlNjtuvizn8kiu0C2FscJYJCL3lH43j3xBlEdUeXdqI0JheQL/8NkqEN1Kp/jJMbjPbFIDaIC2PVbPFH/co9aefzsZ2Y1yEaOG64PaLlQe/ZasIpH/5L8bgUlk5BjoyA+p3gJ4qkJDaC2zPjAcHwHqQiekUf7wPvRxVM0JtawHvsv1ALLrzatKwOAM4w1rRGASZc7S3BmLv4qmBq8towN0MMiODhE5Sih3Ox4NDU0gAYkubFyEkXeGcdcqYBB2fBuFPoIzUGraU+nWE7m7aegqOOa7xFkla/OzDrP9XpOYigjLYbhQouut/OcCEtR0A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a4ee48f-923f-4f47-c814-08dcf4d263a0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 08:52:43.7247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zyfLu2Ca2OxuN20fjl1cTveAVJiYv1gKT+gmcKswkwGHR3kobgDD1OokEhliuCwhDnx2HfOyOq1jLhRetcMD/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6391
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_06,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410250067
X-Proofpoint-ORIG-GUID: eTgN62pVBb4IoqGUVocldfkgvwUMoN_u
X-Proofpoint-GUID: eTgN62pVBb4IoqGUVocldfkgvwUMoN_u

On 25/10/2024 04:45, Ritesh Harjani (IBM) wrote:
> Filesystems like ext4 can submit writes in multiples of blocksizes.
> But we still can't allow the writes to be split. Hence let's check if
> the iomap_length() is same as iter->len or not.
> 
> This shouldn't affect XFS since it anyways checks for this in
> xfs_file_write_iter() to not support atomic write size request of more
> than FS blocksize.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>   fs/iomap/direct-io.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index ed4764e3b8f0..1d33b4239b3e 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -306,7 +306,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>   	size_t copied = 0;
>   	size_t orig_count;
>   
> -	if (atomic && length != fs_block_size)
> +	if (atomic && length != iter->len)
>   		return -EINVAL;

Here you expect just one iter for an atomic write always.

In 6/6, you are saying that iomap does not allow an atomic write which 
covers unwritten and written extents, right?

But for writing a single fs block atomically, we don't mandate it to be 
in unwritten state. So there is a difference in behavior in writing a 
single FS block vs multiple FS blocks atomically.

So we have 3x choices, as I see:
a. add a check now in iomap that the extent is in written state (for an 
atomic write)
b. add extent zeroing code, as I was trying for originally
c. document this peculiarity

Thanks,
John



Return-Path: <linux-fsdevel+bounces-27198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D3095F6FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 18:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B41771C21E0F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 16:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2F419754D;
	Mon, 26 Aug 2024 16:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KBN+qdDt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DnvDuXfM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346252F870;
	Mon, 26 Aug 2024 16:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724690645; cv=fail; b=imWSMriKFMrn8Sk0ABbcOn39FlXpdwseOdMHkZKUYqBLqY54fFbfRyiC52d4YLdEDD+WN3T8vgHsOQOCyUTmlTNIbPbi8PfCwSWPBEDk89giwYZRCos0wvTO5bADgRu0K8CvW2u4Lx7hP24j1XTHhWt8AqcCxHvPYuMNxK+OZVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724690645; c=relaxed/simple;
	bh=Hlf8uAuexUiJGiE9ZtMPzBQSDjYcmFyE9CvoFPUr++g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qi2KrK/PJGNWnxlMw5fLCreS2jsZSjjkj2GHmexDYc9E0wmkHkk0NKtS6q+mU12KiL1uB4qb2kcT6cygVnNpnGEcm+d/ayL1pHMtxuKPD434hX/pbr5L3oEV/bCIwL4iXBaNvf2RL+t7cPeo7ec4T7uq4Ly5XsSvFc+6yLJh33A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KBN+qdDt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DnvDuXfM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47QEfUjZ011071;
	Mon, 26 Aug 2024 16:43:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=9eab+DLkia/YooPP4/6numdhdjEvC3lcp+wKAb1lhnQ=; b=
	KBN+qdDtSwFWwJWQO1Tj/BOmdnunhMr7vPYr5jDSgzjdsV8Ryzh+GD5iUnkM06/P
	9qMpIZC+OV/smm1WZwWMkchReoKTNjU+gZZrFIOEO1JyC81naqJojKqMAQnVyx4+
	RP9ovSq0j8hY8tWGPopLmXqtcD4fFkp8lpZSYiB3OrAkR+jNSvyr5tCGqC3FlHlu
	iOncqv6tS9CBdZWIUTf2ywnf21tXrct2M/Y6nVe0LP5QkPrb8EaVLiYVc8j1jXe/
	xD6nW9uVOAE8rQxcBXbVg5FIxzk81gbsYGlm6s4f6+3SbDmtt1yXuPcKIk5lngeX
	gVL1n7Aw01XaUiD8dVT/0g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4177n43k55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Aug 2024 16:43:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47QGhPtk032456;
	Mon, 26 Aug 2024 16:43:45 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418a0srv4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Aug 2024 16:43:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SYMED7bRLCrbRR3g0AjCAzPX8MeFlhemE8G4xczIdVvCy8+CjJGBUsm2nkaD2fPnCpkQJZ0h67Yugp3VT82atebLWeIRM1maxGbsz7AFXaMPPIDOBhNSXlrcr36A4vo1RZuRJFB5x0TjxgMWuc4vVFxD9//4piFOV4sD2LdCy3tGDqLqTrFkPVLRtLvtXx5mYEiYxi45VeWqi8SEs1fiqWBUTURB06dTxAMEcxF6Ktyetby6tX1fHeJu6hel3XLbaIG4gq1CXPU6QR6neTV0bCsPd/V7TK1zoBBjoFVAgF66jGRMEK7C2fp1vJz9Z6IntQFXRf9u7dbmcQjIkunjNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9eab+DLkia/YooPP4/6numdhdjEvC3lcp+wKAb1lhnQ=;
 b=sqG0ZbHa2fkFurePJxTwoU8ii9TTU3AafR5Sj4rBy5ELxY2800iadP/bQK2MffGlN7IV9VqimByVsT7/ta07dwh0tiYnyRKVxnxyof3eWuQNf2fjGAQsqKVkORXPGkva57Y5Hslj2Dpulw3Ml0k9NHjoJ6uTMenViEBvMvYrGFyzpr8BRlioUZ99COFgxtBEf5yeTz7ucgGDwLx9MFTz+TjeGju6EZgtR2txi5izRt3jdnAkjAWR9lJHaAyOt59VFopLNWh2rUaMIoJ5j4uSpzIm2GS+JbAh3UooO30lOfUtsf1wMW1VcLuKcse/6Eyt9NUsBusSMM3SNL+Jhq0tGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eab+DLkia/YooPP4/6numdhdjEvC3lcp+wKAb1lhnQ=;
 b=DnvDuXfM8h+5Aw45qz6mKYiZlcOqG2QtZ8Tf93rUibSn7xWyzfTEk/tLOcYdWdAN7SDukpqOBEc7EcRVH8Mat18EEMVYWHO901Fk4JuNjvoVzVQhk1wEZ+cg1DygBGCAZuuMlAk81+1epSiY0ZDvZcK4bX9gUCv6pvA4zq47Rnc=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.13; Mon, 26 Aug
 2024 16:43:43 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.7918.012; Mon, 26 Aug 2024
 16:43:43 +0000
Message-ID: <239813be-b52c-431b-b03a-eda8abce900e@oracle.com>
Date: Mon, 26 Aug 2024 09:43:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/nfsd: fix update of inode attrs in CB_GETATTR
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
        Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Tom Talpey <tom@talpey.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20240824-nfsd-fixes-v1-1-c7208502492e@kernel.org>
 <8708e2e4-b9e9-45a7-8aa5-2f06234d3ae2@oracle.com>
 <d438bc3a58fcb6bdbbf39b5ce585deef8d44c0eb.camel@kernel.org>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <d438bc3a58fcb6bdbbf39b5ce585deef8d44c0eb.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0255.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::20) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|CH2PR10MB4312:EE_
X-MS-Office365-Filtering-Correlation-Id: b4f3daf9-181d-48a9-858b-08dcc5ee3ef9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aUJRLzdpbnNCZDBqekIwSkt6aVRaZlFhUUxjMlJUc0VTNVNJWkZVZ3FyZnZ0?=
 =?utf-8?B?WFdIYVJKNWpvckdDSEhoNDlkVG1FOWJEVFAzQThzbVhFYjJLL01WeHNUSnF5?=
 =?utf-8?B?cVFPZjh3Q2FvQldNTUNkVzVKbzY5SWRRL1Z1OUIvWmIrbzZzVVhTeUFFSWVD?=
 =?utf-8?B?bFdnVDMwUVVUVXU5Y2xPYVFTZHJmaXdQZXpuZFRZN3cxTW9DMDBzVWwvT2VP?=
 =?utf-8?B?OUdnSXdFWmlrejVENGhlZWxvOEpzY1J5QTl2OFF6K3dOb29TTVdXckdmNkVq?=
 =?utf-8?B?K1dCekRXQTRCdVZrMlJ0QndqclNXRkU4SENtL2xRZ1ZINDFlMkM5NjJPTDZy?=
 =?utf-8?B?bWxGTVNkVlg2ME9qZ0hwZEtjWmNtdWx4NzFaREl3WUwzK2c4QTk5VURjUlZ1?=
 =?utf-8?B?bDhoNUVjRGVxR1RSK2pqdUgzN25HNC9iMjZMTkZFWm9kTlAvRHVWdXZwM0t1?=
 =?utf-8?B?TFV3ZjcybzZvNXF4MFJXNzdPRDF5ckxqblhYdkRmVUFMWHRUalVQL1pxZGlw?=
 =?utf-8?B?ek82a0x5c0E1cUpteVJOdjR2b2IxRHVwNU5XODd6MXN0RVNPdlozak8zTE9K?=
 =?utf-8?B?MEZ0TlNReWlPUjFndTRSa1BkNVVxMUVEZE11TU5qaUs5NFR3UFFkM29yOG91?=
 =?utf-8?B?b1AyaXNXc3p1SVg0NGc5c2w4a0c4UTdiY3B0Zm0vWEVCbTRMQTFYbDduRGtW?=
 =?utf-8?B?WmVRQ1d5Z0hieTdKMDZDaGlwbzRwaGgrQkhiaWo4VmZPYjU1ZlVpd2N1Y1po?=
 =?utf-8?B?NnJTWlFYL3h6b2k3Y3FjZjF6eTJXZEs5SWMzK1NhcXRQOGhJMDNkaG1KL3Vz?=
 =?utf-8?B?RWpUTHFjTCtkSlRESzlwS2tLSE93RDhKMUJxczBQbkg3RFRFWFlLNDVpT2dX?=
 =?utf-8?B?cy92R2RPZ2VZdTBRRmVuZ0FYUHhZeUgrSGtrQlorVEMrdmhDR0pESnk4d0hJ?=
 =?utf-8?B?bW4ySHo1eE9hdXVNMUJlcnBFL1VtYW5Ib2E1d1oyRHNxSTlYdHhWTGtHY0VE?=
 =?utf-8?B?ME1IbTFyZ1BXaXc5L0loa1F3WGRydlhlTEpYa3NsTEFETHIxQVFIZUZBZzcy?=
 =?utf-8?B?VXVETFhMekdTNjB2elZVaW5wU0dldXliYWNxclpVNkdOalNTdTFxbUJScjQ3?=
 =?utf-8?B?dStmWlBCbW9CVEFNaWp3MHVLcDNOTjh4NjlyMk5OemJZOVlGdTNycW9LMkQz?=
 =?utf-8?B?c1BKbjhkN09uckd6U2wxSTRnRXZxK1NRd3pWNGE3LzNjdmJ1Y2kwdktUN2Jm?=
 =?utf-8?B?TU53NUIwTVlGMWtRZXk1UnpKZS9KR2NXOGpXWjJ1L0tWWU4rMm1oVVpNUnl0?=
 =?utf-8?B?V3FMb0w5T3N1ZDFRL0wxdU9uZ0tLWjIzN3FzMWJzS0ZQeG56QTRFc0kvY3N1?=
 =?utf-8?B?RVo4UTU3OVUrb3ptcTJYREV3bVEyaXZDUkFkTm9qcGtzamxQODc1VE1TVVF0?=
 =?utf-8?B?cUdMZnlDK2Y5bWdZeXBDVU5qSWQ0S2YzVW9yOVF2d1dmVklrTVRyVUI4N216?=
 =?utf-8?B?emZqVEgyQ091ZkdaQTFIYUJNTCtpZG9ocUY4ZTdnd3dGd1dJbGRKUkl5QlVP?=
 =?utf-8?B?ZHJyNzRZaTYrYmdtdHNQbTV4RkRXdzB6anJVL3RRSUxWU0NFcklta3Z5eXZY?=
 =?utf-8?B?RjlTaStLcmdBUFpYeXltWUhRZFhWS2xlZG1sQ3J6STZ1T25vQnpSVUI2V2Ny?=
 =?utf-8?B?dCt1aUZ6czlxNVZtZGRRa1lrZUx3UDE0V0JZMjk1RjBCOEg0MG9NdGMyRUVV?=
 =?utf-8?Q?CQ+huyLf1/6r46xHSs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MG1JWW9WOHRKQjA4cTN2SmxCKy9iTXRSTHc0ZHlCSTZ0ZTZUb2F3QnlwbU44?=
 =?utf-8?B?WTkyQ2RQNURGQmxOMUJjZFR1S2Z3cHNmbVlQZDhvWDYyM0hYc3F0bjdMaDVv?=
 =?utf-8?B?VlYxT2dSMThVd2N6Y3psVDZOSXo4UWlQRWVuWE1vMjNtYWpac1JkOXZ2MnVp?=
 =?utf-8?B?bEhTUFNqSk1SYXMrckswUVp4aXFHN3JQYy9LbUt0azNRY24wRnRVMXo4ZnA4?=
 =?utf-8?B?WDdab2xzOHkzYWh0R0M2dGJyU1Z5M1NaOHdPZC9Na1R1bFFkdDQ0UmIxeXIx?=
 =?utf-8?B?R2lGN1c1WGNXUGJzQ3lUK21OSDZTMmNnRUp0NnFteFZJS3V5eVlQMlVRRlVy?=
 =?utf-8?B?c2VibERUQkZQZFp5NTZqN0JPZVRVc2IvSXZVSGlLU2RhL2FKZ25HK1N0US8r?=
 =?utf-8?B?NnVKUGZjVFRRU0orRTRvTFdudEZObWpGczljaXdWOEZCVnhubTBkbTlyMDZB?=
 =?utf-8?B?Q3lYVXpybTlJcldta0lIZlpKTEVYcjl2a1crbzBmUnZtSXd2NzlIU2MxTmpU?=
 =?utf-8?B?cTF1T1VubldPdzE2cVhrQWRLd0Y1RlhDTkdaL3MwbDc0V1lDVzVTQmZSSHFH?=
 =?utf-8?B?bHVSVytsSndNdEVEaXFTN3RJeU9RbzhDeFRyVUV0RURJSlVTdTJWeEROS3N1?=
 =?utf-8?B?VkFkTEFKRGRoZnRhMHJWTkV4c0tvVVNMbUFIVHRqZEZFbnhZb1o0aHhGQlQv?=
 =?utf-8?B?TWlBYjVNQlVMSE5VdnJKcGtlVXdQanVpZnRTUXFJMTd3MHp0RmVrREp5b0h3?=
 =?utf-8?B?ZGI1S0JLU2RlWFB5d0FzeCtvakFyR04wNXN1a1Yyb2RpMlpnZjk3NG9kMC9W?=
 =?utf-8?B?Y1grTkNxTjVwS29wVWpIMDhOR21zS1NoWTFPQmhsRmQ5Rkd1M3lFb25VM0hk?=
 =?utf-8?B?OTlsUFRCOFlzaUkzeHpKdDR5OStoeWJHdmVWY3BMbVJBN1ZiS2d2OU81Y2JS?=
 =?utf-8?B?aHVnWmI2cGNPMzEyYmtER3pmY2ZhM0w5aHBjZHJmTEEyV1hFV05UYitUU0FY?=
 =?utf-8?B?U3BPS1hVZzdvY25GYXRWUHRnVWVaSmd0bTdqQW5ob3ZTd3RjblFMMGFlZEZk?=
 =?utf-8?B?ZktxZ2tXTWY1Vm0ycDRXbmZkdzVOQlZCVHdZV2llNHkrVlRGbDFZY29uaXBV?=
 =?utf-8?B?d211cGEwWU5sNnBxY0hFaWhHSWtqamVkT2ZackVINEs4UEJOR2NHc2NFVEJQ?=
 =?utf-8?B?MFkzSDhneEFtTUl1WGN1VVZYYnEvbE9XR0pLRk5jMUt2c0tBa3hkOTlRSHAw?=
 =?utf-8?B?RFlnNnpHRnlaZEtDcDkvaEdWUkd2b052dFhSTXdLUGxsa3l4bXk5bU1ZbzFu?=
 =?utf-8?B?R0V0N3pvRzRNbUNSL3RwV0FhOWhRODF3bnlHZmU4eGt1RVY1czNnV0ZsSVRm?=
 =?utf-8?B?ZDBDUmpJZlRWNFFzaHRtTTYvaXZiWHlTbGIvZlIyTmVQaEJOb0NOVzhkeFNC?=
 =?utf-8?B?L3NUbVppK2hOOVpHZEY1T1RSNWcrZlhaYzBjV1IrTExmVU5QN0wxZG9NN2lQ?=
 =?utf-8?B?Ly96ZGdsVkIvVkF6bENpTHhvSUszTUxNbDFnQXh2S2d0WnJ6S1ljL3hvMzlx?=
 =?utf-8?B?eUdROE82YWEzWGN5ZDQ1TytwL0ZHNXo0YmdldHp6UnRlOWkrVEc3OHZKVVl0?=
 =?utf-8?B?RHczbFlFMG9IUXNnTnpOL1ZnMzJPK1U4QktCeTM2UXE4QTlVd01IM1dXV1Iy?=
 =?utf-8?B?cGZCV2Uza0EyUWN2ckZiRldlQ2loMm0zbVhFT1hLTlF2djVsOWtETU1aL3lN?=
 =?utf-8?B?N09TbEZxaTdLQkZ1S2RCRnFpSS9uWXNmaGhaR2llZGxKSXB5V0FlYVVLY1Mr?=
 =?utf-8?B?R29iY0o2V2UxNWRRSW5yMXlIcUNDT3dMbmtHSWd4VmR5M3kyMzBvMXY2alJ2?=
 =?utf-8?B?VkhQMVliMFZvcEhPQXg2aThnc3l1ZDFuWkhUU0Z3aGhxOUkrcE84M0w0Qndy?=
 =?utf-8?B?RFp3M2xBZnMza0t1dW8xbk8zT2paeTZKdnB4anJCZzlGck52Rk5mZkJLTUY5?=
 =?utf-8?B?cEttMVJpdktObU42VXlWeUpIZ1pjRGtDMjdYVnhmb2IyeVhqeVFpUTJVQkY3?=
 =?utf-8?B?OXlWM0VSVHlidi84UHhoa0hjd3BDWGxuTWtodStTQVBGM0dWelRzYkp5Wmtj?=
 =?utf-8?Q?/QJs3ZGF5nnv7n1yw1sqhRRMb?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9QsZDDg9NelLniaZNhDiWuQuM/CsThQ8EwkvJQy2VLfPPK63ieP6ZFHEbSv6rLTgza1pPXPz4cmTSmW20abiNEd/qXYRqy3GLhJDJVLaa65XmNFYXJoGYDAS3Cu5D6tRAhgt42G+O6iaMpujGm48Nx6Z9IEbYdCAXakFYi3PRkVsDgpNsgKegz5jbpr67F9/TK+nzneTWdLkwv/QnBgKvWV4m6cSjPVfxW5ld+t8WYrR94Gz7c7CVPa4ejkS3AzQ1f2mj5exUAVbpKDNgqBu7g7zog6BFXvH88XL9BPBJCQUVGyFOq6TP9ZJAvOjOmv47eaZwCS9gzgETKYHHE/JGvcOpKbpx8R6z4QB4MaSzjEhKFdKAxs7tut1aBmAnXfXZRxmF/O9nNWo6/Mt7RwVgkMo0AkMkfOh/zyhH7oYlXfG3D6IzsVB941zZjtwh4xRFIpPKJqzewnh+jBKKGGISWT7oa3Hd8gGOPWW31fb5S0xGmvu//BZsrXQ94D7JUf6QKeVuHijKFaBA6WXUagJGu/Ns9SczSv6HAVF9+fd0e3agnMCJp0VyVNhFQLsVq88WjqO594YPxN8c8dX926dry9BfkKyuOSGumVF2I+T2Kw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f3daf9-181d-48a9-858b-08dcc5ee3ef9
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 16:43:43.0779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VzpoPdV85q0vZUEzGd0VsIafyx/ynNVpbU4J0fCfloMtmRjz23Xe0KnrfVyTExAZ8Eb52t4QONQzNcW/Xh0Ltg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4312
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_12,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408260127
X-Proofpoint-GUID: XjeseHCrxrVJaoLqnLnnxBLp8M7qdNPP
X-Proofpoint-ORIG-GUID: XjeseHCrxrVJaoLqnLnnxBLp8M7qdNPP


On 8/26/24 9:13 AM, Jeff Layton wrote:
> On Mon, 2024-08-26 at 08:31 -0700, Dai Ngo wrote:
>> On 8/24/24 5:46 AM, Jeff Layton wrote:
>>> Currently, we copy the mtime and ctime to the in-core inode and then
>>> mark the inode dirty. This is fine for certain types of filesystems, but
>>> not all. Some require a real setattr to properly change these values
>>> (e.g. ceph or reexported NFS).
>>>
>>> Fix this code to call notify_change() instead, which is the proper way
>>> to effect a setattr. There is one problem though:
>>>
>>> In this case, the client is holding a write delegation and has sent us
>>> attributes to update our cache. We don't want to break the delegation
>>> for this since that would defeat the purpose.
>> I think this won't happen with NFS since nfsd_breaker_owns_lease detects
>> its own lease and won't break the delegation.
>>
> I don't think that works here. In this case, we've gotten a GETATTR
> request from a different client than the lease holder. So the breaker
> in this case does _not_ own the lease.

Oh yes, the lease breaker in nfsd_breaker_owns_lease is the client
that sends the GETATTR so it is not the same as the lease's owner.

Thanks,
-Dai

>
>>>    Add a new ATTR_DELEG flag
>>> that makes notify_change bypass the try_break_deleg call.
>>>
>>> Fixes: c5967721e106 ("NFSD: handle GETATTR conflict with write delegation")
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>> One more CB_GETATTR fix. This one involves a little change at the VFS
>>> layer to avoid breaking the delegation.
>>>
>>> Christian, unless you have objections, this should probably go in
>>> via Chuck's tree as this patch depends on a nfsd patch [1] that I sent
>>> yesterday. An A-b or R-b would be welcome though.
>>>
>>> [1]: https://lore.kernel.org/linux-nfs/20240823-nfsd-fixes-v1-1-fc99aa16f6a0@kernel.org/T/#u
>>> ---
>>>    fs/attr.c           |  9 ++++++---
>>>    fs/nfsd/nfs4state.c | 18 +++++++++++++-----
>>>    fs/nfsd/nfs4xdr.c   |  2 +-
>>>    fs/nfsd/state.h     |  2 +-
>>>    include/linux/fs.h  |  1 +
>>>    5 files changed, 22 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/fs/attr.c b/fs/attr.c
>>> index 960a310581eb..a40a2fb406f0 100644
>>> --- a/fs/attr.c
>>> +++ b/fs/attr.c
>>> @@ -489,9 +489,12 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
>>>    	error = security_inode_setattr(idmap, dentry, attr);
>>>    	if (error)
>>>    		return error;
>>> -	error = try_break_deleg(inode, delegated_inode);
>>> -	if (error)
>>> -		return error;
>>> +
>>> +	if (!(ia_valid & ATTR_DELEG)) {
>>> +		error = try_break_deleg(inode, delegated_inode);
>>> +		if (error)
>>> +			return error;
>>> +	}
>>>    
>>>    	if (inode->i_op->setattr)
>>>    		error = inode->i_op->setattr(idmap, dentry, attr);
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index dafff707e23a..e0e3d3ca0d45 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -8815,7 +8815,7 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
>>>    /**
>>>     * nfsd4_deleg_getattr_conflict - Recall if GETATTR causes conflict
>>>     * @rqstp: RPC transaction context
>>> - * @inode: file to be checked for a conflict
>>> + * @dentry: dentry of inode to be checked for a conflict
>>>     * @modified: return true if file was modified
>>>     * @size: new size of file if modified is true
>>>     *
>>> @@ -8830,7 +8830,7 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
>>>     * code is returned.
>>>     */
>>>    __be32
>>> -nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode,
>>> +nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
>>>    				bool *modified, u64 *size)
>>>    {
>>>    	__be32 status;
>>> @@ -8840,6 +8840,7 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode,
>>>    	struct nfs4_delegation *dp;
>>>    	struct iattr attrs;
>>>    	struct nfs4_cb_fattr *ncf;
>>> +	struct inode *inode = d_inode(dentry);
>>>    
>>>    	*modified = false;
>>>    	ctx = locks_inode_context(inode);
>>> @@ -8887,15 +8888,22 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode,
>>>    					ncf->ncf_cur_fsize != ncf->ncf_cb_fsize))
>>>    				ncf->ncf_file_modified = true;
>>>    			if (ncf->ncf_file_modified) {
>>> +				int err;
>>> +
>>>    				/*
>>>    				 * Per section 10.4.3 of RFC 8881, the server would
>>>    				 * not update the file's metadata with the client's
>>>    				 * modified size
>>>    				 */
>>>    				attrs.ia_mtime = attrs.ia_ctime = current_time(inode);
>>> -				attrs.ia_valid = ATTR_MTIME | ATTR_CTIME;
>>> -				setattr_copy(&nop_mnt_idmap, inode, &attrs);
>>> -				mark_inode_dirty(inode);
>>> +				attrs.ia_valid = ATTR_MTIME | ATTR_CTIME | ATTR_DELEG;
>>> +				inode_lock(inode);
>>> +				err = notify_change(&nop_mnt_idmap, dentry, &attrs, NULL);
>>> +				inode_unlock(inode);
>>> +				if (err) {
>>> +					nfs4_put_stid(&dp->dl_stid);
>>> +					return nfserrno(err);
>>> +				}
>>>    				ncf->ncf_cur_fsize = ncf->ncf_cb_fsize;
>>>    				*size = ncf->ncf_cur_fsize;
>>>    				*modified = true;
>>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>>> index 43ccf6119cf1..97f583777972 100644
>>> --- a/fs/nfsd/nfs4xdr.c
>>> +++ b/fs/nfsd/nfs4xdr.c
>>> @@ -3565,7 +3565,7 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
>>>    	}
>>>    	args.size = 0;
>>>    	if (attrmask[0] & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
>>> -		status = nfsd4_deleg_getattr_conflict(rqstp, d_inode(dentry),
>>> +		status = nfsd4_deleg_getattr_conflict(rqstp, dentry,
>>>    					&file_modified, &size);
>>>    		if (status)
>>>    			goto out;
>>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>>> index ffc217099d19..ec4559ecd193 100644
>>> --- a/fs/nfsd/state.h
>>> +++ b/fs/nfsd/state.h
>>> @@ -781,5 +781,5 @@ static inline bool try_to_expire_client(struct nfs4_client *clp)
>>>    }
>>>    
>>>    extern __be32 nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp,
>>> -		struct inode *inode, bool *file_modified, u64 *size);
>>> +		struct dentry *dentry, bool *file_modified, u64 *size);
>>>    #endif   /* NFSD4_STATE_H */
>>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>>> index 0283cf366c2a..3fe289c74869 100644
>>> --- a/include/linux/fs.h
>>> +++ b/include/linux/fs.h
>>> @@ -208,6 +208,7 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
>>>    #define ATTR_OPEN	(1 << 15) /* Truncating from open(O_TRUNC) */
>>>    #define ATTR_TIMES_SET	(1 << 16)
>>>    #define ATTR_TOUCH	(1 << 17)
>>> +#define ATTR_DELEG	(1 << 18) /* Delegated attrs (don't break) */
>>>    
>>>    /*
>>>     * Whiteout is represented by a char device.  The following constants define the
>>>
>>> ---
>>> base-commit: a204501e1743d695ca2930ed25a2be9f8ced96d3
>>> change-id: 20240823-nfsd-fixes-61f0c785d125
>>>
>>> Best regards,


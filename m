Return-Path: <linux-fsdevel+bounces-38459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1F1A02E9B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 18:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE6627A27F7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 17:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E421DC9B2;
	Mon,  6 Jan 2025 17:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b5LdfZyy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YH8DwKUv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35080CA64;
	Mon,  6 Jan 2025 17:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736183253; cv=fail; b=FihpIrQjzIGiK0NWa75dU21SMI88IEkng8yED7D+X7Ejh+xuDRCOZbk3XbeNGMeH9Kd5wGZIEebg9asgvrVYFxCdInvKcLBpzSx6hHsfsTC2io4bFhYzvQONQY25OrFxdO+vZXK3m4LUMJF7ooKZaE5cehc2Q7nwJ+/e7z69lzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736183253; c=relaxed/simple;
	bh=6d+uHMK4LGfHxAhmYrRwqLhKq0FPC0Ty/OzGsWmmGak=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sevrtLM1tzvdgZCwgTMmHoKnYQB/37JLkNh/iUklkQFObPXbC24xEOXueAS//jjUuLCLMvNaTk6k/SasxUfP6nW/xrATVCYbNdg2q3dcq7/uFkKalsPNuvj0B3idzHouMJJdxchzI1OQXkrv/bfoJ+7dt2d8Gq0GfmtnVN6jFww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b5LdfZyy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YH8DwKUv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 506H2Lla030926;
	Mon, 6 Jan 2025 17:07:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=bkCJYfe9Yjsl0XwLkRUYUqhKzqwvxkDe1QHBKbzk0+U=; b=
	b5LdfZyyyBJsW2bcrMeKvetZDLVzZxQXnhrPjdf69XnGTuniKEAuohRxe5IxqjE4
	ekTiDH1+P3kijLhj3TcDm6Sz/RaVFLox6FvHNLPeCdynTyb/bxZ4O2GMqvJgj78p
	nTCIj7ca2goFWpeB7ABl1/NsAx320w1zxfje+DBZSM3v06BAnHNg8Jl00Ia+2a0S
	eEYwVDWUKgXFLwsIxKi5HBSgmzTiEIAHBlGmdLcHcZNnaHtRV41FYwXZuKbXKeq9
	NyC32eGh7jUXxzbVAr6YugHGJx7kYECr5hFdZZJ/8xFBKewsSchCpz8CtXkHEICS
	/0whLQ/LLVq+zLoWYx5w8w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xw1btrn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Jan 2025 17:07:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 506H0jJb008547;
	Mon, 6 Jan 2025 17:07:15 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43xue79arv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Jan 2025 17:07:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b9w4dbXQ0JrN4o/Gtk8/JRxNS3ytomvShaP41Wj+z0lywtafPNMF0ml5Uw04yJ7AQDZzIP6j3T4y1GEsCe+rvXqau+zzSpKfNDr05gQszCAiyj8zOe2nIIQW8Izvy6T5KdawMAltv1eW66BOLq7UOKyWOunVRrp5PuGfM5bQJi4usGNnKKMD5yFb9JcMZk95ePtFL1PaaY92GKNq3aTFZ9ca4G+cOEpwNmPRMgdGj9l7YMRnY3hRTVlqRp5NvZrjn6iSKUz3zkRRqnWwp5IOihbC/YdoGAgTo2cHiwvIJk2UY4eoOeUpZc17PGaSZc0hn/IVEsCMTRB2yZDIsTNA9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkCJYfe9Yjsl0XwLkRUYUqhKzqwvxkDe1QHBKbzk0+U=;
 b=O15cirEq8Recm//qhkr0vl030vWclzXKececfgzjYy2SXyMiSzmPJHg5K4e5tfSwNC523JZaykwVfVgSoVezrnMjJHrAK5MHdYNK+ODSrnHRzqA9OCc6abGebuuLB8RINDLB+dBWdCWoaQaUnzpFK58dnewmhVb1CK0RmnlwlJfrkfHGYFbOJHGEuCSKtTb3I5rTYJNbg/WdkYPWnLb6v2+vfGnbopCFN9oobIF2xA0CRSFPvJWEqInxGK3L4+34Ph0XfWMFjCQGAgF4Z+KkRqnGJX0kBIPIOo2lIoOtw4hvpogHQ4U45crn19XqjDSo1Y91EGOnLj7/qfELASE/XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bkCJYfe9Yjsl0XwLkRUYUqhKzqwvxkDe1QHBKbzk0+U=;
 b=YH8DwKUvdUhs3jRnt2uJEvDKCCsuDPi4+wLYPumoV4mOlBjsaxF6NjZB2AwWlcfFlxOXyZqiZVrnz2sUTtRt7oWRxPABZqO6u9eGrKpWoN0BBHWEWl05DIHVcHYfeVDSBNiL1ajWoPgKW8ycWv9A4IGhqXI+JYRuPubzlu0lTTk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW5PR10MB5807.namprd10.prod.outlook.com (2603:10b6:303:19a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 17:07:07 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8314.012; Mon, 6 Jan 2025
 17:07:07 +0000
Message-ID: <0a6a9567-d6e4-4917-a912-21ca2fd473ee@oracle.com>
Date: Mon, 6 Jan 2025 17:07:03 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] xfs: cleanup xfs_vn_getattr
To: Christoph Hellwig <hch@lst.de>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hongbo Li <lihongbo22@huawei.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
References: <20250106151607.954940-1-hch@lst.de>
 <20250106151607.954940-4-hch@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250106151607.954940-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P192CA0044.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::8) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW5PR10MB5807:EE_
X-MS-Office365-Filtering-Correlation-Id: ef2115b0-80af-4281-1f74-08dd2e748ce6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dlJRTjB5QXZlYXdkZDRFNFYzWEhIYXdBOHdSMkpFRkc1N2VDbzRNdkI4aHo5?=
 =?utf-8?B?S0VyWUk0UUU4Q2NuRkZFVXA2TllPSnhMYlRISFkxNXZuY1c1K2RhYjc4bVdB?=
 =?utf-8?B?cHhDN2pmRElIY1ZUU29NMWh3QnVxakZmaldSbk43cUVVOC9pZVRvNE1Jb0JK?=
 =?utf-8?B?dCtnbEdYb2pGWm1SbHNoWk8wV2dPcGtnY0NzRklpcnE5R3Vra0FDL1c2bzVG?=
 =?utf-8?B?WllNdFVPOVNTclRHR3ZJa2UxN1hEUjEyWFBIUnBUYkFtTWw3MVp6bXZKaEd5?=
 =?utf-8?B?Mm5EWWYyck5FVi9PSEd3bXJ3N0gySEs1Z1BVS3pYOGwzMGYxWHFoTDNTaFZ0?=
 =?utf-8?B?RlNWMS9LYWJwemFVVkNwSWNpWCs1d1k2Smk1c1dBazN1K2VhNkd2ZjNnQmFN?=
 =?utf-8?B?NjlRWks1Vm9MWXZLSjlYS2tXUHZmOXpha1JJMnVQK25Pd2sxKzJHNWNDOHNs?=
 =?utf-8?B?T1NIQkd0TDExOU1UdUkwZTVGZHkrZDQ1eThFb2Y2UGZXZ01pUk5qOUV6Q0N3?=
 =?utf-8?B?SjVKSUh6R2pndHpZL0VKNFBKbGNMMUdJU29OUzQ3b1MwUVlFcHRkTWQ2ajFE?=
 =?utf-8?B?T3JXamwyRFNBdHhTSHFFVjlVb3pRNTVwMGRMNHFZTnZLZHYvSFRMZ29mdUxX?=
 =?utf-8?B?SWV5M3J1UlcxaHJ1My9Ud2hWaGtVa0ZZcHhWRHZ2WkgxWm5qQjVxUUJHcDNB?=
 =?utf-8?B?di9yYlg2Ty8xMEJURmNndzZjcEpvTVV2ZDRCMnVVNGlXbGNtWWNOcHk5cVN1?=
 =?utf-8?B?SzI1NkpEQVI5UkZTcW1NWHNrUml1UDJWTEFKL0RzMFkxNm1Bc3pZME96RnlX?=
 =?utf-8?B?czRhUlhlamhZcnhMcDZyWVRBMml6VkRFdVdMOHFaeXR3dDV2a1VOUmVzYzNl?=
 =?utf-8?B?ZGVIYjN6S09JSSsraDNHOXZTeFlodjFFQ2daRVR4OU5PL0gvNVNEeXA5S0tB?=
 =?utf-8?B?dkdwSk93UTROeFpCbG00UkhJdXZFbzc3NW1oQ1dNMzR3Z2FNZG5QcWxZeC9t?=
 =?utf-8?B?T3Q4aUZ3UUZ1emJaRW15QWg1alc4a0ZmbkxkKzVSL25QbWlXcENXaUdXb2VB?=
 =?utf-8?B?Wlhyd2V6ejgrWlU0MVVVNVZHc3FJdURIWTlma2YrN2w1VVQxUVNJbzBEV2lr?=
 =?utf-8?B?cjhUZ2ZVMHZtd2Rtd3pTUGhYOVEvRkxMQXY0RkR4M3FLeTMwSG1UUVJiTklw?=
 =?utf-8?B?QmU5U01vNEdqMS9jaTBsU0l4eXMvOXhnYU1RN2hqSXAyL1o2RkpxUW9BcGlu?=
 =?utf-8?B?VEFQYWEzMGd0czRQYzBkVHRxandiVTcwbGJQVlNJRk0zRGhGdGJudTlEM1Nj?=
 =?utf-8?B?WU01VklzbVh5R003Q1BWbEJOL3ZkRDJOdTJ3aVJYQzV1UXdVVXJoUTBhQkI5?=
 =?utf-8?B?YnhKNWFIbUh5RUVzaTNST3lrUTkyZElLZXlRRHV5R2k2bXRVWlo1c0R2aGZi?=
 =?utf-8?B?SlFXL1E0NnZWbG9tVm4vVzlSQ0h5cjFTUmErUUN2dnk0TUxwZVYrbWFBTHZi?=
 =?utf-8?B?ek55NVN1aG5PaXZ1SjRVUnIraFNNOWV2RUpVMThFcnFncFU2SU9md2JUQ0U0?=
 =?utf-8?B?WnNtUFA3b2NtZUpXTjRoNW11SU9TT1M0VVhTUlpVUmNpdktJWVZ0WERRYmdW?=
 =?utf-8?B?Tlo1K080RWJneVZUeUZKZjJMcWJSSXZaVndLSXFCNkNwUG9rWXl5eS92M2Mv?=
 =?utf-8?B?Ykh6U3FQU01Mekl0NFRmMnlENUVLOUcwakhnaER5cmo2Vmd3c2FGamxSS0dl?=
 =?utf-8?B?OXNDVS9SMnkyU0ZZcmJkbmhJV2lyanNZY2VsTW1Sc2hta1o1MFJPbmk4REwx?=
 =?utf-8?B?ZUtDOXVSYjU2Y0pZaFpXN0FWUitZUzdWNytXSjhpVU9SQUVlazdoU2hkaElk?=
 =?utf-8?Q?tMreoMvlnDRbG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmxmN1I3SGlIQjBpeFpqVEZnaVo3UVZNRUYyZDNyV2gxY0JwQ3FGYXVEL2Nn?=
 =?utf-8?B?ekJNWXQyc0xDc0ZQSkEzU3V2NDNTR2ZhbFNBbTF3cTI4RHJaRjNsYWx3d2x5?=
 =?utf-8?B?Q1ROZ1AyM2Q1OGtSa0Zub1ZTWFB5NWFpc3dFUVFrdXhGTERnSGJLTDVQMlRY?=
 =?utf-8?B?NklGNmEyTnR2RHJFMXhCcVh4RUFqMzdCbVorOHh5TStxRlQxUXNrbHdaZ3dS?=
 =?utf-8?B?NzdEUU1hTjVDMGlJTGtGclcyekh6K2FCSHIwRUFiTnd3MThjL29RRzBnYTgx?=
 =?utf-8?B?UlVpcGlmWXNDcTFmMmZOaG9UNWIzMkNGSzM3OC84eFV2SEdQSy9hcWQ4K1VZ?=
 =?utf-8?B?dDVySWlZc0VCS3VBN20ycm44ZmVPak9lSGg1MFhVRlFyUWQ4L2YxQkwzWmY4?=
 =?utf-8?B?eXc4MzRiZG9US3AzYzBERUZEOTVKRXFHOEJocmJGMlRjbXNyQWs0MStXRC8r?=
 =?utf-8?B?ZlkvNzJiM0VyRmt3b3p3V21oamh6dm5SdjBUN3NYTloxYlZUais0cEJjak95?=
 =?utf-8?B?YzR1ekFlU0ZRMURJRGN1VmQxd3p0ekprT05vRTlWV0I5SXZMUUxoRUNySmZp?=
 =?utf-8?B?YUtzQlBuUXpLYTdvM3NkVmwrQ0pkL21JYWJSRkU4Wk1QVlFKZ3BqUWd5TGFu?=
 =?utf-8?B?dGZMSzhGN1crdkdORmJxTG40UERZcHhBcnJuejZvaVhZWkdWdmU1S3VNcm9E?=
 =?utf-8?B?U3B1bHNEZWZoUHhtUUNoT21QZWFwcXBvcjRET21MR3Nod0pZS0p6ZWI2VEpj?=
 =?utf-8?B?b09zdWdXUE93VkhwdkVSd2psWThnOWxybVZtUDBMSHRBSHpRWEgwNkN6Y2wv?=
 =?utf-8?B?cVowOWFjYXk5N3NvRkNHcFJMaGNpTktsNXdHTGxQcGZmUjZ4WEJmNDlUUElz?=
 =?utf-8?B?Y09hM05VcmF3UkZyNC9XTUJEOGVIZ3l2TnFNb2l3dWJvdUpyWmtXano3cDYr?=
 =?utf-8?B?YW9aQ1NSb1JkaW10bnBvNlM4dlpMTUo1TTdBS21VaU5taXNWN09QWkpQY2tj?=
 =?utf-8?B?VjkvdENzR3FVL1k5QVdLaHNUMk9hNmVXdCtUTVRBMWtWbS9McUhvUW1sa2tR?=
 =?utf-8?B?YnlKa3VTMlZnRU5jQlVJSm9yZlhnb2VJVjgwVDR1SWJuTHR6MFJBS25BL0l0?=
 =?utf-8?B?RERYbkNrWGNjNVZ6YkJnWkp4S1FGTGEzRURlb3NlZm5neXdUWmsvK3diR084?=
 =?utf-8?B?aUNnYVZNT1BWNTU3VE1lMTUyMUIrUHliamZqWEk5Rzg2Y2VLWjdUTzdrR3Er?=
 =?utf-8?B?REVZN1p4anMvVTRKSWt0ZzdjbmRoanorZU1RdkV5S3RiTGhKU0Iwd3NtT2U2?=
 =?utf-8?B?NnlkZjVTc3JnYnl2QTh5QThpSjQzcXp0aCt3Y3RjVkZJOGJTbGpxQ2MvN3Bw?=
 =?utf-8?B?THZHYjNCQUZ4anZGbkVOOFVsdU4rdWNUZXZDU29uS1Q0ODZDK2F4MW9pUnlp?=
 =?utf-8?B?M3BVVzhjL0plbHRiZjlKZGg1TS9kTG5tQzBMeXZyYWx3bzhlc1lrQ2pDYVBB?=
 =?utf-8?B?cVFCMU1XQi82UDlybTFVcWo4ZExQeW5HNG9YakhjeXBuWEZyNjhIdzlld1p1?=
 =?utf-8?B?elVXVVVHWVgxQjl6cWRDQStpR1lEVkN1QWVQZ25nQlI3MkNOVFZPa0dvL2R0?=
 =?utf-8?B?ODVGNGFDQ0dQSTdmWHBHbHhIZml1bDFwckFlaVZaeUltclZHUmwyczZXNkhQ?=
 =?utf-8?B?NXZQQVIrMmtsdGRQT2paU3dGV2RVSTUzdW1IUVBrazNVYjlyUnN6WFVxOWtM?=
 =?utf-8?B?dVhaK2pUTTBuSC8zYUQvbHRzaE9tNXduNWJaZlYyOHprelBxMzF3Sk9DOTZo?=
 =?utf-8?B?eFZCUEk0aTl1K0lkMVdEQ3ZlRUhONUxLcG5uNndubytJZEFmK1ZiMFJiekdW?=
 =?utf-8?B?WENyMEZhdEoyRFZ6VWh1YndLNTdoZVVFQTcrQXNPK0xOcTNuQnE4aVcrMFIr?=
 =?utf-8?B?cXprcWQvQVRkQlF2SEg5aUtoR0l2Qmt3bkpsSW1xRFRTZko1Umg3TlU4T2VP?=
 =?utf-8?B?TDY2MDUzOFBHd1JYdXUyL0lsTW5TVDFkQ2wrM2tBNExnUDNaaUl1TDhwV3BZ?=
 =?utf-8?B?VUFIRDNaOEs3a0gybUJlMGkvUzMyeVd6OTRqVDNCUTcrUis2by9rUUprUjYx?=
 =?utf-8?B?a3FsYzE0a3J1U1l6MXIxVUhTNkE0Mjl0MkNRNHZNNkQrbW40cUl0MWp0WElX?=
 =?utf-8?B?VUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ivgBHjU9xCKdveuCYh9H/sTZknj0W47MCuCIc8f+LMgdn91V5HJb8Lv58DbcJSDff4gW0SURSV5YpeKAVh5p83kd+qE3bOr701TlpHCgGkGefuE+bdQWF6BtjThzgwyFeq47Qkbg48wD3BuGW+qbHYOrcXmzzeOLjJFFg+Ft2eG4OCnpOeUyGYaO7nH0SDVF1MXj6DB8enuPTaX9t7qVCMPIvD65NaDGlhFIVaVXn8QwbBF8yppTIgfAEhnZ00lmys9ET8b7cVJ+b29YNpQuopTXrYudaJ12ov626Y1w6dykGMFpODMog1q8TwRih7olezBxtRyvtzmu93F2vTY0sA35O4nBFGp2lie0aCSk6F7U0GfSO9A81LHm08sGVk2/HYZ1/Uevp/ocC+qRkO12hnbvC3B15ByrvAEZ8ubOUpkh8ssFR/RV/9E9HkRqamUf75Zuhx59odEO6Sv+Fw4ZtTeXune3FhcNg+kSEViGhxbBg4O8fnRsYqp0C7MFAsGQgy7jqc6mnb9xOa4/om7byinnN5xBo9GaYnqn6jh3OUE9Y/RAHsE27EHaCuG0tFqg277uLJA8cdZZzYem+peEvMdk6vAt3K1995SGWP+Imeg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef2115b0-80af-4281-1f74-08dd2e748ce6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 17:07:07.4346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6FqUGzae1ONjAvL9oHGwWJ4L1I2ts16VI8hJD9okNLPdnORYJj6/oDuv7FPE8HQW3QDYo+PqO1+8IjZkYtGveQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5807
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-06_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501060150
X-Proofpoint-ORIG-GUID: 902qq6y9l4FQwzsGVw2ytVaJ5IxXOoSA
X-Proofpoint-GUID: 902qq6y9l4FQwzsGVw2ytVaJ5IxXOoSA

On 06/01/2025 15:15, Christoph Hellwig wrote:
> Split the two bits of optional statx reporting into their own helpers
> so that they are self-contained instead of deeply indented in the main
> getattr handler.
> 
> Signed-off-by: Christoph Hellwig<hch@lst.de>
> Reviewed-by: "Darrick J. Wong"<djwong@kernel.org>
> ---

Feel free to add:
Reviewed-by: John Garry <john.g.garry@oracle.com>


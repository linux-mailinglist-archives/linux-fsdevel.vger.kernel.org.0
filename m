Return-Path: <linux-fsdevel+bounces-29296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F9E977CE7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 12:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 952ACB2A6BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 10:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85591D7E4A;
	Fri, 13 Sep 2024 10:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WppxqUri";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="G6YiXexh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37021D6C47;
	Fri, 13 Sep 2024 10:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726222029; cv=fail; b=TMO2PQPlAiSYOwcXy0i6jZvz3RB3BZU2MKRQz1cuL7sPJhQH6MaYb+ROKuCYDC0YtTFUCM9oYqwFhUGwbkqBtUU9CpGeuaa8hyVHkI3UZGkkNzKIucMTjGG9aA1ACOhjpBOYFpFbr9Cjo37iaIatxb5vgAVLwnZHIKcxxvxkPWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726222029; c=relaxed/simple;
	bh=svcyHmzHK6hsFOMOQM+HyR3N1AzWGTjynJVUKp9QXKk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IXs1RPQysPRTedHOKAzMtzQpkqwt7Eg+o0VkUPL1Up5gNqALwltx6jyAA8YtP2IJuA5WrW97ot9NCyspEmqPeKZ/vXQtKucnSOHtObeKNC1ZbX5p/jnotscotiMx4Ac0WQm+la8u7RTusVakRWPJ0yAPnqjRUXSHOvtUGgeS6/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WppxqUri; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=G6YiXexh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48D9YJ7D012278;
	Fri, 13 Sep 2024 10:06:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=MH7esTSbBESGy3C6YSgKy361CiEKM4K4qfTtvJo7tXU=; b=
	WppxqUri1tAGIVZ8i6gdnM0H2F0ecwndeb/M1R+KOssLYsjDp47v8weGOcFB9BDJ
	ZhXMRUJOsS+vFqtuCUX/ZgNttGXtJUD80IWuCdwLzYHcfCtRVVrVUpD7a0ZQja/j
	PPoHZuDZr2XdwRgFy4DKGCA6FJjR3vD16Uvmg9mJjfCGO/IB8hX3ZG4gl1AiS/Mw
	ycZVEnJYUFpKvtKTzanfKEiOuVIoRZJzC+K4RR1cLidI7FHgW/DuwxQa/FPyd7nc
	SRHYGBpGhUvE9+/bVbgxNqNWIGmmfR6x2cwioOdRLMyZA7dSX6WBX/4oaKkCvle0
	0SjjTxN+6SVOg0o8h1GhGg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gfctn78j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 10:06:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48D95E8Z040809;
	Fri, 13 Sep 2024 10:06:57 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9e5762-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 10:06:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Em3Z4mFA7k1HzE6tXu7ZDE0Fg7n73Zp0Zll8UHwgT7+s4hN8y41J3CT8QDRAy/wXjcrYriXLsHRDjHc+T7MwFQbWkB5k+qYHrgvbUfxORfE3I+L62fIUed5Qc+bz+GE4LRulQo6/AqSd9u5NEfXJr5COXakd2XEo2jk1NqBygwUv6Plfw/cLnuqJCMTa9Go0+pejRR/f18ajok/yAprmvKutRt9UF+MT3Lld37i+qq35+J3J+MohQgePPV4ZUyCgfDVnTySw08mkdcoeiJG4TqJpp5KrFg59IKYG/tqyNteW5LGPSqPdzls6nhQlySg9ESRL5MXBW7iadsJQqkT3Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MH7esTSbBESGy3C6YSgKy361CiEKM4K4qfTtvJo7tXU=;
 b=EcHmhhv4dyXVCHIC8E1Mb+6uZ32dJU2YYFubbkhpnVMVSLHGYoTU/GTni2WNr8sBtpL5dcK/4aOxra9Qaky2adnF1nneGqfsUP28Ny2ZmzS0/gC3vHc6QQioZiQ//f5hXEkVJxinNCZy4UJLk8ABOmtbsBN99n0AI07CbOSnjgbm/Fh8oAIBkzZSiejjRLhjn0xX/H+vXNmlL0xJgn1WJ6qMLTNKiUhO2YHc0wHIrixk0vnQGmLiUFLGRTSZIwXXQP6jkr2CCCrpTh/oTeE24MuYLO6pRgyLwj4YfYZggHPW0Hh8v5jtLJy2gou2k8P5GWK9ooIU9hOrJukWGrV+3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MH7esTSbBESGy3C6YSgKy361CiEKM4K4qfTtvJo7tXU=;
 b=G6YiXexhiC08PAbk+H07HvQhGdgEB0RqQ/AKz3HhANEHkaapJ3IJXKw7e++ezEDPeLM7/iLuv1cAeRJNf2hanDmTg19SCV+BFgPSLCbTFq1y+30ehjVqodAC/6583QZeTR1jc1woghi8xP6fjabGp5Tge9K/uD+AfIiy+i5LaoU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH2PR10MB4375.namprd10.prod.outlook.com (2603:10b6:610:7d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.16; Fri, 13 Sep
 2024 10:06:54 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.7982.008; Fri, 13 Sep 2024
 10:06:54 +0000
Message-ID: <5831e24d-dd96-4bad-815f-b79da73f7634@oracle.com>
Date: Fri, 13 Sep 2024 11:06:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/5] ext4: Implement support for extsize hints
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org,
        dchinner@redhat.com
References: <cover.1726034272.git.ojaswin@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <cover.1726034272.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0213.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::11) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH2PR10MB4375:EE_
X-MS-Office365-Filtering-Correlation-Id: a7d3b877-18cb-470c-64ed-08dcd3dbcb3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXdtUXdvb3o3NUE0RmllME9teXVubFZJSC9nYmVweFpKSktRWjQyTXBZcDhr?=
 =?utf-8?B?czVBK0lQUmk1WjkrRHlJb3FRM0lFTS9TK01tSW1ybnJTeU5neWFhdVdZL0py?=
 =?utf-8?B?TlJkMklsd2U2VElSNDhmbk5mZ3c2S1UrQXJnUkluN01SYnhKMHltei9MekU3?=
 =?utf-8?B?SUFkNzFxVXZGLzkrcDRzdkRtd3pHTWRhVlc0U0lubUpGcUllRTFzek1Ec0Jx?=
 =?utf-8?B?ZTQ1enRSYk5GWHg5c3ZnYXRPcmJueU1YYTYzS0xHbTlTVG41eW5xZm56czAw?=
 =?utf-8?B?Mm9YV1ZaRXJBT2ErMC9BMndIOWJpZ2puRVJWMHhDb2tuOGRkdlFnOHF1TUhx?=
 =?utf-8?B?NEVhRzhZNDdSQW41cndQc3Q0bllTWEQ3ZUxSNGcvKzhJTXNwQXc4UXlwOFov?=
 =?utf-8?B?VlQ5OTgzVUwzYkpSWVNRR3BVcTRaNlRTWEFBcFlkWG9kZU43VnBtTkJobU1G?=
 =?utf-8?B?a0xyZkRRSFJ1ZlRyL2FiN1ZlMHl1TXRHZFZhTlFHMXJKdmxDQ0hZTkZZZG9L?=
 =?utf-8?B?YnNiY0p5dDRUQ1ZiSkZPQnJocFBMSE9jajZ6dkJ3RkRxamp2WXZtNWUwYWF3?=
 =?utf-8?B?VDZVVGJ6UGVJUmVQNms5RC93TG5GelU3Q1hCRVhWbzFDQmR6YVc1RXF3OVUr?=
 =?utf-8?B?bFl2VWZ1cWcvdE5mR3lzRWozaDdxaWVFa0htY2NUMDRLOFp1aGVzTUhhNS9s?=
 =?utf-8?B?bjZCVnNBUnZpUlIyTW5vMVNpUHFqTXFEbHhtOHdjc21rQzNFcXdaZmgweStC?=
 =?utf-8?B?SjZKS2ZsRzhVako3WkZSQ3Z6ZU9xRnZNYnRHUUNpSk1hTXp2U2dTc0MzSXhR?=
 =?utf-8?B?d2RUWHRZeDNwVk9LYnpGdE40elZHU3dBdkxvN29lM3dRV1Q3ckoySGNMQzla?=
 =?utf-8?B?QWFHSnA2bzI5NERNRlpXK3BqczRKVm1YRzhZRldTL0V0eEhpRUdzb21Nc2E3?=
 =?utf-8?B?alNqQzJhb2lQMEl5bXlmeFdKZzBzSlNvSWgrSzlJbVBKOGwwQnZsZllNSEtt?=
 =?utf-8?B?bzMyeFM5bGUrbjIvekJQWC90VzNxWnJGZTZON1RaSi8wMmcyNWx0Q0VHN1A2?=
 =?utf-8?B?OWllcXlyVm1Ubm16VWdBMmQvN25LNkJNSlIvS3FSOGxNQWl5emJmd05wRU5l?=
 =?utf-8?B?UW5Md0tDTXo1TlZ0OTY1R0pzUFdPNGEzKzQ2cXpTNGVBbldrQUJOSyt4Y2Rp?=
 =?utf-8?B?ZXRYQmN3dWxPYTJ4OW9SeE5TS3UwTTZGZXhsKzNpYlVaVWtLcFRTQ0xNTEc1?=
 =?utf-8?B?VFpkTlpIRy82MElicGJndlVtZ0Z1ZG5IZHIrVGF1cXdueHNBZTRXMm0wK1Fo?=
 =?utf-8?B?Y2l3YzU5K2c2TVpjNXNKMTJMZHc0dE4rOTdHcVh4aklraE9PdVg3akVpaStE?=
 =?utf-8?B?a2xwZktHWnZqQ3ZESEQvQVRYNnRiYXJ3bEZhN1RNbXZPN3haMUNISlkvVS9I?=
 =?utf-8?B?VWlMYW5MekFRSW9iZDRJTy9QOUxxaXhTTWxMTVdRV1hIVkpNME5Gci9xb2Ji?=
 =?utf-8?B?VFpnazRaTkVkTFROOElwalVkN0loVSsrb0JZL2dzSXlPdjd4T1VDbXd3R2tJ?=
 =?utf-8?B?ckJPWmFBNkZiMTBMNkpHdWx6aFVCNmh4Y1htY0h0VWtUS1E3Q3RKV0hnMFNS?=
 =?utf-8?B?WTZQbkxBbXg1aEtEVUlyamVtWWpWUmRCdExUV0J3ZDVvL0FxNUd5U3VSYjJs?=
 =?utf-8?B?a1V2OEU2R0hjT2hwYTVicnB3OTRDYzlLUVJHUkZZVis2d0pvT2Rsd3JhUjZp?=
 =?utf-8?B?NXN5L0x6MnFrMW0rTUZHN2xnMjFaK0ovUlBpbjdkd3BhS3pmdDYrU2diQ3c1?=
 =?utf-8?B?cytDbHlaNHRwZXNhbUludz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NURXSDVFenB4dDdUQ0l0b3AzUUQrdTFtTkErRDJtSU04bDZmUFZLRC9rWGpU?=
 =?utf-8?B?ZmQ1ZTJET202dzVTelU0b3I2SW01eDFEaytOUUdwVUhWRWJHNTVHdzhTZFFh?=
 =?utf-8?B?RTc4Q210TmNYZDlqVGdzbkUvaytmSjc1RXNmTVZkZFVFU215UHhPMXMvZm9R?=
 =?utf-8?B?RHk5YTFGeEpZbjViVUJFZUovQnQySU4wYnZQR2JRajZRU0pJcUkwRFNmQzVt?=
 =?utf-8?B?UVhYV1dFN1VwS24zRC8wR2ZtYTAwRW84WDdxa3Q2UEVDbCtUWTU3RlBEOW04?=
 =?utf-8?B?VVAyUGJXVE8wTVExOUFYc20wRHJQN0wxMTY4ODQxZ3ljdUpOdEcvbU50VmhZ?=
 =?utf-8?B?aWpRdm9FaHJhRmE2b2p0d3FlZno5UFg4YmhvRC8yMDVUTEhqamxuQlhaYndL?=
 =?utf-8?B?aTNmNVp5dGg4RnZKUnpKM3l4TXFYaXdOM0VGclFuVzB3aFB3V1Rkc3RSRXR6?=
 =?utf-8?B?aExmMStLRjByeDUrTW9hZG9TVUFIZGdDamlvZjJRMTBRblhnRUZBNnRoL2VW?=
 =?utf-8?B?NHB6VWxqREpLSndkWWZuNEVtRTFoS3lBVjBSTVFaOWdsRjcyWmFubWdQWFhx?=
 =?utf-8?B?Q0JCaXNtMVR5T1AvMkR2QWFtVmhmY0ZhdWRaUzhwV1dyVzFBWGFzOXEvMTFR?=
 =?utf-8?B?QjNhbVNhaGpyUDhwRGhIemRKVGJ2UW45VmpsTnRSSGwxWm5vWE5mVEpkTSsw?=
 =?utf-8?B?ZmU5ZkRWbUwzNVdHMm84V003RUdKZkhXUkNvMWlNYVVmeUZiNTBLcDRqMzlH?=
 =?utf-8?B?S0tReUhCaWZRZFRqSWNjcG5sODhzc1dJZGVOcUdSbUZnTWZIckhUeU1Dcld4?=
 =?utf-8?B?RGNMWExHYTBWYmhmaTR3TjA5YjFEZXA1UWgrdExTMzU0QWYrdEUyL1o0SGVo?=
 =?utf-8?B?Yk5yTVhNcDdOTnNsa3Vma2FBbHZTbElzNTI4UjZDb2paWHNKb0lUYjQ0WFNW?=
 =?utf-8?B?Zzl3RjgyV2lyVGlvcW1hRWsxZUMrRUdhOVk5TE9yQW1sc0pibDdDL1RpTWJ1?=
 =?utf-8?B?c1VOVDAwYmMwQjlBcGxHOHJtU2NBM2hwT3B0OG9rL2pSVlBuMlF3L21mS3dI?=
 =?utf-8?B?NVkxdnNvRlRmK1J5MzZvNnNMNjNwZy8veEU2MG5ObWtxRXdSUS93TXdkK2Nn?=
 =?utf-8?B?MVJKQUNHRGpZNDdZWm56WldXNkFtYnU1bXNjQVQ2bkFNemppaGNSbS9HQk1t?=
 =?utf-8?B?c0o3dVVsc2dReXZoeCtDOFVKOW1TVlc1VzR3ZkhweFBsamp5WVMzeXNpNWpk?=
 =?utf-8?B?VWZkNHJNYUVKU0FkYXQ3eDRZYzJwYzRxbElibld4Z1RlSzBJTkJCUmp1a2xW?=
 =?utf-8?B?VEZ0L0lMUDNkQkk5Q2NQTmFVVEhCWGxjL004M0RMdzVJalNsOVVpeXJNTXp3?=
 =?utf-8?B?aUdTejNzYjNrMXNXMG83QTkrRk41dlc2bXlPenhHa0R5OTJ0dmdFZ2NzWUVw?=
 =?utf-8?B?VmZ0cCtZeG5HaUFLSm1HRDFpVGZyODVtQmk2OGZYNVJ4cEkyL3JmUGV5OFJv?=
 =?utf-8?B?bkxGQXBjQXQzRFpsWm0yVUlWUjlqRWxCam8yNVhFb3A0by8rMERkVCtJc3RT?=
 =?utf-8?B?L3RBL2l6cmtQLy9hYXkvRVA3cm9tQjhVQ1B4UEp5NGNMRCsvNDVqWU14Qmxo?=
 =?utf-8?B?Vm9jNGZnTmlTRXpYbDlyYnA3Q1l2UkpsdEt6ekg5aHFRdEtKUFpGK1p0S1Qy?=
 =?utf-8?B?T2g5UXBEN29SNURpYnZxSlp6a3FrVk9YRURlTXBCNm8xTm95akozbndMaUY5?=
 =?utf-8?B?UWwzMUc2bUxFSmJ4dUgrRHlnZXlubHAzakRaOU51QVIzaFJIY29Id012ZDFQ?=
 =?utf-8?B?QzdIMEN2QjhpTkRUNk5ndCt4NHJvOFZNRFhaeUp5UlBDSjB1WG1XM0s0Q0Fr?=
 =?utf-8?B?WkI0VmlqaFRYS0lGaUsvUzJoL0NCRFUxelpDV0YxaU9SczFRdko3cTN5TWt5?=
 =?utf-8?B?SldhUDErbkFSdW5paTFsMzVqSzlwVGVvZmNXSDJKRkFQQ0hrR2ZPVFRLN2tt?=
 =?utf-8?B?OEtyOEV5VzFLY3B0ZitRWm5rRmZUUzlUWnFzMDlXSmZoM2NYUEdsRmROQWhY?=
 =?utf-8?B?TmVVUU1tcXkwd3V5OCszTHNBSzVPT0RDZ2VCNWdUeTdESVFqMG04UE5MWHdy?=
 =?utf-8?Q?Zs878Kg4divnFGCpkRdBUxjsL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Lgf7myRypJK8cC08uoMVtnXaeuSjpMoJ5CAdvM5YoTFnD/sSyQ8fV0z1ZGxdDMOKXxx3/LZLPLW2lgasdPdrnCj53R1pRn9WtyAjiwDeRc9XNCJymRjDDzFyaeF2lzGeL9gZV8kTdwsOq3GJHc4irgeYDvL01/+mYOuHsPU+eTnSOLpV3F7mOb9QB8LkhH9F0C1rg9NCZ/hZ4e7Xd9oilRUwDsl76vvOWNnQmVncqntwUyDqiWvybZ+yySt4rQQrJWmcoWAHqAw9YHoUVk49U2yAN/O8aWw+AbnwTRz2zNnPj1iVM1hcFSueLKiusRadpY48WW4kTU0yl1SCFS6zLePZTPbeLMXbuZDAwQY0H5DU7W/A2JLqFYwmtMZzXfpaPY0goE6jz9kZ1YxnVe0I/RPn7YSVrKTeb0S4aRC2sQhuoeqIvNm05+RlVyY5vtIy2aEy+tV880kSNuSwr2bg6V4I2WwqKV+X9S1i+WtR1vxP6qVygXn8TEYLXl1txKuPO5KgCjTIA4YjBQk6zF8nk1s5RX98PsBWG70BfnopKqqjtsG08Xp6Xn1FjL0Q+8zF1v+pOkonmP5KP9rgDp2aEdfacYehTYeKqu3VzDsinrI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d3b877-18cb-470c-64ed-08dcd3dbcb3c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 10:06:54.3877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8yJAojVpxZd3NfeobdqEJkXGj287hsI30cVZ8gM1BkTIqsQf958fn20l26FjzblTYDqpuhT2X2TwMuCHLUw4XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4375
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_08,2024-09-13_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=993 mlxscore=0 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409130070
X-Proofpoint-GUID: tRS8AKhRKE9uSe8qq8nXV-MkDACSfQrk
X-Proofpoint-ORIG-GUID: tRS8AKhRKE9uSe8qq8nXV-MkDACSfQrk

On 11/09/2024 10:01, Ojaswin Mujoo wrote:
> This patchset implements extsize hint feature for ext4. Posting this RFC to get
> some early review comments on the design and implementation bits. This feature
> is similar to what we have in XFS too with some differences.
> 
> extsize on ext4 is a hint to mballoc (multi-block allocator) and extent
> handling layer to do aligned allocations. We use allocation criteria 0
> (CR_POWER2_ALIGNED) for doing aligned power-of-2 allocations. With extsize hint
> we try to align the logical start (m_lblk) and length(m_len) of the allocation
> to be extsize aligned. CR_POWER2_ALIGNED criteria in mballoc automatically make
> sure that we get the aligned physical start (m_pblk) as well. So in this way
> extsize can make sure that lblk, len and pblk all are aligned for the allocated
> extent w.r.t extsize.
> 
> Note that extsize feature is just a hinting mechanism to ext4 multi-block
> allocator. That means that if we are unable to get an aligned allocation for
> some reason, than we drop this flag and continue with unaligned allocation to
> serve the request. However when we will add atomic/untorn writes support, then
> we will enforce the aligned allocation and can return -ENOSPC if aligned
> allocation was not successful.

A few questions/confirmations:
- You have no intention of adding an equivalent of forcealign, right?

- Would you also plan on using FS_IOC_FS(GET/SET)XATTR interface for 
enabling atomic writes on a per-inode basis?

- Can extsize be set at mkfs time?

- Is there any userspace support for this series available?

- how would/could extsize interact with bigalloc?

> 
> Comparison with XFS extsize feature -
> =====================================
> 1. extsize in XFS is a hint for aligning only the logical start and the lengh
>     of the allocation v/s extsize on ext4 make sure the physical start of the
>     extent gets aligned as well.

note that forcealign with extsize aligns AG block also

only for atomic writes do we enforce the AG block is aligned to physical 
block

> 
> 2. eof allocation on XFS trims the blocks allocated beyond eof with extsize
>     hint. That means on XFS for eof allocations (with extsize hint) only logical
>     start gets aligned. However extsize hint in ext4 for eof allocation is not
>     supported in this version of the series.
> 
> 3. XFS allows extsize to be set on file with no extents but delayed data.
>     However, ext4 don't allow that for simplicity. The user is expected to set
>     it on a file before changing it's i_size.
> 
> 4. XFS allows non-power-of-2 values for extsize but ext4 does not, since we
>     primarily would like to support atomic writes with extsize.
> 
> 5. In ext4 we chose to store the extsize value in SYSTEM_XATTR rather than an
>     inode field as it was simple and most flexible, since there might be more
>     features like atomic/untorn writes coming in future.
> 
> 6. In buffered-io path XFS switches to non-delalloc allocations for extsize hint.
>     The same has been kept for EXT4 as well.
> 
> Some TODOs:
> ===========
> 1. EOF allocations support can be added and can be kept similar to XFS

Note that EOF alignment for forcealign may change - it needs to be 
discussed further.

Thanks,
John

.
> 
> Rest of the design details can be found in the individual commit messages.
> 
> Thoughts and suggestions are welcome!
> 
> Ojaswin Mujoo (5):
>    ext4: add aligned allocation hint in mballoc
>    ext4: allow inode preallocation for aligned alloc
>    ext4: Support for extsize hint using FS_IOC_FS(GET/SET)XATTR
>    ext4: pass lblk and len explicitly to ext4_split_extent*()
>    ext4: Add extsize hint support
> 
>   fs/ext4/ext4.h              |  12 +-
>   fs/ext4/ext4_jbd2.h         |  15 ++
>   fs/ext4/extents.c           | 224 ++++++++++++++----
>   fs/ext4/inode.c             | 442 +++++++++++++++++++++++++++++++++---
>   fs/ext4/ioctl.c             | 119 ++++++++++
>   fs/ext4/mballoc.c           | 126 ++++++++--
>   fs/ext4/super.c             |   1 +
>   include/trace/events/ext4.h |   2 +
>   8 files changed, 841 insertions(+), 100 deletions(-)
> 



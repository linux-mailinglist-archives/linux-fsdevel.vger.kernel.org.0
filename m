Return-Path: <linux-fsdevel+bounces-13872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD93874E5F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 12:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 991FAB2360C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 11:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6D1129A69;
	Thu,  7 Mar 2024 11:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W4NAzKOq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AoaRJoSF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBA683CBB;
	Thu,  7 Mar 2024 11:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709812588; cv=fail; b=gWQRQWsjeHjUlLsLE4GnKNOs49SRyWJgS975/aXdjS16Yhi4pfoMdAqF5PyxnkaaBQy7m4t/TSUfOGWFU16CTzvZfO4qhKIkCwG+xEuWnw6xLOELmoIudO9boBVRAdFLFOn/L7MSHRllvBWLw0VSBWm0IMgMG4XjLG8kAD8Dwr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709812588; c=relaxed/simple;
	bh=CR0Zu4lHPyHMejefz4M02KorJewl+SKKPf0yZevpb1g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LH/RXBu9dxTB5v3cY1aNZMzBAGFTeW4J7/MCGPon8MDrCT4W+oah6a2252OYypwgRL6FeYwIs7e5x9+DkZ8/C1jxxSYEapWfU6Ma9gs7TfOl8uOJRQ/5rQKffZNoHqjMNEt+O51/dyGYhGu63uqDdwtxQDIA7TGnvDV4s8/wOFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W4NAzKOq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AoaRJoSF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4279nPJ6021106;
	Thu, 7 Mar 2024 11:56:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=fTT+3F9FKqLhiuglK12zDijhph6H2Tt2FmmpDZVI5Y4=;
 b=W4NAzKOqnTmdS8f/cHwN5dD4HlNYFcI8A04BMUnzhtRuQFtyBSrWFD3gJmPGTIpqzaOZ
 Uhyzo79sEW0V9lP0Nd+nVOqxYzZxLKDs3RTlwDuUidAo4OLByy3M3+SpjHZKjay0C/7s
 SzmlVwY3P2ixgEcQoepif/J0/4+kjK8EQuU81vHSe0exAenfmpM5x5hgc2l3Eh6ayUG8
 8cw0jcn02Cq7KW8H7K49kblT4qouNLGMbTQ9noXQXoKNEeIb7oBnwGMVqrXZx+jUO+Q7
 1hXcNcCjeQ11fq1KpkUQta1jOUojRQ3gKo8DH41yoBYE51BmrBtTz5FisL9AYiqnhnEa sg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wktw4bnnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 11:56:06 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 427B5LR0004898;
	Thu, 7 Mar 2024 11:56:05 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wp7ntp1kg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 11:56:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYcM7vZfrzXPSSBqBaiYDfJ9H8PKKcRld2JvTAjlzlxgckOx7RulohiXrEmTGwYq5GpmZfrqaRe/DGLm7sjpTxiV1MWSsXAagkOcONA2me0cowvySkcWlxhSCClAewzku3T8dF0bcWXqAkIrU+he5iEcPXaT+enWfuY6LHTa2ulzdIpDH8x+m9XY/ckKcRD9tAThPH5tpgbEAFjsqEBsMck6bupVlgilTjRcCEcH3X/TvlsoLKqe+UYAT1WVW6KaZ+vh/zLmPXiqwT7hpdCk0oexDD2m9/6+atsgrZyoTvpIjZTPrnFvPlF+xC2f7XlEbrXiRRe5JfaADIyqLy3BNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fTT+3F9FKqLhiuglK12zDijhph6H2Tt2FmmpDZVI5Y4=;
 b=OLm4/IIUP1e8X80hcf/X9qItebcH8ir4g84qbpxl8vQvF7UhC/JyMJ1O0BGdoHlNdux7BCkulATxUGPCiEy1q6o/byOOZhvRT7PZIwoncHQM7u0tG3ACb21z4ImhzZi5U4bVqX96c4HAJQ5jKiQy+QTnIu7/alVccPwa+MenfgiSydY1lsw0wn5BKc8jvYWy5nytUAkL/e/kNEhJrixHNyz0rGPay/fMQMVTj3ZXIZU0EBzwsplrK2aNPVGdDII94vjfQiAhtMBu+LPvhQbNL2kz+tX9kT0+wYq9xOxNmPKg7s3W8yeKnoooyWvMI3pLg9QHq6rj1991m1VAi5PUQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTT+3F9FKqLhiuglK12zDijhph6H2Tt2FmmpDZVI5Y4=;
 b=AoaRJoSFRjgtmHOKrSChlzi34cyN+IThpDVoSPHLNADivCcBpOdtVairwE0Rn10wxaos5DcDEVTt0+1ixfG1E3OlHbOPPsBIa6DiyiYv3AkxU/MBsI0dPd6y/Xr6vCdA6rQI96aMpLB9Gr7UdFyirZd8sV4uU3pnRYun8uXQJUM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM6PR10MB4202.namprd10.prod.outlook.com (2603:10b6:5:222::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Thu, 7 Mar
 2024 11:56:04 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 11:56:04 +0000
Message-ID: <5e7eb717-d810-4dc3-80b0-3baaa20ca41f@oracle.com>
Date: Thu, 7 Mar 2024 11:55:59 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/14] fs: xfs: Support setting FMODE_CAN_ATOMIC_WRITE
Content-Language: en-US
To: Dave Chinner <david@fromorbit.com>
Cc: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, chandan.babu@oracle.com, axboe@kernel.dk,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, linux-block@vger.kernel.org
References: <20240304130428.13026-1-john.g.garry@oracle.com>
 <20240304130428.13026-15-john.g.garry@oracle.com>
 <ZejhNMW5o0JSCgqW@dread.disaster.area>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZejhNMW5o0JSCgqW@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0438.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::11) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM6PR10MB4202:EE_
X-MS-Office365-Filtering-Correlation-Id: c5c6954c-f6c4-4860-1e3a-08dc3e9d90b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	x94vI+VBbmvBPJ1bkkROEkekte9c/yMy4OjoeuHv8vnwMfcXVNVy5c9qMzRNn8+jGvWmMA+oihZ2K/lWQNGJ95b1EsHeyOyFn4+vZEnl+e2rs/p04MnLj3EI6WNIDMKkoY6q5JeOPiaMQYbsmgRoqjSc94V7p4c6Qlzys/JKK5kvBFhVdhVxK32TtxX0TRoNrOomYHX4/+2FEU3khTccUcakQxC/15SrldEf0RFLHZonYx2bloEdJPPoLMSC2HewUvP2LM/xEFHu0p23TMbIto2hroVCyPUuq67xs3p6uX/ofmnSvtUj0l2YGlH7/bYsVBTY4uqKF7Hgf3PssTnXsOk3Mgt2MJMHKa70+FdFKlhFcvXbSEqff2um3RE9BN5KTYlcINESRciq/cGx3xv2KijuejnHqxJlonD/FBw7OH0tOmFtiBHpSWmj6Tksv0g7ZHc/E7G42KGFrA91UAU1GAwkQHPs6eXvM6fx8imoKb1lpXdscJ7jL3+q8m0B0dHnhO/yJ5SF0hHTNdzhpMxQUDuf4+l28ew+24ECsZi6IrGX+JBPH5nDfD44v2FbjlHrJCPnBCGKIqbBbEnb8i0QOeLzqyVvgYX64Y5ZNW0oHBIrcdVf+HSOI3128/Ipp/ivmPQLBt7nJjchF/HV/GV+usvxw85mz3oQ9iSNARtJD3w=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L3JZcXNrVUZ5cGhmbS9xSHVxYmNUei9VMDBiTU53SEROYnA5MlF0OW55UXBQ?=
 =?utf-8?B?Y2NlTTBjbTZDYVk3V3pMNjVlTFZaUElKSWp6MHBMOFI3ZXFqNWJuRjdaMmpI?=
 =?utf-8?B?eWZ5QSt4NHpQNjlxSGJ6eVBFeEZ3MnhPRXQ3L2MxZU9TMTdvUk1aVlZlYlln?=
 =?utf-8?B?bExtRkRqNFM1QUZ0Y0l2R2lNTUxZclZ1VVNWaDVmZkc2Y1RHSHVhVTdERWtn?=
 =?utf-8?B?L1cwaWFpR3BzWmYrcFVlb1RCREZKQ25yT095ODJIZTRHbTNSZ1NmeTVIeG1y?=
 =?utf-8?B?NGVvZUJ4ajRiUTRUUFh3RW5ka0pyYWNzdE53Q2IrOVBYbXRhaWlRK2xkRGY0?=
 =?utf-8?B?TzN0M244aVhvWjFTL0F1cWdybGF3Yzh6b3dlL21MR0JKVEdtKzAyazkxT0Yr?=
 =?utf-8?B?Z2VHc0JKSHVORVB3SjFmSExGUzd3YmxZN29pVHFLSmNITUJqNkZUZ3pJTXNx?=
 =?utf-8?B?emFOL1plYUhSTmEzeE1hcGtxdjFhT01xTFpNQ2ZXRGdYTlQxUExtVWNPOGox?=
 =?utf-8?B?cHdkSXRuWHhpRGtoL3VnVjgwemxkb1RRQU1ZdzA2NHlxRjdIQjE3dEJydmMr?=
 =?utf-8?B?akdEcldadERlb0NEc0FDY2E3aW9nMDkxMzZEMldTM3M4bTI1ck5MYzZodldu?=
 =?utf-8?B?RGJ4RDdJZzg3ZmZkQXI3WG1yZ0s0cnRiZ0pldmd2VTBXVGdXNlFqT3g4eEZq?=
 =?utf-8?B?bS9OdlI2YjE1UTBQL2pWU1k1TDZTWHA3OW1jMVB3UzIyWU5QNUhFVEJCRGRl?=
 =?utf-8?B?RnBHOWk5ZWg4cXZjeHEyRTlXT2x3V3hYK2hRaU1Tc055clZSMlZ6MjE2RGlQ?=
 =?utf-8?B?QXo4eHJXKzBVcTlhRTBneitLS1BUbjNlZEZSUWttWGQvSVNDalc1cEhmNXJt?=
 =?utf-8?B?MzVWZUdYaktmdXBIZTh4VG56Q3RsT0x1b01DMXhwMVVoMGJyYXZIVExlWTVS?=
 =?utf-8?B?emRaZnBWVDMrSDI0WTNTVTgxd05adkVrNHdDUDlSQ2dEYS9BaWhud3VTMFo3?=
 =?utf-8?B?UEwxbE1OakQvSjZuV1YycGZjcWJYbktveHZ3Q1UzcFpkYzRTOFhONmRtWXV0?=
 =?utf-8?B?cEJuUzNwQlE3NHA3VlhxbWt6MUhmZXFzaGNGT2Z3N0YwUkxFSGtRS2pIRzMx?=
 =?utf-8?B?SEhwUEt5Um8zQjR2alViTnorb2VtWVBGZS91V01sWEorbHl1cGVmSjV3akt4?=
 =?utf-8?B?TUhmNXlYL3lPMWJETDNjNE56SVFpN0F1TTZzZ3FEUk9IWHljSHRvaDVwN0NJ?=
 =?utf-8?B?LzVwYSsyd3I1UUxsNVhXUC8rSjRpYnJaR1pzVStoUU5GQ0d4V2Q1aHMycW1B?=
 =?utf-8?B?UWZBcFlQOHJQYkxBMjNMMlZ3ZkY3ZHZiVWRvaHhDd3dpQWlxTlIzWCtqbDBM?=
 =?utf-8?B?d2NGVGdYY0tBYnhvai9UTlpob2FVa0U0UUZKNnFhQ1lpQm9ueUJFdGZXaktM?=
 =?utf-8?B?cEtxY3ltMG02cEpmeFhxMGhMTGxlbVliQjk0U1p2ZnZ5RU50RmdxVE5qaGRh?=
 =?utf-8?B?Y29ja2VNdUx1ZU00NEVEREY5RytLOUNQQldaQnovbk9NWGtLMWhLS3BkYWRO?=
 =?utf-8?B?TzR2RGJJV08wSU5qMmt3YmFJMHQyamxDdmd4QnRHc0cwOW1VV3JhRGNTS0dq?=
 =?utf-8?B?alAvZi9senBZNFE4VVdpbTVQZmVwbkQvQVBEVGtHR2FpU1R4M1JXUW5pYSto?=
 =?utf-8?B?NnAyaUo1c1BRWmlidHJhc3JlZ25NRjg1a2NNM3dFZGVMQlVJUzBKKzVEOU9N?=
 =?utf-8?B?amU1cERCNDBNbmpwa21RVDlOVmZQQmVEK3drYUhaT3BDdVhhWFU2RDZZRklr?=
 =?utf-8?B?TFUxUUNyMFhiYkhZTzIxS1Q5OHM4THY3d3JWalVvSi9yK0M2bHpjY1h3Y0or?=
 =?utf-8?B?ZzI4ODJSRHM0VC9KZU1vNURXaTEvdHJRU2xqNlhVMU9wazVHUU5DdUlaYTJ0?=
 =?utf-8?B?cWpObWVybDZGbFI5RUlsVHpQRHRRZ2hOLzlLT0lzQlMvaHQxUE9ySVo1SHBF?=
 =?utf-8?B?bFJyQUJyOHY2TUllUkIwZ2FNTmdEWHRWdEYrQ3VmT3d4QzNwT1pEM0UvUkJx?=
 =?utf-8?B?SDVoSE50NE5EbnVoN2RQQTVqZ0MwZ2NlNTUzSTlpTVFlNkgvbWMxODlPTFlG?=
 =?utf-8?B?aEdsMUVkQ2FWbUJRQVd3VWJPc2lmUjNhYUdXR2pReFVyK0lMVVZvSlNpSCtF?=
 =?utf-8?B?VHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	VfIELLDZnecccmw1QeiYVKL2CQ7wWUZTp7f3ahuRMEt1UVDXhwtUdx4v6lQFZfxzUwd66evSbmhI5c0Qc7t+3S05SJJjavbuPJM2lKxIe9XyDHUaJPHY96OZEMRLo123VydToMQDrix2DNBrzgaPBBz3tpCcA3ceDma/GsD0wxSQmm4LQb02UE5g1t1whLfaczAvb/949HqhmafHYmuW4/NQI2Y57VMg/tNGfwC9w+xl8aN/iWkmayCPevKsb8sPx2jjjTLg+iwRBHJj3APLDIlG3Jz9jdAYIJSHYRuc72K3OHjmDAnRChk6Gm7+zxK8x9WeqTCeXxuQG1hK+UqXvqfqn6Gb4Ja7HPjrKarG9xVUJgg6lByXNFiSSSc0dS7PvECmZrW8WWMFN86MW3kSm7a3aowUqfpvwNs1ZbHO8XWHagKSorZpjGwCOOboDOT9o7EYUNHtFoP94gkzRNWM1PLkwbgKZ17d9WjJkFY75I1oRoCXxBw9En0kaavVcNNF2p+voeVOjS1aUh6BPh3OrJWQhMiR9wK3yjWXNQL3YbGaiFuNhUHqpMApXGkazWWIzynclHW0ri3aDSyPt48nQ6bj8akvM5KBc9aNcxTEjRY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c6954c-f6c4-4860-1e3a-08dc3e9d90b6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 11:56:04.0458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9X2go77mXY8aZ/LFjEAVI90XSzrKFYp8d3QZnjg+4h8EmbJFJr8wHet/eLATNnXszD+6fSCa0YXSVKmiK9ldlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4202
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403070087
X-Proofpoint-ORIG-GUID: cVtTd53W68gGkQ8lqJE6gZwqhDMIfjo7
X-Proofpoint-GUID: cVtTd53W68gGkQ8lqJE6gZwqhDMIfjo7

On 06/03/2024 21:33, Dave Chinner wrote:
>> +static bool xfs_file_open_can_atomicwrite(
>> +	struct inode		*inode,
>> +	struct file		*file)
>> +{
>> +	struct xfs_inode	*ip = XFS_I(inode);
>> +	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
>> +
>> +	if (!(file->f_flags & O_DIRECT))
>> +		return false;
>> +
>> +	if (!xfs_inode_atomicwrites(ip))
>> +		return false;
>> +
>> +	if (!bdev_can_atomic_write(target->bt_bdev))
>> +		return false;
> Again, this is static blockdev information - the inode atomic write
> flag should not be set if the bdev cannot do atomic writes. It
> should be checked at mount time

ok

> - the filesystem probably should
> only mount read-only if it is configured to allow atomic writes and
> the underlying blockdev does not support atomic writes...

Let me know if you really would like to see that change also. It does 
seem a bit drastic, considering we can just disallow atomic writes.

Thanks,
John


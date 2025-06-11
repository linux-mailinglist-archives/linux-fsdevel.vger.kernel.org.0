Return-Path: <linux-fsdevel+bounces-51356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F9CAD5EC9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 21:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F00631E10DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 19:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32975288CB9;
	Wed, 11 Jun 2025 19:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fOUMDMs6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GSuLSJGx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A801DE2C2;
	Wed, 11 Jun 2025 19:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749668812; cv=fail; b=kiJbKQmEQKPnDKVRR7QgWbWbj3TZ70XecV4N83Uy26E+9b/4VuTM/xf1yh9hJxEcyhDRp9Jvfjcrgk+C/LWk5LPJEjskMRCDB7nSfErvcwNN4d7onQC9JRtPwuSx07V0T0msG77TPabN7GkSNMSOfhnWVtNl4gOndvOPwehfdu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749668812; c=relaxed/simple;
	bh=JdbqkHW97qx0p2Za4Zd7aFZyo5Ar/ftuPoxSIHbsXDo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dMSJhYi64H4PI0DHXmSV6x4iUBVluUknK2x06B4bwQlyfYLeqXtQgajMel19w57gf7EjUeTpGTy1zYLYCdBT5RodQoGRzPVvWciDyZZl6pJ8EFuGlsem67at1Cz4ERfLrUqEwACqdiXOcC1g+T98/KaoxIbKmPb0NT6KXU2Ljko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fOUMDMs6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GSuLSJGx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BGsrjf030929;
	Wed, 11 Jun 2025 19:06:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=pe3QctK3dbpu4QlsrcjRLU77LBaR5yBr6U/wHfUBXRE=; b=
	fOUMDMs6L1cbik47MyZo/vITgWymXcccqRd+Y2HJnvLMjsJg17RCsEYaGySuiNLY
	qrGC5YQjH23YOjS3ObGYbkvMfrVUQ2CUQSKMka6AL7NctmSr8Hpk3eSFYxk7u8e/
	A5BNJv6JKm1NN5BM+jRIclnSCzW/RzgbKbDpiRP6bPIt1bHTb3ZG3NDveKZGpsAS
	KyY7pztJsg3it8DUBnC9HjXDN/HjBT7RzPkFJtJjARs/G3LjijV63N+XjpSR4NBA
	e3UJ7TaCShzOsUY4ls6UNHnifDfKBxZvsYzlGSHepUM7zFFxPIyuqWdbwPwHO41s
	zNKpx1LGnr303P2gVqqvnQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474buf89fm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 19:06:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55BHbvI5011804;
	Wed, 11 Jun 2025 19:06:40 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazon11013015.outbound.protection.outlook.com [52.101.44.15])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bvbksnd-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 19:06:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XbDpYrQ/vQ8yZDqZPZTtazKuPAGOYHBRuqlu2xAXQ7fG72VNj/3c80yKxXYAALoTqrtBvLd4MU9brU7n8qusiAM+ItaofeA19oYAksmp08NJfsPAPpbwZyA3hSb9XIShysZjdWjE/IJtofEjUbaosmkpyzTkMHH0QvZAokTi8zyW4SX3BzhSFzy5JBLFfivI5tmM/jypDvRPDorxTwaEI+zWgwZ2eiNrfp0GL6RNaSHt+kjUMhgh6bSlT02PXJIZMCw0S+0MJbABHwkeCj6aXeBtltP2KI7HYTz/fIzcVmrAfGjFo+ySFHTXTolt8a7caxypHj80l19jznt+p3Q7Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pe3QctK3dbpu4QlsrcjRLU77LBaR5yBr6U/wHfUBXRE=;
 b=oKEOx8FkuIw1flmNQ1BemUTsahWC2hytAoI1feJPgGItjXf3mnPhiRNqXur2b6aOEDlVAfXgQTQ4FvxcFUIdi4D5EuEL5l67Z4K4+cXbtAB6QRQDhMNg+YZOTdD0zrFYRZsVjLHHzBQVjo2jy7Ra2aZujLnugTF6/4a6JhEDVUNCjeRNPBDwK8IqjnN9fgr0407csfDzdqVkScjyv2mSrdG7uGQ2asH9qscxwPVUhVisBW+QqQQwYtGD6illMP4PyNXqCiblvCGzlsXFgTqVoO42EQyh7mrP1cAXACrLrE+AN6N+9mHttaaaAhN7yNDiUnJ/Oc2iv4Y+9vz2AycL1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pe3QctK3dbpu4QlsrcjRLU77LBaR5yBr6U/wHfUBXRE=;
 b=GSuLSJGxG8wtT+eFQHkXyz6RyAX6GkFNeoZeLgzpCsJMuLDtN6xxxeTN9IHR7SaUB+xLfaCZQL6doTatVx0FbUWtSr1Zy78J/6uDAdUjuEbVamIacSdJ4huD1zDRPcW9rM5DUzrOmN7UL/bfiDBBF+YxwTuBO5bfiu9Vy+8fr3k=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB5783.namprd10.prod.outlook.com (2603:10b6:806:238::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.27; Wed, 11 Jun
 2025 19:06:37 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 19:06:36 +0000
Message-ID: <6e94051a-6a90-4ab8-8ebb-7cf6192e0716@oracle.com>
Date: Wed, 11 Jun 2025 15:06:34 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] NFSD: add enable-dontcache and initially use it to
 add DIO support
To: Mike Snitzer <snitzer@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <20250610205737.63343-1-snitzer@kernel.org>
 <9f96291b-3a87-47db-a037-c1d996ea37c0@oracle.com>
 <aEnEnTEYaQ07XOb5@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aEnEnTEYaQ07XOb5@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR16CA0005.namprd16.prod.outlook.com
 (2603:10b6:610:50::15) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA1PR10MB5783:EE_
X-MS-Office365-Filtering-Correlation-Id: d8985076-4a25-4271-b00e-08dda91b168a
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Q09mcW0yRG5FZlF6Vm81WU41SzdSK2ZtSVgybDlleS80Y1gySWtpTWRPZXBk?=
 =?utf-8?B?Z0VPM2lRVm40SXlieCtuZ3ZwZWJDNmZMdDIxMGRUVW5vK3NMc3lVTzVsODdw?=
 =?utf-8?B?S0pXZEY2eTFSb1VzMkQ3dEdSZEtha2JBTDJ1N1JYQWZodWRZK3VqSEIyU293?=
 =?utf-8?B?c01KWTRoQXYvb0M4TmVWOUMxd3phWkU3UFk0TEJzczN4Z2FzRUtoeFIySVE5?=
 =?utf-8?B?S1lLUndLaFY3bVAvRzhJSVJIZnVWTFhNN3kvanpoY3ZaMXMzVjcvQ2tiSTVQ?=
 =?utf-8?B?dkN4Z1NUdTU4VWdRbVVNWUMrbStPaWJ4WHY2RUtzWkNjeUUwdFRRa1U2R3dm?=
 =?utf-8?B?eGlJNEppeXArNEFpL2pRU2JTQjQvOS81RFBoMTNJUmVySUtyODBwR1hteHpO?=
 =?utf-8?B?WFd1bksxMEsvaE5oelJOa3lDMXg1WW80ZXVOdlM4ZUdKZXZnWllVc3B1UFlJ?=
 =?utf-8?B?WG1leDZySHM3bkpPSG9JdkdKNEszVCtKT2JmbEF3MzMvd2RQakhwTVJLMDZ2?=
 =?utf-8?B?dDF4WFdSYnJMMFBJODkrQWZHQjlobTBORzhhMyt0Vm9CeTR0YTRDVkd1N0Nk?=
 =?utf-8?B?Zi9lTnppNGgxRlhRVU8zMkRpYWUzMzdLQ2ljRjYrWm1DRnJIVjB3cUpNYk5q?=
 =?utf-8?B?cUJHdU93S0s1U2VqMFUwc0xQNVY5bGtUTE9icWlXMk1uaHp4aWJsb1haRFVP?=
 =?utf-8?B?NDNXb3NDYnN0RkJDSlJrWDAvSXVyb0ZFTmtTdGgwbmp4RHdHTEZQeUFPUDZ3?=
 =?utf-8?B?TWJaaDE1ZGZnZ1B5bHVkbmZRTzN4K3JjNG9lZVVYZEZ4dWN1bGd5djdjeERT?=
 =?utf-8?B?M3hTM2FkUldRUnRSNlR3TDI3UmJ3VjRDNUp1cXIyVmRXUHdsa2p1eHZ3cmtQ?=
 =?utf-8?B?dmN4Q0VoVktTbzNSWW9NVEU3RjV3KzNFZzRqT3VPZSt2TGlJZjJHeng2RTMx?=
 =?utf-8?B?d1Awa2V4eHQ4NXBKRW80WExQcDRjR3VqVUdWU1pyTmFWa21KTThlVUtRbys2?=
 =?utf-8?B?cmdQVGhYemtmUlhQcmpwZVhHUzdwSVhDOGo2UWtFR3FGNjJOa1NoTlFCTVhJ?=
 =?utf-8?B?R05NWEk5OHlqM3J2b2MxQTMrMzVBVk02bHk1bmNBNjdnOGlpbSswQXowUDcr?=
 =?utf-8?B?dXBVaERDbExvd21NZ0dVdnhhSVd4N2IvRmhjd0V6ZXRKU1k0V3QzT3RBZ3NX?=
 =?utf-8?B?WUcraFM2TXNvQmRGOEovWWxtdDBGVG1pV3lqRWwxS1gwYUpMaXNaN0JpTDNk?=
 =?utf-8?B?OTFpUWwvSTAvMS94dGlsUWVWMStXSmpsYzUvY3BpMCtZNlU2SEtJZEhOV2NR?=
 =?utf-8?B?OE5uRlplWkgvZEUwN1NiUWVnL2psTFphMWs4U00ra0tFS1JRMVlQZ1UvTVBm?=
 =?utf-8?B?OGRJTW5LT05qYjJNR2YxbklNaGIwaWEzNGd2ck5RdGhndGx2TUsyczZrZ0pL?=
 =?utf-8?B?MmRHTXZsL0djZk5ETWlSdzh4eFBqKzh4cmxZOWpEMzAxaElRWkFicXhiTFdX?=
 =?utf-8?B?a0x5SWlaSEtyYitOUHNSanhmSjNPWnM1dWlYVjZMazFDbitNODE0R1RVMklh?=
 =?utf-8?B?OXNkZi9TZlZhVkFvTlFZaFFsbkY2VmRRWisvMXNacW13c3pHOGFJMVZKbW9i?=
 =?utf-8?B?ellqWno2TmhjSmFYaVliS0FaWVdBRVdZZUQ2Sy9sN3E3N0pncDZUMnpvOC85?=
 =?utf-8?B?WHZRc0FmYXNiV0k4WXZhRjlxNEFLSnp4bThpdmtidStQSVkwaWdyWVp5RXZN?=
 =?utf-8?B?K3k1SHVmY3lSWWxsSnF6YjBEN1VtWXlocTZ4Yi9xVEdxdUZ2THVtcXdmYlFM?=
 =?utf-8?B?Y2JvNzQ4ZWhlNUdVVU5ST1hIL0N1UmhFZlFSTk12OFZGZTF2QW55OXYzaDl2?=
 =?utf-8?B?MElIc0xmbm9SVmVvemd5YnJKT1VpbGt4ang5NFVFUW9kaW1HVnV4TnpIUlVS?=
 =?utf-8?Q?icIirVIPLc0=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?dUxJUDg2OXNhOThvN0dvVlZzUi9HMUdKMXl0KzVJLzR3UGNrVnBLUmw2K0tt?=
 =?utf-8?B?MEMvSk1Da0RpTHNHVHplakRIU3pFZU5jcEdQcmVrY3d6YjBjUFR4ZVloa25L?=
 =?utf-8?B?dTJWNUJVTmJONEcrOHZwdW1hZlkyRFFGMnJwcmpnWDZET2tVdlE3WDIrWnZP?=
 =?utf-8?B?UHdtbmhqaGF2aWk0cHBiZ08xQjJMZS9tbWFxRGoyUFZpVFpRcFNvRlRBVkwz?=
 =?utf-8?B?clZpbDd4Nzl2REdSVkt0U3ZISC9nYVRBNFBJUk9TSldXV25PTUpMazJ4aEl6?=
 =?utf-8?B?eWUweEtkdVEvdVlWdGhPRlg3QjA4ZnpvY05nY2RsOEsyQWsxR1k5M05KWkdk?=
 =?utf-8?B?V2oyV0JLeWFoelNYWWhHVHRWdEU5Wk9jT09hS29yb2ZOL1djQjZHOVU4ci9P?=
 =?utf-8?B?YTg2czBFQXV2elFScmpQUHEvSzVZaUgwUTQ4Yk53dWkyMU1HWG1tcVNRYmpu?=
 =?utf-8?B?Rkt5cFhWZTlMSzQ4VERKdmF5UjFRUXM5OC90L01UZkNpUjRENXpEanhwTUVS?=
 =?utf-8?B?bWl2VFRFUlZMc1dJQlc1MmZzaVp2d0c5YVNTbHh3UlFWUE1yVTNweklhZ2Rm?=
 =?utf-8?B?bkM5aU5EaGhYVmNFN2JYc3FNVXZMeUhNUW1ZSWJUd085MWthRTF4MlJkZGJk?=
 =?utf-8?B?MFdNcjhQbUcweFZVbGFxR0h2MFJtOWZPcmtmY3REajBDdWVObkZQdmZUM1U2?=
 =?utf-8?B?S29nNmhjRXRNalBrbGR6Wk5admZZQmg4cFFiY1lXYThWbVpjM1l2YlFQYkUv?=
 =?utf-8?B?Nms1V2MrbkJDMW0wSDA2akhZUGNZbGpmQTdURTFkbDBTUWtwVE5VVUxNRGla?=
 =?utf-8?B?Mmd6djhNbW5aVlRudWZNQlZ3QnVOZGo0ZlEvb2FZQnphQW85dUFaUkxUUHJi?=
 =?utf-8?B?V2VvZ0FsNjFpZlM1OGFXTUsvNk9oWkZmM2JuZzNoUGF1K0EvRldnMFF2ZHdQ?=
 =?utf-8?B?SGJwNFFOcHFaUElyUmh5UG9wMS9xbzJtU0xlZEVzcnlFd01XV2MvOXBYZkZH?=
 =?utf-8?B?WURtY1RMZEIyK0tpaFh5VGlwQ0ZseEJYZy9hODBUR0dnZVJ2cHl3SzVGYTI5?=
 =?utf-8?B?MUpFa0J1aTlNL2VWN3pyenNoeTZLRVhSUXIyajFLcnBZTDY5YnlLSDJUV2Jr?=
 =?utf-8?B?Y3E3M3NPR0ZDaXFocHFpalBwdldHMFc3TkZycldZRlJKd21LRDZ2bFI5TXp2?=
 =?utf-8?B?MldtazlPZHgwdi9maEYyT3dlOWlZMG5lenorOXN0aGc2SGs2dy81azFaRGI3?=
 =?utf-8?B?THlrdW1iUzdBYTludFEvcVVYbm5UMVJzZUZsbWFsVlA3SUVMMWF5cUFOUmJH?=
 =?utf-8?B?aTl5SVlRTG9PSTFYVUNmaE8vR2JkUHU3RmVNRXduSlYzRlk4eGRGUmJxN2ls?=
 =?utf-8?B?aTdwUktuK1hpRkxYQ0tHMUNsS0xPRlVLTHppTkpFSHdWT2FldlhHS3E3dDZv?=
 =?utf-8?B?Qno2Ly9GUnk4ckdIRGtMWFE1bnN1SWdudllqRkt6c2llYVZ2aHlmdVphMGk5?=
 =?utf-8?B?bTlNRUxjdWF2c2xZWmRpZWEra2FUbmp5RTREZ3JyUmU0OVdEc2JtLy9EMUV4?=
 =?utf-8?B?V1NzWXJRMUtWTlcyLzRjYW1FOERJWGJHYnFhczljdm9UcXhQSkVwaUFTUmMw?=
 =?utf-8?B?ZG96eFU4TmlTS1kvam9IU2xueE0vaTdUYVI1dTdsa2V5WHVuNlhFWjdrcC9B?=
 =?utf-8?B?L0R5dDlteDNOM01wWmJXbEZ5SnYxZHM2TWpYV0VheVd2R1RaOFV2KzUxYkNX?=
 =?utf-8?B?cXR1RTRYZXVlYXN0QWtlM3cyZVRsTi9IMnpGV3R3ajg0YVY2bkhnMEQ5VWVz?=
 =?utf-8?B?QXhJclBodXNYTTdXVnJhRXlLeWdtVGdXZnlQdXp1bVp5eXNKYU5NSEdNZkkr?=
 =?utf-8?B?NUtaMlU5eGd0T2w4dXVLT01aTmpyRlJQREMrOFBaM1gwNzYyOTd0N2kvQklF?=
 =?utf-8?B?YWZ3V1lCU3FJdU1aQ05yY0lyaGtmZFE3cC81dFllVWEzdWhXMEg1akc2OTFW?=
 =?utf-8?B?ZndqSWxnNFFDU2p3YWE0VzIxRWFvQ0JzVjRDT1kwbk9GbVd5Zit4ZUNDM1U0?=
 =?utf-8?B?YXhPdkw0QXlySDl3RThvNVBlK21Kb1hnTVlXT3duaG9SakZKUUpyVy9vMjN3?=
 =?utf-8?B?KzUrckVLa3ZVYitXZ05RVXIwcW9DajR3M0hWc01IZjJ0SHF2TUZpa0p5Ujdx?=
 =?utf-8?B?K3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cGEBOSXRG6zaWAHeipQrEeQwlSkm923SENBCR0uwT658DSqm1B4oMOZxekGEqdc0ylcUrHz6vycr9WgeGEK2wdQBprtlxkA1PsQBvUjwNCRXrajruLLED4/OMBZ5eYMMS+KdLU1VeqFpKBoZBBeITkl9XdrLxmnSO/Oqo7humvBJa0hiKmPwcPpVvxKXgYFE7VM4ZcT4W+vkY3aXB1VkMwAJoQnUH6/NeqciG+Tv9lDLlwCtAa8UFXtRJFbHtCs4XqpLvJaw9TdDdGt48CC0c45lEGWpT9WejHGlGwauIuFuk2zM8zj4LtxGidx/5Bgw3H7ylunJ2BYbHmjlxOowpkwc4eKGhk+RUCQ72Bv5pnwIHIVeFmP6jMqkH6aoc3h2UI+TFLJttvj5X8MuT9jld7Xou9BlGKS1GhrFaRwfsP3ZxrXSAavEakKI5CpfkqiOqvHdDaXE/j22IqFdjx/HVAEUgvaEH0lX1YyPCjXF4F1HNTj4Q82Whixg5HrYkGQwPz+smQtyGK4h1HpfRETOlAGEOra/LwG56vRokkcOMSXEjiaaNPJUS74Uq87NHtZ84W54eEtLNOoheVBSgeRdN7cqovoEhov470ZrRhk1RQo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8985076-4a25-4271-b00e-08dda91b168a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 19:06:36.6328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xEX4dfCLLcdEdS9E4SGuHxdUIFqEaRmbhhjlaAVxWR4mSZB6awJDJ7eAIDk9Gb9XsLHFM3AVmtn9nhHfcemBTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5783
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_08,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506110161
X-Authority-Analysis: v=2.4 cv=RZGQC0tv c=1 sm=1 tr=0 ts=6849d3c1 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=w76jtiiuaXXWCIqSKC8A:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
X-Proofpoint-GUID: ezkSxW1mJn1udzLMVA4k9q5ANJlwRFpC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDE2MSBTYWx0ZWRfXxJUN10U19Juk Pf34kyoUHb41RtCScRTeWRDS+xtkGr6LBkvv9egzGAVAkMOBeY1TqztpVb+eLOMeldVZpFgdeCP lL8NO7wjxzbn6mP52K27aL3v1uQAAZnpNiqHALxA0EXsaEWPkKo05FRGB0Z/qY+ZkK8aqXt9ZBl
 ZLUBExwUusH88uq8nm9KTt7r7CdbOHz5yQXICp/uWouORNe+qUkOBDhChne+Xc1rqEUUaP+ni+H JH1S3ndhn4PYdSYvBqxMRNw7XuCOdEbardM3hRameutFO3EVL1OCUcbIlKiOKTMcUIigoVDF0ix Bmla6Pmu995+H0c1SJ5VSRHoXfzeM+hCpR600LGYImWoxcQA9dyX0AOovn2/hvSB10UFFaYFC3O
 DFfQ84SlAu1XnYRo1W58JctFUZMQzuGTCxNb5i49IeEc4LDCaP9QJrluqUNgudSAAuYbmkly
X-Proofpoint-ORIG-GUID: ezkSxW1mJn1udzLMVA4k9q5ANJlwRFpC

On 6/11/25 2:02 PM, Mike Snitzer wrote:
> On Wed, Jun 11, 2025 at 10:16:39AM -0400, Chuck Lever wrote:
>> A few general comments:
>>
>> - Since this isn't a series that you intend I should apply immediately
>> to nfsd-next, let's mark subsequent postings with "RFC".
> 
> Yeah, my first posting should've been RFC.
> 
> But I'd be in favor of working with urgency so that by v6.16-rc4/5 you
> and Jeff are fine with it for the 6.17 merge window.

Since this series doesn't fix a crasher or security bug, and since I
have plenty of other swords in the forge, I can't commit to a
particular landing spot yet.


-- 
Chuck Lever


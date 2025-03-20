Return-Path: <linux-fsdevel+bounces-44525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F097A6A26D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 10:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 683F68A2B31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 09:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58882221F2A;
	Thu, 20 Mar 2025 09:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fqh/Zc9b";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="o7/0n9nQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B9820E32B;
	Thu, 20 Mar 2025 09:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742462400; cv=fail; b=rMpcbdNztdNCmefEaC8QcSSpMpSe+I5QQnlJnD29C2IVEPpz7csN22aQIWOsARNy261Ug0C+cfo9hE1luBW0qslFrK4qDyMDhRujLc3aXmveZmw268zt8YA7CFY43M+FWBlvm/sLQeE+zO/D/Exfyb6Oq+2nuQW/sO8oviI6eSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742462400; c=relaxed/simple;
	bh=ySXnUne+YZWcK7qmUWSwOUBxsYBmCKNKm2UxUf/bB+o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oK8046NB5VUlWXaXC1QbytgnPY4jqavkIbFEaezFL/DZXi8asaF4FcOutAazdw+CNR4U6ZkfLQ994dO3dWrqTJIHHwekL4nX4UMZfLd2EarO2wpXQx5xyKlHAppJfHJW2UG31/K4awDhxgJDen0Yik8GiSzfbkPj5UuoSy0Xxe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fqh/Zc9b; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=o7/0n9nQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52K8C1lN032563;
	Thu, 20 Mar 2025 09:19:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=W1XZBSkO53uN97ePJjBE3KURtKKYOvw1PmNq/PBLXf4=; b=
	fqh/Zc9b80UlFsHlXFerdDePmWH2uMtYZVjsS7ogUIgvG//kRxA7lyQi5sQXSNIF
	+teZNry/OpcoG5T3t1x5hThiMoKkzqzVOv1H8hHKw58lCLlsCv0wmd9YWKhVOU1/
	/D5bEABHxgXoFQbrp2s7DpTJC7p1akzWzIPpakHU4TyT+0bGTBSXcIhTfkVxr+HC
	apSZfgBE/t1471J1U9Q/+Qf4A8JBapV8zcXFyX2uQWfo7DDA26H9yIWcUWAM7Clg
	IwFFOOLmapUAZWXrzQgyEoF6c+5BNJLM9dQeZjTVnHLKok4ViAlLwcO7a8A4GCiw
	IE4JwGgWdNK5l8OiWtkoEg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1m15e73-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 09:19:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52K9EhHj004519;
	Thu, 20 Mar 2025 09:19:46 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ftmwqxtb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 09:19:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y4ujWLojDYkL3mPu106MOqXORUBHA52ETDGybNEtqxBXP+3NLcR6N18Sr+yCgG5u94qqS27GKgDLQmZ6p9Ze/LKRRhab9ew8uvb1a0mMwjxk0dvXvk7Uo/yK5LoqKDpOY8paeEdtp6Eq3Dv5zuUCmPl2Li06WDe6KX3ONlUEB52kQ3CPdznr7Ip2vPOfHzLBm9oRUvLvWyyTn5Vz1zCVRfYlERBhH0x/Qii94QMr731pGRvWRYhnKORLurD/3xyBppn6UoWLZxSJ48woZJr/xj83ifEbbLwxUAYOR7AP0Qrzp7T4djPRw6Ip+6EWMnrg/qmN1hklavdOv1riKTXrkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1XZBSkO53uN97ePJjBE3KURtKKYOvw1PmNq/PBLXf4=;
 b=wjjHy4GDDwZGB6SsqQd6a2CY2OmnZZfcUI4itzUR5TmrmB2ah1bh+DMPYxmM2X4idzpDZsbVpBOj6Dr8z4adamOIwDJJZC344VPTB/HQpbvsp+uXtialOoD0/sKZchNI3mnakGPKdKfNt4O2ueTmE4q0AZKoyiircv1nZ6Cua2BMvec1hMzsBeuQFeZAN7OC39vPVAiLifyVGO0KDPpuLd+v1Hp8xMp/TvkwO74SqW7ZaZjv64QQmS3/3LgB9PL2UqGANpTXM76Z5pW0JZLqbEuq9dMNd2U7/H91HMPSguZRwX8x7/UlAFUR3kVhr2AHdGofrsMwj3XsrIDEt2gSNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1XZBSkO53uN97ePJjBE3KURtKKYOvw1PmNq/PBLXf4=;
 b=o7/0n9nQMl3qydt9RZyYKcMHzVV+XWmqQi51YribZ6XVKeke5tGbvUq7Q9soLNQSJN3Q7I6PueNieXKL1oe/4Fz6JXqFIke/4vOMBFzktHav1UFTx/LBKGMRXrO5cHwKo7rueU7CjZVjptKlrUFF6RHE9UxOSkN2JiuR83I9jbk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA3PR10MB8041.namprd10.prod.outlook.com (2603:10b6:208:514::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 09:19:43 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8534.031; Thu, 20 Mar 2025
 09:19:43 +0000
Message-ID: <c656fa4d-eb76-4caa-8a71-a8d8a2ba6206@oracle.com>
Date: Thu, 20 Mar 2025 09:19:40 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] statx.2: Add stx_atomic_write_unit_max_opt
To: Christoph Hellwig <hch@lst.de>
Cc: alx@kernel.org, brauner@kernel.org, djwong@kernel.org, dchinner@redhat.com,
        linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com
References: <20250319114402.3757248-1-john.g.garry@oracle.com>
 <20250320070048.GA14099@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250320070048.GA14099@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0542.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA3PR10MB8041:EE_
X-MS-Office365-Filtering-Correlation-Id: b4405f96-1ca3-4856-5410-08dd679059b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0NPSUFWQ3Z4RFlQcFRtZ2lHS21hVEFTMERBV1kySzROVDVsVGxnL1MxdnU0?=
 =?utf-8?B?bTF1YTBJZENQYzZzTUJ0b20vOGpqWFN1Znh2RDRMTm9ZTVludmZzak8zd1lr?=
 =?utf-8?B?d0d6SjNVKzB5NWhEcVUzR2R1NWF5WC9paUVyNDVGWVgzUHVyVnNmNWFLS1Vl?=
 =?utf-8?B?M1cwMTRycEI0NUxZUGFPRXpMUFJrOHVXcGRDd1AvNlRIOFBQYXlpcEN1SEM5?=
 =?utf-8?B?S1hIOVdTeGhwdjc3WHRWR2VBYTAvK2pqV3NEU2R2SjBxZWJDTVpLa1VkNXFi?=
 =?utf-8?B?VXV4VitGT1AwMW9OajZnWGZLODJ3QitCSGs5aWJuMnBuWUZOTUZqbk43N1FH?=
 =?utf-8?B?a2dCQm1RWTZtWXY4SjFWaXNCNWtxVHF5ZGZ1aTNiK3p4ZnBDcEZjcGVod2pT?=
 =?utf-8?B?OTFjb2N6TE9sUU4vUXg5UmtmZ29OK3Fpb2RZZDhOMExETmJlVEs3SGdlN1hW?=
 =?utf-8?B?R0VaREFNOGtUUEFoQzVOZVZhc1RCdVdtVHA4Sk03U20wN1A0WFpNdmRBaWlW?=
 =?utf-8?B?Uk5jTVVhdG1UUEVFODdpdzdjY1d0TDdBTTRSOExhN1poUUVmaG9xQnZDSUVy?=
 =?utf-8?B?Z3pKaGpFOHllbHpyenA3dG4vWkp6RUJyNThGMktuN0hqUnFMNURzYUJtR3Vr?=
 =?utf-8?B?VGhtRGpTT0hqTWhKRWFIaHpXNnBjLzFsWjQ4S2V3T0VSVFlrNEN4d3VqTktG?=
 =?utf-8?B?aHpkTDZFV0xXbERCaGcxV1dwWkRmVUVSMVFEd09sdTlZQWNGVHFzU0xidDh6?=
 =?utf-8?B?SnR3VFBGOWdFQnVObW95bGpWRkc5dDZZZE9UZ3B3NDFhYTJxWVNPQmRjMnc2?=
 =?utf-8?B?cnk1YkRON0Y5dUhUUnlITXBFNmV1MGpsN3VuaGFjZXhHL3hMTnBSb1Jnakhu?=
 =?utf-8?B?VHFZZzExMk1xdUYxSWRWS3V5SVJqZUl2bmlIUC90ejlyMlQzWDVyS2pLdnBr?=
 =?utf-8?B?bFh6ZEN1c0ZTRUp0N0RZMGRjSXp2aHFxQjF6cDQ1SUVVQkN1WkhjUlpYMWE5?=
 =?utf-8?B?Y0doeWcrdjIvYi9EZ3h4NlVYbXk4MEF1K24zMGtwRUtaYzlzN29YRGxZRmRO?=
 =?utf-8?B?SGZTQjA1Z2hJempvZ3V6ckY1R3R1Rk14Ylc4Ti9xbUs3MlFIV3BpQ3lDRXFF?=
 =?utf-8?B?T0phRE1TcEJKa3BBRW0yUFNqQU11YnJXdWtVRVplWVpXNmRkc2ZDRXd5REpr?=
 =?utf-8?B?Y2VVMkZWWXo1bkUrM0w2VE5OVmRmbEczYUVGMk5acUpheTZkb2JUa3hnTU9R?=
 =?utf-8?B?QUNNaC9sallidzcwb01lRXJ5eU5vcmpsWHBMZmxZRm41TXEwR3hpR0J5NGds?=
 =?utf-8?B?Zjh5VVQraW1uclFpL3NiVFJ2b1ZHMzVFTG5hV3pNL2lCamRmaHphbXE1NjhF?=
 =?utf-8?B?c2tGQS9RWDR3Ly9YZDEwTlJpOEtMWmlSQ2Y3d1o5Nkt3YnVYNUhZeUpzcDAz?=
 =?utf-8?B?eGs0WnZnNXNlbko5eU9YNXBlZFM3Um9PN3kxazgrNm5iU1A5Y1FvMG9aYndB?=
 =?utf-8?B?bmsrYkdYSG04SHZmTEhaVzdCbHpaZmxZNXZyZkxUOXNuT05qUTlRZzNSTjc4?=
 =?utf-8?B?WkNDdi96aUJjdndxSGNMYUI0cm16bEVwUjdBTUorV1BzbXREYlFWQkY2VEZX?=
 =?utf-8?B?OXJtOStTQUl1L0ZXQWFERTNqdy9FTjNOK1lTdGwweEFwS2FqeEl2MGYrZXUx?=
 =?utf-8?B?d3paUHd3NjluRHVqNEVwVXcvYk80WmtUYS9nSDJUNzRVaFBZcDdsV05uZjB1?=
 =?utf-8?B?cDNpWVNZWFdhTGRCQjNCUkU1ZHppbkVKbkZ2bkRvc0gxRGNBYy9jM3lYNUkz?=
 =?utf-8?B?czl4WnNoNDZGWi9GWkRqbmUrR2dwYm5UOWs5eklyd1BsZ0ZzOGdVajFLTXZh?=
 =?utf-8?Q?Ja18RbZurNyAq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VnJheGdYd2YvMmZYeXRDNzZBUGtnaGdMazJ2QWk2SkJPWE9ZaE1JTmpmbWE0?=
 =?utf-8?B?RmV2QlYyUVNDR3dXeWpobURJVEhiZXVOZ3FSTjFTdkZSMUxmWFM4UWdZMUlh?=
 =?utf-8?B?SG9YOEpuQ1ZpT1NMRHJuL3FKc3pSNkJzcjRQVWp0bDdlK3BxNGVjeTBvTW1i?=
 =?utf-8?B?anF3cUdlUXpMSkNMRTVteWxnRkRyV3ZaZzQ4QjB5Nlp4c2xQMTU2cVNNNzl6?=
 =?utf-8?B?K0FURVJ4c0xSekV3V1JLWERqWGwrekU3Si94aVp5bzg0TkdEQVZVMlFnaHEz?=
 =?utf-8?B?UzBGUVB0Rk9kOFYxUjF4V3BXYVU0VjU3WGpDbzVwbXZIbmlSTzhGOG1pUXpC?=
 =?utf-8?B?Wkx2SEN2YjdJODBkbFQwc0VqUFdsN3ExL25GNlNzd1FLcm05R1RzSmFWOWFI?=
 =?utf-8?B?QytOaVk0MFJjTW12OUJBR014Zk5YNEczU2ltcHRKRk4xMjNBdGtKNVp6bHNJ?=
 =?utf-8?B?eVF0RTFyZlptRnAyaUFnYk45T3FlOEh4TkFvS3Zqb0lVS2dOK0VqVEt3NXcy?=
 =?utf-8?B?RkRlYjNvSlFtTnM3RzQ5WmFDYjE4MDRqL01xRHRwZEJVVFZrem5xdStFK2FO?=
 =?utf-8?B?dGltTy9PbzVnM1ZhZDNEc3NwODJUd1dHaWdNbUFZNjJjN09CYnBvZTBzR1lK?=
 =?utf-8?B?ZmMxcWNGZmsrcThtbmd0TUsvN0dxd2pVUmhkQTdENzVZdjV6QXRQdVBhWi91?=
 =?utf-8?B?bDFKZ0FnL1pRQ0U2MmZRVVFlUmhhUUljRFlzcTdjUjcrb0xLMnVWeWpxWWhi?=
 =?utf-8?B?bUd3TTV0TWhCeWdtM1hQVEczV2k2TG9NQUt0bSszbHpMcjIvTjJRbk9scGpv?=
 =?utf-8?B?bzE4dnpIMGR4K0MrOHp5Y2xYK0ZRLzArRGtpQ3Z3YWNUY1BxN3N2ZlBaSnls?=
 =?utf-8?B?UHQrMVMra0d3cTNPdUZld3JUTFZlb0lRdnQrUGdFVEg5Smc2QWxTdWE1azRP?=
 =?utf-8?B?aVVTQlVOR2hjc2wvUlRDT2Y2NWlDbE91VVRCV3ZIRzlxYlpxK2Vaam5GajBJ?=
 =?utf-8?B?Qm5GaFNkRGRTMUltYTV3VG93TnVSMlU5b0hGZm1nMm5XSE1iT2FHbUtSdFRX?=
 =?utf-8?B?MkhKQnFpNzFnTk5tbHIreWgzVEJiM3ZtODNZNndDcG1nODZoakJpbWJ1Sk1X?=
 =?utf-8?B?VnpOQUFOL09RdkkwWXRLQWFYUXNSY1RwcnlNb2MvZzBvUlFURWw1bko2VEox?=
 =?utf-8?B?TnNOdjhmaFlEQ1NXSlJtdzlVOXNqSG5VYkE3L1pyemRISXVmR2t2QWdQZ3J3?=
 =?utf-8?B?b0FFSXI2bmFHNG9aV2p1WVNTS3JrSDNnRGlrQ0JHVkZZZ1B2eDUwOStZamh0?=
 =?utf-8?B?cEpybitNRWY5ai82R3BjNU5wMDg2djdKUGZ4dHNMOEZCYkl0b1hwU1ZNVlFr?=
 =?utf-8?B?SFd4UVVkT3BPUmxORU93d0dqWkxPcks3WFdzUWZpcU5PeEw2SzRnQUZKMHAx?=
 =?utf-8?B?S2xXeHFrMEoxMzFibmhURlN0c29NanZ5RzlYNmZNSnAyYTR1V0o3TVFtYnQ2?=
 =?utf-8?B?bjhGcUUvSDNsV3kvZ0tGTHpUUE5BWmNRY05xemxDa1phVU5JVWFFZFdKa2FX?=
 =?utf-8?B?WVNYU0syc0J4YkhUd3NQd1FKcFRXUnEzQ1kwak5ocTZBaFpjQkR3cHphNXZy?=
 =?utf-8?B?UW92a1pLaEhpQjRHWEpWeGV3ellRT3hLcm16cHBPZ3NWaWpvRWQ5eDRpdGEv?=
 =?utf-8?B?ZE9pK3hzWWtacE43K2oxN1ErVlVUYmtLVzllNEo2MnoxNVhJV1Rud2RLYVUx?=
 =?utf-8?B?TVRMWnZldExDYm4wemU4bmQ1TW9PSTNVNWlQMTh1TkVSSzQ2UHN5Q3BoTE05?=
 =?utf-8?B?TWVQM0xNNjB2czFnaW1VWUtHU3VZQThWUVdmbERLa2x1cS9xTmVGMXo4aGww?=
 =?utf-8?B?VnR1WFRJT3Q4QWw5aHBkQTBjZ09zczdKUjFtazJnK0R2MkdqaDlycDBvZnE5?=
 =?utf-8?B?QUkwcU1lTFBKekFrd0pHVkljbnJ6YmVNY2hjdjhEMUVDcjRoNWdJaE1QS29M?=
 =?utf-8?B?L01XY2h2ejE4VjE1UFNsQjc2cWNHNXNFdzI1WWtJU3lMQmdzWDk0V0JXVlMx?=
 =?utf-8?B?aW8vbEIySGtiVkRUbFNEbWxNeTRYWDJKMFQrc2piNmx1ZXB2QUk5bVNRT0tr?=
 =?utf-8?B?cWRocDdOOXlJODRtWWZGWWI2MjQ4Ynd3Smg4SGVmdEFXbG9TcGN4UUFXSFZ6?=
 =?utf-8?B?cFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8UMLCh2XOEoZyCCpDL5yf2F7TJPfucQrhBbT1PlnaqOKlJoM5gxViFm+HXJh93UZ014V9FALCsIuENwmLRiVpEXAV1N7U+ARB+nq2dtkDWgRLSjaexpotv6GXC2BEwW1qZOEW7H4qQb9qc8W6HLZLR3PqTGjV+QAOabVeE8cSiNkGHAnauP6JlG58SodTBtR+cWjQOeUYdoR0jjvFaNXLOma+gDFUbVMdemLkzBhb43fxUkJnWrMvAcrCRH8v1Xob1YU19NrLBajWRzTKoJHKEUNZ3zY8tPWcUaZ8PGUxHiPZluh/scI/RVs5KOYu8F12RE0Ewb3clQAwUTIakPiv/3gcZgAsKmhAzLWlRfMW7lgkJwjBZqvfkoVqj1RiRAYTaytCDKA6doXHH3Bc5Ku42CN8Jfv56x808cnqXtBwLFVWFI0pRjx6KYziMuNkCa+o4W9tdqWcmy/4IhmQbRzA125k5zbdtQWb92V6VH4iCxibwrVP7fAY0VwNxd1iGD+sokBqjQ1bHoxZUy9sD4G/k6c6CbgJ53tSqjDCk5ac9wdPv7/Tlzs6tEO2tSpr9GjjRT3KgeoS+ZFj9DqozhqnHIYsWlnipoAMLNBkAINLU8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4405f96-1ca3-4856-5410-08dd679059b9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 09:19:43.7121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: svJNhYS0TMI49d7RH3t8CMHegx5QllTXq7JW1W9ZMIWveuiUlMWnDenGmeXzwaiJEN5poeZiBSxOOS4lNbLRHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8041
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_03,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503200056
X-Proofpoint-GUID: lNfLBavpI6nn0xhB4DJgwpfHecWVwhap
X-Proofpoint-ORIG-GUID: lNfLBavpI6nn0xhB4DJgwpfHecWVwhap

On 20/03/2025 07:00, Christoph Hellwig wrote:
> On Wed, Mar 19, 2025 at 11:44:02AM +0000, John Garry wrote:
>> XFS supports atomic writes - or untorn writes - based on different methods:
>> - HW offload in the disk
>> - Software emulation
>>
>> The value reported in stx_atomic_write_unit_max will be the max of the
>> software emulation method.
> 
> I don't think emulation is a good word.  A file system implementing
> file systems things is not emulation.

Sure, I am still in the mindset that a filesystem-based atomic write is 
a 2nd-class citizen and just trying to emulate what can be done in the disk.

> 
>> We want STATX_WRITE_ATOMIC to get this new member in addition to the
>> already-existing members, so mention that a value of 0 means that
>> stx_atomic_write_unit_max holds this limit.
> 
> Does that actually work?  Can userspace assume all unknown statx
> fields are padded to zero?  If so my dio read align change could have
> done away with the extra flag.

I will double check that, but if we needed to add another mask just for 
getting this, then yuck.

> 
> 
But is there value in reporting this limit? I am not sure. I am not sure 
what the user would do with this info.

Maybe, for example, they want to write 1K consecutive 16K pages, each 
atomically, and decide to do a big 16M atomic write but find that it is 
slow as bdev atomic limit is < 16M.

Maybe I should just update the documentation to mention that for XFS 
they should check the mounted bdev atomic limits.


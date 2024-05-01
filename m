Return-Path: <linux-fsdevel+bounces-18424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1068B88F0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 13:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DF432823B7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 11:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBCA7FBA1;
	Wed,  1 May 2024 11:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZZt47ygF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Xpwb0VJu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A54A5E22C;
	Wed,  1 May 2024 11:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714561754; cv=fail; b=uQdYJ0mU1iVh8gI2QtxNh1zPsiVvfm6m3lx5/bpxeql5xDwJkA59svfhBAUc/3MwXQKEGedbtXv4Ga/YVtNCBb+39bA5fafur2/NDayM2yDgXcXkPxhP5KHwl6Z9VgxRYEFtOR1bgTYtyUy4CElf2LOUX8ul6lGH5l7K2XpPoMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714561754; c=relaxed/simple;
	bh=98qN0Kbp1wntBJl+9A8Rf7tA/SHxxWeXErN6WHZccHs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oZEOJ/2Gr/djBnEVMPOA3MT3P3bXIdIqTb3acOaJYPy+Hm7sAAXzki8fwKOs4oNl0Tg6F3s73bva8OCRF/BvEzFFWaKnin9N6Sv2eS2F5QnnpAhLOhwStsSqs1hyCM04JwvSLYL+uhB/Im5iXOrYcmpMHRfd7c4DJNIjgVZSiDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZZt47ygF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Xpwb0VJu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 441ARplC028249;
	Wed, 1 May 2024 11:08:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=9M6J1i9dP1b5Yx5OmdBGcWwm8QLPs3bsG/Sms+vR+Lk=;
 b=ZZt47ygFbVZO8cGgU+582CRGfoOxdEQ78Ti5ab3CEet6s6KY+i0Y1yzhOP9VRfc0OewN
 XIw/wVjZZBZC9C/Ug/qZphsQX30/8TC2i5AjEqBEzCA4GR5DfU/2laoT3Fl4yLzv2LhV
 VKu73/mhVggKb/KrudQobzst6i1AM1TUc5D3HVKhuFzQlYNqLzsKkQhirZnJ0AweKoaP
 ovf7OtfB7q15RmXZDB34l9bzrIp5xwl60ylnKTOlDCD5ZiOL3/lVBIT85hnm7L8SIS86
 espaR2aDwy7qER1iOwUtsI+sWIZPoPfpPllr+x/BGNN2cx5R1yRDyrezyg+Lbvl0jp+U 7A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrswvq150-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 May 2024 11:08:44 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 441A3qQX005115;
	Wed, 1 May 2024 11:08:43 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqt8pp75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 May 2024 11:08:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9hzMskyO9bzdg0C4h3CN3u2uR+A0fwkmnevA3IUkNzEQclmZtO5OJkRl/BdoWvbAGf7APj6aeoYlwqynzmzg8HdskAh1FZLfSCFnx8Pbij6SKkesn1Qn0d+dLXKuzohSjjeC3tpdU9YyHrDx2rQBun0E3NxvtxY8rxWjRSgNuZcbM7aX5vpuQBV7xOFMwPv0fNvt80dvCUnCZ5HvWK4yco/jcNQobcQm17vvt2b+hei5vYMzajTvuKcDYZgaYh5fyf7kk00QiU+qewgq4xdQsGW0EVMs/B3MhVxuO+QxZ0VWcMC+t/sow6K+gKlUu+X4PeUxGYduE2L8Ap/lJ4vxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9M6J1i9dP1b5Yx5OmdBGcWwm8QLPs3bsG/Sms+vR+Lk=;
 b=J+nOqaHiPPn0OJZrsEL9lLcftNIgG+YahwodhfCgXheajJpFvS8V5acuohzLsDxmwa682m+SWt2KCxvbXp2xmNzxcMtRnH/kSfzL9WrJqrIngNE5+ZWRurS1xGCi1dP3yWYyMg98c2qQ/XSBSL6wI3Sta5MoIpZ28zC3l1PWBAbH29JtKrMFjqlIgGmDGtpphhVyhBxyIAKwsrr+wUTf1toX5hXhAgfa5yCaR5bPyBIjKsJKc0lRQtejx5PAUuscE6hY/WbZI3U0hRTXUyGV8Fw+rWt42aujibsnL38YyKC1xUa7W9Eus3vqwFff7qLG2g55Z1QWSQfpNgIfzavZPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9M6J1i9dP1b5Yx5OmdBGcWwm8QLPs3bsG/Sms+vR+Lk=;
 b=Xpwb0VJuTUAbsBTn/GIYnJjbWgiv2x/UG6iDql3Gp7TiaP9gK2x3wymnXlIgd6QC4phBKu6F41xTVOPARzHKEXzDcmHAxDT0nQSVLMoyQ9cPG0z9pGaMSE91l23W+vT+7ME5T+LlH+p6OBd9SU3I59tNt1lE/8wUIAc0O0erCqs=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CO1PR10MB4642.namprd10.prod.outlook.com (2603:10b6:303:6f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Wed, 1 May
 2024 11:08:41 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.7544.023; Wed, 1 May 2024
 11:08:41 +0000
Message-ID: <d39c46b7-185c-4175-b909-2ba307c177c9@oracle.com>
Date: Wed, 1 May 2024 12:08:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/21] iomap: Atomic write support
To: Dave Chinner <david@fromorbit.com>
Cc: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, chandan.babu@oracle.com, willy@infradead.org,
        axboe@kernel.dk, martin.petersen@oracle.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, mcgrof@kernel.org, p.raghav@samsung.com,
        linux-xfs@vger.kernel.org, catherine.hoang@oracle.com
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
 <20240429174746.2132161-18-john.g.garry@oracle.com>
 <ZjGfOyJl5y3D49fC@dread.disaster.area>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZjGfOyJl5y3D49fC@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR10CA0016.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::8) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CO1PR10MB4642:EE_
X-MS-Office365-Filtering-Correlation-Id: 562a97f3-e712-493c-dbaf-08dc69cf0ef7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005|7416005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TS9oNG9ZbUtMVWRBRWFDQS9lWUswV0dxb1dtbGF4anhwQkhGT2xhMXpWaDRD?=
 =?utf-8?B?ckVNdHgzODVQMSs2blhZMU9PQ2xzbmdjYS8wN05TWDU1NXZ6SlQ2bFRYSjVF?=
 =?utf-8?B?T3F5a2NWcDZ4cUUwNnYyMVplOHdGclFlOWdwaVFDR25qVjMvblIwWmRkZkVL?=
 =?utf-8?B?ZW4vazBLcU5CWDlpa24zbWZPZVVzWlErcFZ3RlRTMDhVTGNXdWRLVGk2ODB1?=
 =?utf-8?B?M3EzSTlzcWQyd1p5VXNFdE10Y0hlcGRYWHYrSnBlSlB1bXY0M2I1SUcxRHh1?=
 =?utf-8?B?ODFObDFzak9iOUJ4YWhqK1J6d0pHWVRzVFJVb25Lek10b3VXWGRWTkg5SGQw?=
 =?utf-8?B?Y3MyOGRXUVBYc1Ntakw2Q3lZdkxLZzR2d21FMkt3TVg3M3VpKzFWY0FnM1dx?=
 =?utf-8?B?N2xPYXhEd05TZTVwdUZzY0JIbFh3ZzhlcHUrdVJyN0ViVFJ2MSt2OFI3RzQ1?=
 =?utf-8?B?eS9xbHhCUmdCU3dnNVhrZ2xDeWdxeVVKMUV3cEplMmxneEFrdnBKc1NqNTdN?=
 =?utf-8?B?bENITHB3WkRDWVlyMzRXV3RaTUZLdGNSRlAyRDhmM2tsNWh4RmQwVHV6bmV4?=
 =?utf-8?B?R0FHNmcxNTF2eHVORkwxK3FVT1NsSWJ5c3R2eGJkN29MbmVvcTNLaDdWSTVy?=
 =?utf-8?B?WEIzcVJ3d3dUbU5QWUhWT1F2WjJQVDRiTmwyR1p2SzBZTmFpVlFkUjNpWWRK?=
 =?utf-8?B?SDI4RFRmODkrMnUrcTA3MTBlSVpsOTNuR2VpNTB4TWZOYWRTaGhSTWRJV3I0?=
 =?utf-8?B?ZFJmWlRDemZ4VHBqNUVZR3VyWTZKVXpqTTVsbHZleXZwTkZIdjBoTUxxenR0?=
 =?utf-8?B?TlVHc04zL2NqTDlEN1Jlb0tLeEhFQ1NqZ29QNm5XUDVtTzc4R0lrSytxWmF5?=
 =?utf-8?B?YlpmeWhnUXV0NFVadi9HRElkcWxBKzBtT09wWlRrVnJYRGpORnlFRVhQWWRk?=
 =?utf-8?B?NDFvUjYraC9DdmZQeXhBTmFKbkpNSWIwQ3NCWFdQS2F4TUVveVhFSGJUd0NW?=
 =?utf-8?B?UlRpSW1PQ0dLSEVMTzA2UytEdlJ2bkY0NkI0TTBib0JOUmNMQTY2dFBkWnBX?=
 =?utf-8?B?TDFVcTRXNThTM0Q2RExwRVJxeWFSVjhrakt0NnVCUUNIU2lyaWtBamxGNnFF?=
 =?utf-8?B?RCtVYnVSdS82WUs2bnpVWW1abGIzdytIbTNhL2UrMlZETE85TU9ZcWw3R3hO?=
 =?utf-8?B?RmQ1MUxhdGZCc0dNWVdmWGgySlpBNE05Y0hvdVBLZXlwdTNtaWcxWkRtclNx?=
 =?utf-8?B?eEkyK09pRGN0N2RxTlJwaVBzUnAveVpESXpGcWRTanVjekF6Z0lZdzBPV2Fm?=
 =?utf-8?B?QVhZS0hVMzhrNXNCNllyL3hSWnM1VEQ5VGtZZjB0dGk0TTV6NHFDeDJsTDIz?=
 =?utf-8?B?elBBZWNwY0s1alZodk9GL3MrZlM4RS85dUV6eTZEOG5RbmdJSUtjQzNHMTRl?=
 =?utf-8?B?ZTRrL1Z2VUpRbnMyYW4xYStUVFNpblhWbXhoVDFRNjJwbk1PUEhQM0d2dS9n?=
 =?utf-8?B?aGIvZ2UzU1JLb1BUR3I4bFBBcUxTclVaWjdxRHlWcDRJQlBJb0tZSXJKZFcw?=
 =?utf-8?B?S0tnV3R1VGNMRjYrYzJQNE91K0w0NGhLcGhsOG1ETC9OcitaL3FwaGVvTXhV?=
 =?utf-8?B?M0Ixd3FjUDE2QTNkUC8renptdlNoRUczc1VKMjJlVkM3enlObGJQUjFyeG13?=
 =?utf-8?B?QXdRQ0JWQWRzcnFnU21oTTV1MVJKaDFSaUpBdUFpdUhvSnc1V3NSUDZnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ajFLd29OZ1ZydTB0UW5ZakU0MmhsdzNrd0N5Yi8xK3Fma015VTZjWDZxYUl5?=
 =?utf-8?B?bTdXQXJickVMcVVvWCtVM0ZxcG9icW5PTCsxM3F4TCtSRjRnbDRDaG14cEtv?=
 =?utf-8?B?UUNCSERrMFhWVkNSbW9kZ2UvaUp1MFJiMUpvb1pocjcyVzVRbWNoYlVEbnAz?=
 =?utf-8?B?R3VuU0FuYTBsNlVlS0JTQjFZaFBWYlVwMWJEYzNhZFFMcFRUQ1NPSm1WaU1j?=
 =?utf-8?B?NGFLVGluRzVRbDlBLzhqMXMwUXpaNk1weUFhazl4Qi9heThLaVlxM0YwdUMv?=
 =?utf-8?B?WE9Qa3p5d1RrWTIydllQUXJJMUgzbHliRGNZL3BiWE9WdFgrdmhPL0NxUndR?=
 =?utf-8?B?MHdoeVdoOEdHL21vQlY5VTdGL1d6YlVCZERQckt2YjFKTTl6UEpnK2ZqMTFv?=
 =?utf-8?B?eGl0ODQ2czRsN3ZHM0JzZDdaa0x4bTVodXdldXo1NVVKUDl6WTdVUHI2VXY0?=
 =?utf-8?B?VE4rT01jaG9sVEhJaVlGcWQ0TFp5VzFwcnlJeG4zL2ordDRMVy9zOE15WXhT?=
 =?utf-8?B?WEFpaXh2aFFPSVEzTUdOZ1FCMlltZlM4c0p0aDlHQWtXbytlMGNqK1lRbEMx?=
 =?utf-8?B?eXZ4MGQxS0xnNnd5eWlzSmczSE1YMVl2MG9pQkk3QTlMY0FrL2V6VGwyQVlR?=
 =?utf-8?B?Vm1GVW1BdWozQ0xZUHdWWEtBY01xSkluTWZ6bm1yUTAwTEF2VG5xTXYvbjk1?=
 =?utf-8?B?MFVmK3NxYmZSTHdUTjh2NW1ORUJWanJicFJWVFVSTXF0cEI1a015SVJaYjZK?=
 =?utf-8?B?anZYdmsxOFFRRGdSNjdCcHRMbzVYTCtpbVZHVTIrdVBDdmFIYXk0RXVIUkdv?=
 =?utf-8?B?TThsMlRGQi9wNXNsanpFc2JTcFYybGF6QldHSnM4RUN4VFJVeDdvUXdnMTgy?=
 =?utf-8?B?ZXc3V21ITG1TRzlidVVLN3poRm15QnZ1THdZSktNR2lYUVNxRGo1cjdKNVhk?=
 =?utf-8?B?VFV4ckpZQmRtdklEa3AwV3ZVLzl3NU1ZSDNVVUNPbVVTendpMXBLTTdFelIz?=
 =?utf-8?B?RjFhU0lPSU5TSzNINmpYL0tobTAwdzlDWmJMSW5OZjBDS3d0SS9qMDBTM2ZC?=
 =?utf-8?B?QzBhREtWaGR4OXUwU2hTWmdHQ2lsNko0THIwdlBiRkdpamhsWDFoWGxtbmY4?=
 =?utf-8?B?bWpyLzZPMjZCTWJiRXN0K0ltcm16SGtjKzV4aFQzU3VRRWZuKzJ3WVl5ZmJl?=
 =?utf-8?B?ZS9TMjlXZmhySG5wVE8rOG1xUS9wTExHZ2s4elhPWTBvMytVcHpWQTBNYWZH?=
 =?utf-8?B?dk9GTlp2bnNQUUFrellGR0pyTHIyQnYwUUNkQWZFSDdQZ3lkVGhpWW5Ta2dk?=
 =?utf-8?B?WCt0WStOaHpjOHk1cDhVZjAxMGFFTTVkVWhjSG9oVjArbTdtUmo1V0ExWGdw?=
 =?utf-8?B?ZzdyaGpicUYrY2RVTUpvRm9xcFRXYXdISURQVU1MSEtjSWl3eVRCNUdyWE5C?=
 =?utf-8?B?aGI2WGlQZ3lmWVlhazRwMXNPblQzMmZnQ1JpbEpwVFdRdGF0WjhuTnJ5S3U4?=
 =?utf-8?B?ZlhsYWZVcEtiL2crMXp0NGJONGNSMUg0cTM0aVc1U0pOUGQvNHd1WmcvdFZJ?=
 =?utf-8?B?TmUzSlpicUNzV0QrSGpkREpxbldETlQwK1FTR2loQWU2Q1BsOGFaNDdkclFv?=
 =?utf-8?B?TFNJWUNBSlkwazVGL1NsZy9lRzdNVnFaQTEwcUFNYkMrL0RvVTdqcGUvUkNT?=
 =?utf-8?B?Z3pZZ2p6cE9LQ2NWc3JrWkZYcjMvOWxjWFJ6L0hMaUUyV2RLTTMzb2JBM09W?=
 =?utf-8?B?UCtSQ1N5YWZ2UlF0M2FnNEdVMnRpQ0V2N0pjT3V4ODJ4TjgzQ3pMUW1YOUJG?=
 =?utf-8?B?bERNcld0NXAwWlpBejYzNVJTUDVtcFlVMnpLMENjcjZFbFB5OUdKY2EvYXNM?=
 =?utf-8?B?VFN5em9YK1hXSGVsTmlhRDBhWmVVNjRWczJvQU5Wb0wwanIxV00vVEhIemE5?=
 =?utf-8?B?ZGxacVZuM28wRFAwYmtNTkwxNVI3LzNLSG1VN3FJZEpzVHQyVk1ramFydWdV?=
 =?utf-8?B?dEM5bk9FOXpXQlIrVTRiWUptZktpRk5BanJGM3JKbDFGbnpIT29QSlhTVHF3?=
 =?utf-8?B?V3g0K3dHQmtDblJKeXNrQlVaTlBQWExzcC9laVEzS1FqZjlkdFBRMFpNWkdW?=
 =?utf-8?B?TGNlcTArNDVjaExtaXlGRjZnRk4zOUtQb1cwM2VwV2FzOWhlRkRxSjFhYURT?=
 =?utf-8?B?dmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Sk36+BuIu/K5KM3OfWw71EwkF7jF/8GxhJIXgadFJ74PaOpVsQQHIuXkLculq+QJPzA+UJiyh7lB1W0AVXSSGCUzDSw9H5aLNaOaGZH+Y7+G5a1OEBvMDg0QJgP+ChNmJZAg4I0xkpClKQ42V0O4mE5sfF1Ksbk7C7+mn+8oYEy+NsIMk64ZeatscTNY683k4jEvIbDImeicoWw3ZyE0FbsRtHdDjnd89C1sWWEHEQNyJYmsLd+4T/DyOJkysEc2JV9qgIwPVCip2XQ2c4KB7DDOXY0KMZtsYTyClA3fTAhcCgk9VJbBlbJ8zm8MBR3qNLtEep2DL5Fzmxrw03dJETJZzq21K+anqy2CECRmO9ixOIOJ6FIcU4AFsq+Gc5hKgJa/j+CEdc7DAvijw9Mr9IV4bApQaKOnIqY9O4vxI3mfGNLaUX6ZqUuw2mVHxcjsIm9QJEEahmEuxaHrxAmXCTcq+nAauoG9w9P8u+07s87AHj6MdaW4mo9aVOy35dFUryIjQJWNUXtciEkQsy1/tk/IeHkia2unYNEjADbb6pDUh3Z9SNtzb3fm8i2zW1/P4MrH9k6LS9O78ExrgqxqVifHnTuw6UQyBoOEHvXeFgI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 562a97f3-e712-493c-dbaf-08dc69cf0ef7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 11:08:41.3076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FFcVSlDCIGUz6II4LtdoiFNG/xPvAjuunLLo0HXHsS/R/i+9ONHhfWVYRaGfCp7TYu5Bx0hZTIfmiW/qQ10Ygg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4642
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_10,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405010078
X-Proofpoint-GUID: nEEYLxfjBIPD9_47D783veiaDzdEB9ov
X-Proofpoint-ORIG-GUID: nEEYLxfjBIPD9_47D783veiaDzdEB9ov

On 01/05/2024 02:47, Dave Chinner wrote:
> On Mon, Apr 29, 2024 at 05:47:42PM +0000, John Garry wrote:
>> Support atomic writes by producing a single BIO with REQ_ATOMIC flag set.
>>
>> We rely on the FS to guarantee extent alignment, such that an atomic write
>> should never straddle two or more extents. The FS should also check for
>> validity of an atomic write length/alignment.
>>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   fs/iomap/direct-io.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
>> index a3ed7cfa95bc..d7bdeb675068 100644
>> --- a/fs/iomap/direct-io.c
>> +++ b/fs/iomap/direct-io.c
>> @@ -275,6 +275,7 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
>>   static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>>   		struct iomap_dio *dio)
>>   {
>> +	bool is_atomic = dio->iocb->ki_flags & IOCB_ATOMIC;
>>   	const struct iomap *iomap = &iter->iomap;
>>   	struct inode *inode = iter->inode;
>>   	unsigned int zeroing_size, pad;
>> @@ -387,6 +388,9 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>>   		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
>>   		bio->bi_write_hint = inode->i_write_hint;
>>   		bio->bi_ioprio = dio->iocb->ki_ioprio;
>> +		if (is_atomic)
>> +			bio->bi_opf |= REQ_ATOMIC;
> 
> REQ_ATOMIC is only valid for write IO, isn't it?

yes, it is. We reject RWF_ATOMIC for a READ.

> 
> This should be added in iomap_dio_bio_opflags() after it is
> determined we are doing a write operation.  Regardless, it should be
> added in iomap_dio_bio_opflags(), not here. That also allows us to
> get rid of the is_atomic variable.

ok

> 
>> +
>>   		bio->bi_private = dio;
>>   		bio->bi_end_io = iomap_dio_bio_end_io;
>>   
>> @@ -403,6 +407,12 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>>   		}
>>   
>>   		n = bio->bi_iter.bi_size;
>> +		if (is_atomic && n != orig_count) {
>> +			/* This bio should have covered the complete length */
>> +			ret = -EINVAL;
>> +			bio_put(bio);
>> +			goto out;
>> +		}
> 
> What happens now if we've done zeroing IO before this? I suspect we
> might expose stale data if the partial block zeroing converts the
> unwritten extent in full...

We use iomap_dio.ref to ensure that __iomap_dio_rw() does not return 
until any zeroing and actual sub-io block write completes. See 
iomap_dio_zero() -> iomap_dio_submit_bio() -> atomic_inc(&dio->ref) 
callchain. I meant to add such info to the commit message, as you 
questioned this previously.

> 
>>   		if (dio->flags & IOMAP_DIO_WRITE) {
>>   			task_io_account_write(n);
>>   		} else {
> 
> Ignoring the error handling issues, this code might be better as:
> 
> 		if (dio->flags & IOMAP_DIO_WRITE) {
> 			if ((opflags & REQ_ATOMIC) && n != orig_count) {
> 				/* atomic writes are all or nothing */
> 				ret = -EIO
> 				bio_put(bio);
> 				goto out;
> 			}
> 		}
> 
> so that we are not putting atomic write error checks in the read IO
> submission path.
> 

Maybe, I'll look at a rework with the suggested change to use 
iomap_dio_bio_opflags() - I actually thought that I introduced a change 
to use iomap_dio_bio_opflags() previously...

BTW, we need to return -EINVAL, as this is what userspace expects for 
such an error.

Thanks,
John



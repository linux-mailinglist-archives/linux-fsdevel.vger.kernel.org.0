Return-Path: <linux-fsdevel+bounces-18476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0BF8B95F7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 09:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35634282E25
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 07:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901A332C8E;
	Thu,  2 May 2024 07:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XoGzgCko";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IhdB4aMi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD931527BD;
	Thu,  2 May 2024 07:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714636643; cv=fail; b=ZB2fRNHOUdpnDh4nohA2kNb8CYcOkQmIRlYsNkiz5Wp+saB1aPmpOWAgEEgr2PhH4HIcYth/fOz1Nm4xyOXBxX4uKw2YAIFfNspXDTPSROZ+RAUQO4j7Q+8hE7ZNp+C+gZDrm2H4UCq3/HqZy7darczMokRvhXhJbPWsT01gN/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714636643; c=relaxed/simple;
	bh=luJ3k8CbAW0Ko1tFdfuJRcplY0iI0xD5eb/m4YD8zBY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JbRO4PE00L78ZrEft1mJxNxLHWfDKtxZddP5PQKicEPUdT68cnUmVDR/I9+zu5SwnJaZvIUzbZwtLTVVq0wenh85YK9dgGc9ebwTjJybF5xoSTubQgRAAg/Jwrjv/P6b18HWqW2rNK/QMdlUBw0xOJ23h8L1GZYvF2I8wZQGSZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XoGzgCko; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IhdB4aMi; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4426U1sX005285;
	Thu, 2 May 2024 07:56:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=VELNTqVEtkWDHTBI+f3TYzE93eJE0d1K/8nP7Qs+WeQ=;
 b=XoGzgCkoeBbLV3fGoxNdyKiPhWB99eyUtfRpJemdMlQUj6jN5YxG5DLjm6cYp6Ou8Ue9
 gEekQL1BfTl+x3GvtJroQs95eAcWPc+C2l5RnfeRo8kJ3YMr8VUbqBek8r3Q6HdDvB7I
 Q4c1QoMrZvPBLBO8iMbtobFg1b7j64atSJNVOgQzpSH8SApMuOv9AfnTBIM5wdLAs6aQ
 CnQknn6Zm+D8x+BkdLdKe6bMouW7mGEdhOyR+5sJCLUwDLdyL1El5E9V7cNcWt8O0nTM
 2wl20tywxEkxsOzU6rKtRfElT2IanVwmaQ1akBXH99RREFDbm4Qrb8wZTBd0ggEbAeCA IQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrs8cvy43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2024 07:56:58 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44279Ypu033247;
	Thu, 2 May 2024 07:56:56 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtaarey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2024 07:56:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lX3h2rQbnda7ZEBly1+NQ53tMUZz5gTIkzFM6NopABQAYikjuuq/Cmab5ag/Ldpvlm8dzZOhCw52Qsym+yN5diMTMHAljrHl80uMn/mymEVMj+Ddux7hC7vzVv3pH3N8ce/ac54BUuVfMgu1IQVBwIhPOVS0WN+OxycvNjnHPSgPLNLIqAZv2a1eqi6dgiNz/oVqHNp+irJE05HTX6jsuPXKEQTXZ0jAWeWx9sSthrokMYAmY5xlFZf3B8+DEe6wL0gMsHRSwcJKq4g1tsa+3onC9EU6Yn9QIJ3b9UtpJYtlq2bUduPTmquYl9n2QAlCrbpjpvEd7kciV0mGCLJUgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VELNTqVEtkWDHTBI+f3TYzE93eJE0d1K/8nP7Qs+WeQ=;
 b=YlHv1eA0A+k5JDDQIxXm7C2MAIdIGNlA1yFGih+OujfVriVBFQlNF3vgs+8nqLsGRyT5wGEONPsDXmvAg20BXrrWLq7mR3pM8DTZiqb0A93+Un+mgoaTmOPg5DqtTxKdETaStgai8x7ZM6ViCnxqvY6+VKT5PXWnWZGzDZmer3BqL64/TiC/fUjtvyIgn19U3YY8Phgnj+zbyTxVVuaQRYkzAMuetP7V2cguOmn+v1g1dFKi6XDxAIIzTCRtvtP7oIUhCsI06PDlPyl1KfizakVjiWHog67yBkr8KB5dzqpaKmk3M8PhG8nOaFi5lp3gdI2+jd+PUarDucrJJzzSCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VELNTqVEtkWDHTBI+f3TYzE93eJE0d1K/8nP7Qs+WeQ=;
 b=IhdB4aMi/IG6bP3LdJTig9cAc2IAJ0rBBTw6KuQdYni+565PhyhtMcPJ2aGUkEPcA8PVFpmnIA1EEHLyD08NVejDAoBT1Ug3OCda7eJO0m+DI9H+jAIWJef94wT5FrKX7pzin5x3HpsboBqJbQ6j4SQklofl4N9dig2Ejg/h/zY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4728.namprd10.prod.outlook.com (2603:10b6:510:3b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.24; Thu, 2 May
 2024 07:56:54 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 07:56:54 +0000
Message-ID: <41612184-0804-47d6-8712-3dd99270a665@oracle.com>
Date: Thu, 2 May 2024 08:56:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/21] xfs: Introduce FORCEALIGN inode flag
To: Dave Chinner <david@fromorbit.com>
Cc: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, chandan.babu@oracle.com, willy@infradead.org,
        axboe@kernel.dk, martin.petersen@oracle.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, mcgrof@kernel.org, p.raghav@samsung.com,
        linux-xfs@vger.kernel.org, catherine.hoang@oracle.com
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
 <20240429174746.2132161-9-john.g.garry@oracle.com>
 <ZjF9RVetf+Xt70BX@dread.disaster.area>
 <cc54060a-2dc3-45e4-b47c-a9926553e59b@oracle.com>
 <ZjLjYsjTJGSdWZ9q@dread.disaster.area>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZjLjYsjTJGSdWZ9q@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P265CA0003.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::12) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4728:EE_
X-MS-Office365-Filtering-Correlation-Id: f6a8e75f-0901-432f-792f-08dc6a7d6ee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RVlOK2YzZmhqVGYrd3ZZNlpzeFo0eDlaelVkZG5jUlgrTTgrb21nWU5oc3oy?=
 =?utf-8?B?TEZIbDF3Zkc4ZGJReStpR1QrNC9VQ1RMWlllYVdDbVYxclpRbnlkU3orV2NW?=
 =?utf-8?B?QVJabjErbGw2bXlwaWhxV3VKd2RTaXgybi91ZStLQThXeGJSc2hCcEE3TXE0?=
 =?utf-8?B?T0ROSWFORVc1bVh3anQzMkgzTWF0YVBWVEE2Z3R6SEZ3NG52bU8zbE90a0U5?=
 =?utf-8?B?NEtObnFCaDRoR3NpdFY2MW5zNVZGNTlxMDhYdmxCbmR1c3hjdWlzVEQzdVRi?=
 =?utf-8?B?a2FDTXR4ZWkwNFl3SG11Yk5Mb1d0bWwwSG1wbDlVSkJFMm9hc3E2VEdKV1p3?=
 =?utf-8?B?N1lGS05OMXZVVGdNSHNQVzBTK1pxcEhHTmJNOUwydEZZV01yWkFUdGhZM1lG?=
 =?utf-8?B?RVdmOGFhNVRGUUlHL1AyOGhWWmpFY3VmODdLcHo3a1ByYzBGTUwxZTE2c0pV?=
 =?utf-8?B?dlB5bEk2aWJCU3FVVDdaQXJSekhiMVZJU2JPRjg1WHY3T24xdy9GOWRGc1Nx?=
 =?utf-8?B?ZTRlSk1oMnVlN01Qb0xhb2YxMGw1bUR3bFU3N0tWOEVDSE85cXJrc01VZ2dW?=
 =?utf-8?B?VmRVWk5iR2lvdDRHRFA5K0paUFFWUlhWMTBrRVhiRHBVVS9NMFVFeDNudkRn?=
 =?utf-8?B?ZDJoSkNjVW9ZVjBhbWRheHBnVC9lQm01UnU0azlNSEpCem8zaU40VEFPZDdz?=
 =?utf-8?B?MXNoV3VwcWEvbjl0alN1bkZCM2xhdU90S2w3cjhrK0ZDdmNtSElHL3MzKzI5?=
 =?utf-8?B?dlREdjgwUDllaEd5M0ZNRG5WZVZCbG1wR0RjYkVnNlVCWlFhWXhvOTRjaEU1?=
 =?utf-8?B?VWtaemc5Y2hpajV5NC9wS1lxS1dqU09YT1NMaVN0UDI5Tld2dWt3NEZxK3VB?=
 =?utf-8?B?Q1RiKzlkZ2cyM1YxTUdMcG8rVlVwQVRBSkVqU01BTUdFVi9lZUdyazlIazZ0?=
 =?utf-8?B?bDRlZnZDRnRqa3hDcjRQMWxGR1pXUjNUakdJWDVqNFRIRnY0TVY2TE9rYlhi?=
 =?utf-8?B?TUVMc2NydzI0ZU1wejNzR0YwSDVicVB5TFo2bmY5by92OHhaVkF3QllqTmJJ?=
 =?utf-8?B?R2szRDZabHI0WkZPY1pmd0Q1eUlIMTMweXlpeWR0aWdTa2tRUTFMSzB2bm1U?=
 =?utf-8?B?OGxjdUprNy9nYWc1SGlqVW9sS2p5elNFMUdmOVF6N056S3R6RldHRTRuY0Fs?=
 =?utf-8?B?czRUR00zaXIyUE4vR084R3FQT0RwMDZnZlJ5NkwyMWZWVEhJeFBNaU1DaE1M?=
 =?utf-8?B?cVdJbDZ6dmhnM3BpbU5UZVB2bzBJK0FSTVJ2b1pZZTQ2SXZ6Tk01OUE4dndu?=
 =?utf-8?B?Qlp0eVB1ejQwSWY0Nk81VzFXQXNub3V4bHo2V2RUZ2VPWHh4UkNtMG9PWW13?=
 =?utf-8?B?anhOcGpqcHFnUkRhVndKV3YzNnBxRFU4S2N3elZlZGZaUmxkTjBGTm5DTisx?=
 =?utf-8?B?YXRTS3BtS2lqQ0Z3S1VMRVVJTSszOExTLzdGRkdjOWlkVzRYVTBTdXVWdFBr?=
 =?utf-8?B?SlVHd0ZySVBlRmNvc1l5TFNHelYzQ25EOHlESmw0cEZCQU15elc5MTNYTVNI?=
 =?utf-8?B?OFJDdTArbVFOaGlnZWEyNi9PRVppa0VWUGNlK216aUpxZ25SMmJQQ3I3cFYx?=
 =?utf-8?B?Ty81MklmQldEV1I4bzhDd3owQWMwQzVGV3FhN2Y0QTJib2I4UzV3STBucWpE?=
 =?utf-8?B?VmFNOHNQMG1qQ1BMT015ajRzaUI4dzhOZnJHbEJaL1JoN3pkbTNsUDVnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VkFXK2N3UEFUUkJVTjZUK2FnRnBXQkVuZlpGN1IrVDlEUDdKSVNOOTEvcXpV?=
 =?utf-8?B?b2ZWSDhLS2hOR29aTUZ3ZVJ0d01Jb0cxZDdTT3lzSzBpQnFvcGFxRkZkTCtD?=
 =?utf-8?B?WkRGV0FsS2g1OXdiQnl0eXdhUms4MnZranJyeHJnMzd2anBGUDVQOXVWOFRY?=
 =?utf-8?B?a0E0RjZwSFk4TWs3UDg4Y0p5NzZSeGJYS0dTeXo0WG5Ed1lLQmpBc3BtT3VZ?=
 =?utf-8?B?a01heVNwbVJZRWwvdXVWZ2JIalg3ZWUxSkNJNnpTbU8zTTJzNFlxY1gycDFS?=
 =?utf-8?B?NmdERGY3eWRGSFhTWGxvWWU2VU96VVVXY3lFWmpGTFQ0RjFxeExUS3Z2amFH?=
 =?utf-8?B?dEJVZEVaRy8zZ0pyK3NBSWw4a0hXbXJHSFlMMnMyZlBqRDhTcVo2WUwzd1M4?=
 =?utf-8?B?NWRpcHlhTE9tVU1vazJ3TnN5MUE3MW5DSE9xSXJoWC9nOTl2RzVVY0lRUUlm?=
 =?utf-8?B?R3BEWDhUbnFTdHBoWTZRTVNLbFRucXAwN2RJaDlMR1N5U1AwRnBTYTlIUmxS?=
 =?utf-8?B?Y1lFK3d4OVV4aHN4ZGdzc0Z5cXM1eXFQU2pGL1Jwd3hhYVNNaU5UV0UvaVlq?=
 =?utf-8?B?ZXhUT0QzZGRFZFNBUWNLOE9zNnJQQzh2NCtJdjF5UEVUSXdOK1ZpRXNqNGpp?=
 =?utf-8?B?TkNXREN6T2J0UmIzdXhURjU5UG5za1hROS9OaFlBUHBONS9MSFRpUXhQcENY?=
 =?utf-8?B?bzl6d3M4cDNvdXB4aGJXY0dkc2RMKzA2SW9vRnB2MHpURURIM3hSZk0zcjdr?=
 =?utf-8?B?TkYvaSsrVm1EVHdGWDVvMVlQdlFSdUpHMEtwWFBqeDBxeDRybm44UHkvMThq?=
 =?utf-8?B?elg0L2czZ243Q3QwcDV5WGU3emVRUDN3RnVLR2poQzdhVnhDaHVjMjBqRjE2?=
 =?utf-8?B?WVRtTFc3bTZwY3IxWkhhVDlRMjJpSnB5anplVUZBUmRPVVowK3BUcUF3ZE9M?=
 =?utf-8?B?dFRLWE5EeWowRzhVMW04S280NlhpakZZc2dHUG9JdHdpclg2NWhIaTNhU2F4?=
 =?utf-8?B?aE5uTTAvS2wvVWJmN054dmFFY1hVNFJxOFYyRktNdWZUeFM0Yi9HRmdLZ1RK?=
 =?utf-8?B?VEQ4VFdOVWRORGl2TXhTMTlLN1l5MkNIaXJYWTZTRjlpU2NRaWtFMFFld1Rj?=
 =?utf-8?B?Y1lVcUFwRSs4c0JPaXRwYnZ0bUdyblRoWithV2svZCs2VytYUVdlVksxRWpn?=
 =?utf-8?B?dXZTTUh4VCtzUFg5WWlveHh3TVpmUVVEc3JUaVRYbzl3Vm4wK3VCaXhPR25q?=
 =?utf-8?B?TGJPTDExeVZ4ZVV5aXZTdXAybldOZWNZbldhc3JMMzY4RWM5cGp0NFlIV0ZQ?=
 =?utf-8?B?U2IvVExJMllsMUpSNVl4N3A3dWZ6eFNmeU9mQnZlMktJczJpWGYwMXFjSVdT?=
 =?utf-8?B?MnVUZS9hSk5jMzNnQmpiN3IvcWw1aTRUS3ZhZjdwRHNPSng2N204aVpEMFhE?=
 =?utf-8?B?UlYwcWliZjZqaDh2UHZNU2V0eXRRRzZhbnNCVVAzMU5IRXZYRkh5Ly96eUY3?=
 =?utf-8?B?SnRpVktVZHQ1SWFjRVZOTFB1OWpUKzdVcWoxT2lpSEorSHFOUUdGVmpZY3RK?=
 =?utf-8?B?UnpVMjlmVzFpajM4djNxYkpyVUs1c0RmZ1QwTERmd1VrVXpsRnZvNXMveVJo?=
 =?utf-8?B?QWNDdXJmT2plM2F1M3Q5czROMUo3WExYQ1BNLzgvM3ZuS2N5Rk0vWUsxT0Rj?=
 =?utf-8?B?S1hNSkxlVGwrVXJveU1KQUhBZ3RVcUJmZXE3Q2psNUpDYzE3R1pHUHhBcXFm?=
 =?utf-8?B?NmFGVWlncjN2b1Q4SXdWMC9TYlBCNGVtSFllRnQ1QVBoaURtVkd3UUx3Zmd3?=
 =?utf-8?B?K24ydktlUWRoaTEwREhybzhOUUF5K3YxWFd5WGJKL05mK0xhU2M2VzNIZUJQ?=
 =?utf-8?B?S3FNUWhjSW05cWd3Nlh2cWc2bmcwR1JwakJYTkJDNVNxNEgzeGtic20vVFJy?=
 =?utf-8?B?Nm04Q1M5R2VaZnlseXJuVllBNjVUTHR3OVk3OU8waUhybSt2d2dTTS9XODA1?=
 =?utf-8?B?aUFGOFdQZEprT1R2YitmVnNqMXNZSjFFa2R0eG1kRjNQcHlKa1hMU0JrVEFi?=
 =?utf-8?B?cEx6Mm5wMmtwTXlqMC9OUXVWaUZQZmRPTlBIWnZxTzIybXh5VWxGeDJvaUR0?=
 =?utf-8?B?ZkdMNDU3T25DZEJnczVYaDZ6UHdUUHV1OCt4Q3BmMXJ6K2FseGk3M2FCUVJp?=
 =?utf-8?B?bmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	QfKlnY9VpW/21xy7rqEB2Xu3VE2Cu4Youwzx8iQC2sffi4VnXKK6buGOA8tbYpn+WJHwBmmelmLykfOuS7esVOgGHpdhIwhLBrEqM5t0bR6yVzTqyoZoXwkUjhmgpnpxEB70LaNNpBQt+dqy2cnIf2FMTE7OYR3+PMBy0JKsKKGqkKRjXgCMg6gJZmyF2WW1YJyHMKW/46T79USjMfNBUVLXBhoZlTP0VfUudesinUwSQiVyVBUWPE9+XYv2whycZe+Uzev7bwlsO6VNFnF4ztsYU3FZCF4Z4NUj09fxNqhnpfgIheLhJAe/eekhcwx9HDhb9kOeDkP723qCh02jvIYoE68XiG0fFNg//ND4anVox8MM/UXDcr1ZbKxL7Wvu0Y3JJzt1Yk4mwkgYXydLdzlUfQqpzsd/JB3AZEPEDOTynVkiv0SOaqJKFNZqcKVYWYS3peEoZWb9FDCfb/R/sCAlMLMs0NBNHTMMFB78KyfK2Lq4konOVetFs4UkR03F1fHMXIJpXa2vvd/vF+X9wxFBJE/3wMorkLVID8WxWOlE9VoiAW67ardKGRwZx6cGE9Ra9AoAbQBikfY3IO9eDZM2RuksUa4ZdmCW79UZNkI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6a8e75f-0901-432f-792f-08dc6a7d6ee3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 07:56:54.6662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8RXVXUz1jS4RceoUrkMFMm1kRmhlzr+k9KAlqBwmLx4R2LXnkRsBf3fh6P5HKBkrqxjFuudPx5HYiz8CSENjmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4728
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-05-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405020045
X-Proofpoint-GUID: fRtMHauviVm5ud56B534nErtM6N1vt1L
X-Proofpoint-ORIG-GUID: fRtMHauviVm5ud56B534nErtM6N1vt1L

On 02/05/2024 01:50, Dave Chinner wrote:
>> For example, consider xfs_file_dio_write(), where we check for an unaligned
>> write based on forcealign extent mask. It's much simpler to rely on a
>> power-of-2 size. And same for iomap extent zeroing.
> But it's not more complex - we already do this non-power-of-2
> alignment stuff for all the realtime code, so it's just a matter
> of not blindly using bit masking in alignment checks.
> 
>> So then it can be asked, for what reason do we want to support unorthodox,
>> non-power-of-2 sizes? Who would want this?
> I'm constantly surprised by the way people use stuff like this
> filesystem and storage alignment constraints are not arbitrarily
> limited to power-of-2 sizes.
> 
> For example, code implementation is simple in RAID setups when you
> use power-of-2 chunk sizes and stripe widths. But not all storage
> hardware fits power-of-2 configs like 4+1, 4+2, 8+1, 8+2, etc. THis
> is pretty common - 2.5" 2U drive trays have 24 drive bays. If you
> want to give up 33% of the storage capacity just to use power-of-2
> stripe widths then you would use 4x4+2 RAID6 luns. However, most
> people don't want to waste that much money on redundancy. They are
> much more likely to use 2x10+2 RAID6 luns or 1x21+2 with a hot spare
> to maximise the data storage capacity.

Thanks for sharing this info

> 
> If someone wants to force-align allocation to stripe widths on such
> a RAID array config rather than trying to rely on the best effort
> swalloc mount option, then they need non-power-of-2
> alignments to be supported.
> 
> It's pretty much a no-brainer - the alignment code already handles
> non-power-of-2 alignments, and it's not very much additional code to
> ensure we can handle any alignment the user specified.

ok, fine

> 
>> As for AG size, again I think that it is required to be aligned to the
>> forcealign extsize. As I remember, when converting from an FSB to a DB, if
>> the AG itself is not aligned to the forcealign extsize, then the DB will not
>> be aligned to the forcealign extsize. More below...
>>
>>>> +	/* Requires agsize be a multiple of extsize */
>>>> +	if (mp->m_sb.sb_agblocks % extsize)
>>>> +		return __this_address;
>>>> +
>>>> +	/* Requires stripe unit+width (if set) be a multiple of extsize */
>>>> +	if ((mp->m_dalign && (mp->m_dalign % extsize)) ||
>>>> +	    (mp->m_swidth && (mp->m_swidth % extsize)))
>>>> +		return __this_address;
>>> Again, this is an atomic write constraint, isn't it?
>> So why do we want forcealign? It is to only align extent FSBs?
> Yes. forced alignment is essentially just extent size guarantees.
> 
> This is part of what is needed for atomic writes, but atomic writes
> also require specific physical storage alignment between the
> filesystem and the device. The filesystem setup has to correctly
> align AGs to the physical storage, and stuff like RAID
> configurations need to be specifically compatible with the atomic
> write capabilities of the underlying hardware.
> 
> None of these hardware iand storage stack alignment constraints have
> any relevance to the filesystem forced alignment functionality. They
> are completely indepedent. All the forced alignment does is
> guarantees that allocation is aligned according the extent size hint
> on the inode or it fails with ENOSPC.

Fine, so only for atomic writes we just need to ensure FSBs are aligned 
to DBs.

And so it is the responsibility of mkfs to ensure AG size aligns to any 
forcealign extsize specified and also disk atomic write geometry.

For atomic write only, it is the responsibility of the kernel to check 
the forcealign extsize is compatible with any stripe alignment and AG size.

>>>
>>> Can you please separate these and put all the force align user API
>>> validation checks in the one function?
>>>
>> ok, fine. But it would be good to have clarification on function of
>> forcealign, above, i.e. does it always align extents to disk blocks?
> No, it doesn't. XFS has never done this - physical extent alignment
> is always done relative to the start of the AG, not the underlying
> disk geometry.
> 
> IOWs, forced alignement is not aligning to disk blocks at all - it
> is aligning extents logically to file offset and physically to the
> offset from the start of the allocation group.  Hence there are no
> real constraints on forced alignment - we can do any sort of
> alignment as long it is smaller than half the max size of a physical
> extent.
> 
> For allocation to then be aligned to physical storage, we need mkfs
> to physically align the start of each AG to the geometry of the
> underlying storage. We already do this for filesystems with a stripe
> unit defined, hence stripe aligned allocation is physically aligned
> to the underlying storage.

Sure

> 
> However, if mkfs doesn't get the physical layout of AGs right, there
> is nothing the mounted filesystem can do to guarantee extent
> allocation is aligned to physical disk blocks regardless of whether
> forced alignment is enabled or not...

ok, understood.

Thanks,
John



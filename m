Return-Path: <linux-fsdevel+bounces-17414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D67488AD177
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 18:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 001821C229A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 16:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D62153818;
	Mon, 22 Apr 2024 16:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LvJzLWCu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tb7kvr5/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AF0153519;
	Mon, 22 Apr 2024 16:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713801798; cv=fail; b=DIHWOeXDiWEWF4s8PZ7xWaUp+V60y+9mdddrEyYVeNp/A7dffZZYTtibEzVpiCcRQ5iFBLONZwyYdQCz5YwewZZEf8kt2qkYPnwPL+cXneiAku5N7JN5O9pyu+U9Nxa9RdB8YI4h1UGe3J1d9ihOmKmTz+CxhpFlCZnr41DNnPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713801798; c=relaxed/simple;
	bh=WU5C9dSx9sCSuvT1E5uwMx+qYe+BB7+HfLz+GldQiSM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n9eApptPu9mMRsE52X0Qe10ryh7lRUnpFDGQ7OTswWcffHR+CKI+Ms8U4XWVOYqzt4Z6r0VNHIO9fQsqoo37hAZt1nmKkkmt9MlKqxHO2P2920HJpIg50by+1fy0sBzsb5b4XuaFTbF5jEIuC2lguOZ/Xs3sd9NNEEGhV1N3+jI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LvJzLWCu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tb7kvr5/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43MDY1c1005897;
	Mon, 22 Apr 2024 16:02:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=h+R47Fyk6+drc7CpqABPlKdrSycdG9ECawfOhAhtEcM=;
 b=LvJzLWCuQjgTkwG8kVGrU0oM9FKOnS2WXtgpfvLK0t32zMvVRqve9OKMJcBR+/ne/sXb
 DKr1HxjILsiJrYRwOHv58ldhPvN39YTLUNWZmgqY+MNciLTjymLOWhAWeZzk+yrHvqoZ
 MaTU9+A6fpatYrVMrbDGWQx9Oe2LFEnOvFbaRqKWnwx9VnvUdjwWTzDkgh1q9TqnJgcm
 9EEuNviYwwy90UHvdJNkjMqEBBIoPxQaUMa4Z0/nb8wTV2f4c72LVQX8/h+DtyPDvDiu
 xAQ1baKLohJVOIGeD8KbRZToJRwZ061IG7IGjAlRiUu55cLeoVwQBoKuEqeWe0PnFy68 CQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm44eu1h7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 16:02:36 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43MFTTUV009366;
	Mon, 22 Apr 2024 16:02:36 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45c3kq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 16:02:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lI/pCzsTv/D+mm+F7ZVSzWmI5PZ73Yiy2NqC3elh7s1PkLZeMf0ZQBJg+juRZtcjHUZNpjS7apPQDPjOOVMLS+65uqmm0JZg/BVRQbWSgEBvrQ73w6reAwaIJoOTIzpzWkQTSTnbI2/PTdYDRF+ekiiPknPsYmwgwIKwrc6kUyuK8DycE43IlH1hWrGYlDue/ZJtamaO4KyB6QcrSlv7zUy0h/3gnoJ2X0UHramcIVMHDNWrcio8xJFNVbQ50i1C+DXGN2L/u5PYXbx4zIgI7yiNev4da40eFyQIfELSxJUHI+9gP2OX7jPgzPpsjR1l0xQJjcS609j14RSaUuKuFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+R47Fyk6+drc7CpqABPlKdrSycdG9ECawfOhAhtEcM=;
 b=B2YCZuKFLxOpsQbm2rFdwns9aGCq14a5BdyznxlwXHftj6iGgk23coYSIoH0N+HA5v0Xk2CL3Eu3M7cLruWfgDWfssigkT2qvqsXK4KcNQ9KR5uaJzbEKsvnwt8Pm0MAXtKiM6FOtXM5kqkBxNfrdjMMrqrzBf23/IszCb3qh5++QfRm7oieHlJoucjR2SRdLvARqrc8OSPFcSlhN92aV+kdtgIct6nx+PVge5m06VdwhVe8RHDbPhnLW03ESivv0kpiJNE078Gc86UkjtWuJvQFgJwgSCnhFNIQ80FZZQXP/FQxTdE0HOaun/iSWLxksrZX9tl+GRrdlH8oQ4kQvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+R47Fyk6+drc7CpqABPlKdrSycdG9ECawfOhAhtEcM=;
 b=tb7kvr5/7Un1le8oYpc5QcoaV7npsHy0ODsxEGDzhPQ/YiF2NYKMWKiHqFZl3jnRu85fxEsdy8M+fCWtQQ21LIYT3hHM1T1uamRHV4ldaXHeUjDwT/ay4CfJAiUrXCsdHxiDdFDnvHoRry3VXlowabAN83v2ojlJbDlPYbyEus8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SN7PR10MB6666.namprd10.prod.outlook.com (2603:10b6:806:298::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 16:02:33 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 16:02:33 +0000
Message-ID: <363ee90b-00a4-45f9-91a3-663a8cdf077c@oracle.com>
Date: Mon, 22 Apr 2024 17:02:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 5/7] fs: iomap: buffered atomic write support
To: Matthew Wilcox <willy@infradead.org>
Cc: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, akpm@linux-foundation.org,
        dchinner@redhat.com, tytso@mit.edu, hch@lst.de,
        martin.petersen@oracle.com, nilay@linux.ibm.com, ritesh.list@gmail.com,
        mcgrof@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        ojaswin@linux.ibm.com, p.raghav@samsung.com, jbongio@google.com,
        okiselev@amazon.com
References: <20240422143923.3927601-1-john.g.garry@oracle.com>
 <20240422143923.3927601-6-john.g.garry@oracle.com>
 <ZiZ8XGZz46D3PRKr@casper.infradead.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZiZ8XGZz46D3PRKr@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0515.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::22) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SN7PR10MB6666:EE_
X-MS-Office365-Filtering-Correlation-Id: 11fc5f66-beb3-4383-1a39-08dc62e59e96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SmduYjYxMTU3VUNrKzVxN0s1c0l5U2ZQVGswelF4TUxDYng5SGsvOWVxS0M2?=
 =?utf-8?B?S3Ixdi9IaWRVU1RIeWQwdTVJaEFQdU1yMnVxL0RmaTIwWmhvTWRramppRXgr?=
 =?utf-8?B?bmVlSHVobFdEUmduNlJWWVgzNHNYZTFuelZtVGRKaUg1UmNGUVNNb1lrWThr?=
 =?utf-8?B?UXRoM0hTd1VQS2FPNHI5UmhrNjM0Y3B5VmV2MXh5bDE1eWxSM0FVYytKV2tS?=
 =?utf-8?B?MUxtY25vcWUxc2I1ZzFkemd0clQyZ1VESlVUSEcxbERLNG1jRU1wNHFzcW4r?=
 =?utf-8?B?Z0R6VEpCd2s1NE9xRm5ySUYrUUdIVVllREY4V2N5d0V5RzZqOVI5cWN1ZlpH?=
 =?utf-8?B?US9uUGJvSDVIQlUrWkpobEVqaVNRY3JJeXkzQ29EZk9yWEFLbmszZEpSWUF2?=
 =?utf-8?B?NkMrWFhKVkpybWpGYzl2S2tDR2VQeS9VYzBCWEhmV1liM25SSnFydXUrODk4?=
 =?utf-8?B?dDNnSWt3UzU4c1JRWWs3SkFnTDMzTWpMcnZEL05VeGRQeVBmbkJ6c0RqQzFt?=
 =?utf-8?B?bXJzS2g4NmgrLy9zT1JyQ3daV3Jkenp1OEZZZFZqdHVkS3VIYWNaUjB6YlZE?=
 =?utf-8?B?TjVQU1FxRWpZWnBzUU90c2RVSFdvVE1Ba0tyL3VsR0k1djJOVVkzVW9FQXJN?=
 =?utf-8?B?cnM3RHduMWhMNEx4NGExSVBWTVpORWpETTY5ZXhMcU9WcWlrLzB4SnlIdkdn?=
 =?utf-8?B?ZWhyMjBnajVleXZpU1ZiWFcwZzFQeXhTZHlmMDZlaXlibWwzV0FSOUY1ZEJt?=
 =?utf-8?B?RjUvOHAwVjhTN3VmdmlQdnpvc0NYaW9kVHZ2YllLd1RYWHJwdDlYVm1OUE55?=
 =?utf-8?B?NWZQd1piK3JSZHRWaXp3cUV2Q3RmZEpRVjhldnQ3dkloNlE4OWdxRHpJN2R5?=
 =?utf-8?B?M1NQbFV4ZnJGTjkrWDZrVnhtVktBUnZIMDMwcFJWc1REM1BwdUx1amhWa1Ry?=
 =?utf-8?B?alBXYnk2VlFZcHJ6R09KOWl2LzUyWnY4NC9OUHcydVp1ckhMVnFLY3NORTFX?=
 =?utf-8?B?ai9BS2EwMXBrYWxPODE3U0ltM1BhanZnRUhMdURiWWdVTXJmV1dUWEJUcWhm?=
 =?utf-8?B?SDBqWXprWmgyaXN0aGlLeGFBb3J0Y3RZZml4T2hqZ2dNYndBYzUzalNocEt2?=
 =?utf-8?B?S3ZCTDQxMGI2cmVSdkpxTGtyY01tcGNLR1BraTMzbk9CWlRoRmRLNkhpVGZo?=
 =?utf-8?B?d3VscTNWVDZzeVN1TXQ5eU1VekRvRmM4UGh1WkxRTHdlRHNRTmN6QzR4MkxG?=
 =?utf-8?B?bkdjbDRHRVUydkoxK00rSDN0aXJsNDJMdElaYXc0Zms0MHFtbHVnMCttOTN2?=
 =?utf-8?B?TjEzV0J2Q0tkR04wcG9WS3ZHTC9qVDcyNCtyZElpMWlOYVFyM3pPR1hPZks0?=
 =?utf-8?B?V2ZrVzNXUGJzL21ZR0l3WjF3dXdEREdydk16OGdISFpuNW9kVzdvWGFXcVcv?=
 =?utf-8?B?bmo1V25ua1NmYXZGcmdOazFyUmc0ZUN2Mk5uUWpzajFnMlNXc2lpcXd3WTNs?=
 =?utf-8?B?V3pWclhWSUJQTGRhK0pHL0VUZnVqNzVMdGdKMWlZalRuUVF2V0srOE9oUG5F?=
 =?utf-8?B?blJwY3RvclRTaEZwOHRMTUVMMEJ1QUFNUUpmenR4UkFYWXpuaXlWV1ExTzNF?=
 =?utf-8?B?U253alB3UkdXY25zSnRHVUxQR2luSDQwM0N2TlNDWlVDRVZmMml1UUxLeXBv?=
 =?utf-8?B?OW83WU1nVmFMcnU1Z2Y3a0hwYXF2cVlmQTFJZVI3WHYwajNUVlkza2x3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TGU2allwYm1LY3UvVk94TklOeElhaDhHUzY0WVc1VXc3cEVGelVKNEFEaEcz?=
 =?utf-8?B?RlI2MGppcm1xSGp4MzdSSENvNGVGRGUrcDVDbTJ6anZic2NTWCtud01XY0VC?=
 =?utf-8?B?d2J2R0huUU5Ddkt6THlkdnJRTzVVODd2R0NiUzJnNDhCM3ZtNTZyZlJERWxj?=
 =?utf-8?B?QktwK3NKTVBjcWgwcGE0RmVFNFdUU2lNUkhxL0RJQmxuQytzSk85SFFtNVlu?=
 =?utf-8?B?aWgvVUF2cXpmWUJRZW44WXB2UUNSeDUvZDE1WnNOSXZ2OTdoSGdZMkcvSWdt?=
 =?utf-8?B?c29MYU5iVUFjTlh2bFRuTVdPVU5mTEpUeUFRS2kzMFlwYU5md1QyY0ZObjcv?=
 =?utf-8?B?dWc3SEVpWTBrQzh0SFk4cUxpQjZuVGRkdlNZMWd4NktFZ05EZUd6YzZqazVk?=
 =?utf-8?B?bksvS1hIeWN2OGZ3YlZ0R24xUGtZSEF3MTFkckNqRWFvUXUxM2MvUFJ6Mzlu?=
 =?utf-8?B?QWFQZUpGZE5aY2pGWXNEK2pzOUxoN0NqbFRISTFEamhURjgwTmlLWWVsYXBD?=
 =?utf-8?B?WlM4ays4cDlpbm81enZQalA3RjRTcHp6em42aUtKVU5OK0ExV082UWV0VEQw?=
 =?utf-8?B?SDdKSWo2cVR4VGN6UkZ3cUpkdWYrUlFlZU9GNGtxay9zNi9RV2dnRmI3UHRp?=
 =?utf-8?B?b3lySHo4UWZvTHVDSjZvTUhhdzFraWF3aU5IalFwRkVIZkhCVTIxcWhOVjR1?=
 =?utf-8?B?UXNhK1RTL0U5OG00aUh5eHVQeFZ2R1lYTlc3N3Jwb3BRWkplcmo5R3dCZU1S?=
 =?utf-8?B?aEppTmlKOThrSkF3OHhLK3NoNER1Yzg2cTZ2VXVaSFliVXhMem1WSlVOaHh5?=
 =?utf-8?B?OXpGc2dlRWQrVzJlZWxPeFFSbWNvK1hFRmpaQXIyVCtmMW1Gc1kzNGtjbWtu?=
 =?utf-8?B?bzRZb1UwdnNSQ1BVNXA0MlF1aUtFRFpqb053bTBBUXI3eGFnU1pxRHVtVkY3?=
 =?utf-8?B?ajVWR1pRM2tncXg3Q0VPR01MMzRwVzBRQTJjSjdXSzdEOTY2aTBhYmYyMWFN?=
 =?utf-8?B?VjJoY2dkaTMranZNd0p3YitZUUJGYnhIYVV4c29DaG5obGNKa3RpeWoyVGVl?=
 =?utf-8?B?STRhWWhIQk9FMlZyYWR1NFl5bkZLL2c0LzJEK3VETDZUMS9WN1YxNlNLcHlB?=
 =?utf-8?B?VUszMTV2Z29weHBQLzRwMnVHWGhYR1pLQ25aSnNZM3ovNUYrUUdMcWI3bDM0?=
 =?utf-8?B?Q2ZFMWVwUUY4SHpDa1M0dEY1TTNTVStLblpmOUxoajNPRlZhZ005ZmpNejgv?=
 =?utf-8?B?V2RxME5DZkxEdnVoNVRJOFJZS0xWWEtNeE0xNmhRcXNvRGZoNFFDQ2RBNHF4?=
 =?utf-8?B?YUNod25sL0VEODEyUFFxaml2WmdUc3RIeFBwWDZGa3hWZ2RBbVdYNkFkeFJP?=
 =?utf-8?B?ZHBicEZIWmZPdE1BcVF6R2d4MUkvMTVPb20zY0pSdVJjNGVEQUxWVHM2eHF5?=
 =?utf-8?B?Rkk2RjIvejdrYzNnSFN6TXNxYlJhZDZScUw1d3M2L1g5NU1HV2Q1UjBYQ0hn?=
 =?utf-8?B?RGEwbzROTllLRWJDbEExTy9xSUQrS3NIeWZEWW1aMldpOWp1SHAyTXVzZWVD?=
 =?utf-8?B?Rlk5cVRHMkF3YjdqSnNvZ2Z3Zk01V0hWbzN3aXhxNUJHTjN3Y1FUME9xVmh3?=
 =?utf-8?B?aTJmb05FSkU2Vnhla0FZSHFNYkpjMVpVY2pYUzhNSy9aSk1qb3M4RWhxTWRO?=
 =?utf-8?B?RkJQUzhQazdqKzY2Q3F4RFB3eEpMeDJ5QTNmR0pLL1JwNW8rT3NTQ3VkbEg2?=
 =?utf-8?B?NUVrMFNpWC8wd2RmS0NhaDVtSkpTMVYzTytpVGRNY25pcmhuWXdORzhsdVI3?=
 =?utf-8?B?bFNBMjRwYzdUaGRKekhkOFh5RTN0blRCejB1MERLOEQ3NXZTVGV5ckNkdXdI?=
 =?utf-8?B?M1dMZittc0xLd24vcUY5VldqL1VNbThOY0ZFeW1rM1JuQ2tadjVUMFp0V1Rz?=
 =?utf-8?B?aW9ES1Z5cXZYSXFmOVFuZk5neG8za2xueERHYVR2cG9jdldRV2pGMUJVZWpG?=
 =?utf-8?B?YUFNeW5GRTBMckpoWFBjeHluRmdoK0VrdU9BZmZvY25ETmQwajFodHpaUnJk?=
 =?utf-8?B?TmFuQkMveHNOOFRRdCtoUngxeDlQNFUzdUdsMWpjYk1sYXVvSlNmWGxNMFVZ?=
 =?utf-8?B?ZkJGQkJyK0pYQlpuOXdMMG5raExOZXVKK05xQUlKdGptbXJEQzVEUHB3U2oy?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	MrtbGJZ+zcjAQt5DhcZj/MzAoTBiqo0AeU1f8EYiHM5DPFMxFBoBL/9S78MAxFFdoTtKiCExPG+Bp+/oAFB0OIDhxBqrEjADhyMG9IMvVP0S5TyS9X54mxbRoHGZ7uJo7qDbjCNLyHbrvEcJpwjxv1MiteTLCUbzMAiWnxM9UE3kjYE2r1X2iCsbXvyMsEahy8NM7FPBi6sPt+AjLAwwk929VcDKTIg+v5eSrsxZNUq3LbHtq/dZA2jdm5ZC8uSKT7olLeo5xoEekV7ui1hZzGV2VSJjnL8uXbU4RO9ndZhTd0jsgXeo05+hfy88dM3GjfoEkxSpQd64P0WYIovouzD1LHC8M0jeECFDfTs4UZ94yTtwh6MIZ0u1Od3s7pbByTOdDP26o22rQzZksC+PPyJ3e/weti874sqaMWpKAuG/KnGUdzsCDSohTPsdxYLgTicBQ5w8Muc1WGjhHexC+GUrlFuiKC8Ldc3CzkxUCSrJ/ty8IvdsH+jf+CqbJ0xBIZb4uLOPVVwQ9lsOr73XM5m8CuiMuOZCSwK5Mj+ChranlqRKdT45MzBxPS92zks+KtlGVpK+WGUPxidfmbuGree6Qg4zU2w/OdWmI+fa94s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11fc5f66-beb3-4383-1a39-08dc62e59e96
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 16:02:32.9599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C1Z8SXYSmlaGozNb4xEav/BsWYihprxodnqXnLYK2JjdD1XuFtjNXnvh3f/8bPrif6kYAzi+WG/R0retAVfGLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6666
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404220067
X-Proofpoint-ORIG-GUID: jVnHYxT69A2H2blz4gtJXHUk3RBribhP
X-Proofpoint-GUID: jVnHYxT69A2H2blz4gtJXHUk3RBribhP

On 22/04/2024 16:03, Matthew Wilcox wrote:
> On Mon, Apr 22, 2024 at 02:39:21PM +0000, John Garry wrote:
>> Add special handling of PG_atomic flag to iomap buffered write path.
>>
>> To flag an iomap iter for an atomic write, set IOMAP_ATOMIC.
>>
>> For a folio associated with a write which has IOMAP_ATOMIC set, set
>> PG_atomic.
>>
>> Otherwise, when IOMAP_ATOMIC is unset, clear PG_atomic.
>>
>> This means that for an "atomic" folio which has not been written back, it
>> loses it "atomicity". So if userspace issues a write with RWF_ATOMIC set
>> and another write with RWF_ATOMIC unset and which fully or partially
>> overwrites that same region as the first write, that folio is not written
>> back atomically. For such a scenario to occur, it would be considered a
>> userspace usage error.
>>
>> To ensure that a buffered atomic write is written back atomically when
>> the write syscall returns, RWF_SYNC or similar needs to be used (in
>> conjunction with RWF_ATOMIC).
>>
>> As a safety check, when getting a folio for an atomic write in
>> iomap_get_folio(), ensure that the length matches the inode mapping folio
>> order-limit.
>>
>> Only a single BIO should ever be submitted for an atomic write. So modify
>> iomap_add_to_ioend() to ensure that we don't try to write back an atomic
>> folio as part of a larger mixed-atomicity BIO.
>>
>> In iomap_alloc_ioend(), handle an atomic write by setting REQ_ATOMIC for
>> the allocated BIO.
>>
>> When a folio is written back, again clear PG_atomic, as it is no longer
>> required. I assume it will not be needlessly written back a second time...
> 
> I'm not taking a position on the mechanism yet; need to think about it
> some more.  But there's a hole here I also don't have a solution to,
> so we can all start thinking about it.
> 
> In iomap_write_iter(), we call copy_folio_from_iter_atomic().  Through no
> fault of the application, if the range crosses a page boundary, we might
> partially copy the bytes from the first page, then take a page fault on
> the second page, hence doing a short write into the folio.  And there's
> nothing preventing writeback from writing back a partially copied folio.
> 
> Now, if it's not dirty, then it can't be written back.  So if we're
> doing an atomic write, we could clear the dirty bit after calling
> iomap_write_begin() (given the usage scenarios we've discussed, it should
> always be clear ...)
> > We need to prevent the "fall back to a short copy" logic in
> iomap_write_iter() as well.  But then we also need to make sure we don't
> get stuck in a loop, so maybe go three times around, and if it's still
> not readable as a chunk, -EFAULT?
This idea sounds reasonable. So at what stage would the dirty flag be 
set? Would it be only when all bytes are copied successfully as a single 
chunk?

FWIW, we do have somewhat equivalent handling in direct IO path, being 
that if the iomap iter loops more than once such that we will need to 
create > 1 bio in the DIO bio submission handler, then we -EINVAL as 
something has gone wrong. But that's not so relevant here.

Thanks,
John


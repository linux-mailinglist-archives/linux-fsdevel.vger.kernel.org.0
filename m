Return-Path: <linux-fsdevel+bounces-39406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABFDA13B74
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 14:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43F533A9AE9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 13:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945FF22ACD4;
	Thu, 16 Jan 2025 13:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iMMeoisK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MgVKgHu1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EFA22A819;
	Thu, 16 Jan 2025 13:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737035973; cv=fail; b=G9nr2KoXQUAqDcj9cVlnVGL8Zbw+8hthbw6F5FtxjAspsKfVpHg4Z1OS02qLTGzUOhQSpFeTHCdDVEkJky34WiEvjr/HOx1HTad6N9pFqbwUMZ44OkKWmmRSHbwjIlxcoSybbhflyuHvuMzeja9n0FTzH46JrfLw5l7qjx0Uu8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737035973; c=relaxed/simple;
	bh=XrKPi85B/jUaoa2xmNg7shmYNn4N+thjVQshaV6RWxk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q5I8ZKipSHTue1+EBqfeojRwReozbLhREPB7NmNm5ViYL4mbgyWVPk1p83LZG5weva6/H4kQjNVexyzf9EQ7bi1sFmWWGxkMN8G4tXkbRZYHInbBSG7l0GhzmyhNcHbKFbgMPFqVr7LWQu2VcySV54YXvor2EbmOYlzRTCEQugE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iMMeoisK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MgVKgHu1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GBN10c026628;
	Thu, 16 Jan 2025 13:59:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=c8WD6olQKitPV+6s2YaNAWsR4r39duFobe5bukTzOMs=; b=
	iMMeoisKE3ljvsKZWGkMVWJILYkRavI063zH6CDDGGokq4uBX8M++xFEwschQ5jn
	YrITU3t1vRqT5bqeQT4Pm+jW6kxp/zlj7luBAi0mAHNT+gskmsaBjQsJE3+zK1/Z
	n/G4b7AcfysN2JJWM8wgaRwZv6o4rGM8sbTTtddWu4/+rbeuCrwhmVfPHpJnC4ew
	jMmkM2+Dvxb6Uf7CvZaUzBDqolQCJXAG0EEfEqxYnj1EMq2AzXk5CB1rpsa0Zpri
	dTj+B7PPrHBHw5ZC2Eceel2D3u37fZ0uP57odtgy6FhkIHsCNwHmwZftOh4sUcI5
	r9r6lS5AZllp5qXkoPlVoA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 446912tyja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 13:59:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50GDSPg1033608;
	Thu, 16 Jan 2025 13:59:23 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 443f3atpn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 13:59:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f1xjPD3fv4BK2wEozsm8WETSLv4Zy0at4coFS/Lne/rT615/OmS6VpVQOqkWD3opXE84FqZVD2gn0PvhT0LOKbN+Yo7TYDBfdvDixm8jxKuaDsuR/FuvP5IICQRlDf8GQmA6W8UkaAoKXcMKdZviExaSQEiRthtA1B/XMgROGN5PEblz1rAkzFZ+dn80rqUJOFaEwzpYI1SzL+c6flJukulJn4XJ/Q9uT/68QGXAtXThJnukx4EBT9f17tsHW8AS6Nt1u19ZLdq/M49MjDIOT35j4y0pi42MhLEge6c4DhsyL1L4LjGUUnEdf0i9YwWV315izm9n71ik8NkkkUDL+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8WD6olQKitPV+6s2YaNAWsR4r39duFobe5bukTzOMs=;
 b=MIaQESw5OgBm815BtmVktqNMeXvLZCRnyzztU4bnFfBY8kqD5PVgB1JanB7CT0hJ5tdvAW1H/Jk1ibAfuExMjq1pLBTj90PDVJmBVUwEoBIwYc3aehhE4xrBzR+Kd8wscWT8KwhPB7ROsJHJxOY4rju08snTzkzNaCYRnLp6EPPHqLHXgMxCTfu2PUQ66bKcJeKi6tCCGMvqGgS8lARE7++KQyyVf7OPPpCc3pgWQn6zqZLx68UEyul+bs8h3V39fWQJEfjefMMkC5ZIK2d8d34VbrUtICsUcXl1IbKWmQolF+LxmDlFiSwOAksadpg45lgWEZBn2ResjPV7j3LAmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8WD6olQKitPV+6s2YaNAWsR4r39duFobe5bukTzOMs=;
 b=MgVKgHu1Uinp6Jx8LDLDLFLf3kS5bdyjkhfHInENyWUcjz3Ahq4jvkZuKNqynYzX/svTwCyyr1dA4lm1x2Vx3KcgeP/QMRY9u8Y4z9JUKYPq8jSglqj3yjzCieHF6P1nImi/ib+rFvIMAsFl/zVK3PdN8LO0Zr+30GvJKewr3GQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW5PR10MB5827.namprd10.prod.outlook.com (2603:10b6:303:19c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Thu, 16 Jan
 2025 13:59:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 13:59:20 +0000
Message-ID: <21c7789f-2d59-42ce-8fcc-fd4c08bcb06f@oracle.com>
Date: Thu, 16 Jan 2025 08:59:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Implementing the NFS v4.2 WRITE_SAME
 operation: VFS or NFS ioctl() ?
To: Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@infradead.org>
Cc: Dave Chinner <david@fromorbit.com>,
        Anna Schumaker <anna.schumaker@oracle.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <f9ade3f0-6bfc-45da-a796-c22ceaeb4722@oracle.com>
 <Z4bv8FkvCn9zwgH0@dread.disaster.area> <Z4icRdIpG4v64QDR@infradead.org>
 <20250116133701.GB2446278@mit.edu>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250116133701.GB2446278@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR13CA0045.namprd13.prod.outlook.com
 (2603:10b6:610:b2::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW5PR10MB5827:EE_
X-MS-Office365-Filtering-Correlation-Id: cbd7bb46-4bc5-46fa-4d2e-08dd3635f9c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SEV0UFdSbGRCTmtxTVU1VWpBc2lFK0FKS3grLzVScGlCT0xKcktUYldLVmFn?=
 =?utf-8?B?UU5SeUozcnl5WGx0Nm0rRElVNi9hcnJtQlJibXBJQzdxYnlWaVViZkFSOGV5?=
 =?utf-8?B?alhCbDZ6Z01QZlJXZ3JPWWIySWJMUnZtcVJYSnhzYVdoNmNLZkY4THJZb2NT?=
 =?utf-8?B?Y3dhempHc1B3WllQNlFSOWJQcmV0UTV2VEhxRWMzTnA0UjQxVHRtMDBnMTgr?=
 =?utf-8?B?ZDVUMXpUd29MOUNDYVpFLytKdGszeG1HZDU2WUxXMjdTeU4vVDhjMDBzUVBw?=
 =?utf-8?B?bHdoTDlod2h2Yk94R0xlZitzcHFyenNZRjJ5Y3R1VzhXU2Jnem5kNlh0RWdW?=
 =?utf-8?B?L21qVGE0VTZDODJMRzRWWGhxSjQ5TUNxcG1yTG1LZHUyMFdYT0U4OURQZ1hu?=
 =?utf-8?B?eExBQXB0M3hCSHQwYlpUN1h5aWs0RXI0dWdjaHNUNE1wK3M2QWhXYmwxWE1a?=
 =?utf-8?B?bGtxMGFXNjBiZko2S1NPMUZ2bUxMdjBhbVlXZVVPamdnWlFZT0xXNlVPcGli?=
 =?utf-8?B?dnNIdWFyQ0k2NnY4cHlRYVlRWDNaS0UyOC9WSVZxNkp6QXh5blF2dHdlbU9E?=
 =?utf-8?B?Y2hmVXdPSlRYbVplWGxKYUVFcUxuajRra0kva2Z6SGhYU2FVOHc0d1lkbzh6?=
 =?utf-8?B?cUdEc0MzaHlZa1JIb3krVzVLd1g5eTk5RUZmaitHckhmQzNLUngrVDZhNHoy?=
 =?utf-8?B?TzFQRjJsK1VVbWIrWlFqWXRoTVB0Q2tmMm8wQklIMFpyNHZtWndzMTVMZGtD?=
 =?utf-8?B?SG5zU2pOUnJ6RWlaOCtyMjNEMkhsNE5tUWFXd2JwRjNWbkJPZXZycUFCc1Zm?=
 =?utf-8?B?TzBRVWluVkVMaktzM3BIa2FxMUNOMTE1ZU94bVlpTVJMQ2ZvTVVQTkV6WTJQ?=
 =?utf-8?B?WXYzekFMYnFwSWpSSkljT05Gd0VEcUxyMlBqbzIxcGMybWgxWDZTanNlbXQ2?=
 =?utf-8?B?eFRxNGNqd050L1UrZ3BwQ1VZTnU1SmQ3eVNEZmYycmZXZ3U3Nmt0bDlVZWlO?=
 =?utf-8?B?L0wyL29uSDg5bDhxckxpbjV6aElVd29xOE16cGJvNHZHL0ZVWHFQSEFFeW9h?=
 =?utf-8?B?QVA4OHVwUGZkK01nSjAwZWtDMTJLR1FZandHQUFmY3U4YW45dExLSml5eUE0?=
 =?utf-8?B?NGJqQWovbEVzTHh4Mlp2d1dIbVdseGRqZWp1YzFQT1hGUzVpWS9pcnZ0ekFa?=
 =?utf-8?B?UTgzQXhvNHlTOGtLdjQ5V0MzMmEvR01MZ3pBVElEeUUvR0lhZjV5bmpJQXhY?=
 =?utf-8?B?UjFFSVIvck9YRTh1bFBpUVhlZWxkSVc3ZHV0NG40QmFEd2RZZXBsb1pSUFFM?=
 =?utf-8?B?M1JldkJhRjNyTnNFejZHcTBUVnhma1JKa1c3T21CZlNWdjRURFVHaExQelR1?=
 =?utf-8?B?bEdnWU5iK0pETFRaMlRycldUdWdnaUhKSDF0Z3lyUHJwVGFTM3paTFNIdXI4?=
 =?utf-8?B?QTlOUDBDUG44WHNwejJjOG9KSU9LODhyQUxVWEN6U3ZKZ0hLTjdJdWFtVGt1?=
 =?utf-8?B?SGxCUllHdEc3ckl5c0lQSW1PMk5sbVRTckJQYjFweTltU1J3MERIeFNrTGVh?=
 =?utf-8?B?T2dhWnFVTzFHRzJiUEMvTHV3akRjcnZQWkduaGk1MW9tQmxYS25CZHNXZWlW?=
 =?utf-8?B?UWVyVGsrYkNKL2JZWmxhZG9iRFYycGtnZlpzZ2J1OTBoR0FGN0FyaWRKaE5h?=
 =?utf-8?B?NHgydHBXZ1BvQm1aNUFpOXR2NHhGdHlIK2QvdEhjWjl4eEhNVTloVTIvRU1O?=
 =?utf-8?B?MWpQWDM1ZGl4MUhFVjM2ZkN0ME1HUkxTeFA3Z2h2b2k2M1lib1I0ckg3ZTF2?=
 =?utf-8?B?TU5WblZLc0JFUVh0eHVKWVd0TXFUS1YrS1ViUjRYTnBhTDhpMjI0MUhPOTlN?=
 =?utf-8?Q?aD+t1iC8kFfCD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWhKMjg0Y1dvMUt1Sk0weDQxV0RWVkVwcGlIVjY5MlV5SzhCdWNhMEpxNUlG?=
 =?utf-8?B?TnFnR0hZOVAxckM4a29lNHF4S0pIZ3o2MG5TUlFvNW5oa0tOVTQxaTkyNjRH?=
 =?utf-8?B?ZmpxZUlmKzhwdDFhdlh5SzAzeE96N1pjckROazRMSnU0OHF1Wk1US09nYTRl?=
 =?utf-8?B?bHNlTU1DNHkrbzZBYjNkMnR1akFOZzlMOHo3SzJMRTZna2xtbGErbEYwc2RD?=
 =?utf-8?B?ZjN5L2U3SmhtRlJCYWRVNVIxRzVTcFpyb3VuWFNpZjZjZlBJWldCMi8rRnlE?=
 =?utf-8?B?ZEEyWG10V00wL0haeVFqYWdxdUVUWFFnUHZ4b0tLeGZoSCtsU0wzLzdGcjVQ?=
 =?utf-8?B?K3ZDNzhIOXE0T25qV0U5amhPaWtYNU8xRSs4NHRKSlNPZWxKaW1aNjBQSVVM?=
 =?utf-8?B?M0g5RFRDU003RUMwTlUvS1o4OXM2d3hybncyelJuZHpvZGFWRmFzTTZWOUFG?=
 =?utf-8?B?T1o4UXNVTmtrUEFaUGgxUGMxbWJlQ2F0L1Vza2RGRGh0WkhTM2wyaCtITHJn?=
 =?utf-8?B?bmpxQTQ5WWkzdG5yYzRTRTNGT0lDbXlMalExS1Ruc0tuQ1FOTzdFWXhwSjk1?=
 =?utf-8?B?YVVKRGNLbXlqb01zTFYwQVg1cUhPaEE0WkI0Mm1TdWhvQmtJUWdKTWxpTXdx?=
 =?utf-8?B?Z3lLY1BkTlROMjlGek03M2p5QnR2a3ZPTFE5RXZsamQyeHdvS3BQNXoxWWJm?=
 =?utf-8?B?WDQwSWZPNVpiemtPbmVwOHFNajRzR0VnUUVNYTV3elV5VGVTNEVsZmdZa0s2?=
 =?utf-8?B?MXhNYXprMC8xOGxabk00R0tFVzRWWklFRE1KS2t5YjIwMlU2aU1Hc2tDaGM4?=
 =?utf-8?B?VGtRajdsVTJPZmlxaXprWmZUZ3dTS3JicTRLekk3VVppc0Nodit2Y2lvY3ZC?=
 =?utf-8?B?eUZ1dFZscnRxMytrQUxvWmJZMVBRWXBucno2dUg2ZzhzVmpWN3FObUdmZG5N?=
 =?utf-8?B?KzMzSUdseVNwLzRmZVVZRHFscEtuTW5qUjNsVlZLY0dPNzZmTWQ5UzhHTlkw?=
 =?utf-8?B?eGVEUFFkeldiNkRDRmY3YXQyQ0c5V2ZsTHNWQ0tiRFdLU2E1RnFyUmh3azNY?=
 =?utf-8?B?bFV5WUNHTXY1eWJ1UEJZMXhEcEg5TXVJQm1pTU0yeGY0TEVzTkJwQ3RMTEMv?=
 =?utf-8?B?V2lkekdPcWcrU0RxRE9kc3NxaUdFU3l4eWVQU2hTTVlsLytPWjVGK0MrRlZZ?=
 =?utf-8?B?d3RrakVUZWpsc00wcDlEZHc4SG9FR3NBN29zbWNuMmpHZjJIZWM2WnBnYzd6?=
 =?utf-8?B?TTZwQTVRdHlzUk8zMngzbzlaeEs4WFdJb05IVWV6VzEwWFprajQxUWFwOVhJ?=
 =?utf-8?B?dlZhandySkExa3FVYm5PTzRLeHI2ZnNkVGpyTS9DWEk5a1JDdCtLQ3BNcVNR?=
 =?utf-8?B?aEFmM0pYQlBsSzUrb3pJSGNrMmJZTE9mWHIxWS9mM3JuNEcxbU9sVWhVMHpE?=
 =?utf-8?B?V3hBOGJPRUdvY0VwRkJoTDBtcXlvU254ZW1xQU9OaEhVcTgxUzB4eWZjVkZT?=
 =?utf-8?B?N2xCVkgwVithUVlrcTZLdldUTTRabTRXZTV1SnhDWlJuT09RQUZSR2NJNXBZ?=
 =?utf-8?B?OVBKazZTWHBRWHZJZnJvMDZ1N2w0ckhpVkxqWStsenFMeWRUQytvdDVrdi9t?=
 =?utf-8?B?T2dMcVZ5T2VUV3o4QzFia0ZuMEVGRjdTRlk4VnA5RUlGaXRQLzkyanZUSDFT?=
 =?utf-8?B?Vm5seWdDVEQ4TGF4UG1SVnN6N28rSG53ZDhWL01BMFN1a3RpWDlJalhlNnYx?=
 =?utf-8?B?bzgyVi9leW80NzhkZmM3WUwzZGRJeEluR0R3ems0bVNCR2ZSa0k5clM0YzBP?=
 =?utf-8?B?Y3oxOEFJK0NiM3F1cFN0eGI5OWdaUHNWVURIV29FNEVNN1BEb1NCbDRIV3ZI?=
 =?utf-8?B?T1RIcVZPWDF5RldvTys1MHJLTmhoQTZFT3dzd0wyT0VnOURlMlRraDJKMFly?=
 =?utf-8?B?R3pyZXFTa0ZjSFVKQ1dQYnNXNk1EVEFaU3JtY1FCU3BNN0lHVlBOcldKaXZJ?=
 =?utf-8?B?NWJkVVJjSGs5YnhiSlRoMUZkWG9qbVl3aU50ZFFyd3JWSEh3WWFDVVhWY1FI?=
 =?utf-8?B?dVdIWEZseWlBOFdzTTk1cWYwZWlWdkdSdW0wd0VpVG5GS3VxaUNnR09VL3ZW?=
 =?utf-8?B?RU5Kay9jdE4zK3B0NXcrSm5xcVhDQ2FvNUNZYVZlUk5CV1N5Y0ZiY1JMQ2M3?=
 =?utf-8?B?c0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PhEYpK0s74Qt97ZXGybcJhuBpCd5bqN6+m5syXPWKURDmDsggzfC0MJSUiY57QG+MGAeuQ3N5AwCVjTVLadKVpSH5gYy2pet7w6ZJTPwz9MA4fW8u0Rk4vuanIIC/F0JqdKGIGpDMfX8509SeGGVzvjSNFBWBbAAUzPKsydm41lCe3ILeax6lZOD66d5BweT2VzvrmJMAv75Kbhi1a/AxFdUOM9PxXD0T0f82MQ083QFuL1g5w95omXgzCusRE6UuhzCRhS/pYmb6TuIxZPvrCIoIvHCJZ8NTnQNEjozqkd272TA8AN82CuNGFhV5ooqzMYEfGad5GvR7UW/2NG8ldiK/fx/eemu6gs8hXXd4zaRNqEeXzrFIPDp/xKSyoCcSPz4TqK5fvCnqW5EtmsoArqecqSPuxiH9Dn6gzJ8uqi7C+6Qq4agW2PfuAvtR7vvxgwlvgyOZuamhPFZsdsFWj9wI0Tu+/x6cD0uCm2+4wazj8lVJ2hoqYj1O4SpzSQOZoa9a4j2ZJUmGEWljGPLLT/61SmNiogh5sabbtvYs2oxRDfQZ3Xaw9HnTI1jB+xhlzjLZDA4MRezuBBhgL/40cBOYGAb27aolAMfwg1TuZE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd7bb46-4bc5-46fa-4d2e-08dd3635f9c0
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 13:59:20.9387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e2UDyxILU7ZMLF4aOqDbEiOXbmvy0Us9CENrBPfYdlY5UwJ+pDVQq9LgqBnqBvqyJ9y+/0GpPCi2Qg0qYgezkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5827
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_06,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=998 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501160106
X-Proofpoint-ORIG-GUID: qYilFn7OkWbMR4lvEB_CvUY0aR7lzA9J
X-Proofpoint-GUID: qYilFn7OkWbMR4lvEB_CvUY0aR7lzA9J

On 1/16/25 8:37 AM, Theodore Ts'o wrote:
> On Wed, Jan 15, 2025 at 09:42:29PM -0800, Christoph Hellwig wrote:
>> On Wed, Jan 15, 2025 at 10:14:56AM +1100, Dave Chinner wrote:
>>> How closely does this match to the block device WRITE_SAME
>>> (SCSI/NVMe) commands? I note there is a reference to this in the
>>> RFC, but there are no details given.
>>
>> There is no write same in NVMe.  In one of the few wiѕe choices in
>> NVMe the protocol only does a write zeroes for zeroing instead of the
>> overly complex write zeroes.  And no one has complained about that so
>> far.
> 
> It should be noted that there is currently a patch proposing to add to
> fallocate support for the operation FALLOC_FL_WRITE_ZEROS:
> 
> https://lore.kernel.org/all/20250115114637.2705887-1-yi.zhang@huaweicloud.com/
> 
> For those use cases where this is all the user requires, perhaps this
> is something that Linux's nfs4 client should consider implementing?

I've seen one or two other mentions of "let's make the NFS client do
such and such" in this thread.

To be clear: The proposal includes client and server implementation of
the NFSv4.2 WRITE_SAME operation. This is not a client-only thing.

In fact, the most recent requester mentioned only a server
implementation because they have a client that already implements
WRITE_SAME and want this feature in NFSD.


> In any case I'd suggest that interested file system developers comment
> on this patch series.
> 
> Personally, I have no interest in using or implementing in a
> WRITE_SAME operation which implements the all-singing, all-dancing
> WRITE_SAME as envisioned by the SCSI and NFSv4.2 specifications.

I think we need to consider a weak generic implementation that resides
in the VFS or a library for file systems that choose not to implement.


> I will also note that many Cloud vendors (AWS, GCE, Azure) are moving
> to using NVMe instead of SCSI, especially for the higher performance
> VM and software-defined block devices.  So, I would suspect that a
> customer would have to wave a **very** large amount of money under my
> employer's nose before this would be something that would be funded by
> $WORK for block-based file systems (and even then, it appears that
> NVMe is so much better at higher performance storage, such that I'm
> not sure how many customers would really be all that interested).
> 
> But hey, if someone knows of some AI-related workload that needs to
> write the same non-zero block a very large number of times, let me
> know.  :-)

See my previous reply in this thread: WRITE_SAME has a long-standing
existing use case in the database world. The NFSv4.2 WRITE_SAME
operation was designed around this use case.

You remember database workloads, right? ;-)


-- 
Chuck Lever


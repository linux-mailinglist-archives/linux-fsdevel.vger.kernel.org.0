Return-Path: <linux-fsdevel+bounces-32980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 576CC9B1184
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 23:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A7521C210A5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 21:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C476C20F3E8;
	Fri, 25 Oct 2024 21:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VMVWp6pF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="U9nzdWxN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AB61CEAD3;
	Fri, 25 Oct 2024 21:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729890620; cv=fail; b=QMVj/hkDOoKOL0t5tlKpcg2QBlzwrqjASULkEvhKRTBt+hmWWHbFoZSQkwiLewfS9iXIYNTInArO609ZjjWwTV8alLdRrzx3n5Qfpf42JeYooS0fmBl7kLJrO3VrAxR+wAhMCQRgwYupKOQxZ8VM4dQw74TWmB3pzA7/pcXO3iA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729890620; c=relaxed/simple;
	bh=BzE5zqd6nfFv63HhEIbwPL9o4NU+0msETEpl8jiR3EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FFwWwGqDCvhPb/cE2FjTdLW5h76lEvxvMNOMzMsfiYPG9x647xMUPgUMopYeSr/WyvRuxgwh//eJaMMphT7TMRB9JeOaSRGfmDSCXnz6KNufNHO17DhCOaf7cB6Tie2FhUsje8A12yagvgsl3csI3zxLbV+xrqlFIzYX3lqYcLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VMVWp6pF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=U9nzdWxN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PJdUrm007228;
	Fri, 25 Oct 2024 21:10:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=BzE5zqd6nfFv63HhEIbwPL9o4NU+0msETEpl8jiR3EE=; b=
	VMVWp6pFVytZh/ShYZH1qkSQjAyqGsEXh1zgjhVuyxnHz1XnIUbnz0zeg6a7kDfd
	4qO7rZAn6OLgahBWTZItEZEwV9Qg0OoSsBPrZ8oI/bdVwbn1kFOtUn/7/S5jdhUT
	OGzJfW6Z156D0HkFenC1gnz8QeBsZhng7uPwoNkLXAzX901tU1UKvqtWtAJMlZZC
	w6Or0LVjnTxGYEVDSTKmHTBIbc4b1Zdj9WNTgWtJcogvTNQfErPO+HDW18iRskV+
	69g9Wi7ArxSg3DV6eLHbD5BoZfMlK9aQ4dqIv4/bdnRpivk3jPTuqzwXh8obLqe5
	lZ9l1uvTL7y5hZfJiKcgLA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c53uwwra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 21:10:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49PK1DIB015685;
	Fri, 25 Oct 2024 21:09:59 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emhcsanx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 21:09:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XasA56f5fbVDLh4/AUm/1s2dl1X0bVdimOSrmsEuhVbJiK/SqM+Z4Jhb1js8X1fQHpLacKwjzg6U0fNWfI1lHa8Zz0RaNiXyvWZr6aE3HeV3bvssth6lHC57oSvdR1O9jBkeDC1d1eMKxT+dlpd3LnI7q+ZGydZukSXgSc59mKEIdkXNFoI6ht5SgvHGwHTuGBvAJPIYYcUoCCgYzdJ/GYVgJ6cTUz0u6uhBmFGJ7OhLvBiSmzXu62FL0o+XBh9nx2nHsCRSiQH7Xnm5YSADsofQp4k0YUooI3BMPqLlBHc+ge2fxCBcMlHRXGrc3x447qRxbsLufSuLKaMjFt2ucA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzE5zqd6nfFv63HhEIbwPL9o4NU+0msETEpl8jiR3EE=;
 b=aO7Oyb0AUBBLv9hUSfHulrc63LqX5R0iWoyKEnRF5MQJV5NrK2pfXQ/MUGB4EoNSumST9M2b0GZW1C3XUm2lNN0M1n4Da7Z+ICuHyzyy86sre0DfwbtcPwJF8rkxWjGhN5uhq9wJXcrdugINYOVdZqvm2A8ZBJoEy+gUF2T0WrFDGOn6ouxbjBryzv/0sHej4VYxSD7l5FIziJzM4Eedbc2xfHIU6ElSTxZbU/l7DzQAKzQ+OTq4PwGHsjP6HKmYrq9Mb41W1QjiiQbh0FHlGzGwDoGGwBTtfLDGGIycy5Qi+60wE1kKfdcR8S6f+ph7hHJiZRI9RxG7xWiC1M95lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzE5zqd6nfFv63HhEIbwPL9o4NU+0msETEpl8jiR3EE=;
 b=U9nzdWxNu2rsrU7ee6jmjTyi646l5xE2fFxu9Efq6xwuEmYtBUKb139ecWGNIKneUo+FnfBEf4HkEyQRq+WAhCeRREWh20VWmlpyeUR7X+aZL8Z6zoDWrRTAPyHg/KOLQ2sIWbb6M8eFS9glFbHdraDCcQ8L25RLNm2rAJ2vojk=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DM4PR10MB6280.namprd10.prod.outlook.com (2603:10b6:8:bb::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.21; Fri, 25 Oct 2024 21:09:57 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 21:09:57 +0000
Date: Fri, 25 Oct 2024 22:09:52 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Pedro Falcato <pedro.falcato@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oliver Sang <oliver.sang@intel.com>
Subject: Re: [PATCH v5 2/5] pidfd: add PIDFD_SELF_* sentinels to refer to own
 thread/process
Message-ID: <239456b7-4045-46cd-a2e7-8445dd6640c6@lucifer.local>
References: <cover.1729848252.git.lorenzo.stoakes@oracle.com>
 <788fdfcc9ef602b408951d68097918d6ae379395.1729848252.git.lorenzo.stoakes@oracle.com>
 <CAKbZUD2ZB+U3GKJftfRH_2ejNja26v38OLVE2Lbfn_1KSOKhNQ@mail.gmail.com>
 <828674d9-e862-4438-86b6-61977f4cf3b5@nvidia.com>
 <CAKbZUD0fxczjSJo34MnWRNT4M6HTfWN0DRXr9CFe_+cKJW_mog@mail.gmail.com>
 <e5ac648b-88d7-4fa6-8eb4-d061a4b2baac@nvidia.com>
 <31dd0e52-9868-4cb4-aec6-d8749cdd2560@lucifer.local>
 <9de8d876-5729-454b-bf8c-8b0ec8f8ffc1@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9de8d876-5729-454b-bf8c-8b0ec8f8ffc1@nvidia.com>
X-ClientProxiedBy: LO4P123CA0064.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::15) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DM4PR10MB6280:EE_
X-MS-Office365-Filtering-Correlation-Id: e0614471-c659-40ca-df08-08dcf53960e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z1NmVVc4UTEyb0dCc1hYR0o1aU9jb3I5bnVSYjhneUtTb3pCWDB5RTRFQWY0?=
 =?utf-8?B?UHF6cEIzNzdFejRQOW5BWGE5TmRWdzdhRjRmdDFNYXdTdnltcnN0VDhhTklC?=
 =?utf-8?B?Y1h3OFNHZ2tXTHlibXVKVkRWb1BZSWxNZWYwcVNXTDhwSTRJT1FaZ25NZWFz?=
 =?utf-8?B?SnRRTnFIaUVmb1ZLK2J0UXU4RVhyQjFOMXdTWWdMdVZqVFR5Nndhb2lZRWgr?=
 =?utf-8?B?ck1QTEFHODExRGFzcnFDNWIxeXlrLzgzZW9yalFEZXFBRWdEVXZUNzM4QVZV?=
 =?utf-8?B?UGdQR2p5aXJSRG5QeE8wR1dZTlVwMG9rMSswMUVIR0tzSGU5MXlaRnZiSXIv?=
 =?utf-8?B?R3VWSWJKbERRcGJMd0cwa011b0FiWkluOEMvbkgxWGVHVFJYM0liVzZQYVZ4?=
 =?utf-8?B?VDNvc3k0TWNvd05yWHdtY0lBcHVUQmQxS0RTeld3bUhUT3U0U3d5WGw4VTNn?=
 =?utf-8?B?QTA2aGNibDhYRHV6TDY2ZEp3YjBIcmg5ZzZCcEtUalhra01rR0xaSGgzT0ZV?=
 =?utf-8?B?bkJxUG0rdmltR2ZJMVpnb0JvRENmSWJibW1OMlVDL20wSnF4U1FMQ1RCUXg2?=
 =?utf-8?B?SUhjZHJ1eFlGRDRhTjJaWkhJS2ZrSE9qZHc1eHN0dHBjTGRTc0U0YzFvcThv?=
 =?utf-8?B?MmxIMGZTYlViS2xqL0lzK1hLcFlVczZmSXVjOVUydmwzZFdaVXl1WThqbTY1?=
 =?utf-8?B?YkxaL3BJeUtsNmZoMlhtZ1ZEdzMyenBBYXozZUtlRmhjOHZzYUNwZ2dRajhh?=
 =?utf-8?B?MHk4TWYvLzY0Q3lUU3owTTZBbVUwdFQ1UllpSWhQSXByb1pCeG9mTGUrM2Y1?=
 =?utf-8?B?S1d3R3lLYUR2NnBZK0RZOXZrcjZiQWdNUngwOFhMNnNOUXBiVm9uKzBFMlJ4?=
 =?utf-8?B?WHFNdHFYb2tZNXJaVzRMT056bGVOelVrMk05OHJ6TGxudU44WExqNWhFWjNw?=
 =?utf-8?B?ckt1Z2dMeHQ1VW5CZzZ0dHRSb0I5Sm9QS09Ubyt3ZCtjOWU0QkZoenFEb0VM?=
 =?utf-8?B?SzJJTFBXcWoxYiszamtLTkk0STZsbExSVjJuTTVLMEpZYVl1OC9wSGovSkRQ?=
 =?utf-8?B?Z1lVY2Yvb1BwZnJiSHBUdkRVVlBhbWNIakRwTXo4NmR5Zys0RXowK2oyWlNz?=
 =?utf-8?B?TW1ZTEZ2VzNhMUExazQvaW12WlhYUmRDNjNYTk1pUHJFNWhwNk9IcExKL1pK?=
 =?utf-8?B?QUozdlBpQWJ6clRXQnNMYTIyVkU2V05PK3F2L2FMdFhnZGJSeHE4TFlEWWk5?=
 =?utf-8?B?Q2RaYm9Dd3BZYlM1VG5vOGtaVXZjb202WVJudG0rYWRSL2hUektOejZGT05r?=
 =?utf-8?B?SjBXYmIvUklRR0NxQytSNW1udkdXc2ZXbzFNWGdrZDNra1FtYmdmcmwyZkxQ?=
 =?utf-8?B?VWsyYnpWZ3NEdHdFZE82eFdtUDlnWXRoNm1qSGMzVjVOR2NhTGJSdDZFOEFW?=
 =?utf-8?B?aVZrVS9Uc01iVVR2bktKa2FpT3dod1hBbVZ4eVNVSUlIcUJpME9vdmdJQ3Y0?=
 =?utf-8?B?U0tWb2p3bEFLOEttVTJPalFlWGtHTzl5VG9Uc3I2b2taSmR5UWxqc0ZETjBa?=
 =?utf-8?B?VWZuRnRjSFEzYnlueU5PVlY3akRuNSt1S0tuTXRkSmxsTG9WZnErQjREcEVY?=
 =?utf-8?B?eUg5aE9hbW1TTmw2NGdEcERxZDcvS01naWJ5d1QxNXRJb3dtSUtQaStkalB4?=
 =?utf-8?B?SDJ6eDRyWkFFd052OCtTR2F6WmV6ODFqS2xyMk40NDdHdmlPU1R4aTZWdGQ2?=
 =?utf-8?Q?xL5fp3/UNae5aJXHiGpz9N5ZK0l3sCMjs51aEm7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDNvY2EyNUozTlk3VTY0cXhvUVYzRThQQTBRRW1JbTdYVForZkg2K0JzRUM4?=
 =?utf-8?B?R1RuR1pGYlpWM2VzTjNYQTFEenErem5uRURtN3pUZHdRTjAyS2J0YWpVWVVI?=
 =?utf-8?B?dkt4T2NmNy81Ykl5MXE2cXFtQ3JCR2loeTR2ekk2WXZnb2tEMTlpYXhxa0VR?=
 =?utf-8?B?c3NZcDNpYTVzdkJyMW4vT0tnZzVTUnorcG4xU2xOOVpkeGNMaUlFWU5Nd3VR?=
 =?utf-8?B?WEpvY2pteEI4VVV5b1daMmpVMlEwOW1GY0I2WWVKZWlxRG5LTWxzTXZQRG5W?=
 =?utf-8?B?RHV3WE1kQkVOL0VhbnRwa3Q0T0huVjBjUnRUYlU5OFdRZE50QW9od243enFq?=
 =?utf-8?B?d1ltTGJTUE5oVzgrNlFEcG9oaUlmTy94OG1PdGNWdTQzcE9hc2luN3M4ZGNE?=
 =?utf-8?B?RXZQSWxEV1ZZc2xvWlY2Rk8wQUN1VzFPMW8wbk02UllvRG5UY1o4cEJyVnIw?=
 =?utf-8?B?MFhZUEdRMmc4eXplb0NxYVZpUDJES28xNlpnVXR4NFRTWVJwZnVDV2o4K2Uy?=
 =?utf-8?B?K3NuamNQQWVXS3RCTlNpRkFSMWp0emJGWWtKa09RZ2FoRnNLSkY2UXpTSG9n?=
 =?utf-8?B?L0owV2Y1L2JiMDQxOWxBbEt1eHYyNnlTenBCV1h5anVGV25Id2FlSWlOb0Ev?=
 =?utf-8?B?cUcrckNzMkNtZnJzVUNDbzBpYm1GUElnMGxNYkxVWVVXdEpSQWxnK3FYOGFz?=
 =?utf-8?B?SVhmbFVVRXg4Um9LR1NJaXZsYVhZZEsvTFR1VVVRUmtCYlk3WjJzMGZaNFJ4?=
 =?utf-8?B?Y3MvR2Z6T0R6cjIzL2pzcEt2eGdyNncvZTNQbHJGaUdpOGNHdHR1bWgyeGRT?=
 =?utf-8?B?ekZLeWVHUS9aYnlTYU1menpoRVV5UnF0SXhvWGZyd0FNTTczSEhpRFpVNlJF?=
 =?utf-8?B?aHBwL0Q5eTBRd0F5U1lQaS9zN1ZTK1hCUzlGYkNQMWIyMHRaRFc3V1cyQWNq?=
 =?utf-8?B?OXEzYmhWSVQ0b3dkTW1mVFJJQWp4OWY4TUVKSWlXb0pSZHBEQTFOcFRydUFD?=
 =?utf-8?B?eENhellTUENoc1UxNVhHVmxTRlZDSGI1WHBObzBEVlZiNGFmU29tYURCVWJL?=
 =?utf-8?B?RUJCSUV5UFZOdzVTRVlTbGtzOEhiTjFDR3RFajRGcGZEM3I5S29QdGN3QU5Y?=
 =?utf-8?B?R3lqNmk2NmtpTlgwVVV3UmhiMklITkNNc1o4eUM2NjdJbjRjanZscnB4Mm5Z?=
 =?utf-8?B?L3g5VDNGbTJpOHJTNDNGbldWWmd5UGxOWlJ3R0FSVWxySWdmYnlsaXdVdWN1?=
 =?utf-8?B?ZVJBcjNWc3ArMHJaWTFndlhzOVFOckErQkhxQXM5eS93VHJmcWZZYjhZaFda?=
 =?utf-8?B?MVRGcTgxZlgrclJGUHVaMlB1c21TQTdHQlI0RlVoWHpWeTRaZUlxMlBDWkd5?=
 =?utf-8?B?N1JKNVZHcW1uelBuckNSbGpySGgxUnkyNVVWMy9YdENnRHBDb2xIcDdsaVVz?=
 =?utf-8?B?MWtiUXBTQ3lCd3lWSG1qNG1xa0QwV3FneTRlbXRQYnVLS3I4YldlTHM5RkU3?=
 =?utf-8?B?TXZmcW1iMWYzc0V1ODIxK0p0dys5VkNyRzQyV2lxTU13ZjhFblpscmdNdkhL?=
 =?utf-8?B?elVHUTUza3VvN29Pd1ZxRGNFMmhmUk5DaSs1Mnc3OGd0QnpqVGhGUFNDQXVC?=
 =?utf-8?B?ZG9kWDhKemx3NEZBRWRVT01JTHFDVFdmeFZDQXZzSmdFbC93ZXQ5cXd2OFhV?=
 =?utf-8?B?TmNXTTJyOXMzMEhMSDRUVFM0VXRia3hJVUduR0tYNytnV0lkN08xK000T0Y2?=
 =?utf-8?B?QVd6STRkanJTWFpQSko2QWtwSTkxS3UxUE1wblUvNGtuWS92em82bDNUUWov?=
 =?utf-8?B?MG15UGNDNHgzTUUxM1RkMzFyR1l1ZWxjTkFncGZ6Sk9qWTVCN1R0ajM1QVJk?=
 =?utf-8?B?dkZTOFhCa0ptOG9QYTRyUFUza25vQkgzUFoyTmJTbnVRWmp2MHhRQm9iZC93?=
 =?utf-8?B?N1R0cUVHaXFUSS9PSVRMeE5wSlN1NU1tU2REQmR6VmdzYjMwaTV0RFNHeU85?=
 =?utf-8?B?ZncvakErY1hjL3lPaFY0U1JjOWUyY2ZRZkRtc01URDRxREVMRzFxQjRaQmpm?=
 =?utf-8?B?VTArcWhnbjkzWTVDQ0ZYYmxWalpaMkI4UU1KS2V5UGJqUk5jU2pSclJnN3d5?=
 =?utf-8?B?R2xEUTRLTS9seDd4bGd0aUVwalc4TnRpcndaTEhZc3RRVHhIQzdtNGNSYURL?=
 =?utf-8?B?VEh1UGR6anROUHhMSS9xdEM5NEFNdkpxWkdoK2dUSGZrN1V1SnFFSytZZ01v?=
 =?utf-8?B?YXlCRWJsUTRmRktFYk4yVWxqcVZ3PT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BM9TUDOpq5HAGOoJ6sD57J+JKbozQK9X6m3uEnq1wd8cs2BgJxKpqaFTHKQ2iU5/WfoHiZWhxS2R+Hd9cC6QzbnijPvcrcn/ohVmXgGQtJFwapsbWXPLvqG1bbUkQ8jTX361jpXZ88UL4vP1X4GHgOKVY6q3y1ICIGTh0XEqq2+44YDNIqrd3HJ8Kr8Ai+JAck8Nk1UUSxbbw3t2qVcXq6IHlIKpjoCUfdTXl2u1q2+YfnTElhMbeymzev8O5cn+FsvbtTyEuCMVW/wg9SR3TSp1NTSwC6OctgjkqAgoOB2etrc8j89jkNH2E9yuDyKlli1clBYDNWznWZ7j+RkbRm3KQnJ4X1nWUh0o2jgXygNjlrsg/bMDxuaISHoMPEud30qAC7R0E19R99JpgY8SHaW7WleBLtaxYfJ/Yn1kBayT+5bJd7B8PJgCY75FzrpLv9+2zHJvQrpYQeDY7hsAe8SQ9aygMT9BRoBtZ8yZNIEwOhVTvHY4iColqtsVWIhT+DHESBeO7bFJRd1NwFBOtGnBAY3Bas08AGnf77ZLZvBRKGhIIvuL+nJFqKwxI/A1zU4Cg1ofSglWiE/duMLVaCN0a4rsM7bF4JGQVQuvlPI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0614471-c659-40ca-df08-08dcf53960e7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 21:09:57.0302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cE24aKur8APFVdhHdqzYffr5BlRhyA1uGCsfYOXtTcqTbzQh98jwZcVDUBVasBNm0TMj4utYslgIGf3OaJoAGpvNTZZClC6N8ntP0qRykPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6280
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_14,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410250163
X-Proofpoint-GUID: eHCCxbLTaKqL0DBvAV-p-vGRW_kEFu4-
X-Proofpoint-ORIG-GUID: eHCCxbLTaKqL0DBvAV-p-vGRW_kEFu4-

On Fri, Oct 25, 2024 at 01:31:49PM -0700, John Hubbard wrote:
> On 10/25/24 12:49 PM, Lorenzo Stoakes wrote:
> > On Fri, Oct 25, 2024 at 11:44:34AM -0700, John Hubbard wrote:
> > > On 10/25/24 11:38 AM, Pedro Falcato wrote:
> > > > On Fri, Oct 25, 2024 at 6:41 PM John Hubbard <jhubbard@nvidia.com> wrote:
> ...
> > > > That seems to only apply to the kernel internally, uapi headers are
> > >
> > > Yes.
> > >
> > > > included from userspace too (-std=c89 -pedantic doesn't know what a
> > > > gnu extension is). And uapi headers _generally_ keep to defining
> > > > constants and structs, nothing more.
> > >
> > > OK
> >
> > Because a lot of people using -ANSI- C89 are importing a very new linux
> > feature header.
>
> I'll admit to being easily cowed by "you're breaking userspace" arguments.
> Even when they start to get rather absurd. Because I can't easily tell where
> the line is.
>
> Maybe "-std=c89 -pedantic" is on the other side of the line. I'd like it
> to be! :)

Well, apparently not...

>
> >
> > And let's ignore the hundreds of existing uses... OK.
> >
> > The rules, unstated anywhere, are that we must support 1972-era C in an
> > optional header for a feature available only in new kernels because
> > somebody somewhere is using a VAX-11 and gosh darn it they can't change
> > their toolchain!
> >
> > And you had better make sure you don't wear out those tape drums...
> >
> > >
> > > > I don't know what the guidelines for uapi headers are nowadays, but we
> > > > generally want to not break userspace.
> > > >
> > > > >
> > > > > I think it's quite clear at this point, that we should not hold up new
> > > > > work, based on concerns about handling the inline keyword, nor about
> > > > > C89.
> > > >
> > > > Right, but the correct solution is probably to move
> > > > pidfd_is_self_sentinel to some other place, since it's not even
> > > > supposed to be used by userspace (it's semantically useless to
> > > > userspace, and it's only two users are in the kernel, kernel/pid.c and
> > > > exit.c).
> > > >
> > >
> > > Yes, if userspace absolutely doesn't need nor want this, then putting
> > > it in a non-uapi header does sound like the right move.
> >
> > The bike shed should be blue! Wait no no, it should be red... Hang on
> > yellow yes! Yellow's great!
>
> Putting a header in the right location, so as to avoid breakage here or
> there, is not bikeshedding. Sorry.

There are 312 uses of "static inline" already in UAPI headers, not all
quite as obscure as claimed.

Specifically requiring me and only me to support ansi C89 for a theorised
scenario is in my opinion bikeshedding, but I don't want to get into an
argument about something so petty :)

>
> >
> > No wait - did we _test_ yellow in the way I wanted...
> >
> > I mean for me this isn't a big deal - we declare the defines here, it makes
> > sense to have a very very simple inline function.
> >
> > It's not like userspace is overly hurt by this...
> >
> > Also I did explain there's no obvious header to put this in in the kernel
> > and I'm not introducing one sorry.
> >
> > ANyway if you guys feel strong enough about this, I'll respin again and
> > just open-code this trivial check where it's used.
>
> No strong feelings, just hoping to help make a choice that gets you
> closer to getting your patches committed.

I mean, you are saying I am breaking things and implying the series is
blocked on this, that sounds like a strong opinion, but again I'm not going
to argue.

As with the requirement that I, only for my part of the change, must fix up
test header import, while I disagree I should be doing the fix, I did it
anyway as I am accommodating and reasonable.

So fine - I'll respin and just open-code this as it's trivial and there's
no (other) sensible place to put it anyway.

A P.S. though - a very NOT theoretical issue with userspace is the import
of linux/fcntl.h in pidfd.h which seems to me to have been imported solely
for the kernel's sake.

A gentle suggestion (it seems I can't win - gentle suggestions are ignored,
tongue-in-cheek parody is taken to be mean... but anyway) is to do
something like:

#ifdef __KERNEL__
#include <linux/fcntl.h>
#else
#include <fcntl.h>
#endif

At the top of the pidfd.h header. This must surely sting a _lot_ of people
in userland otherwise.

But this is out of scope for this change.


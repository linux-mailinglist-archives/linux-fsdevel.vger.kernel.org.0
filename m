Return-Path: <linux-fsdevel+bounces-43789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5F6A5D8C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 10:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DD923AFB91
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 09:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0FF22B8D9;
	Wed, 12 Mar 2025 09:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W3yIcU0Q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wfWPFLtg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE0F1487D1;
	Wed, 12 Mar 2025 09:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741770073; cv=fail; b=PkXHv79Nq2wxpHhqZpzdqYtZIohF2O0ejoMekE15ePU3kia65AdGxFx7wbAdA7KFxFRrBchr7Dg4nJ8W0F/Cp7IY5JRAA5zuONsPfoVEnCMhFeOH3tE/SxwhtD/p45EYuDehbaFHVsp7ivl/GW0eM2qlTC0ZdNV4Fa/w5MDZn/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741770073; c=relaxed/simple;
	bh=95iPAu9FVJIyoQoME7IQdL1SbRNpbygpjUKn9g9l/YA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qw66C7zNd+Rk8kmbieRsVAgSy8fYYqlp4AFuoxTyyViLKrpzlw+p4oREL5JDHabCh3R6gEjtpFUdoND+/VX6xruynbZVc3qqnBO+10bq0CrnKkpPnxnoKWu0uUuwrKrpwEVio5v8TC89NqeXb/z/k4Jkfc9br48tlCSpomjggt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W3yIcU0Q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wfWPFLtg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52C1goLQ029700;
	Wed, 12 Mar 2025 09:01:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=VpA+9m+Zy4d/a1cND0lgVhRdgFyzGYJO9LqVbnCQs00=; b=
	W3yIcU0QR1gKHfvfhEgJgGrZj/QPOBXCGnYwXfQ79Ape1VK/k/r+tK7CuaARK+Ug
	o6OmQq9Y2urTQUgr/z4Epp/hksahqRz5lppUwS5uJdfsx7myQl0w0I1wuOUW9ucL
	SVB7XvogegGwgsHZHt0nEEPStzzhsYe5yNY3K3Un3TBeLmDBw0tSAB8/mZsGMGc3
	vvdQEaCEEuunMNWxk8NEp7HwOJMxG/mAV9skXa+rSsBncmYId2bGTU3W5aaeQD1E
	xfyLnO7NWRVxz47gBRBNOcpUVKoqY1Jo4fDzEWvhNB8GR1JL3UxADz1kJ5eVliTZ
	/RJhGTcQ3jxBCS/ENG8zSg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4dh7s6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 09:01:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52C8wYSt019587;
	Wed, 12 Mar 2025 09:00:59 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45atn083th-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 09:00:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OkLnBGXctmu8THTDIT5ts02ZxjT70yXYBiqK3AmzuoWQMsy4ok0pJxtuCwvpjqWA73RQFFkDpuZHnrVFSJq9qkZ7FMx6jPN/KAKjBrWctIIcI66UMyZrSoAU9J/3+WKXV8cpNj6+9Eqg1Qdc8iJvZAtjhQcqFfpOtGRVzZkVfvTGFQ7S91pPNzT4Ix2R0lxA2XcSePvzDF5pEbzeM3HbO+bYFJ8TMqi7Rs1TPmP3ibzO90FQ7f3O/9QJbXUuLVogvPk6pUEnOF+GIuwogLFgVQbNvrMAh5IWFJksRwC5tqi2L1gqGQV8US5QcSSzhImy2gs+7NJ3+SnKV9T08KCLrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VpA+9m+Zy4d/a1cND0lgVhRdgFyzGYJO9LqVbnCQs00=;
 b=DQAsvWSVZjZIGM+7EU8OmIB4r4Q9zX/iuoB8m5r2uHzgy+VE9+YpHCwBioAFd7o0UmvKFCqAK0exR7YC0JegDhFz4bpqHWTEnP5RCZTADdcXKBJxUVeCkjJYRuwQmFTLOKirWZeEgd8z57q65IsOr48LOVRko7vorGQ+E4joZFzWV4nAmTWI/h1UObsmWdDx1XdHWmR7kgwnl2F0iv7E5Jw4jB5XYhQa+/XcVx6QBkz1JpjsP7Ig7MApI7K37CBU2KUSPUqd+d+9k10657dG/qnv6Cg+NLfkLmuOZd2l2/cRR/QNIrXxPesGsYXXCQ3drf5/Ou6HLli+yYrugnvr8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpA+9m+Zy4d/a1cND0lgVhRdgFyzGYJO9LqVbnCQs00=;
 b=wfWPFLtgp/Q9V57kNMUWGjgySSLNuzUegMkWGOOyjOnFSBlzzAR/MhNoRu05LMLdZtBQK1wE+PLltGNgJwJh2uoWQ3m78FZtnXBOC9JUq+x7+wTH3tN/DhSajiko0b+V8M3qBweWPYJJWwqoBrKQmc+0Gue97QJxW4EPfDTH7cU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA2PR10MB4489.namprd10.prod.outlook.com (2603:10b6:806:11a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 09:00:57 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 09:00:56 +0000
Message-ID: <ea94c5cd-ebba-404f-ba14-d59f1baa6e16@oracle.com>
Date: Wed, 12 Mar 2025 09:00:52 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/10] xfs: Iomap SW-based atomic write support
To: Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com
References: <20250310183946.932054-1-john.g.garry@oracle.com>
 <20250310183946.932054-6-john.g.garry@oracle.com>
 <Z9E5nDg3_cred1bH@infradead.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Z9E5nDg3_cred1bH@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0195.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::12) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA2PR10MB4489:EE_
X-MS-Office365-Filtering-Correlation-Id: 4127a668-5e4d-478c-a9ca-08dd614466a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0tVOWlGQ0R4QlZMakJSUzZHWGxWNmpTc2s1ckxqallrTlJPZGtGVGp0M2dm?=
 =?utf-8?B?eGRWZDhkRzlqNlFpRU1NUm44NGhZTTFmYWthaWJHSmVhbFNMWXJSazk3TEEr?=
 =?utf-8?B?Z3dnOEpKWUFyYkpLdGF1djBXMm5XQWRTMUhyT2J2cG1qU1J5YUNrTFB4QnZw?=
 =?utf-8?B?bktnLzlVS2NEQVk0MFhHcXgwSndvQTBiSWJDU2dHNzV5UVdZNll4aXY4TlBO?=
 =?utf-8?B?WWorL3JTdjdzc1QwVzN3ZjZwYXlERkdMck44YkE3SmN1S1luc0hsM2hzV0cw?=
 =?utf-8?B?SSt6dkZGMTlaa1JzbW1PUnc0cGpQUllXN3ZJdHNWbTl3QjZzVHZMa1ZySllB?=
 =?utf-8?B?dHlpMkFWUGt6c0p6dkJVQlE2K1I1M0lNS2lzNlBpdndxc0VOMFJaRm1ZRkhI?=
 =?utf-8?B?YTVNMWRmd3lybEpXclVySk1TREJnM056MXFMSGRHZG5uRDBBdFpLaHBlTm1H?=
 =?utf-8?B?aG9aRENyWFZZb1lUKzEyblpFeDhYTUJyRkFJaGtjOHFJY29FQ0NRY2ZHa0hF?=
 =?utf-8?B?QnQ4UkpCWko0L1VDY3oydWxudWtKUlY0RzAwUVk5ZU1CZGZvV2VqMHk5M2d6?=
 =?utf-8?B?MVd2RWYxN2VvRGsxcHpNYXpSeldzZHpVNFNvaFlWaGdablhKRk1heTVieGVJ?=
 =?utf-8?B?clVzT0V3NmZIazFlMWJLVm9UNmZqZElLYlV6R2NiZXdJcjM1SUdFZ1VxK2xD?=
 =?utf-8?B?VDdNaDZGM2x2UHJRcjFMSXdiWGlzZVJ0Ym1rOFJhVXFEQ1o2VEgzWU1JU25j?=
 =?utf-8?B?ck5jbHpTQjl1anozbytDUS9QdXIvR0w4bnA5KzU0OFM0RXhLRDNreitFelEv?=
 =?utf-8?B?MHJhb3pTbkhad0FZOE1ML1czd2xmWmtTMHNBcngxVFdiM1lLVTh5ZGVjMktB?=
 =?utf-8?B?M3ZBMXRWbDdsUTZxNFdlUWdFdm1sUVhwWGtjNEp0TGNrTVhZL2wvOTdxTlEx?=
 =?utf-8?B?YWVxdXAvRWlDb0xxR3lUUS9DeFR2emNCaC8xTUxBeWNIb3QwaWlrdmZ3S3BH?=
 =?utf-8?B?a2s1b2JKSG9MQkxZVW95ZTcxc1VMQ0VoMDhud3o1RnpXTlMwT1U0a082d09Z?=
 =?utf-8?B?SmlkOG9ocGJ6WHN0WGE3c2pidEs2S0dZRTVIQ0wzakRQQ1pZZnY4MTFkSzdN?=
 =?utf-8?B?QzE1ODRFL3E4S0xHYTBNOEpWN09UODN1SnBSa0lGUnVOL3p2blVjUURQQy9R?=
 =?utf-8?B?QVNtZmRUMDZzRUZORkpxRkxSTFFiNHgxdjR3ZVpWWk5FSDByNm4yU1prWXZL?=
 =?utf-8?B?STYzajVzZTZOcHJGMDdyM0xreENIYUF5czBzUGhFOVhJTjZrd24vVTh3SzJX?=
 =?utf-8?B?anE0cjFabGVxUms4Z09Edy9SS0Q3QkRJREFHcWQxOVZHSXhSRkgxNG12cVpp?=
 =?utf-8?B?c0NNdEJ6UGVKdGVZWFAyRGtEK2o4YjVmaE5TVEFyZGQxMFQ0UDIrRStwL0Nz?=
 =?utf-8?B?ZFVhVG02Q25LekI5Q0Frc0hySFRWM0IwRUN2RVVVYW1rVWtqUGEydCtUdkE0?=
 =?utf-8?B?bjBIQkhNVEZqenlMT0sxN0lINU9DTzFkcjJWSkNMMGhlYk5jSG5XL3o0VDBI?=
 =?utf-8?B?NGw0ZEFLSCtNNFF3MTFtL1RIMldmeXpoNHpLK0ZOK1g2TWowa1JJWVJNem1N?=
 =?utf-8?B?L0JjWDYraE5iTDdFb0xaZ3BCbVRjY0N5VWp5M1R2ZkllcndCaTZKWWRMOGZQ?=
 =?utf-8?B?c3BTeG1YWXZMaGY4dXh6eW9ablc2c3QwaEJ6ZUVSTkpFbmNMUUhyVWliK2Fy?=
 =?utf-8?B?VTZWc0lka1FSQ3dPVUNxbklqSGhENEorTEN2ZnFYSExqc3VpKzZBSUd5cDd0?=
 =?utf-8?B?NDFqUDhsSjRnOFQ1MWVqNm9mZ1ZTcW1ldnJ3Rk9ycnJmSGM1c04rQkVoa1Rx?=
 =?utf-8?Q?mreGQE8vPn5Zd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUNEdzF0SzR2QVMrWG9hVHRkbVp6YlpYanljSmRua1d4bXlYK2tqN2FvYmhv?=
 =?utf-8?B?YmdxNEo4Tk9XR0hjb0d5dTFDRWN5UnJyalpoUGFiRWhkK05GVWFSd09rQ0lO?=
 =?utf-8?B?UGExMFZuYk95OHFnQTN2Y3Vrc1d0TGJQTlFuNElRS2hBUlZXbTRjRmF0Y1lS?=
 =?utf-8?B?VCsvSUlkVXpjMzFFRForNUdDWHhZTm5aOElrdVJYUkxiNnUrbDZsRjFuOWJX?=
 =?utf-8?B?RTRTSHozblVkWk9IRXNPM29TTE8yQ2Vac2RENXIvOGRQSmUrQm5YSWxOZm14?=
 =?utf-8?B?azhKT1QwL0FndE1UOEVJY3lxaDExKzlRaEtJM2orUmxBNWRkcVpFMmxCUVBK?=
 =?utf-8?B?L1dmQmJka0lkWllnT2Fjdm1PazJjZ0prdjFPV21QYjIrNWhDRGRxN21rUjZs?=
 =?utf-8?B?T1NrbFhxcW42SytYRW44ZFZnMnVFbk1zajhiVzJSZ05wUUlFUEVaOHI1Yzcw?=
 =?utf-8?B?OXArbzBVT3ZWdHoxa2R6SlVxWVJSWGxJd0h3V1FJcktZcHRWMFpBYUl2dmdV?=
 =?utf-8?B?UHEyalN5Wmc1V1hPZm9ha3VDYUU3aVhPU25HQkx6Ti9ienRFT1lMRk9LNnI1?=
 =?utf-8?B?YW1Ic3AwL0RwdXpWRk1QTUhuL3pzOG9nMzliRzZIVHFFR2dySDR2UVNzY2tR?=
 =?utf-8?B?a0tCM0hhaEcrZ0VYeTIzQlZleXJHZWJ3bExMbnJCNnAvUk5keHFpWDFrQjRQ?=
 =?utf-8?B?YXNuSVdCdkFZbXBUSGJSNlZieXgzMXQ0VFl4eGtIbnZoM1dJWDhRM3BaYnI1?=
 =?utf-8?B?Y3NTeVRlRWdDaTNDdEdOZ2pOQVpZcEQ5ekVMeXRXYSszTHpwUmI5R2dnWVVF?=
 =?utf-8?B?OXUwV3dCb0xZRmxHT1ByWXZNTVdSSjNoSkEwTnRGUU9vYngzVEVndEIwS3pq?=
 =?utf-8?B?bEtieVgyWTQ3ekFMU2RwWkYyekw2d0crMEhHamlZN2xrUWVra2lNUklFcGNl?=
 =?utf-8?B?amkySTVQVllLaDg4NDV0bm9kWGdWN0U0MFYreWM2cmhzSFZ0QThld2t1TEx1?=
 =?utf-8?B?bWxPQWtJWSt4bWhTdnNDMTFONks4V1dnTmpMUXcrSmZqRGNMVHhEWGhlQzNC?=
 =?utf-8?B?dkZmeVZVOFNjYlY4Z2JjRWVoZVNKREkvb25paDcrZzlScWl3Y2pnbzRFRE1Q?=
 =?utf-8?B?dHBIczlHbStTak9hbXo1SW00WnVXSkhTdjhkRlVUL09WQmwxa29CMXB0d1Vp?=
 =?utf-8?B?NzBqNWxHdkUxN3FJZGx0eEVnRHdzSzM3ZTNITEZndmZJRC93SlNsaXRKREY0?=
 =?utf-8?B?UGZ1cGFoc28zY2w3N0FjSDNrU2syanF4aERxUTFVOENDdWRSbzdNajBBZlBk?=
 =?utf-8?B?dm5EZnBIWFdISUxnZFlRQ284dnNtTVdObEd2TUhYYTNra3I4eG9PQ1hwbk90?=
 =?utf-8?B?Z0JvZFNHS0owNlFiam85Ry9OVy9SN0gxd2VkM0V3WjZ0cWVLNWZvWnR3N3R0?=
 =?utf-8?B?amtGWkZTZ1J3RW5RVEpqekk0bEQ1OFpCbTFzOWR1QWhkeHdTQTB1ZVNMSzZy?=
 =?utf-8?B?alV3Mm5yNUFyOThlYUdvME82RStOaWpkdmxFWCtXVnVXQzhJRnhOcDJsclRS?=
 =?utf-8?B?TEN4cm5PMmZyK1VBdFpIUnpXM202ek5jalkySFJ1bm1hNVh5emQzOVFBM2ps?=
 =?utf-8?B?dkVySnhlNURZZzFja2FIMFRNa1VyWkI4UzJrTnlvdkl2OXNrWHgwbDZIOXJQ?=
 =?utf-8?B?emU1ZG1pbUN3NENRREFUL3NqMlpDaStUcGlZQ2VaQmtmdWdDMEYrczBKOWJO?=
 =?utf-8?B?L2h5VlNxekV6TEtCK2RLWXRVdm1CYmd0cTJFSmpuZllzaFBSbTVsVlVCMEpF?=
 =?utf-8?B?NnFyMzJMa3dZVXhNNFh5YXFJVURpWHZsd0RWR0hETERkanQyRWpuSndFMzl6?=
 =?utf-8?B?VER4NnlQelp2WmdpKzd2ZHZGbXFzVndpbHBndXk2a1ZPQllyQjdKT1JZeW91?=
 =?utf-8?B?Yjk1cEdHR01QOXhWODJRS2FDVGV2V3BkYTQ1Vll0cTRIME5KSFNoREgwU2pK?=
 =?utf-8?B?VlEvblAyOTV0WWsydWExSkhzQ2tveFpCdU5FczUyenJsSmR0K2M1ZmFpcUxH?=
 =?utf-8?B?OW05LzhTNThxUzNCSU0wdjlkaUNFVGNhd0tEeXM3dS9GSTl5aWh1ZW1WQ2cr?=
 =?utf-8?B?U1RHOXV6V1lHLysra2RpdFd1dzVpZjNIQ1ErWWRZNXU0L1A1VUtFenRlOEtL?=
 =?utf-8?B?WXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Z7Z7ap7C21dqQQai4YZEJ8qrbrBMMFK6FRn2PSsKJFyxsEyc0DK/xdiz7XABbvuL3s2dDBrTVwvunkL5zHgAbMjWNNr93c3UfmdcspLZ1caLO4hmOGWU5lAxfGOqCSJ2s5YnZ1KNkhV7g/I96cTJPuuQgeEFQOpb+GsfvJRcnaUn3njimGB4DqnpThhTrh4rZHi3oJH42w6uybf1s/UkDGQCPUTqxNT1TMQwX/BspgUSOWd58F7JwtGK9J2inCCwgszWPykDB8FnT1Qv8GiGlfyMLrblHIMLpSIXNfsFls4wEAHf7q+elPZ4fuxoB+jtQU7GaNsSW/KXhBRcMODXzKLnJPke6k64gIv5ByvUCpr5lDihKQKieLxJEvQBxu6SUF3Dmn1lu37QKWCP4itMTNijEy4xzCbMilgn/bUH8Z+M1f4dh+08Y313L7mkx43/AtxeXAirOz2RU7pOnoyLE5gd/dAU9PZL4QGjCTtBPls9k86EprIj70J1Weokks2SY0A6FsXaYyrt9UmIvKUPfmjy6bh7zEfYVqvDq9UoFtNn3JoQrECj97x2n7L4lw0O4TWvVAQDoNfhtgKpUQKXS7kz/Y+HXt/2Rlwr+f/ExfE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4127a668-5e4d-478c-a9ca-08dd614466a9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 09:00:56.7048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: re4laoeMFIU/uLKSQ9v5MgH0ToyCRgLxh9QLM5vYhF5enwJC4ug1UJy0e0297CLxuhQNUgs7ngNVNSQ4v7rVtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4489
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503120060
X-Proofpoint-GUID: rL7Ypnlzkm5GcluKZWWeseohSpeNG8qr
X-Proofpoint-ORIG-GUID: rL7Ypnlzkm5GcluKZWWeseohSpeNG8qr

On 12/03/2025 07:37, Christoph Hellwig wrote:
> On Mon, Mar 10, 2025 at 06:39:41PM +0000, John Garry wrote:
>> In cases of an atomic write occurs for misaligned or discontiguous disk
>> blocks, we will use a CoW-based method to issue the atomic write.
>>
>> So, for that case, return -EAGAIN to request that the write be issued in
>> CoW atomic write mode. The dio write path should detect this, similar to
>> how misaligned regular DIO writes are handled.
> 
> How is -EAGAIN going to work here given that it is also used to defer
> non-blocking requests to the caller blocking context?

You are talking about IOMAP_NOWAIT handling, right? If so, we handle 
that in xfs_file_dio_write_atomic(), similar to 
xfs_file_dio_write_unaligned(), i.e. if IOMAP_NOWAIT is set and we get 
-EAGAIN, then we will return -EAGAIN directly to the caller.

> 
> What is the probem with only setting the flag that causes REQ_ATOMIC
> to be set from the file system instead of forcing it when calling
> iomap_dio_rw?

We have this in __iomap_dio_rw():

	if (dio_flags & IOMAP_DIO_ATOMIC_SW)
		iomi.flags |= IOMAP_ATOMIC_SW;
	else if (iocb->ki_flags & IOCB_ATOMIC)
  		iomi.flags |= IOMAP_ATOMIC_HW;

I do admit that the checks are a bit uneven, i.e. check vs 
IOMAP_DIO_ATOMIC_SW and IOCB_ATOMIC

If we want a flag to set REQ_ATOMIC from the FS then we need 
IOMAP_DIO_BIO_ATOMIC, and that would set IOMAP_BIO_ATOMIC. Is that better?

> 
> Also how you ensure this -EAGAIN only happens on the first extent
> mapped and you doesn't cause double writes?

When we find that a mapping does not suit REQ_ATOMIC-based atomic write, 
then we immediately bail and retry with FS-based atomic write. And that 
check should cover all requirements for a REQ_ATOMIC-based atomic write:
- aligned
- contiguous blocks, i.e. the mapping covers the full write

And we also have the check in iomap_dio_bit_iter() to ensure that the 
mapping covers the full write (for REQ_ATOMIC-based atomic write).

> 
>> +	bool			atomic_hw = flags & IOMAP_ATOMIC_HW;
> 
> Again, atomic_hw is not a very useful variable name.  But the
> whole idea of using a non-descriptive bool variable for a flags
> field feels like an antipattern to me.
> 
>> -		if (shared)
>> +		if (shared) {
>> +			if (atomic_hw &&
>> +			    !xfs_bmap_valid_for_atomic_write(&cmap,
>> +					offset_fsb, end_fsb)) {
>> +				error = -EAGAIN;
>> +				goto out_unlock;
>> +			}
>>   			goto out_found_cow;
> 
> This needs a big fat comment explaining why bailing out here is
> fine and how it works.

ok

> 
>> +		/*
>> +		 * Use CoW method for when we need to alloc > 1 block,
>> +		 * otherwise we might allocate less than what we need here and
>> +		 * have multiple mappings.
>> +		*/
> 
> Describe why this is done, not just what is done.

I did say that we may get multiple mappings, which obvs is not useful 
for REQ_ATOMIC-based atomic write. But I can add a bit more detail.

Thanks,
John



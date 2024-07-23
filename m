Return-Path: <linux-fsdevel+bounces-24148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D8793A4CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 19:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBE2D1C22262
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 17:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A6B158207;
	Tue, 23 Jul 2024 17:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HMZndeIV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IvzcaPFx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B509C157A61;
	Tue, 23 Jul 2024 17:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721755027; cv=fail; b=ESz3NLK3WaqGb185/KmLW1MuCw+MWmR5PthCBuqpRuQldOjAByI0iYcFY9mG1VSk4VRFtQ6Zoj7U0kvDYrQQ/N5Kyv9l6Ya6SgnT5GWODbHWEQXrtdz/urX6IQfQxSkU3aFdGUEx8jrm6ZtCnw9eM9ggBM0nSiZWx8RHtVJ4a1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721755027; c=relaxed/simple;
	bh=yBUTW57m4T5AajInDRzlGXVVZOkqmAFa0hmdlN8jw5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qORR224ryDuJH/xp0NiHigNbVdF1djsvg15YE3rmX9O5ednrUk5K1tODJyI4WojZ5f0jJUgiX6LisgREAp8uIHD9pgymQm8RPqgbkK0vAE2veHJUMBDsKvSuOCEQDpSLHGCAR2mB0ufL2TdMOUnjakr7/bTX9ezOLyhD144EccQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HMZndeIV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IvzcaPFx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NGQWND026263;
	Tue, 23 Jul 2024 17:15:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=PB8BYpcdslViKF79XJ2YzlN1Vk5ClgDRth1iFgE5pWU=; b=
	HMZndeIVKXe/vaQQWQxNIwb27dj5IgVOmWj4gYtGcAhfFEvy+AZ210bjQoUlE0W+
	L0AVPo1IE7hNtAH9c95x3cuR/sA4LtQk+mH/31PLw84aBZvt1KzSTroQw2bBQPFG
	ugrynGvrU7SbmK7eqLTClH5rI9tuV3UwqpC0XX85iE0Kt+db3ICMHBmQc9IU+MrE
	4CAszbU5XwDdEyFZcoTAHPdUL1z4vR4OpXeMpl6OKFORra23Y8/LJ+Vkh5AZc9Q1
	cbsqhLCL3AJQaFwvARA4aJXBJkg2Rze5f+qckdK+RBRjG77IIgG+YBp/lT4SpeC3
	ysR+Y1GJO7YSF3kdSGspBQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hgkt75ps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 17:15:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46NGG80i040109;
	Tue, 23 Jul 2024 17:15:49 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40h26mrcka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 17:15:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJLiw6QcZLQi37iSyGO7o0yWPTvKJdl34vrehXOl0Iv+OSGLvCoPbysPkXdGHheLuDEbfqhUY0jr1Yf7DqI3/FLZW7uekevgNTK4SXPYBLnqMhd37HBjRdUysNzpqswg0RCTVxp0sbqpFanAcIxyn3RIZeLruZHBBnekJ3f1cRO+RISIcOikVnqWD78LwWApzJu7/tPic/TcwwxDjxQQVFAjyqy+DMR7qktGgrqdU2r8tntAorJMlJst3DW1uHEhwULxjzYAmSM6TV3E8S2nCVaK/7hVERfhT/dd8cCVo//rtWQ1M30syUFP/1kgzRMWtPeJJZFOVev57ed4zVFk3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PB8BYpcdslViKF79XJ2YzlN1Vk5ClgDRth1iFgE5pWU=;
 b=xdlVB9eTuqi61x+++tbv8vxZa8ASCflBavD26O3+0des7BfLPtx2ulNz1DjY/6B8Z2fIRPqReDNF4JyxhEeG4qzWn9BueHWbcYNtGpoQJ17sH3TaEyz8c7eU8lCOwxCgmkGS0rkQ5aLFfrG/6rj7DPBmexm40u4Yp3NzbfR2zZdG9q4nqe7tYKT9XtBc6b2sNtlgqmW2rc9JTA1UJq5ryWIZFSGcyFDApfwP0p4JVKgVPxUu3/NdEFXsqrHk0xZKPcI5GiXiUzzVKxQGQ5x91gOMVdYNUPhjFfaRfrs4p1Qp28h0bo39KzN4zBTCpqArFnNoK6X9TRWB7f5ZAITCDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PB8BYpcdslViKF79XJ2YzlN1Vk5ClgDRth1iFgE5pWU=;
 b=IvzcaPFxq02bWI7yQr7UPKrlyeD+h928F5Z3Y/t8nQ1RzcpVyQBAGxOgFG95qmStrJRMpvtvghZ8PNzluHOVU2KbbKqJm/O8TG+HZ97KC9JlTZ7j6V/REgLEIxiShB7JvBxBbE9ErjHWt90lh0PBzxk8jfOcLv5Bbx1lyX/wP6k=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DM3PR10MB7948.namprd10.prod.outlook.com (2603:10b6:8:1af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Tue, 23 Jul
 2024 17:15:41 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 17:15:41 +0000
Date: Tue, 23 Jul 2024 18:15:36 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Shuah Khan <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Subject: Re: [PATCH v3 4/7] mm: move internal core VMA manipulation functions
 to own file
Message-ID: <caf36eb7-f737-49b6-aa3a-f9196f6a17f6@lucifer.local>
References: <36667fcc4fcf9e6341239a4eb0e15f6143cdc5c2.1721648367.git.lorenzo.stoakes@oracle.com>
 <20240723165825.196416-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240723165825.196416-1-sj@kernel.org>
X-ClientProxiedBy: LO3P265CA0024.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::19) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DM3PR10MB7948:EE_
X-MS-Office365-Filtering-Correlation-Id: df4235ad-c34f-4584-9dfe-08dcab3b1489
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGVReXJnTUtRT0QyL2RxZ2tmL1d0NVVjNURMd2VMYmxRbkRaRldhMmtVOExK?=
 =?utf-8?B?TGN2eUlUcnhIdzI0U1pDWlV0WXJ3Z3Q5SFZENHlsZ3IzSWVRajRPUERJUTRu?=
 =?utf-8?B?QmpnbGtxY3B0aFUyMnhWVVRTWTIyVDM5NFA3aFcxR0k5L3dwU1NRMDc0Wm5n?=
 =?utf-8?B?eWlORXdmVGhBVVJTd0I5bnUwUlV3TGRFRmxJV1ZsT2VGOGhWRVVtMHp5Y1B4?=
 =?utf-8?B?MEdwYmlkNlZ0SDdoUEVwV0h0UXFoLzdBYkFqUWR6bHM5ZWZHYmU1U0dXeWl2?=
 =?utf-8?B?T0Jua3RnV2JobFJUNGRGNE0zMlFVZXV4TTRualBsMWthbmN4eWs4ZVRtR1Qw?=
 =?utf-8?B?Q1REb1RHUWZobXk2cS9LRHJCYjNhNVhXNEUva011Ni84a2x0ak9neWRyQitS?=
 =?utf-8?B?M3FKbWN2djFJd2JJbVd2S0FkZ2pLaE5RbFV4Y0VLQ3p5YksyVEJsZWRQNzZj?=
 =?utf-8?B?MHBwUlB3dHF1Mk5MTmdRM0RGanBCdFZsd0d0bkkxK3o0YTg0MU1WaCtDRitK?=
 =?utf-8?B?OGo0dGJyUDN0VWVPV2V1WEU4L2NLaFdNbXNCeFVscXNPcDRzaVZMTTNyc2J1?=
 =?utf-8?B?enZWS2RIaFhucmpaQUVXN1p5WHhrb2k5NlJVYUxpZDRTcUJhNzZNZ0s4UVVh?=
 =?utf-8?B?SXBGeVpiSFdvL0Z6UkFrMG5ZOWxMT2dNdkpCLzI4dnFmdGlvcVNEODViUUpE?=
 =?utf-8?B?b3FZZmt0NGozaHR0Um5YWURnM0ZwWHRkdFdoNW9pbmlkYXdYR01RVHdKUGpK?=
 =?utf-8?B?dzBteGN2UEtJNFRvL1cwakxmVFBMZFZ0T2tFMDRvM0NjcGhLYXM4NkI4eXV3?=
 =?utf-8?B?NmljaW9xU21QM3NGaUF3SDVIWC9XTXQ0bDMwbU16WVk3dGNEL2VwR3NaWG5R?=
 =?utf-8?B?UVhHY1gzWHVRcUlneEpFa1VWWFUyY0paTHJrb3lMU2o5OGlVeFpQQkhjbkk4?=
 =?utf-8?B?eFZEbVdZc29TZURMOHlkL0lGQ2ZUbTNsTGNyMXlHTnJURzZrUjJLZUpIUWZZ?=
 =?utf-8?B?T1BqaU1oUFFoNStkRGlreUpJR0Nid0lUNWlETCszUlh4dENjR3BjdmxaalJx?=
 =?utf-8?B?SW5oTDB5aUtaNmZFTFZQVFJJbGdPTVdWVjI3NlB6NVNldFo4UTNTRktQY3FG?=
 =?utf-8?B?UExnb1FMWlo5cHJ6U1lNOVpJUjhZalhaWjlScFJRQ05NL2krUVFHWmd6RzUw?=
 =?utf-8?B?SzFXRXpVaDUySnpveDl0RnZnaUsvOWY4OTRCSExjcytpc0JxYXdYWXU2d2t1?=
 =?utf-8?B?R2VzWlVVNTk0dVpZV0ZPc1JnVWU4VzBWSkFOd1c4M01vU1luendDb3VrZ2xr?=
 =?utf-8?B?amJSYWlhMWdMaCtZYXNUcnJoWjk5ZkJRaVpPNVBkOTlZS2gyaUJVbWZpM2ds?=
 =?utf-8?B?TTY1ZlQ5Ly9tb3JzK1Rva0dDdXZIOGpacmt6KzF4cjRoOUsxdStHdjVqSlVZ?=
 =?utf-8?B?SUNuazNIWEkwTTd5VmhBYWVuakdDYWZIVGcwSXlLdWdvdHVySFBSU1hlbXBu?=
 =?utf-8?B?eEVQOW1Zd2trMndqd2lPTm1KeXpoekhMNFQ5UWlkeGdPd2pFMHF3Y2txQzQx?=
 =?utf-8?B?bFhMbEVaNktUZVpwc3ZtQmI4NHMxUjNJTUU5amtHelFRbnl3djRxZWdRNG1K?=
 =?utf-8?B?WXU2ZDZRNkJlY2VTU3AvcDhjVGk1M2FnYVZRMzZTTHcvYXNoYmc4UUhEZmFn?=
 =?utf-8?B?RGRIQUlmVmRRK1JzVFdXL3N6WTYwUzFqS1ZNVzd2Nkd6NmhHQ2cxVDJxVTQx?=
 =?utf-8?B?R0E3MExiQU1YT0w5b3BLKzEyTERidmF2cUswOFB3ZnZIb04reXI0anVoOFp3?=
 =?utf-8?B?SWlZcTU1Z3krMEc0OUtRdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0tmWnFHalZvSlczRVVrSzFpVGg5VnVFN3pMNGVmcUZNUFFBbUcrY1E1d0ha?=
 =?utf-8?B?MmNjTmhFSE5yTTJXMzMzWlVlbHZDY05uVHMzSm82bUxxd1hnTW5veXlUcEVu?=
 =?utf-8?B?ZUdLN0NETUV2SWNGdEFMV1ZWOFE1Wm40NFRxWElvNWhEQUlEbTVkUEJoNTRV?=
 =?utf-8?B?ekI0dVF0NGdDaWMwNEZ5b0s0Qmd2K3BuOERDNHhaQlM1RitqRkIvc2xMMEcw?=
 =?utf-8?B?cmQrQlhjb0xFM3FPL2tFZnZKZ3QveEduYUtuMExrSjVhRE1rZGRiazhPTEU0?=
 =?utf-8?B?cjFnWXNlaWd5R2FDeE9UU1RZZFlocjFyTW1jbURNdDRFdkxyNm9wUGRwSmU1?=
 =?utf-8?B?R0loOXZKWHVHOVJMVG5CME5xTFpWUEdhMHV3STFuNURHSDlqTjNSMEh1ekd0?=
 =?utf-8?B?M2t3a012M0E1VGFmN3lPeGUwYlROb1hLTzFMU3RiZ09COHVLeFZNVU5Vald4?=
 =?utf-8?B?N1JYVndtWVBoZUduc2JRWlhwK0F4OGhMMlNJcGRYYm9rZ3lVZ3F2VTlibXQx?=
 =?utf-8?B?aDdjZ0FGeGJyaDdUcitwVGUrUm5YNDdRSmNCSDJIZ2hvVUNYS2ZQMC83cnhx?=
 =?utf-8?B?YUlFV01Fakt1c3F5V3F0SkRkQWo3ajJLSjBBT3VaVlJKM2F2N29jUzl1d1h1?=
 =?utf-8?B?c3hKNVBvR3pzR3hzRXBCMjdqNUxMbndsUDNhUWxpNzVYdjg1ckpoTXVGTHA1?=
 =?utf-8?B?eTAwK21hL2U4clZSa3JTZjVOaElUUXJ4VmRFTFhDK2ZHZnFvN3pFb3pyeE8r?=
 =?utf-8?B?Q3BwbnovcWJvWHJVYzRXUzdKY2Vta2RQR1ZuQkorK21TUWlpV3hkMXdZSU9K?=
 =?utf-8?B?bTVGb0l5d3JxUzFVOExhZDBJNy9CY0h3Y1pHQzc4ZHJCZ01Qc2ltQUV5bWFR?=
 =?utf-8?B?dHpQQkZ5bWF6RG5sWGRCN1lpWDJVUHl4dWdhZUtLWjRBZDN4aFFYQjQvNWM5?=
 =?utf-8?B?NSsySWRYN1AveVNpNmJFdHJwZWVkaHB2QUl2VlV0OFY5dGs2UXRXdGt1YVFZ?=
 =?utf-8?B?OTZ3NGIrckpWc0Y0YTFaNU85eExFalBSYWJiSWdHK1YvNWZuSHVhQVRtT3lk?=
 =?utf-8?B?M0svNEUzakZ1TFR3Q3cvcGJ2bXQvd0d1NDJiYnc3dmVoMHJKWHhNK1JZalho?=
 =?utf-8?B?dHlCMmtNUWJKZnRONG1CR3pVTG81SEpXdE9nZk9LVVpaa0pDZERaeVJkSEF3?=
 =?utf-8?B?MUN3Qi9HL2tpUWMybE9zbGhqRWN2ZEs5dTBaVllrWjZJWG14TVFlTWhObVhN?=
 =?utf-8?B?T083bEtITllXNUkvR3JrY0ZKVE45T2tuaTd2NjlpSnhvMHUrTVFudkNsYXli?=
 =?utf-8?B?S1RGTVFHWlNrdXZWS0diL20zN0tzaFpkbjdNRm0ydXBVQmI0OGUrblR0dDE4?=
 =?utf-8?B?eUY0ODJXdjJRKzNDK2Y2QTF4RE11WTBTZENQUjN3NU1TUmtHRzVYVC9IaG5E?=
 =?utf-8?B?WnJ0OGs0UkFrUGMyVUp6U2xJdTFrcFhtTnJRQzlnNXFjVThPWXBrZUtGOTBH?=
 =?utf-8?B?YWYwTk5sWm5kempJTlowMVYxQjd3U0lXOUdmaWJzMXV5cVlMVDJXVUdGVkZn?=
 =?utf-8?B?S00xVTB5VnR6Y3Q0NHJPNlo5N2hkTHZ4OG0vWW5EYVRiemRBNmFxSFFWZ2xB?=
 =?utf-8?B?bWoxSHJWdUNua2p1SW8xdjQxdHdVMTI3NGdJVnpFcjNPdTlacjdwbDRxYi9O?=
 =?utf-8?B?RFg4eFp5RWhOUmlYOEorMjdwNG42aWdZeXR6MzJrZDBWZ2g2d2w0bFhSN0ZK?=
 =?utf-8?B?SUxEdWdwdEp1NDZFRCt4bURpUWhsUGFpWk9vUHgwcXo5ejFGL0wrREh4Y1pn?=
 =?utf-8?B?aVZ6RlBycFErUHcrVHhHdDBsOVNkNTlrV1dVeVZGMnZpQThvR0RiTUw1Ritu?=
 =?utf-8?B?TFZhU0kwS1A1dG02LzNadWwvRzFHRVA4U0F1WDJZMktGOXpsSlhyTXR3cjJN?=
 =?utf-8?B?anI5WG1uaDQzKzk5SW95d3dMQnl0QVNrRldGWWEvRU8rOFZTTHJQaTRkc2ZE?=
 =?utf-8?B?K0Z4U21kcTl0RnlLcDk4YzdaZE9hV3NhZ05mR25vWFB2aXp6ZCt0amp5dDJp?=
 =?utf-8?B?UXJkY2RxbnI5VjRaOWw0ZmNPdU5IZEJ5ZWJwVXFBME9HNEtNVzhpV0prMTZ5?=
 =?utf-8?B?RXJrcWdWVjM2Wk9nVGZWVzJSQ1VhU2NMcks2NUdPRUVadkFXS3lWZHBlQ0ZZ?=
 =?utf-8?B?MGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xkHpGjk4fGG6fYuKDz879FVJMOwSczD9br2RrwVZ6tPgBHmYaRDUiwr0qS6YAAb13IMyz4SjUEGaDX9wOK6E0Dfh7emidAYSHiyyb8tsmhc5fyp9uHN5+df+P+gyspoo3Ew6hWEX34Ryc+7UvU0uz59pEbnFEuRPaOVpm4K/eLa+pBnled8AaCD7w5a4a3t2YaiIrYiEjQ3jhhWWL8nqHiXrei2Tu0hokd3vQizJCeUv9Nd2DKK2Mx7p1aaCET0GQV+POX04px8B48yh3ECGa53mjFSBVGkAk33eHSK+a79gHcvKRA0yH1gvOM3JwhbiHamWxWTISj11UP5VjETFVX0EJ9C6lUXQbxCHKCq1LT+GOBN4xMH37fSVTQSa8gWvgGbSUidedf4Emk6mfpLPqmeAGGqpPfN/rcL4wEQqIfqgnI0OHq7djc8zZ3xRXeikF5JGl7jUDkG0R4POqG9p7jbKNuxaLGJLxwX/e+KiwqEr+966IyRssbV2cHpng0jdwkhVGiSU4kMxJi41qwqkXJC+YH+9Ewmhvmw+2Wph1aMt1aVSTlYg8e8H94DnQfQ9P0GtA1SIKvRfoE9UN8K+exbO1gOUJO10fcqWMjdP4NY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df4235ad-c34f-4584-9dfe-08dcab3b1489
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 17:15:41.6603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bCQGJcLp+rzcqzCh/k9SpWjuYjqXZkEL9Cv8Z4qOh+02jsWxpUee1VSvXXst9MoksDwNMdnjARgwDuFq2IY8hqcTHl4bxAco+I88tR3UfwE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7948
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-23_07,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407230118
X-Proofpoint-GUID: sQRDH8D7xpcNekWqk5-ye0QxRMtXXj6z
X-Proofpoint-ORIG-GUID: sQRDH8D7xpcNekWqk5-ye0QxRMtXXj6z

On Tue, Jul 23, 2024 at 09:58:25AM GMT, SeongJae Park wrote:
> Hi Lorenzo,
>
> On Mon, 22 Jul 2024 12:50:22 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > This patch introduces vma.c and moves internal core VMA manipulation
> > functions to this file from mmap.c.
> >
> > This allows us to isolate VMA functionality in a single place such that we
> > can create userspace testing code that invokes this functionality in an
> > environment where we can implement simple unit tests of core functionality.
> >
> > This patch ensures that core VMA functionality is explicitly marked as such
> > by its presence in mm/vma.h.
> >
> > It also places the header includes required by vma.c in vma_internal.h,
> > which is simply imported by vma.c. This makes the VMA functionality
> > testable, as userland testing code can simply stub out functionality
> > as required.
> >
> > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> > Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  include/linux/mm.h |   35 -
> >  mm/Makefile        |    2 +-
> >  mm/internal.h      |  236 +-----
> >  mm/mmap.c          | 1980 +++-----------------------------------------
> >  mm/mmu_notifier.c  |    2 +
> >  mm/vma.c           | 1766 +++++++++++++++++++++++++++++++++++++++
> >  mm/vma.h           |  364 ++++++++
> >  mm/vma_internal.h  |   52 ++
> >  8 files changed, 2294 insertions(+), 2143 deletions(-)
> >  create mode 100644 mm/vma.c
> >  create mode 100644 mm/vma.h
> >  create mode 100644 mm/vma_internal.h
> >
> [...]
> > diff --git a/mm/vma_internal.h b/mm/vma_internal.h
> > new file mode 100644
> > index 000000000000..e13e5950df78
> > --- /dev/null
> > +++ b/mm/vma_internal.h
> > @@ -0,0 +1,52 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +/*
> > + * vma_internal.h
> > + *
> > + * Headers required by vma.c, which can be substituted accordingly when testing
> > + * VMA functionality.
> > + */
> > +
> > +#ifndef __MM_VMA_INTERNAL_H
> > +#define __MM_VMA_INTERNAL_H
> > +
> [...]
> > +#include <asm/current.h>
> > +#include <asm/page_types.h>
> > +#include <asm/pgtable_types.h>
>
> I found the latest mm-unstable fails build for arm64 and kunit (tenically
> speaking, UM) with errors including below.  And 'git bisect' points this patch.
>
> From arm64 build:
>       CC      mm/vma.o
>     In file included from /mm/vma.c:7:
>     /mm/vma_internal.h:46:10: fatal error: asm/page_types.h: No such file or directory
>        46 | #include <asm/page_types.h>
>           |          ^~~~~~~~~~~~~~~~~~
>     compilation terminated.
>
> From kunit build:
>
>     $ ./tools/testing/kunit/kunit.py build
>     [...]
>     $ make ARCH=um O=.kunit --jobs=36
>     ERROR:root:../lib/iomap.c:156:5: warning: no previous prototype for ‘ioread64_lo_hi’ [-Wmissing-prototypes]
>       156 | u64 ioread64_lo_hi(const void __iomem *addr)
>           |     ^~~~~~~~~~~~~~
>     ../lib/iomap.c:163:5: warning: no previous prototype for ‘ioread64_hi_lo’ [-Wmissing-prototypes]
>       163 | u64 ioread64_hi_lo(const void __iomem *addr)
>           |     ^~~~~~~~~~~~~~
>     ../lib/iomap.c:170:5: warning: no previous prototype for ‘ioread64be_lo_hi’ [-Wmissing-prototypes]
>       170 | u64 ioread64be_lo_hi(const void __iomem *addr)
>           |     ^~~~~~~~~~~~~~~~
>     ../lib/iomap.c:178:5: warning: no previous prototype for ‘ioread64be_hi_lo’ [-Wmissing-prototypes]
>       178 | u64 ioread64be_hi_lo(const void __iomem *addr)
>           |     ^~~~~~~~~~~~~~~~
>     ../lib/iomap.c:264:6: warning: no previous prototype for ‘iowrite64_lo_hi’ [-Wmissing-prototypes]
>       264 | void iowrite64_lo_hi(u64 val, void __iomem *addr)
>           |      ^~~~~~~~~~~~~~~
>     ../lib/iomap.c:272:6: warning: no previous prototype for ‘iowrite64_hi_lo’ [-Wmissing-prototypes]
>       272 | void iowrite64_hi_lo(u64 val, void __iomem *addr)
>           |      ^~~~~~~~~~~~~~~
>     ../lib/iomap.c:280:6: warning: no previous prototype for ‘iowrite64be_lo_hi’ [-Wmissing-prototypes]
>       280 | void iowrite64be_lo_hi(u64 val, void __iomem *addr)
>           |      ^~~~~~~~~~~~~~~~~
>     ../lib/iomap.c:288:6: warning: no previous prototype for ‘iowrite64be_hi_lo’ [-Wmissing-prototypes]
>       288 | void iowrite64be_hi_lo(u64 val, void __iomem *addr)
>           |      ^~~~~~~~~~~~~~~~~
>     In file included from ../mm/vma_internal.h:46,
>                      from ../mm/vma.c:7:
>
> Maybe the above two #include need to be removed or protected for some configs?
> I confirmed simply removing the two lines as below makes at least kunit, arm64,
> and my x86_64 builds happy, but would like to hear your thoughts.

Thanks, good spot!

Yeah they can just be dropped, this is pedantry from wanting to absolutely
nail down the sources of declarations, something I pared down in the final
release, but obviously these were unfortunately arch-specific.

You're right that they're just not needed.

I will send a -fix patch in a second.

>
> """
> diff --git a/mm/vma_internal.h b/mm/vma_internal.h
> index e13e5950df78..14c24d5cb582 100644
> --- a/mm/vma_internal.h
> +++ b/mm/vma_internal.h
> @@ -43,8 +43,6 @@
>  #include <linux/userfaultfd_k.h>
>
>  #include <asm/current.h>
> -#include <asm/page_types.h>
> -#include <asm/pgtable_types.h>
>  #include <asm/tlb.h>
>
>  #include "internal.h"
> """
>
>
> Thanks,
> SJ
>
> [...]


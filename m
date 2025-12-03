Return-Path: <linux-fsdevel+bounces-70536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD7BC9DC12
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 05:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2713634AD58
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 04:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5529627280A;
	Wed,  3 Dec 2025 04:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hhqNp6dA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010032.outbound.protection.outlook.com [52.101.56.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A6A239085;
	Wed,  3 Dec 2025 04:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764736615; cv=fail; b=PNlN9bsGoIkfEEDif4iHCp6YHU2nyff8adJDOWJ1N7YbDTs53rYhdvu3DMEzMcgZ4Tz+85COvSQuNKpsoLbuI9JmW7VTUu7w+kjK7nwZu6M6TFUGfYXEzpOhu4NeNK5vj/AEB8eEWOAI1mXIEs5V14fPdz2TlsWuRlRa1f46d74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764736615; c=relaxed/simple;
	bh=uXpF7qzfOjwgtxGZRxCEUwM5Ko2tgM4wuC2+qOiHfcE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fP+kvwMviqZ5EsM+eYuYCTjCGshc3f0bWWFfUPkzCI4HqBY7UgkaDLa89yXNoxe0F53A3xWumLQyx44+ZJIXBqJbd/HwxNZvPXR66yKCJ9VsjgESLvoNNAqMche7KNKQ7bwh2d/gp1Zy2wanwfRgIL8I4DXCTeu0ZTS+F3NXRgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hhqNp6dA; arc=fail smtp.client-ip=52.101.56.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PbHLVSf42gSg5RFFjXq6zZkzCp9TdGPDunR/YgJt3JriFv+EvxoN+qKkQYlDQVlP7B1EdQeBr44Y8J8QM/WnCURpwiOYyBb6QqfR6kboYbjBf7ONn0coRGXmDmRlDeC60A/oIjrBhrz/1rjjfy88I61biCb9extSE7IBTdTQglGx2QpVb7MVX+YGPfDlfQyaCWDNBSdnJo5fCrykglJowZeWYfXzvWpFCvLGRRUqdKy1mkvzDfiX7M4Zlec0t0L6iG1TpnUx7zeqZkxPkHNwlFKR7jw+QgWNgLPzqbs8jAFQTlcp7lfSVE6QVjj/evtqGRQajuu88vQD+rrIBBpM6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iPe/CKPSTmlRpTwa3ojTD92XfSOJTe3V2OXjNvCoC2w=;
 b=TaPnvSpUGRDYMDyr4XM35jRgHU3rAIg/27Lkl6lDIVJVkAv0tl246L86UNATwS3UeZWJ8PpwjOGG9quWsq+QdS7uAsJ2l5SS+zoACasMptjSGJ2qKXYUU7imgnkw+kndRqkrV39BGP4fgLV9JjuVC8EUbnzkiDbKG0fFbhqcu9zUuuaU2Szoove/pIKH1Xwwcp+laimiE5M9B5G0CMEW1ccqA+7cWQgVK8AYZWCx2/EShp6ET+qOdllD+zKWLalmgetr69dyRixM0i3vOp5x26DfkfikSD7EcDNLLuxg+jvLgc4OBSbffNLMTf3LTpwPwb1yt5gl7/xqqEuleITQ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPe/CKPSTmlRpTwa3ojTD92XfSOJTe3V2OXjNvCoC2w=;
 b=hhqNp6dAfcqsihxHm4scpRAZqPd2K44LvgwZBTDH8byCnkXm0c407sSLIQMoiXr1MBRFvnTtIglTi3rscqRONysexOkSM22THEb2KznU4ak6iIuQEtSAWojQw4aGRXOw7T2YGarfUZMDJW+eE/GH3x81wf0H1t7CCN/hQmQ/UNGfjDbHYrpYA/0HsfEtqoMGOwCLm56WcCRj6pOomDwkP6wTIENxdHhFiz34iUhnly0vCNDeKnteiP2bDm30euv7nL85+NPyJ6QfajCrGGgLfHUGS80BbjojfISeNN+HrfeRF6N/DBpXBGDPixjP37QDrSaVAf1jzHlcpUDIUJXfrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by SJ5PPFF62310189.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 04:36:49 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%7]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 04:36:49 +0000
Message-ID: <36edd166-7e11-4d43-9839-42467d4399d1@nvidia.com>
Date: Wed, 3 Dec 2025 15:36:33 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC LPC2026 PATCH v2 00/11] Specific Purpose Memory NUMA Nodes
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, kernel-team@meta.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, longman@redhat.com, akpm@linux-foundation.org,
 david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 osalvador@suse.de, ziy@nvidia.com, matthew.brost@intel.com,
 joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
 ying.huang@linux.alibaba.com, apopple@nvidia.com, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, kees@kernel.org, muchun.song@linux.dev,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, rientjes@google.com,
 jackmanb@google.com, cl@gentwo.org, harry.yoo@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 zhengqi.arch@bytedance.com, yosry.ahmed@linux.dev, nphamcs@gmail.com,
 chengming.zhou@linux.dev, fabio.m.de.francesco@linux.intel.com,
 rrichter@amd.com, ming.li@zohomail.com, usamaarif642@gmail.com,
 brauner@kernel.org, oleg@redhat.com, namcao@linutronix.de,
 escape@linux.alibaba.com, dongjoo.seo1@samsung.com
References: <20251112192936.2574429-1-gourry@gourry.net>
 <48078454-f441-4699-9c50-db93783f00fd@nvidia.com>
 <aSa6Wik2lZiULBsg@gourry-fedora-PF4VCD3F>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <aSa6Wik2lZiULBsg@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::23) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|SJ5PPFF62310189:EE_
X-MS-Office365-Filtering-Correlation-Id: 53d25d62-7b91-4dc8-c00e-08de322592b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cm93R2VSSkNoRlcrbUZ4aFhqYmV4VXRuWS9JaU5FdnVxUnE1bDVxNDg3TXFu?=
 =?utf-8?B?NWg0aGZxRW1xdGxQL3JIblBVckZDQ1ZLSHcxSks0QnhleFJTTWJrS21VNHZN?=
 =?utf-8?B?eGNRclZIdVhhVlpxU2JrMkpQQ000WEY2R29RL0s5dVByNmJMek5BaWpvanJu?=
 =?utf-8?B?TVFqSFluMUlOakVuSUF1cUUxeW5GaFMxM1gwV0czbkc4Y1cvVG5uMFMwUXU3?=
 =?utf-8?B?dTBLYTlJZnI2SEJIeENCNS8yVWtxeTNxSVJCaitDRkxtM1JUVUI1cks1Snla?=
 =?utf-8?B?UHArcExQcVEzOWlnUmdHOXhwSmVEUUtITVpPMDhBUnVvU2pNT2cxSU00dG9l?=
 =?utf-8?B?cmR0NHpQS3YvdW5RbmhtQmcyc1k3WnFwL1ZCNk5CWERUaWIrUW9JZXpEZEx1?=
 =?utf-8?B?VzBEblZ2Q0xFYXBYZmNFYlE2cHluU2JwWWJUS29CU0UvSzFjUEVYa0VCaTQ2?=
 =?utf-8?B?NU40VmRvVjdqbEd3M0xONk9QOEEyMmFhcVBteVpnQjlHTWJHdmVGYUZyY3VX?=
 =?utf-8?B?VUFXN2poRGorbTRGM3k3dnhQRjhRNjg5VVU4Y1pUTWZocnc0S04xbXBheitw?=
 =?utf-8?B?NnRXVUw4STlnUk9kTzV2R2pjYzQyK2tERjg3V1lLSmhSQjRESnJ4MHkwNVND?=
 =?utf-8?B?WkFVK3FXVUhrdGUzNUVaTUxWQ1BSQSt3L1dwUzZubFhwVmFoRFVmamRDK0Rj?=
 =?utf-8?B?eUEwODhrWExTbmg4RTdORnF0RndNZmZkWnlVQlFoTEtscHN3QzlwdnBDcWZG?=
 =?utf-8?B?UFBOK0oxeXIvWHk1M0N2NG5CcndqZlZDem9TZDNobG1NdkNVT1JXZjZXWW9E?=
 =?utf-8?B?eGEzNXY0Yk1kQzNhREh3bGNrbFRmK0tYQWtSVkVmTTZGenZzYmtXSXFLbjhn?=
 =?utf-8?B?cHBKc3dwSDh5d09sZFBLUmd4UVN2TitvcFN0bjZSK1NxZ0g1UmN5UGVNcEE0?=
 =?utf-8?B?cWtYMW9MSk51Z2lHM1E3MUk0OXVPT2RiNWFlWlVmRU9kNDUwZFRCRUl1N0t6?=
 =?utf-8?B?WHllYjNiZldRemIvbTB5YU5DeWNVQTNKQjBSWFZTTGo1ck85TG1Lb2lTdE1t?=
 =?utf-8?B?WEJjL2gwSXVPU3R3WlcxQkZPZWNoL0ZucjdMT0F0UDA1V2t0MG5LWjM4NVBD?=
 =?utf-8?B?ZVl6b3FQd3o0T2hJTXFxWlMvVzMxVjBHbU1sMEZMNWVFQ29ROERCdzlETldP?=
 =?utf-8?B?RjdaYkxlbDdjaEh6MXZ5WVREMHFtcFNkRHZqYXlFclEwbnBUOVF5THlpODlL?=
 =?utf-8?B?VnUxQlprMVI0NGlSN0ZiTEdFQ3ZtdmxBN0xmYjBocjFCSmtUeUNVNlJBck9w?=
 =?utf-8?B?YmhTTzN2ZlZUU2M2WlAzSis1dllMRmh6bTB1NE1jcTNlVjVhQXRjQk13MGIw?=
 =?utf-8?B?aDNnWFdKNUQ5YVFiMHFHU3JGbFRJWEFKTTQ2aUQrV3BwVkVZTjBVSDN0SHZr?=
 =?utf-8?B?MzEvcXl6aGFGamQ4OVZVbk9VaVJBK3pqczBLd0k5U2xsT2ZBdzBqT1JkMTJT?=
 =?utf-8?B?RmpTWUl5cGFNZzVERjFVRDhKSUJZUS9oN2l1cmlZSDFTSUVnQ1RMYkEwZnpL?=
 =?utf-8?B?bGxlTmQyYkJRdCtIaGtwdGd2aXpKS0lVY0pnTmZLeWNvSDZHVDE5TjFxdEFJ?=
 =?utf-8?B?N2hNTkxlaVkrLzdKRk1SWjhQSUhrTXMyQndXeTdpNWpIY3V5Y0pPVm5WMXBO?=
 =?utf-8?B?SXhQdUVFUnAyNVFEQlJjVTRSVGU3eDNsWWx6NnlMc0xsdGlIU3VZRnJvUklE?=
 =?utf-8?B?cFZ4enE4bk81L1Y4VGZsT0RPd015WU05OHU0UlJORHhkU012YkkzSnVZOXBj?=
 =?utf-8?B?Nkt4MVdRajloZTFwOE5NeDNiNXk4a0xwV1RJSlN5d3VxYmhWVEtFQytONzAy?=
 =?utf-8?B?TVo2SGo4YUdQWU14OGMxKzFPLzkwWDZIdWxTa1hiMGxnK3lrV1c2d0VWd0w4?=
 =?utf-8?Q?Z4DCRn1XRDZdmj/PcXo7qsPcmHxry7NQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnBwQkp6czhoeVpBTlBjQmU5aHUrWklwSitMb0ZucnRTNXdzeTBhbUw0RG9C?=
 =?utf-8?B?aHMzdWpkM2d0dDZtYVFYb21URGEvYnROMG1wTURkeFZoU2dObFkvL2JKZE83?=
 =?utf-8?B?YVJ5eVJ0Y2RzOEtJOU9UV0tqWEovS1NicVNTZW1naC85UUdTVm4xbkhMZnc2?=
 =?utf-8?B?NGRkSnZmc09OT0lRdkVSckxDMEdqVHdieVhzU21ka3hmWVdJa2l0Q0tLdnpw?=
 =?utf-8?B?RzFUeVlDNTZNMTRQRDMyMktMOE5lUHVqY2RucHZHcDc3bnlUOWFHOXQ3YVhG?=
 =?utf-8?B?dU9KSlNNOHFCeHFDajdzTGM0bkFBelQ5bk5ITGhKdm84RVYvYmU1bU44eG1q?=
 =?utf-8?B?NUIvQytxREpCaUR4NGdUN3BDbGJUa2RUK1BYalVyTDYzWE5sWUhYS1ZVTXZv?=
 =?utf-8?B?YVlpVUdMbmpJU2JHNit1OVJGcStwUFd5ZjQ4a1NXS25ld3d0UkwrSmhKRi8v?=
 =?utf-8?B?UmZvWXhzR2RpTjVIY041YjJ2MllIME1OekQwYUQ5bXdTNkF4b2I4RmhpMnBq?=
 =?utf-8?B?RWU1OHZqcGJBbTJRRDR2VVpMZzdqTVNOUVBNZEhNOGhCaWNjVTNUQVJjVkxV?=
 =?utf-8?B?Vk9keituTE9rZ0JoM09MV3krb0NKanB0VnY0RUwyVHFjUThTbTh6RXlXalE5?=
 =?utf-8?B?NkhVSCtlb3RqVTQwWXFXRGs3Qk5MQmxPL2NNSldZcmNzRmxhRWJZb2wzeVM0?=
 =?utf-8?B?Z2E4Z0pta1VLNWw2dGFLanJXUWZHZHl1dE9mUjNJQTVZb3dCY21VUGd5TS9j?=
 =?utf-8?B?bzlBL2NoRkNPemFRVXREY1lrcEZjOHNDdlpKUTNkT0Vsemh3bFg4T2tPclhk?=
 =?utf-8?B?R0pGY0VPSEFZblR5NlBBSWJzbU1xaGFKdEh5RGE1MFZERnBnQ0FCWWF5VHBv?=
 =?utf-8?B?TGF5M0k0SUhXQlJ4emllZXVlZ0VtNDJxYUhMa1dnQVJqT0R0QjBkRHdmM0lU?=
 =?utf-8?B?NmRjaDJhd0ZrdE91MHZITzhrWCtOTWZzWHkxM3ZFN0k5UldqMFo5Mnd4ZGFV?=
 =?utf-8?B?V05tTDNsUG5lNnFOcG5RQytnZFV0WGljYThCNjFZcXBBRTdzWFM5UFl2UGRw?=
 =?utf-8?B?RWcvWENmRlh2V2tVSFVUZWl1cGM0WlcxbFA4c2Fzd0tmLzJod2JPVWpZOHkz?=
 =?utf-8?B?UlgxSjZyNEJkU1phakI3cGMzZTdZdklYMm9ueEhvNVJGNXRIQ0ZrdVpqN2xy?=
 =?utf-8?B?OWc5Tm9hOUdtMldGa0NUTlBIVXJGTFFuZEFXUjIwSGlTcVRDSGFnNk9LdkhI?=
 =?utf-8?B?UHVsTXYxYW1RWHZ6Wk1QRklMTjVHUmYwdXQ0SXA5Um1ISDZlUnd1dEZ1QzNM?=
 =?utf-8?B?N1V5aTR0VXZNZ2NCYXQrMStuSVlMMjFRYllvTGlUa3QrQTdsRHFLYUk3bTU2?=
 =?utf-8?B?Z084b2RuYzM3eUgzTm1DbVZaQ2w2ZytFdnBIMDM5a2RXVCs2S2Q0VFFWZkR6?=
 =?utf-8?B?ZXdmSXRzaUdjdTJ0b25hdVFVcm1IRzAwY0ozS2tFazBNaEVMREJMMVp1N1NW?=
 =?utf-8?B?d0NjYm9lZFNUbUZ2STN2eGZzVCtzMjZQb1ZqdUM0ay9KNXF5c1ZjZXdpYVVB?=
 =?utf-8?B?SWs5QUZYRHBEMnBrZkV0TngrM25zaGM1Z2ZsRTdZaThqdVhGemIrQ3MvYzV4?=
 =?utf-8?B?V3MyQnh6WXpJV05SMmFaTHBMaE94Snk3VUJNbVFMWnY0Vi90TVpJWCtSSkNw?=
 =?utf-8?B?ZHNheDdLNEhjamFYL2p3Y2NmVExzWDhYa3h1YVVjZ1NIMXAwalhTcHgyY1Bo?=
 =?utf-8?B?SWVrV0ZTWUExUUx1WUdFRndQRUwvM1MzRFRCc3ZVaUZjYVBmWnE3VXFYbTZh?=
 =?utf-8?B?cnRvbGNWcjFlZkowdUFmY21taUFja0VSbzdaTVJXbVM5bWRHV2VIbFljUGg5?=
 =?utf-8?B?TExhVy84V0Q5aHQ0UnU5UmFXZkhGaFoxbEJQOXV4UnBFVWs3a1FSZllaNnVJ?=
 =?utf-8?B?bXlBRkh2RFIwLzVoZGMvU2F0eFBFSTlOVnlrNTlweEU0cE9scWloTkhnRkMv?=
 =?utf-8?B?TjdDM0t2QTZnUVM5TG8zSjdudUl6TjhwbTQ1dmEvVFFZanlyOEpBdFRPUXBO?=
 =?utf-8?B?QjNvNjJVeUxIdGlueHNUZzU3QVBTemxtWk5PMWFaR1lBcmlPK1lIRlhDWVJj?=
 =?utf-8?B?SGtlMktXd1ZuVGs1SkRCMjZyUGxWd0RxWmdybVFvOTF4ZE1CTkNxTVdseEFt?=
 =?utf-8?Q?78qIB0hgHUJlfLTF1mV5wZCycQ5yr5W2UeOs0W7MMqNt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d25d62-7b91-4dc8-c00e-08de322592b2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 04:36:49.1566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P8tu/SXc+jOuDwMFnP8avVTPmexDzWPTlmkRwWz1E4fDVMsPPQb9pDDWz5se8UWpKPq5bR83maCJlU105G2BMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFF62310189

On 11/26/25 19:29, Gregory Price wrote:
> On Wed, Nov 26, 2025 at 02:23:23PM +1100, Balbir Singh wrote:
>> On 11/13/25 06:29, Gregory Price wrote:
>>> This is a code RFC for discussion related to
>>>
>>> "Mempolicy is dead, long live memory policy!"
>>> https://lpc.events/event/19/contributions/2143/
>>>
>>
>> :)
>>
>> I am trying to read through your series, but in the past I tried
>> https://lwn.net/Articles/720380/
>>
> 
> This is very interesting, I gave the whole RFC a read and it seems you
> were working from the same conclusion ~8 years ago - that NUMA just
> plainly "Feels like the correct abstraction".
> 
> First, thank you, the read-through here filled in some holes regarding
> HMM-CDM for me.  If you have developed any other recent opinions on the
> use of HMM-CDM vs NUMA-CDM, your experience is most welcome.
> 

Sorry for the delay in responding, I've not yet read through your series

> 
> Some observations:
> 
> 1) You implemented what amounts to N_SPM_NODES 
> 
>    - I find it funny we separately came to the same conclusion. I had
>      not seen your series while researching this, that should be an
>      instructive history lesson for readers.
> 
>    - N_SPM_NODES probably dictates some kind of input from ACPI table
>      extension, drivers input (like my MHP flag), or kernel configs
>      (build/init) to make sense.
> 
>    - I discussed in my note to David that this is probably the right
>      way to go about doing it. I think N_MEMORY can still be set, if
>      a new global-default-node policy is created.
> 

I still think N_MEMORY as a flag should mean something different from
N_SPM_NODE_MEMORY because their characteristics are different

>    - cpuset/global sysram_nodes masks in this set are that policy.
> 
> 
> 2) You bring up the concept of NUMA node attributes
> 
>    - I have privately discussed this concept with MM folks, but had
>      not come around to formalize this.  It seems a natural extension.
> 
>    - I wasn't sure whether such a thing would end up in memory-tiers.c
>      or somehow abstracted otherwise.  We definitely do not want node
>      attributes to imply infinite N_XXXXX masks.

I have to think about this some more

> 
> 
> 3) You attacked the problem from the zone iteration mechanism as the
>    primary allocation filter - while I used cpusets and basically
>    implemented a new in-kernel policy (sysram_nodes)
> 
>    - I chose not to take that route (omitting these nodes from N_MEMORY)
>      precisely because it would require making changes all over the
>      kernel for components that may want to use the memory which
>      leverage N_MEMORY for zone iteration.
> 
>    - Instead, I can see either per-component policies (reclaim->nodes)
>      or a global policy that covers all of those components (similar to
>      my sysram_nodes).  Drivers would then be responsible to register
>      their hotplugged memory nodes with those components accordingly.
> 

To me node zonelists provide the right abstraction of where to allocate from
and how to fallback as needed. I'll read your patches to figure out how your
approach is different. I wanted the isolation at allocation time

>    - My mechanism requires a GFP flag to punch a hole in the isolation,
>      while yours depends on the fact that page_alloc uses N_MEMORY if
>      nodemask is not provided.  I can see an argument for going that
>      route instead of the sysram_nodes policy, but I also understand
>      why removing them from N_MEMORY causes issues (how do you opt these
>      nodes into core services like kswapd and such).
> 
>      Interesting discussions to be had.


Yes, we should look at the pros and cons. To be honest, I'd wouldn't be 
opposed to having kswapd and reclaim look different for these nodes, it
would also mean that we'd need pagecache hooks if we want page cache on
these nodes. Everything else, including move_pages() should just work.

> 
> 
> 4)   Many commenters tried pushing mempolicy as the place to do this.
>      We both independently came to the conclusion that 
> 
>    - mempolicy is at best an insufficient mechanism for isolation due
>      to the way the rest of the system is designed (cpusets, zones)
> 
>    - at worst, actually harmful because it leads kernel developers to
>      believe users view mempolicy APIs as reasonable. They don't.
>      In my experience it's viewed as:
>          - too complicated (SW doesn't want to know about HW)
>          - useless (it's not even respected by reclaim)
>          - actively harmful (it makes your code less portable)
> 	 - "The only thing we have"
> 
> Your RFC has the same concerns expressed that I have seen over past
> few years in Device-Memory development groups... except that the general
> consensus was (in 2017) that these devices were not commodity hardware
> the kernel needs a general abstraction (NUMA) to support.
> 
> "Push the complexity to userland" (mempolicy), and
> "Make the driver manage it." (hmm/zone_device)
> 
Yep

> Have been the prevailing opinions as a result.
> 
> From where I sit, this depends on the assumption that anyone using such
> systems is presumed to be sophisticated and empowered enough to accept
> that complexity.  This is just quite bluntly no longer the case.
> 
> GPUs, unified memory, and coherent interconnects have all become
> commodity hardware in the data center, and the "users" here are
> infrastructure-as-a-service folks that want these systems to be
> some definition of fungible.
> 

I also think the absence of better integration makes memory management harder

Balbir


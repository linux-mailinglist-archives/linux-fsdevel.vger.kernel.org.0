Return-Path: <linux-fsdevel+bounces-52481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C07AE358B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 08:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDAEE16AC99
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 06:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3F31E32DB;
	Mon, 23 Jun 2025 06:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OLfXRWV3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2070.outbound.protection.outlook.com [40.107.102.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E34E1DC9BB;
	Mon, 23 Jun 2025 06:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750659346; cv=fail; b=ufv4sSDzaouG9r+LTGoj9o3x03bgW2l4UXfzOzKVPjO4tzCvg/z29CGVa4qIJrxX7WOrdZvl4Ty/ZjcKOSizQqZ/w9QZT65FWc6ZgnsV3J9oHe1ZMzWmGc+K6zqisuFgTFd6hXuZLXotz0rjoCsszIgamk1n1WbEuHVMCLapY/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750659346; c=relaxed/simple;
	bh=KYYP/xwr5nS1WVd5CXiycjd+5lVvSfweD7B5gcfDmlA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RT/H1o5dW/eqc8MVtdeDJY+LWVorNibl8MNuZYmRQStr8/Eb9ARkBrdqM/Oa0Xc5mGi1wCeL5+Qg5NnUgMghaxPgyCfHpf0XO20V9LAbmMhlQz0/2wQHL5iuoPpDeL1j89rFu74M4dxhCZR8ZjtC//o1ZC7/ooKBGTimAy3ZTOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OLfXRWV3; arc=fail smtp.client-ip=40.107.102.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TUR98vZlB3/JHB/1GJ/POV2AUew0KdvhsvAv4D7oBIDTC0AyCE5e2vI0mUcGgU3OFYK0OTa7hd+tDGs0boTwR04QIcGdYepV0vC1yu1p0S18xZ0MseFysV+SCn+/1j0HyHnxGbj41F9lEzEY4I3rOGNuIv0Cr18PQbDLCjVPFcYmYzgB5aI7tm5lkb6WbkpTwQd2nvGgHik1kG3serWQLUtxVdUPebU1ra0Pn9V8O6+9OPFB7rtAs9FWy3jTGIN4mJ1yzMAYvD+zjp4lf0np9N9jNcUoMOrPz7R+bINtISOpMfk4Rd+3LLJrmOqXI1CX3Zr9bFvARbS1U3kdzzfzMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERsPHmPYpcmN8lWYoC8w/SS2s6zO9ei6nwJYB0XeQoE=;
 b=wiXYL5TXZ4Y3Ih+MtZISlmBeZWNF42E+UOhK9p/7+/kZFQOJOi7v0oz0nKoYgpFJffVZOlxIUqmB9+cQoIbcKvqP3KwkZKx3d3q9d5is1AYPz71FdwM2sCgxEy3FhmQ+hE5SdfbnjzprGuYAcp3+X1+bd+3qyz0usTqwZTfdBMnVRnnBKESYsdYfJfaL5y/vGZDuLdpRzju1/F90lwZ8YpGXVueIuxVyAVI8v6n46XPJlK+3hqY/VSvELeImx6fibw+qMBVVARckZj0MXYYouZqDrsWBJmcD77YDI9wtr9hK5Ity0yhrve60viNUwt9doMjbYV0knfv7Ha+b+HrkvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERsPHmPYpcmN8lWYoC8w/SS2s6zO9ei6nwJYB0XeQoE=;
 b=OLfXRWV3x36jsf+f+WU3RKuehuOpCaJ0Ca4QAboLKyf/9sE5PYQzHLf+0wp8d3m8el+PZ76tJZOP2FyFmnLZqt23RhsNAyZ9zeF1tUTcjUCSJJEa5nFpQWx7dOL/DB9yR/uTYIwpakFWiF+DIDfPOjtGgeiBtJSamMn4qwMCvdo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8189.namprd12.prod.outlook.com (2603:10b6:208:3f0::13)
 by DS0PR12MB8293.namprd12.prod.outlook.com (2603:10b6:8:f3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.35; Mon, 23 Jun 2025 06:15:43 +0000
Received: from IA1PR12MB8189.namprd12.prod.outlook.com
 ([fe80::193b:bbfd:9894:dc48]) by IA1PR12MB8189.namprd12.prod.outlook.com
 ([fe80::193b:bbfd:9894:dc48%4]) with mapi id 15.20.8835.027; Mon, 23 Jun 2025
 06:15:43 +0000
Message-ID: <74f4367a-f821-4e0f-9e9c-d4f1221bcb07@amd.com>
Date: Mon, 23 Jun 2025 08:15:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] filemap: Add __filemap_get_folio_mpol()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Shivank Garg <shivankg@amd.com>, seanjc@google.com, david@redhat.com,
 vbabka@suse.cz, akpm@linux-foundation.org, shuah@kernel.org,
 pbonzini@redhat.com, brauner@kernel.org, viro@zeniv.linux.org.uk
Cc: ackerleytng@google.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, pvorel@suse.cz, bfoster@redhat.com, tabba@google.com,
 vannapurve@google.com, chao.gao@intel.com, bharata@amd.com, nikunj@amd.com,
 michael.day@amd.com, yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com,
 thomas.lendacky@amd.com, michael.roth@amd.com, aik@amd.com, jgg@nvidia.com,
 kalyazin@amazon.com, peterx@redhat.com, jack@suse.cz, rppt@kernel.org,
 hch@infradead.org, cgzones@googlemail.com, ira.weiny@intel.com,
 rientjes@google.com, roypat@amazon.co.uk, ziy@nvidia.com,
 matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 byungchul@sk.com, gourry@gourry.net, kent.overstreet@linux.dev,
 ying.huang@linux.alibaba.com, apopple@nvidia.com, chao.p.peng@intel.com,
 amit@infradead.org, ddutile@redhat.com, dan.j.williams@intel.com,
 ashish.kalra@amd.com, gshan@redhat.com, jgowans@amazon.com,
 papaluri@amd.com, yuzhao@google.com, suzuki.poulose@arm.com,
 quic_eberman@quicinc.com, aneeshkumar.kizhakeveetil@arm.com,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-coco@lists.linux.dev
References: <20250618112935.7629-4-shivankg@amd.com>
 <20250620143502.3055777-2-willy@infradead.org>
Content-Language: en-US
From: "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20250620143502.3055777-2-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MR2P264CA0036.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500::24)
 To IA1PR12MB8189.namprd12.prod.outlook.com (2603:10b6:208:3f0::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8189:EE_|DS0PR12MB8293:EE_
X-MS-Office365-Filtering-Correlation-Id: bb287ad2-e761-4913-603a-08ddb21d6251
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TStqQ01vb0ZPYVp2YVNPVHJMalNXTGZBeG40YzYzRmdsUThrbjdmRkErWjAv?=
 =?utf-8?B?dS94bEtRaTVKY3U5VjIyVVlSaWlITGdOT3dCY21ZUDRJSHNXdm5RVjZZMFJW?=
 =?utf-8?B?NXU1NzhaNm1ESjhQbTRueGhyMjJXc3RJa2hGYmVCRUtMdGRBc05rZXdkSVhM?=
 =?utf-8?B?SFhOaDBOT2plTXU2cHBNL3hpQUhWTmNJalJJOHVYUit2M0gvQVpicW9GWGlF?=
 =?utf-8?B?Y0lMOXVjTXozZitxZ21HNjM5UlV5Z1N0dUxGYXZYS2NqVG9EeG5ISDRYWm5r?=
 =?utf-8?B?ZGdMSkJGOXd0ZW10RXZuaFJLUnRrZkhkUWdhTUk4ZGUrNW5VOUdSRXRSN3Rl?=
 =?utf-8?B?Mk14RVVuS3pTWk55QnY5dVFIY0J0N3B6Skw1aGVkV0t3eUR2NXFkMFJLQkdt?=
 =?utf-8?B?aTBRYUVPNGppMGdIU0NxVThoRjc0aWpMREVRN3lxcHhxckVwWlhPbzRlRjRX?=
 =?utf-8?B?YnRqelFLWG8xYTJWRnBGVi9qTUl4b2FUREdKNGpsdnJiK1hiTWFMZnhxNFdV?=
 =?utf-8?B?YmdZTnlxQUlySFNyTkQ5MUFqK215cVYwa3ZDNloxQjdDMDkva2t5RlhKVUY3?=
 =?utf-8?B?TXFVcWRaRlFtOWVxeUo3M1dyRlYvNzBlZzhxUkQ1OURhQi84akdrME5LRzBI?=
 =?utf-8?B?dGZYQ3BkVEUxSFV2WmtnY2Njek1CbXpuTW9NKzMzNTIrMmIxbVN0U3U5VmVo?=
 =?utf-8?B?cFBpWlF0cGZaSmxVOWxrTmNHbFJWS216d3FjV2tmUDR5UnhwM3d1bFFJRVVI?=
 =?utf-8?B?OVpQeGlBQSsyTEhvK25lZldWNDlMa2xCcS9Kang1YTJSbjhZQ3hNRHFtc1Zo?=
 =?utf-8?B?ZTd3RUpnU2VJdFBMcUF5cjRBQmU1MStTMnpMVTJhbTBJMkhpeUJqSUlvZzF0?=
 =?utf-8?B?THpOa3FpTkRrRHRCS1JTOXJLUHg2TWEzcDZMVGcxdkxiczFrWTFUNTJNbVkz?=
 =?utf-8?B?TFE3T3FXbjFpeGR6bFArTGpxcVcyZUxLSlVGU1ZwKy9uUGVOa1BrKzA1a1FN?=
 =?utf-8?B?ZkpiZi9sTXNoM293L1UrcVVkZmZtWFlJM25uY0RMeTk3a0h2dW1VNHNVelNk?=
 =?utf-8?B?dnRneW9BaGxhTGdjMWxZZ2tya25wSTdrV29SeFA3UE1PN2tZelByVzFhOUxC?=
 =?utf-8?B?U3NPTm1vRGtON2lXQ3Q1UVZrUEFSOVRETFJoZ05HNUVzbEh3UjBaWVdkSHI0?=
 =?utf-8?B?RDhsZkZQci9KOTRhQ0NIcHNSeWhFVTBwZnRCZVVVeG44L2ZZM0hYaEJybjQv?=
 =?utf-8?B?Q21Fa1k0c3NjQ1pmcjl0RHkrYzR5MDlpVmM4MnJ1RG1qU1plYnptTndOaWxq?=
 =?utf-8?B?a01wV0xKcThzK3FwUitmejRMKzJ1c2MvcUlOakpwWUt0Qk40cEZXbGwvMVNa?=
 =?utf-8?B?OUVFekhISFIyR1ptdlRFSDBMTGZoOWtET1VwVlIxZlVJUndVcnhCeG5NSzNZ?=
 =?utf-8?B?Z3VnWE8ybXhUakU3UkFEYXFrM2NZYnNUTVNhcVpWcG4rcHBvLy84cnI4eDFI?=
 =?utf-8?B?ZzJtM045NytRMk83eCtpK1FsNVorTmZWa1R5OEdqeFpzd2FyV0hKWjhjMHhM?=
 =?utf-8?B?V2JzVDBVM1RCdHcxeGt6Tm8zYTFTQmphd1FMV1dSajg2SHN2UkszNU1GMmtZ?=
 =?utf-8?B?R0lrNFJ6M2JRZjB5V014SnozV2ZWZWlwSXBWUVFqSmc0WGQ0MmNQVmxaZG9N?=
 =?utf-8?B?a0Zaem1CWFpYK3ROV1VRUlQ3Z2F5Zyt5MnZ4T3RzY0EzejJyRng4NFJGclhL?=
 =?utf-8?B?RkFhcDFmM2tTZFNQYldoaW9oQ0VuTUdYREVxcXFhSGtXenZoNFZUeG5oaWsw?=
 =?utf-8?B?QzBNendwQzNzbXVmQmowaE1IbUZPcFBoalBTZkZDNC9hQTQ2Q0NXVnNXbGtF?=
 =?utf-8?B?bjFMcXErWXIyRmVIcjZLOHFoUEVaMDlJVHpuQkUrRFJXL05tRHl5MU5aVzZp?=
 =?utf-8?B?NVVNYUlwOUMzb1JIN1FrZVpLZ1pWT3VuelcxWmNoL2NibENjYjE5Z2V0Tzd1?=
 =?utf-8?B?S1BaNlhIYTJ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB8189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDk5dHRXRlovbE1VaEhQdFhmNEM1M0E0T0dqbGdrelFETXVQdE1KTDVaS0Fh?=
 =?utf-8?B?SEtLdEYwOXlIV1c1OEpGcDB2cjloUmNCUkxDZTlsV0ZFSTExRTdsOWVzT2lP?=
 =?utf-8?B?dFhnUWFQZkpRemNTV1FvZjNRM1gwSkdwZnFoUVhkNVIrbEhHbmlKeFBVRFk3?=
 =?utf-8?B?R1ZEVnNNN1k4NW96azYyQVg4YzBRQkZpTE5WL0R2dWUwU1BhTVZVYWJSSllx?=
 =?utf-8?B?eXExQ3pBUzNNcnJXaFk4b29rVzQ5dkdrWUt3Y090L3Q3QTYwU1VjeW90RlVD?=
 =?utf-8?B?NlhDa3l6VWRTSnZHOWhWQ1JzNVJ3c3EwWXY1MW1wQnY2cmpocDJBeWZEY0RM?=
 =?utf-8?B?OWR2K1NyY0hNQXdGTlVXSEY4ZnVZcEhrd2FTYStKSDVROE0yZnZNR1ZIbHJI?=
 =?utf-8?B?YjM2Tmc2Q2gvS2JpUXAxSWdQY2VqWi9xVXlqWHdlWmh3VDRRR0ZMUUl0ZTJz?=
 =?utf-8?B?cGtDSmxoVEJFbnFqcEc1SnFiWkNlbG5RS2ZrZjd4VUJyMGFJU2RJVVVYenpq?=
 =?utf-8?B?dURtNmJZNWdrTVZ6Mldkd3IvSlJTTW1NSHVEZEtENkMydm1nZE93TExMVjJT?=
 =?utf-8?B?ZjVsSm9TcndETXZjYjhPVTlEYnpFcG9keXR1TEVrekIvcWY0NU5nUXJidWFL?=
 =?utf-8?B?TFhwQXlpaklFTTRPcXZTSE9RMXFmMUZMZjhHQnBrRHVScXRMamtnSEsxR2Ni?=
 =?utf-8?B?RnV6RVg2ZHBoWlpXeksxUER0QkJGOW1RdXU0M1QxQk1FYTBLVkpaMFYyMThr?=
 =?utf-8?B?U0J4UEZTci9kZm83bFFFaXZqekE1MHJFNTJJTit2dktjYXUyWUhud2xtdjMx?=
 =?utf-8?B?cE9xN0dFNVM3RVZaQlJ1elVjZ1o1amdtZFRza0NyZXcrUEc4OUZRdjZjajBY?=
 =?utf-8?B?ZHZhTGpWd0lPRTJMcE1ZanZmNXVVcG5CQXhqZ1NDbjM3eVB2d3JLRUxPdkZi?=
 =?utf-8?B?elhmYkJiVEVBR2NzRGs5OEpvS01sbzNzTjhDN0s1ZVBHZGFnNHRsYnkzTDNN?=
 =?utf-8?B?blJ6L2ZROTJzdVFmNk9SMmtOVnFaai90cGgxT3p1K1NWaUt1NGlEdkQ2Q1dO?=
 =?utf-8?B?eU5jVXNnNWY0TThBQWNRaERSaVQrVzFodUtxK2hhU1pRUTZaT3FSeFltWXhz?=
 =?utf-8?B?TXVDdldIOTRYZUhPRXlQUks5TjZ0bitjUGNud0JrRHJmejlYbmV4T0VMUVJO?=
 =?utf-8?B?UmIxQWorckZYNzFRUzVqZlBzS2tGUllaTXd6aERQSkg5L0ozR3MyNWVZUXRo?=
 =?utf-8?B?LzlmaWRtUVllKzJmMXFNNnVpTlpVU3Y0NVB6a1RFSG5JWHRzNC90RUhYa2wv?=
 =?utf-8?B?OGMxZWdLRTZsUlp0U250K0NJNkxoK0FwcGcxbFEyWnhHL3k0UjVod2tXMGJP?=
 =?utf-8?B?RlBIVmhtWVgwQXNhY0pWYmlScmM2cWF6NWFwWWlscC9ac240Wk1TZG5UUnpX?=
 =?utf-8?B?ZFRDbTcvak5VVEZ1UjlQQTVLNnRkVG5KV2JPbmJZK3Frb1dBL0wvSXNzTGJE?=
 =?utf-8?B?L3I3QmN0dFZaVmV6Y2R1b3VLRU4rYlNFeFZCa3V2bFJic2xBZGVOY2p4U2VD?=
 =?utf-8?B?c2xQQVF3ZGJ6b2FrLzIzVU4ybzJycVdZSXVYUzladnJ0MVkzU3NnbWhpbnph?=
 =?utf-8?B?Zlc2cndGR0N6bmlIcGMvaVhjZDZPODY0b3hDNG5UQnhmNDB2OTc2aDErbExP?=
 =?utf-8?B?YlpCNHhNVFpBdzdhVlNva3dxbzI2ZFBENHJmcnBta3hVU2t4L3kyZ1lLNXZC?=
 =?utf-8?B?M3ZaY3pzZGJONjZ1Vmc0SGdZMW5lRWJRSkJkYjJTdE93bkR4VHc0K3RJdkI1?=
 =?utf-8?B?NXZBTCtLYVBRaWtDdno4WnNqMmh3blZSV3lGc0NWVTBCT0c3Sm1QdG1nTndD?=
 =?utf-8?B?QUFUeTNpd25LbVVSZCsxcVFyNEdPSUZrV0NuTWg1ZllvTmVHdEt4MklXV0tz?=
 =?utf-8?B?OTBrTGdQTkdPaEZiWnJWdGcxNHd1TlRKVmpvRDkrOTRKMGx3NjU0QVk4Vzk5?=
 =?utf-8?B?QjdHZDBzY29DRytmeFBYd0VUUjdYSk9aUnEwNVpXVHZXNEt6Z0RtT1BiOUF0?=
 =?utf-8?B?eDB5am1yMWpHQWZMdW9DcWZHWXVDK1MzQTJvcXVUendlWnhRZlIyTEgzUGFu?=
 =?utf-8?Q?t4ps4zjfKt0NL1ZFxOQakUgCo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb287ad2-e761-4913-603a-08ddb21d6251
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 06:15:43.1638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m7TBATAKThkcVrULBwl76LE/PraoQ21E0Woj5LMeuTSueYGyKMlTfDUQe3QHNjBZNTANyPT8reg3ZVi2gPjROA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8293


> This allows guest_memfd to pass in a memory policy.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>

> ---
>   include/linux/pagemap.h | 10 ++++++++--
>   mm/filemap.c            | 10 ++++++----
>   2 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index c176aeeb38db..1cfbf7b8f573 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -745,11 +745,17 @@ static inline fgf_t fgf_set_order(size_t size)
>   }
>   
>   void *filemap_get_entry(struct address_space *mapping, pgoff_t index);
> -struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
> -		fgf_t fgp_flags, gfp_t gfp);
> +struct folio *__filemap_get_folio_mpol(struct address_space *mapping,
> +		pgoff_t index, fgf_t fgf_flags, gfp_t gfp, struct mempolicy *);
>   struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
>   		fgf_t fgp_flags, gfp_t gfp);
>   
> +static inline struct folio *__filemap_get_folio(struct address_space *mapping,
> +		pgoff_t index, fgf_t fgf_flags, gfp_t gfp)
> +{
> +	return __filemap_get_folio_mpol(mapping, index, fgf_flags, gfp, NULL);
> +}
> +
>   /**
>    * filemap_get_folio - Find and get a folio.
>    * @mapping: The address_space to search.
> diff --git a/mm/filemap.c b/mm/filemap.c
> index a26df313207d..597d146cbb3a 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1896,11 +1896,12 @@ void *filemap_get_entry(struct address_space *mapping, pgoff_t index)
>   }
>   
>   /**
> - * __filemap_get_folio - Find and get a reference to a folio.
> + * __filemap_get_folio_mpol - Find and get a reference to a folio.
>    * @mapping: The address_space to search.
>    * @index: The page index.
>    * @fgp_flags: %FGP flags modify how the folio is returned.
>    * @gfp: Memory allocation flags to use if %FGP_CREAT is specified.
> + * @policy: NUMA memory allocation policy to follow.
>    *
>    * Looks up the page cache entry at @mapping & @index.
>    *
> @@ -1911,8 +1912,9 @@ void *filemap_get_entry(struct address_space *mapping, pgoff_t index)
>    *
>    * Return: The found folio or an ERR_PTR() otherwise.
>    */
> -struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
> -		fgf_t fgp_flags, gfp_t gfp)
> +struct folio *__filemap_get_folio_mpol(struct address_space *mapping,
> +		pgoff_t index, fgf_t fgp_flags, gfp_t gfp,
> +		struct mempolicy *policy)
>   {
>   	struct folio *folio;
>   
> @@ -1982,7 +1984,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>   			err = -ENOMEM;
>   			if (order > min_order)
>   				alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
> -			folio = filemap_alloc_folio(alloc_gfp, order, NULL);
> +			folio = filemap_alloc_folio(alloc_gfp, order, policy);
>   			if (!folio)
>   				continue;
>   



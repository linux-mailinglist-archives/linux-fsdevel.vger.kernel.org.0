Return-Path: <linux-fsdevel+bounces-71294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B0BCBC9D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 07:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDE08301B48B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 06:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F77327202;
	Mon, 15 Dec 2025 06:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iiCd9r98"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011020.outbound.protection.outlook.com [52.101.52.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBBB326D76;
	Mon, 15 Dec 2025 06:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765779114; cv=fail; b=UjKS/T6Uth6+0OwLmy5Kh06hqMfNmgdzUhzUhmUf3QqpOsjJnbU80s7rPiHQ1rnCaafXBtJcJwQsW//uPudHCsIJ5tD7HFw4HWYaYGyiHuzxgX99s95GQiz6iJQA8CTnzOt2LIdUicNdqUsMlZl+wPxA+XAphgQAQ+AywkUzJvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765779114; c=relaxed/simple;
	bh=tcsV68FVDWcm7gowtX+8mBe26VZWw0Uoh04lS5gesXM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DsnG7O/K6xW6X9hRCzesqhpv7DtYIWlXZGUEb2VCFHalQsyYdMsCIuM0YiodUsAu0IkBX0B0QR5ZH4b+FYCFDBK4knrr0uzLF9NtawCUd64DvUktOQaU/fVonwY7t63C4L9ZlPWMePM2qqs9r1l+WCtE09JZq2wjwLv1hX0Dz8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iiCd9r98; arc=fail smtp.client-ip=52.101.52.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LgLYhRDPPSiXyslkbmY8mKzVdDZh0Kna8dQvjFUX0A1n4HGVQ32Vbw0wUToVdjB842vz4knBfN9mKv5teZ3d7m2jTekLN+2vtYy2ew/G6Xapg8eIOg8OXAh/LMf58IHNYpbi1D8Z5rFmjd+/2nnOxfsAyYh1xV+dWEST9jBZQOfyMgELTlZCPuZL6oJhufuLGct0IThL6e3HLJGeM/7uTkz9PXAQFSFwCEnpGTSVjz6eGfbEkwNvJOOu/IAZmWd/RJVA9XQc3O2bC9hif5w72QEgX+vWukNZSoFt1Tt3vZ/712PzhQ1tRkmTGA+sTPx9rDExo8DevijH9fyfGPaWhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SvM+VF5Tk57sfO3VE82CIAGuoDmtUArEph3EeqXoeSA=;
 b=E4VRT5mSWV+tWwWhfjEE1eerdLpiJ5siDrI1JNLJPtl0OC/cqMFTxtOdKydgizz3/iV7tCAJj4HCdQxWjzM9ZMHtC8d9EjkemAprMp1uVOydDGOTDkgmi4KkCNBMPbVeNQOzAF8QLrp/MhXhUIx3nqu4wh27Z7Sy9FBtBZTFOXOUpCqBRb0JvHYQO6wPlO1mJ8I+9+scQNubV8coyOgD5/uNg3whV+emMkGfPeANqMu7grhmxXHFZWyTlLaIm1J+N3lGf2YwS8J5Ha7I6EmUaEKs1v6gYZx/naNegukXx1DY9dvMhodeEeSxo2DwbW3nlV9ilEfSmCfImAL9SO5E+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvM+VF5Tk57sfO3VE82CIAGuoDmtUArEph3EeqXoeSA=;
 b=iiCd9r98oS6n8MaQBdIF8SEmPjlAN2EQSR/nGaF0xwnh4Z3M06LKW4Rv60gxFwZxdSD8FQNvRoKsdcl0xcSDZZrMJZisVKJcWZhlU6eNLWWlrNhcjzygaetKRTQSmjdt+1Cf+Cs+U2rEICdgx5Mg36OfOHvpXAP/y5UqTpcSJHdztn1L5NKHYf0Dss/kgQXCkhIIY8bqlzw62Ra3fGPThIYOCcC2zdYaRQFdJ0GZhWOW/6KgaP9swhkGP5lBQo4VuKYqg+ba6m7v44SUtgLIyNWSG6uvlGrblTavERd4VNW7IIvmP5xtf38PuDumC46SrRLuSy4Dku5k74rWmRKeLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by PH0PR12MB5607.namprd12.prod.outlook.com (2603:10b6:510:142::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.11; Mon, 15 Dec
 2025 06:11:49 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%7]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 06:11:49 +0000
Message-ID: <e6053bc9-f027-4abb-bae7-fcb254e04913@nvidia.com>
Date: Mon, 15 Dec 2025 17:11:34 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 01/11] mm: constify oom_control, scan_control, and
 alloc_context nodemask
To: Gregory Price <gourry@gourry.net>, linux-mm@kvack.org
Cc: kernel-team@meta.com, linux-cxl@vger.kernel.org,
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
 <20251112192936.2574429-2-gourry@gourry.net>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <20251112192936.2574429-2-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0046.namprd02.prod.outlook.com
 (2603:10b6:a03:54::23) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|PH0PR12MB5607:EE_
X-MS-Office365-Filtering-Correlation-Id: 4116ccc8-88c5-4b6d-e831-08de3ba0d545
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aUo2L3h2ZEVFTExnUnRSSzkxd1duRGpQenZkR3pEY1YxM1dHdFlRNWpxZmY0?=
 =?utf-8?B?L3I3S0w2Tm0vaFhhQXVlY1ZRL3ZuRlQwQTRWemtPaUhCSk4vb2txR3QwdjFy?=
 =?utf-8?B?Rkg2SWh5cVpESEpEb2ZqY0JXdVhXM2poQWRhNUQrblJETHMrbkdkNWl5VWtp?=
 =?utf-8?B?TnNVenN5NnVQa0VjQ1p1eWV4VG5FODAyL29YQ081anJvYmZQcWRGVnh3VU9G?=
 =?utf-8?B?NTlTTkFRbUFVSHJMVkN4MnZ4ek01RVVyMjg0akg3dGFHc1kzMVI0eG41T2wy?=
 =?utf-8?B?Qi85VzlhbmdVdFJQUTk0RXZidlhxYUpTL0JNTWFCdG10RzFKK2ZSM3NVNFUr?=
 =?utf-8?B?TmZ1RDFmK3BDQWdjaUxOQ1kvaEdjQUxKRVlrV291eHExb2kwZlR1Umlsdzcw?=
 =?utf-8?B?bFpQZnlKandpUnBUbzNibWhScmdWYmRHQSs3SlpuelU1b28zMGlYSldXOWw2?=
 =?utf-8?B?ZW0zVVZKMWJCYSt6bHNRbU1VOGdpcmxidnZDYTdIa0dwdndFU1VBY1dtTktU?=
 =?utf-8?B?R3ROY09Rc2FmOUQxZTRsNGJkQU5kNXF2bXpVck5PSU9uU2crejdIWWpLOXhm?=
 =?utf-8?B?V2phV0o4OG1JMVpsUU9tSWowaHRGT0RjRWl1NHd5VmhKK1N5Kzg2TWFIYXlN?=
 =?utf-8?B?Z0o5dFlib3lEZDVOOENqajhISll4Wi8vZDhQWXRWYk54WDZLbCtmUWk5MmNu?=
 =?utf-8?B?Z00xVXYvSWh6bmlvdC94SFJXSzcya012bWZaMmVQMkU5ZHpuSnNtLzFsUEtD?=
 =?utf-8?B?NllpanBZVzJnTmFZZ1hSZ1AvU1pjSFRRUGhiUUZ6RWRFWkpiaWhPR2NEcTIw?=
 =?utf-8?B?NW44c0xjRUlVbFlGM2cycHZEb0VGaXAvV1JjeFdtU3VGT2RBekJUZG54QWVR?=
 =?utf-8?B?MHBxZld2eFhIanVsYkZzOVE0b1Z1M05NdUlCNk5oU01Yc1RGRGJpMEk2Mk9j?=
 =?utf-8?B?Z2RxTlBXMml4TUdSZkFlSlFHU0RQbG54ME9SZm04SnZud09hM3RpN04rYjRW?=
 =?utf-8?B?VTExU1Q0UFQ0UTE2YnY0RUp2dkl1SGZ4M1ZhM1VROHdXdVk5NGtlZ053SkJ1?=
 =?utf-8?B?U3o0anlZc01BS1JtUnMrYzcyVVVlTFhhY3VLellDLzlvcjY0YzB0all3UElh?=
 =?utf-8?B?cXV3WGhCSlRDR2NrWlU3alJ0OTNIbFBFZnJQL25qOVA3TEovYTJhZUJwN2t3?=
 =?utf-8?B?YW96Z0poRURHUzYzNlNWTjBiL2FtUkpoRXhCbmVOekptU0V2eURYK3V3MG5X?=
 =?utf-8?B?MnZRVmU3amRUeVduRVB1dGdQR2M5RFlrUHhGdmN3MFRSR3JaVHRXQ3dQdXFN?=
 =?utf-8?B?MURpZFNTaTlkeXdHcUZPK3VCakdjWEkwSWsvRHNoR0NNcTFwUk05cWlUQjlm?=
 =?utf-8?B?VHEvSllzZG41WlFWZUxlVkg1Tno5U1RTUkhOdithUTNJYkNsZU84RTJkUTBh?=
 =?utf-8?B?WXpnM3RMVjBscVhMQjlZYXRmT05nOFAwQVFqNjhueE5lUjdIMXo4MndlTytU?=
 =?utf-8?B?ME9EcUdIQWs0M1EwRjFGYjJBUVRaNThya2tFNDNldU1WdGpodTByTEk2WEtG?=
 =?utf-8?B?U0xQeTR0bGhBOVEwV0l4YXFMY05FRGVLVnRsQ3ZBQUNKbDg3KzMrbEdsTWl3?=
 =?utf-8?B?SmcxYjdFblhYbHZIR0NDcUEyNUpmdUZwczdTNjRqdkFyZWJtdVFLVjQwRXA2?=
 =?utf-8?B?bWdIL3BGUTNLM3pVR2xPdkJqNDBoQlF2Y2ZPU1FDSStkT0lxK0xsQXBwalZv?=
 =?utf-8?B?MUhWWURjN21HRWtMNHlla1lINGk2S1UzWWRDc0hYbnRybXVTTnlHaUM3TkV5?=
 =?utf-8?B?Z2pKUjdJZ1pkQTlieUZCMUlneVZQUDVBWkJ0c1YvcXdQclpHOEFNVjByZ3hT?=
 =?utf-8?B?WEE0TVJIQml4Qy96K0s5T0lqUzd3bFBnNFBrUm5BNDJwSlFVQjNwQTZxYk9J?=
 =?utf-8?Q?VHZ5ZsJa8IBD5DgN7SNU30ILV7Nv+xG3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVFqbjB3c28yelVta0NLbHk2RWxZMExlUUhlYjl0V1F5STY2VlYxd3JMcUww?=
 =?utf-8?B?YVJMYVdOOGtPZFM2NDhyTkxTdDk4OFBwQlFSUmJiajJZb2FLdEVhWW9DOTRT?=
 =?utf-8?B?bjNiaGZyem9JbC9rRkxyaHFTZGNrTmZ4dUZ4NjJuelJGd2p1Qkl5bGRlK21a?=
 =?utf-8?B?SzlsSXRGbTlyMGQ3dHorbGVvendPMFNjU1JBcVh2UXVaVDlPSGU2RURyV0hS?=
 =?utf-8?B?RDA3b3BUWEp5eEZXM3ZEVGRGeUNsRTVMS3p2VWhsaGU3ekVkTlM1VkFBdlVC?=
 =?utf-8?B?dTN4U0kzTnZLbkNGTHpsZU1sbndOWkh5QkpxaG43b1BTeGhVNUF0d3NST2p6?=
 =?utf-8?B?Zy9zOTZsWDg5Vkw3aHlVSEdLVFZYNlVLbUxxdVBsQmhJaFl6cG5XeWN4T2Qy?=
 =?utf-8?B?bVJ1YnlvNHRvaDVtSFltell0eTh1QmJJN0I2aVlNdG1Ob0RUQ1JncmtLOUhF?=
 =?utf-8?B?dTdES2txQUVQbEZ2NE53clF3YmlxMUpGc3IxS1RROGFhMWlleVY2MkEyOFFH?=
 =?utf-8?B?WmpDWUZLRWJwVVR1MjFjT2I0VzVicmtDeGZXQnZLSDlrWVNGMFlIczVtYjkz?=
 =?utf-8?B?NDB0WElpSGl3ajI1VE45TXZMS0FtcWFqb2dQSjlsM2YzN2NFakErc3BLZndk?=
 =?utf-8?B?YUNDTjM5eW1qaGlJamUwUklQSm9yWlFLbzBiL3VtQVdqaDNaZVlzVG5lUDFE?=
 =?utf-8?B?cGJndjBkQXhsc201RTNYT1Z2N0RLNHBFd0ZRalMzL1pQbi9kMWNCdzdra1U1?=
 =?utf-8?B?eEpwNUdlTnYvWUlXV0QzanF0b09BQ1I0S1NENFVrWE1YMS9UcTBmOHArWHlU?=
 =?utf-8?B?Y1FUTGN3cGFTa29aOFQxWFZ3V1NpUXljbFlzM2VyZm9yTkJYNzRDK1ptVDgr?=
 =?utf-8?B?Z0RMQ2ZORjJTb3BBWjVLYklKKzhqSjNtU1FVcEhtek9HdmZJV3ZTM0J4aTEx?=
 =?utf-8?B?dkFScW13YTFHcHRsdTNmZ2F3Zm8yTFBKQ1BMNmdRY00wUk5rYXFhbnlQeFo3?=
 =?utf-8?B?eFhoOE5TZlZsU0VsU2doUFlqYXlxOHpYUlNJSnBMQWw0TlIzSHkzUTBzQzdR?=
 =?utf-8?B?YUorVXJxU0R5dkF6ZjVlOTloZUV6Slg5K0lIMEQxLzAxeWhSRXg1VEZTVDJI?=
 =?utf-8?B?bGRLTm9MYmovUGZNRXlBc1VhS0U2NW9BNno2T2tOWk85SGpkZmErOGZHMkdT?=
 =?utf-8?B?Q3RxUWtxNjhkL2FyaWRHQ1R0K3kvZnpIOCtDVTRPTndya0tmc2pPUDhScUk5?=
 =?utf-8?B?QzVqUzJLZkRvQS9jSWJJN0E5MlR4bTVCWWtsTUpxUzQ3NDJrdXVHTm9ha005?=
 =?utf-8?B?UmEyY3h2TEgwNFluZG9qMGFjbzVveDRvR09DSnovcmp1dmtaQ1Y0cWdZdzBY?=
 =?utf-8?B?ZytxdVR3N1V3YlVkT3RuWCtiMjJsVU9oNjQxckt1VWtveldVU0QyTnppdWsw?=
 =?utf-8?B?SSthWUdtWXQvVjk0ZjdoTEtkS0lxbWdxWVZVdXZWVmhvUkN3bHhHNTNlTy9B?=
 =?utf-8?B?Mm9xNkU3WTFEeDFGQXNFR05RTzRIb1YyUTVnS2luRDRKZXFiUEE5aU5EeXMz?=
 =?utf-8?B?NUR5TUJzcUF4OFpPZUNoRUlOZEpUcjlSbkN0SFFMa0Nvbk1lcFRhSkVSMXl6?=
 =?utf-8?B?WW1YQ25PcVVzcmFacFBkR0trWll1WjZmUzdlOUlwb2RONjJqR3huSmkyaXNu?=
 =?utf-8?B?M2xpSEJTTWVPYjdVeFJIdHBjNS9NZStmY05qdmRCS2FxcUJySU9WQlRzUFZY?=
 =?utf-8?B?bDJqNTNoNDJUNFd5VjVYeEpyU29mZUpkU2FTVkVGK3dEWTFJeEpYeVhuTXd6?=
 =?utf-8?B?VUkwM21Fci9lZDFFMk1SaHBFTWFpL0hMMnRRTUI1OXZsejdhR1poWDAzNTZu?=
 =?utf-8?B?M3pFbCtmcEhhakdmbU9QM2ozSVU2U1h2a3pkc3lwU1ovWkZkOGVkUVFlbHVC?=
 =?utf-8?B?dUV4dEcxR1ZpQkFKUlVxUW9DaXNocmJudUJveEY5ZDhBWGVPaDllaDV3V0hJ?=
 =?utf-8?B?TUwzOENlejhOS09KMXZWM2M2VG1HTkRUWDVaUG92UHF1eURoN3hsdHFGWHA3?=
 =?utf-8?B?a1NSN3BKY09BcEIzQ3ZBZEJ6UnpLbnpWdkZFaGFQZEtVVFpFVmhobmVlRUdJ?=
 =?utf-8?B?VnRDZDQzenZCM3lSd1NyMG5tdU94U0Y2bzVGV20rSi9uQjBPQXFFWTBVcDVz?=
 =?utf-8?Q?gg1JCcwHDHkAY06UO8G4Jz8I4x7V9ei1mW/Du1Mpj5fg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4116ccc8-88c5-4b6d-e831-08de3ba0d545
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 06:11:49.3697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +OrI0foLEK7b1lxpf1gUVzV4P+uCMFW6mOBt2WpoN9TpgSo6qwASnrMoLGR42z0KalWnBAS0sS11s8aar1LO+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5607

On 11/13/25 06:29, Gregory Price wrote:
> The nodemasks in these structures may come from a variety of sources,
> including tasks and cpusets - and should never be modified by any code
> when being passed around inside another context.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  include/linux/cpuset.h | 4 ++--
>  include/linux/mm.h     | 4 ++--
>  include/linux/mmzone.h | 6 +++---
>  include/linux/oom.h    | 2 +-
>  include/linux/swap.h   | 2 +-
>  kernel/cgroup/cpuset.c | 2 +-
>  mm/internal.h          | 2 +-
>  mm/mmzone.c            | 5 +++--
>  mm/page_alloc.c        | 4 ++--
>  mm/show_mem.c          | 9 ++++++---
>  mm/vmscan.c            | 6 +++---
>  11 files changed, 25 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index 2ddb256187b5..548eaf7ef8d0 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -80,7 +80,7 @@ extern bool cpuset_cpu_is_isolated(int cpu);
>  extern nodemask_t cpuset_mems_allowed(struct task_struct *p);
>  #define cpuset_current_mems_allowed (current->mems_allowed)
>  void cpuset_init_current_mems_allowed(void);
> -int cpuset_nodemask_valid_mems_allowed(nodemask_t *nodemask);
> +int cpuset_nodemask_valid_mems_allowed(const nodemask_t *nodemask);
>  
>  extern bool cpuset_current_node_allowed(int node, gfp_t gfp_mask);
>  
> @@ -219,7 +219,7 @@ static inline nodemask_t cpuset_mems_allowed(struct task_struct *p)
>  #define cpuset_current_mems_allowed (node_states[N_MEMORY])
>  static inline void cpuset_init_current_mems_allowed(void) {}

The cleanup looks good

Acked-by: Balbir Singh <balbirs@nvidia.com>


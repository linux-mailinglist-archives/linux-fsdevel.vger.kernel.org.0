Return-Path: <linux-fsdevel+bounces-71218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BB8CB9E81
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 23:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 82D4830022EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 22:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B491830B511;
	Fri, 12 Dec 2025 22:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IkBx5DoK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011037.outbound.protection.outlook.com [52.101.62.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2422BE625;
	Fri, 12 Dec 2025 22:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765577541; cv=fail; b=ANYDEsCGhWfzPMtAv631ZOQ2YYQtR0APY8K+PfsSR3YVAQQ7TsJk/126I1ryCwDUt5CzefDOfpaOWZEWgpy0NLU7bnCRdNCn1ojp//DcYfVErnhs/FN/v1vFbwIPwKbdupmtGaXBX89t7CctS5oJvcYzKHsWq/aGadkowD83PX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765577541; c=relaxed/simple;
	bh=Yzaco8fF3gTFsXN8GkU+Iv1yf7JUtmXpO4NlhX/h0E0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YNXKAaOfRBiDV7xfHjadPyxdOdIQOYUvr0QVaafUFrKIDqJRR9b49CeNybg8ZJ/fgTUV8D/PSM1QPx4A+PTTVZdkm65XGQkPSlgqaANKZ65M3JgSBS3ggsRt11LPkgH2oEy+fb/0ecb+crA4R8zjlshdzRO2Qy/OwVpjSYmBFmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IkBx5DoK; arc=fail smtp.client-ip=52.101.62.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N/v83gJ8628jtuDfWEO9Q0QvuLIdAj36KVxzDar+hJmMQc3fZ7qpB9v7xKTZvQveXj+wwIBbAY7lDMxVnoZ8WBoKqU2VoQ+IZrBNj07sj/a+LM8IOKPfJdOBm/fLKIr8Otah/RqeSHauMjOkJoHvwNwdhbMpZLZPFqtVDVlePKky9UOecQ3bfivlu0uAItO/mIa+/AGqK8R35vvAd0u77xs2WPkNNWHh06F+hAIWnM6nMvaOOxGp4WS1tjbTIrqkDC4H4wwY0RK1YIn+/jD4VkClyvqN+rwLfu/HOl9ky1FGXOmEOtKRKD1bWMmuFgXpPCcjjR3u8YWs/bEr7N/K/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xIvVQdi6l6BV0d9gltbh2R1CztLaZoy+V/c7Y1P/nIw=;
 b=gkvTXPVGt9v2J+WNIwjRw+hbQoGmTOeCX5FQOeXjxO6FeHg38CgRaLKe+HlZXgtdxzz1XJ62RER77iMPKsNpf98eVpQWs6I8b228MhNj9Vg0gmvF+LirFtiCmjxYVyDb1WkrkwQZe/8KqW9JxKQ2De3Vg4sGOw1185IUxcAa1tMZInDp59ZFfeDaRVKUJfXN/CtFCknpWNLgLFJKNDuPYVacZELqLWba9W35dAsAKLSE/JVFiustoJ3CIigEhXlLNTx9qBASLbfbFpRNCraM4v1DKIpKZflHNaevXJBAHYnZyDhV0T96ikRvvBFIrJjJeeJuJGGdC5b5zH1DPseWwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIvVQdi6l6BV0d9gltbh2R1CztLaZoy+V/c7Y1P/nIw=;
 b=IkBx5DoKVOxTEAicZC3AAKtwwjmAbkg1SuvERwcSV90cuWoiq4v+SpCVtmiB6GTxUzQ0foR/q6UbpWYuwg4tlzXvScXrFzv4ajOlvzQoXANnfj1SLWWQuOaM3PVJ5g0S+L6sR7EMUH0TAzZN2cLfNsqOEpNoNvQU7ZNY+OEkWS4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9714.namprd12.prod.outlook.com (2603:10b6:408:2a0::5)
 by SA1PR12MB6800.namprd12.prod.outlook.com (2603:10b6:806:25c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Fri, 12 Dec
 2025 22:12:13 +0000
Received: from LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::c18e:2d2:3255:7a8c]) by LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::c18e:2d2:3255:7a8c%4]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 22:12:13 +0000
Message-ID: <73ad791d-3f72-4fdc-b466-fb8fb33a73d5@amd.com>
Date: Fri, 12 Dec 2025 14:12:09 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/9] cxl/region, dax/hmem: Tear down CXL regions when
 HMEM reclaims Soft Reserved
To: dan.j.williams@intel.com,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Matthew Wilcox <willy@infradead.org>,
 Jan Kara <jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>,
 Li Ming <ming.li@zohomail.com>, Jeff Johnson
 <jeff.johnson@oss.qualcomm.com>, Ying Huang <huang.ying.caritas@gmail.com>,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>,
 Greg KH <gregkh@linuxfoundation.org>,
 Nathan Fontenot <nathan.fontenot@amd.com>,
 Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
 Benjamin Cheatham <benjamin.cheatham@amd.com>,
 Zhijian Li <lizhijian@fujitsu.com>, Borislav Petkov <bp@alien8.de>,
 Ard Biesheuvel <ardb@kernel.org>
References: <20251120031925.87762-1-Smita.KoralahalliChannabasappa@amd.com>
 <20251120031925.87762-9-Smita.KoralahalliChannabasappa@amd.com>
 <6930dacd6510f_198110020@dwillia2-mobl4.notmuch>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
In-Reply-To: <6930dacd6510f_198110020@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0099.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::40) To LV8PR12MB9714.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9714:EE_|SA1PR12MB6800:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ff6b236-49be-4f59-bf1c-08de39cb8055
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGphN0NyeHhJNFpuZEdmc3k0YkRZaGMyVlkvZmw5dnoyUnBwQVhQVGg2eTJW?=
 =?utf-8?B?MVBMZjBQaExITEROZVdZM1dLWWMvWmIvMDNKSVdNbVdnbXRNOGtuYkpmNVpv?=
 =?utf-8?B?RzZNT3NaTUw0YUUyRGxRQWszNXhuQ3lSb1U4MTk5YzRIa2pxaFdZczhDNmhE?=
 =?utf-8?B?VkF6dXMwRitnL1lHRk1nbGFyN1pkV0YzeDNqZzRWWVkrR1kvUGtDbFZRdGNa?=
 =?utf-8?B?bTRoVzlRMGpDOTVVbnVUbVhReGw2RlJYTHVMUndjQklOQStNcHRyanlLVWNy?=
 =?utf-8?B?SE82SHRnRE5TTDEzdVlBTFVvZGx1MlEreW5Jck1SRmlOTzB1QzkwTkhSeW5O?=
 =?utf-8?B?RDRsZnl4Mjg0L1BuOHlYVE9GUjZqWlVCRnMyQmVRZHM5RDBKemVoWkRqMUhj?=
 =?utf-8?B?V1ZQUGhhOFVIcU1qbHNVQk9OOEFVazRQN0pSYjNFeE80L0p2RlNUUTF5TkVL?=
 =?utf-8?B?MTBQejYwa0xUS2NrSFlUQVRzNjUvdE5Yem9xa3Q5MzFleS9rb2l3a3F2cjJC?=
 =?utf-8?B?dlNHZGl3WURXQUhtTzZwRDBta2pRbk15SU9SMDFCblVSZW50L0dNZFFwbWZ4?=
 =?utf-8?B?V3h6WU9jbjhmYW94MHprN040RFE4WkU3RXNnY1BvNFdxOUpseE1tOFdDQU1t?=
 =?utf-8?B?bmljYm51NUVQY2lIZTUwc1Ntalh3RVYxTlBvVG5SZWVsVmVYNzRKMkNaUVho?=
 =?utf-8?B?VHZZcHhqUzdKUzY0Uk1EdUpTenBpOUtEY3lUb3h2MU5aU3F3dWIrQlhsd3Fj?=
 =?utf-8?B?azRPYVdnejQyWFRHL2Z6cGk1TzcwMEc2WjZsaDcxWElzMHNqYytuWUcrMWtS?=
 =?utf-8?B?aDV1ZnpZOVFxNFhISmhpU2FqWFhaazgyUDMvRGFSL2k0UTdaKzZORWQ5YS9u?=
 =?utf-8?B?Rjc1cFFEa29tbE1ZWHJBOW9ZYi9pWkFLeGI4TCtnWlZoM3hrWHdETlY5a2dq?=
 =?utf-8?B?N1NxbDFGVG9xaklCQXUyREliRkwySmE4N2s2azNMVWh4TlpVK2dueCtjZGF5?=
 =?utf-8?B?VWFxV201RCtQYkR3WTdldE90VTdWQ2V2YjJaRzgrdHJla2xySzI2WTdoc2Zq?=
 =?utf-8?B?aXpma0VtZ29NNXlRbzI3NVduQTBTUEtVODRKa3dsb1VxdTVaWG56MU54N2NH?=
 =?utf-8?B?WEdMZFR6MzBJcFViajFEQjEzK3B5TnJqUWVycUtramRzZjQzYTRqWSsvQkxF?=
 =?utf-8?B?bktNOGpkVzN2QkIrTEhDSGN3OGdBSVorWHdtNlBoLy9BWUt2QTNkbTkzUHRP?=
 =?utf-8?B?cUI0SHRtNldSb0VHMFo1V2ZlYUI5VWJVamxYMGdzOHdSN0VEemVRb0txK2My?=
 =?utf-8?B?L2Vaa3NWSVRObmZvd3J3b3l3dHNtbWc2cW93MWdTQjVmRzUzbDlhdjBkTzdB?=
 =?utf-8?B?bmRiVWkrK282YTRzUVN6ZlMvMVVjZ2NIS1Z5bUZtTlEvaUpxbzhqSTdGaUJJ?=
 =?utf-8?B?UFZ3ZnJ3RFRDT3hBU2xUdWZWVEdlUnQ3N2JkaHFOZjg5Nm9xeldzcWwxMWls?=
 =?utf-8?B?L0prZ1lIRVB1RXBLa0o2czlPT1VEcDE2cENqcm1CU2hhc2Z3NTlJZGNNQUg5?=
 =?utf-8?B?eWNveTkrOTBQanlTR2FtQlRVRGozV3VrVVN0czlmTzBuOTRKUGt1QVgrbGFm?=
 =?utf-8?B?cWJDOUZ2Q2RXVVZncGJyd01oUkQxazY5SWFjWk93djZTdkRnM0s0K0ZVSWVN?=
 =?utf-8?B?SWI2eitkZzZYOTc2UmY4QW1GVVhsb3Z4b3hONnZ1Y1pkWTBheUhvL0lOcjdl?=
 =?utf-8?B?TjBQZnBITEdUTURtblJEMmgwaFMxUStXUGlsS2RQQzc2ZXdKNURVWGxubjJ5?=
 =?utf-8?B?eVdjcTF1UGk0Kzl1eFVDTEhtWEUwN3B0NjNSOE5YZlZxWlhMUzU2YTdFVW5F?=
 =?utf-8?B?R1NVdzNBd1R0bEdDc2hGZ3RTSE50bEtCN2V1SUF1VGlxQWZ6T3RoSUhrcUVp?=
 =?utf-8?Q?Oy5tqiVi7kvDYTvEQlYmuoXUMvcUpJdf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SXA2czBHRncwR2JJMWo1enJ1UTZKdlpoWjArQ2ZIZW4zV1QzYW5BVUN1aTVs?=
 =?utf-8?B?RjU3RmkzSzJNb1VwcWFJNHdGZUZ6Y1JaOWZZdnFweXp6MVFicUk4NWRrWXY0?=
 =?utf-8?B?aytpcFE0eUcxTE9mR3V1bGZrOWphbVhpYTNXSGw0VHRhV3RvdFoyNmxwam9U?=
 =?utf-8?B?U1pCd295WFFGWUs0NWxPbVlTRVE5WmFObHo2dlBnNEUwSnh1RHFneXZ3cHpL?=
 =?utf-8?B?cWdFaXhOQ01qcnJHaGlJNlZaNkd2dDg0R2VkZ21ua0toUmdpemZzQk56RHhD?=
 =?utf-8?B?M1ZqMU92NHpyNVE0MnlEcDhDS3ZHQ1EzY3J6TkZRRytvNmpNVHBwQWg1YmJN?=
 =?utf-8?B?OTcrcmtncDQwblVEbzREczFtZUwyZzNVZEFGL3kzYlM3K1VVSVZ3RHd3eUMr?=
 =?utf-8?B?clBneE9Nbnl5ZHdLNzVSbFFWajJHVnhwMncyM0FhVlZWcERYUkdBSFY2UzRT?=
 =?utf-8?B?ek16eG45ZU4vbnlwL3JpWjRWUTVmdG5wTGtOOHRUOHYzaDFxYnBKTHZEbkNP?=
 =?utf-8?B?YTZVMUF3NDBzSldxUVlQWEpEb3ZFU3BsNFI2WFdVUTVaR2tMNkQ2dU5YdTVQ?=
 =?utf-8?B?NCt3NDFGVVVxTm9RQm9BL28vcjlneUpmU2FnTStZYW84K0RXMHB3aHVpT0dD?=
 =?utf-8?B?OHUyWXUzdldQb0EzNWJ6dnExdndoNUNLcTVoQkNYVlpPQWRxSEo4R2NGZ284?=
 =?utf-8?B?M0Z6UGd1Z09FMVltMkhXR1gyR2tYZUtLK25EamZ2ejFaMmxmOW9nMytrSC9S?=
 =?utf-8?B?TzJ0V0RUb2FHUzY2a2RHWlpROTRQTlJoSFJqeGVBODBYQklpc05YOThsbmNw?=
 =?utf-8?B?Y1BLcXVhU3pReFVSN1V5VzMzSVVUUzVrb1pwN295UmtEVnRBeUlKQS9GaExG?=
 =?utf-8?B?c0FQbnF0eGpuR3FDbU1oV1NDajF2eXVKcFEvWmx3Z2szSkVFTWs5V2p0MXFV?=
 =?utf-8?B?MHBRell2ZWJxcjdpRjdMakdYZzFqZ3dxRVhrMUU1bFQyZ2tTOU5SeFZJTENZ?=
 =?utf-8?B?bmo3aHJ5dHBaRHRZSlI0Ky9tUG1RbllzdEFlZHlZUUFSanYyc0FjblE4UHBr?=
 =?utf-8?B?aU51QkJYQXdyNEJFbno4bEc3clRxOXAzN1VrMk5wNlF0ZEZpVk9JU0NkNDlo?=
 =?utf-8?B?U3kvMnVxUVlLQnFPTFJ0czVtTFRaY1Q1cWZQK2c4cWVnTU9rV0RGUlFNMk9z?=
 =?utf-8?B?K2VCaERIREhpTXpaSHZpVFVuYnVpaTdDc2FnWjc5ZlFOZkd4WTQwMnlFVUhl?=
 =?utf-8?B?SGhkdUFMUVc4VjdycW13WWo3RzFPYXkwNEE5Z0ZSZkczVXRlcHBteEVYQW4v?=
 =?utf-8?B?aVR0QUFyYVJDNFU5STlRRDk3L0JZeHZGQjVZd1pJZzNOWkpyaGljUTZyQ3A1?=
 =?utf-8?B?Ky9BOG00U253VVpnQThzRFRXTm1vL0ZLdWRBUHFvNXV2UnlhM0Vld01uZmdx?=
 =?utf-8?B?elMySEtrVU8vaWQ2MmtSekxIUkU5QjZzdVFMZ1pxaFlaN0ZiN0ZRV0lqTVp5?=
 =?utf-8?B?Nm9OTjRNWWJleHFOTVZFLzZDdE1Fcng0REJXUFRYMDJiWnRKN2R5OExZNURJ?=
 =?utf-8?B?K2JVWVMzMUM0NTFCdG1aU2Z6VTFhZkk5Y0UvWEtmS1VXaEozQjB0Q0x6dVkx?=
 =?utf-8?B?a2FySE1MNUNWMXpvODY5aWhIUnQrZ3ZLckhudStBY2dCNlVjZmxsVzJDWWEx?=
 =?utf-8?B?TzcwNzJLMGZITnBSU0FmWHY4N0VuanFLZ09UcUY0UGpQdlRPK3I4QlIxcWw1?=
 =?utf-8?B?WFA1VjdaT2E0SCtlZmJrRkIwYlhjcUVHdFV1WGYreVhPL0p4c1dnazg1ZUwx?=
 =?utf-8?B?N0J1Y0FGMjdYY1JoejR1ak12TVNGb2JvdmVmTDY4eHpueE1SdHh5cTBaZVlI?=
 =?utf-8?B?VGFZMnFMVTBCVmhPZlduaHlmbWRQNTMxZ0trRFQ5NGVIcFJUdStGaENjZTJm?=
 =?utf-8?B?MXBWWHZuaDB6bWhWV2NnOGJ6WnUvNUFVYnpvdDR1YXhxUUlzT1ZGYXdZL2NC?=
 =?utf-8?B?NEhIQU5HVDBwM1Z0TDlubldNNiswR1hHSjB4M3VtMmZQYldtckJFdmh5bE9p?=
 =?utf-8?B?dG1QOEFUdU5uaFVQOTdOR3Vmc1VKQXdLR2NlRDBGWTk5V3dhZTRXSjY4bmsy?=
 =?utf-8?Q?rcirHXPVj8I9NCnYo9ckdTc8d?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff6b236-49be-4f59-bf1c-08de39cb8055
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 22:12:12.9217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rz3KAEDmrc32YfMh2IkEc33joqgFOajYGY0P+wBKsNjRKNnfdov6mcJMHr7YgIJPG+PA8mvmnKRLDcukfA0GoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6800

On 12/3/2025 4:50 PM, dan.j.williams@intel.com wrote:
> Smita Koralahalli wrote:
>> If CXL regions do not fully cover a Soft Reserved span, HMEM takes
>> ownership. Tear down overlapping CXL regions before allowing HMEM to
>> register and online the memory.
>>
>> Add cxl_region_teardown() to walk CXL regions overlapping a span and
>> unregister them via devm_release_action() and unregister_region().
>>
>> Force the region state back to CXL_CONFIG_ACTIVE before unregistering to
>> prevent the teardown path from resetting decoders HMEM still relies on
>> to create its dax and online memory.
>>
>> Co-developed-by: Alison Schofield <alison.schofield@intel.com>
>> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> ---
>>   drivers/cxl/core/region.c | 38 ++++++++++++++++++++++++++++++++++++++
>>   drivers/cxl/cxl.h         |  5 +++++
>>   drivers/dax/hmem/hmem.c   |  4 +++-
>>   3 files changed, 46 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 38e7ec6a087b..266b24028df0 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -3784,6 +3784,44 @@ struct cxl_range_ctx {
>>   	bool found;
>>   };
>>   
>> +static int cxl_region_teardown_cb(struct device *dev, void *data)
>> +{
>> +	struct cxl_range_ctx *ctx = data;
>> +	struct cxl_root_decoder *cxlrd;
>> +	struct cxl_region_params *p;
>> +	struct cxl_region *cxlr;
>> +	struct cxl_port *port;
>> +
>> +	cxlr = cxlr_overlapping_range(dev, ctx->start, ctx->end);
>> +	if (!cxlr)
>> +		return 0;
>> +
>> +	cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>> +	port = cxlrd_to_port(cxlrd);
>> +	p = &cxlr->params;
>> +
>> +	/* Force the region state back to CXL_CONFIG_ACTIVE so that
> 
> Minor, and moot given the follow on comments below, but please keep
> consistent comment-style and lead with a /*, i.e.:
> 
> /*
>   * Force the region...
>   
>> +	 * unregister_region() does not run the full decoder reset path
>> +	 * which would invalidate the decoder programming that HMEM
>> +	 * relies on to create its DAX device and online the underlying
>> +	 * memory.
>> +	 */
>> +	scoped_guard(rwsem_write, &cxl_rwsem.region)
>> +		p->state = min(p->state, CXL_CONFIG_ACTIVE);
> 
> I think the thickness of the above comment belies that this is too much
> of a layering violation and likely to cause problems. For minimizing the
> mental load of analyzing future bug reports, I want all regions gone
> when any handshake with the platform firmware and dax-hmem occurs.  When
> that happens it may mean destroying regions that were dynamically
> created while waiting the wait_for_initial_probe() to timeout, who
> knows. The simple policy is "CXL subsystem understands everything, or
> touches nothing."
> 
> For this reset determination, what I think makes more sense, and is
> generally useful for shutting down CXL even outside of the hmem deferral
> trickery, is to always record whether decoders were idle or not at the
> time of region creation. In fact we already have that flag, it is called
> CXL_REGION_F_AUTO.
> 
> If CXL_REGION_F_AUTO is still set at detach_target() time, it means that
> we are giving up on auto-assembly and leaving the decoders alone.
> 
> If the administrator actually wants to destroy and reclaim that
> physical address space then they need to forcefully de-commit that
> auto-assembled region via the @commit sysfs attribute. So that means
> commit_store() needs to clear CXL_REGION_F_AUTO to get the decoder reset
> to happen.
> 
> [..]
>>   void cxl_endpoint_parse_cdat(struct cxl_port *port);
>> diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
>> index b9312e0f2e62..7d874ee169ac 100644
>> --- a/drivers/dax/hmem/hmem.c
>> +++ b/drivers/dax/hmem/hmem.c
>> @@ -158,8 +158,10 @@ static int handle_deferred_cxl(struct device *host, int target_nid,
>>   		if (cxl_regions_fully_map(res->start, res->end)) {
>>   			dax_cxl_mode = DAX_CXL_MODE_DROP;
>>   			cxl_register_dax(res->start, res->end);
>> -		} else
>> +		} else {
>>   			dax_cxl_mode = DAX_CXL_MODE_REGISTER;
>> +			cxl_region_teardown(res->start, res->end);
>> +		}
> 
> Like I alluded to above, I am not on board with making a range-by range
> decision on teardown. The check for "all clear" vs "abort" should be a
> global event before proceeding with either allowing cxl_region instances
> to attach or all of them get destroyed. Recall that if
> cxl_dax_region_probe() is globally rejecting all cxl_dax_region devices
> until dax_cxl_mode moves to DAX_CXL_MODE_DROP then it keeps a consistent
> behavior of all regions attach or none attach.

Thanks. I will restructure this and rely on CXL_REGION_F_AUTO semantics 
for teardown.

I wanted to check one nuance to make sure Im applying this correctly.

Consider a case like:

Soft Reserved spans (HMAT-visible):
SR1: 0x085000–0x284fff
SR2: 0x285000–0x484fff
SR3: 0x485000–0x684fff

CXL regions:
R1: 0x085000–0x274fff
R2: 0x285000–0x484fff
R3: 0x485000–0x684fff

Here SR1 is not fully contained by any committed CXL region, even though
SR2 and SR3 are. In this scenario, my understanding is that the global 
check should fail, and we abort CXL ownership entirely (tear down all 
auto-assembled regions) and proceed with pure HMEM, rather than allowing 
partial CXL ownership. Is that correct?

Related to that, the flow should be something like:

Inside process_defer_work()

process_defer_work()
	wait_for_device_probe();
	if (cxl_contains_soft_reserve())
		dax_cxl_mode = DROP
     		rescan cxl-bus (bus_rescan_devices(&cxl_bus_type);)
	else
     		dax_cxl_mode = REGISTER
     		teardown all regions.
	walk_hmem_resources(&pdev->dev, hmem_register_device);
         (Here we walk all hmem resources second time)..

and as you mentioned

cxl_contains_soft_reserve()
     for_each_cxl_intersecting_hmem_resource()
(Here we walk all hmem resources first time)..
         found = false
         for_each_region()
            if (resource_contains(cxl_region_resource, hmem_resource))
                found = true
         if (!found)
             return false
     return true

Thanks
Smita



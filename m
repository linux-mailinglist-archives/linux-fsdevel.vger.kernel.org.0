Return-Path: <linux-fsdevel+bounces-46211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 855A5A846E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 16:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32F4C4A14F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 14:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113691E5716;
	Thu, 10 Apr 2025 14:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lS/QJ8gy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC47621CC6A;
	Thu, 10 Apr 2025 14:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744296584; cv=fail; b=Fu3N3182VqdtypEvxTGE8Ph9tAIBY7o6c3QdNarwgqQCMyDa2n1wmqhG/bg9TFcyn0jYdrobe9ZNZHlOmB6UP22Q+wLCSsJoB4/Q1x/kTuYGI0ng+nYi9igNqbdXnfzjBQo9u8d36cyAf7VFKkvnVpmL8TFf9/7VbvoDfULCQrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744296584; c=relaxed/simple;
	bh=gcSRO/t9AiA/mcXhTTSdnASm4D43GRzQvssHWWMi5Ms=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RahpQ5dR4guaqbznc4ie93uqfZq+1kRxreZMKrTg+IILV7ZIdnepEmT3cHFeQRGZWcTZ3A44zknbTETn8KLYU2ttVpVaAGxzE6fTycvNWYu45Gvq5Pnj0tJ74EVkN9Ke/4RuOWPXDT89f3c4vl3hGu5PQcfv118rJolCu87zZxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lS/QJ8gy; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yKsAPELXeydCjGtDH7GpAS5CapJjuAU8EWwz7RwPVsTnsiwxTn71nA2K2x13hCl+VBm2aUXmszrtPrb81XN1Us0T7Df3LIQLiXqBdTdFL6V7rwnvpZlNbiMLZTGHNH0UWRpLpBc6H7YALlgBC0HApSpv5AJqlaqJV++3CzG4l6AmHtCcOTIQFrbee3huc+5srTwaKFa1nbh9ve+KQXZ5kHsNz8qtzRoII4JKdf32YpKHAaw2K8dN3MrtBeytYzMy6Cgyc8utL/UAi1L4O9shMm0FfoG0rgu/6H/9j9Q+YzIqzDhOFSAq1aQSGb72LsvCVsG3zvBQ9XaBvh/WLS3KZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVyjCCUaiAmR57OP1QK+gfU98G4V3ot+88RzjwMdA1o=;
 b=dTkLqS3HC99dYHbQ3ugJs53y7nX7i+GYpYY3jSGKB8j7mhvTwSajcFrEDcnyAdn0ZEGlywUwEQ/N97LeldTjFbBcJH6PZlUqeFBRyqGkv3Y6rPK6jxaz/AVrnpqgqe7Ymzl3qvrQBYbCs6GwKZ4FwgXHeM+TYIA3w3mXe43fuFIMhvFmujpHOzaGNbnt60Tc8CaHq2XLRZtFa2u9L84EkhW80nUJkIsXvzZ+gfG/e6MOF56x9XhKhiV7X3QO6fqfmW5+H/dzPrS1DXl1Dq884tjRc6Vav+KKPtCKMvfEv/IVgjQA5tCI1/wSARe1N1q6XgDwhcITsUfU5OnRyyoBEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVyjCCUaiAmR57OP1QK+gfU98G4V3ot+88RzjwMdA1o=;
 b=lS/QJ8gyWZg5gfPH2dPUoabx+lqrJJWib9+vyY7iSpGf4MeQsSA2BlaAZKIfHVM3mGMtmQWJC5uciPYB3NvULwqh03Fg9HNKRKW0e5JHgxHneUTrXJBd5z22GeQpJsXHg/3frd49Q6zPFSYcGh88rkSLHo/wX9AcOI0nTolX+J0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SJ2PR12MB9088.namprd12.prod.outlook.com (2603:10b6:a03:565::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Thu, 10 Apr
 2025 14:49:37 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8606.033; Thu, 10 Apr 2025
 14:49:37 +0000
Message-ID: <04dac478-f734-4fb9-a792-d3f11be79657@amd.com>
Date: Thu, 10 Apr 2025 09:49:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] kernel/resource: Provide mem region release for
 SOFT RESERVES
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 willy@infradead.org, jack@suse.cz, rafael@kernel.org, len.brown@intel.com,
 pavel@ucw.cz, ming.li@zohomail.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, huang.ying.caritas@gmail.com,
 yaoxt.fnst@fujitsu.com, peterz@infradead.org, gregkh@linuxfoundation.org,
 quic_jjohnson@quicinc.com, ilpo.jarvinen@linux.intel.com,
 bhelgaas@google.com, andriy.shevchenko@linux.intel.com,
 mika.westerberg@linux.intel.com, akpm@linux-foundation.org,
 gourry@gourry.net, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org, rrichter@amd.com, benjamin.cheatham@amd.com,
 PradeepVineshReddy.Kodamati@amd.com, lizhijian@fujitsu.com
References: <20250403183315.286710-1-terry.bowman@amd.com>
 <20250403183315.286710-2-terry.bowman@amd.com>
 <20250404141639.00000f59@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20250404141639.00000f59@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0096.namprd13.prod.outlook.com
 (2603:10b6:806:24::11) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SJ2PR12MB9088:EE_
X-MS-Office365-Filtering-Correlation-Id: e31ffe68-5910-4f4e-746e-08dd783eea84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHVuUUFKeTB0WUtMRTNPSmlhNDNCMXVRdGFWU2hSOG4zbnlpYTJPencwYXBE?=
 =?utf-8?B?cHNzcHNhWUdDRDFkakNxVnRtR202cUx4aDRxNkkvdE1LdzVad0FRY2R3Szk5?=
 =?utf-8?B?M1dQUlpOVTBqZU5FL25YVmlYM1hsa2ZITHJMSDJWWWhCTzhUNm5Vc0U3YkR0?=
 =?utf-8?B?dlQ5RkxwRHZXbWluOERpN21yZTR1Ryt1b3cxT1U2MEtibE94bTI5bFVPN3BH?=
 =?utf-8?B?VlgxTGt2UUx6RElpTkE3Kys0dFJ2UTJFYjJnTFJIRjBFZGZYeUhmNDJ1OWhq?=
 =?utf-8?B?NFVKcnE4NTJVbEg5UGZ0eDVidXJOVVNZR1FyRFlSZDRoZ2JyaXd2SG9KT3Ir?=
 =?utf-8?B?TzdHWDRDaHc5S0l1ZkpUdEF0YzFTcjFVREI0WDRteFl5N2pKOEYwcnl4amhv?=
 =?utf-8?B?L3lqdmpQdENNYUg5TndtQVdYWERXTTZzUHFvQlB1WEdKNEFBNTJYaWhFNTVC?=
 =?utf-8?B?MGFMRUh0RytZSFRrU05RcWNRQVc4amhieE5IaFR3dVE3SkEwYnU3Z1BoNXc5?=
 =?utf-8?B?clFrR1dGSXB0WGgxcUdrTnlENFg3S244ME9lSGRqaGdNblIyY2treGxnQzQy?=
 =?utf-8?B?clc5eXJQRk56anIrUVdQd3BqMXZzM2k3bm85Yi9hRUJMZTZvcEU2R1liQ2d4?=
 =?utf-8?B?TXFjWlZadVNPSUZobFkzOUdVa2ptOTBLWHZuOU1LMWp3UlpHelJRanFkOU9S?=
 =?utf-8?B?S01yajJSZGpMTmtTb2g1N2NjWXlRM0xjNURYSm5uWWdMZTFaMjRqUXJ5Vmtl?=
 =?utf-8?B?TC96N3VBdkYvQkFyOGd0YXhUakpQbURqN1NNRjBxenVjbGxSVUREY0hKb1pK?=
 =?utf-8?B?V2ZEVGpFdVc0aWUyY0ZIK3NoaUpyTWQxOC9jYW9LQTNBMjd2TElhOUJwakpY?=
 =?utf-8?B?QXhGREg3Y29PYS9ham5OaThkSWdGSXhIdkcvY2hsWnBSUjdpL2tBVFZaRmFE?=
 =?utf-8?B?ZUU2Ukx6ZXM4QnJMRmxDTDQwNzdINzRaZHV1WFQyVURzeFhjNXdodlI3TXhh?=
 =?utf-8?B?Q1hmQ1c5U1FvVW9yS2NxeXo1Tmw2WkRJNnB3RElscVIwY3VxV284Rjd3Vmln?=
 =?utf-8?B?VG80NUhKUDRTNldISVIxclBXWVU0TnQ2ZEtwNDRSeWJ0UnZvVVhYTWhEd1A3?=
 =?utf-8?B?KzBtS2p2bnpIU09PRGRTeTFKekNGaGRKOXIxRm91ZVMweUxsbm41OC9SK1dD?=
 =?utf-8?B?eUxYM0JmcXBHUkRoZi9CL0NmSzc0Sk53TWpsWWlWQnFTd2h4c2xpRHN3NGlj?=
 =?utf-8?B?UzVOWk5vQktGMUtORmRLcDg5SWVKdEV1anN3c2dMcVphRmNlMXZBcWVUSk02?=
 =?utf-8?B?QWpMNFRFb285ZFkxYmlsbVc1NnZTSGU5cjNBWUtuOVNhSnNhVGtlNnd2ZnY5?=
 =?utf-8?B?eC8wSm1WaE9Ua21sT3NIR1EyRnVvSzlyWHpyaDNBQmp5andMa1VGWExjNlIr?=
 =?utf-8?B?NHhJTHJPak9zR1g3S2xyeHlZamZRczRubmdJdW9ycmtyMnVydHJNRTUyU3Qz?=
 =?utf-8?B?K2dXWDNPMXY0clQ2QTVHNGk0YXJpcm1WdkI5eDlKa0IyK01PNWVzZGp0b045?=
 =?utf-8?B?d0VlWUtNWThtWml1MGFxYnRpeThnaUU1M2VOWEY5MlNQb3hrcGd5M0l3azUz?=
 =?utf-8?B?OTcwS0R6VHN1UUFLbmdTcnpDeUpkazZyYVFHT01hdmRhTTEwM3JqazJlVmxu?=
 =?utf-8?B?K0c1RnRWcDJMTlovdWtheS9naWxSOFdzbVVVU3czRW1lM2lRdmdtUTNvcTVl?=
 =?utf-8?B?NWNWQk80YzNOOVpSQkFReTlrQ2RkMU9ld2ZSdElORWltb3JkajFTZ2VFekk0?=
 =?utf-8?B?V2RsL25rQkJpWGZxQmhlRk9FVG41MzJHMHVCejFoYnBudEMzS0hYTmlNNDRh?=
 =?utf-8?Q?uuOQktnnR+2C5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHRvOHA5eUVPRitJZE5Yd3JqVEpOaDRqS1JtUlB2WFRhRHZnTk5wYkpHSmUw?=
 =?utf-8?B?Yk1xZk5PS0JUb3VWckh5ZFlKYzk1YVkvTW9kM2huTEUyK2g1WGttRW9PMkda?=
 =?utf-8?B?OTJqZ1hlMUJmSUpRenJhRVM2Y2JpKzRDS3UxMUdHakN1bmNrQU5hdzlFM1di?=
 =?utf-8?B?eDIrVFZzZHQ5NWQ0c2VKUEZDci9wOHVyQW50Q0FKTGZ1enFlQjdzN1hoTDF6?=
 =?utf-8?B?SWEvcU9iVkNoVmtuZ2xUdGVMcXFXa2ZzcEZFMTlNa0dPOFEzQk9xUklibDIr?=
 =?utf-8?B?Q0p0cnZKeC81T1FZZzZWa3FJTEFrSUhQUURvZ25JQzhIQ0hGeWFSVndVVGNS?=
 =?utf-8?B?bXBPZTFiQnRNV2xLcEFFaUpCS1o0NWFmSnNnVEQ3L0VVVUhtM1Bac2NZakpN?=
 =?utf-8?B?Ymxhc25yWkVKSkd0UXkyQVdDdGU0aWV0MGRQdkl0NmxlZlgzRmo2WC9NUHZI?=
 =?utf-8?B?SGdUYlFvMFcwOUpMUm1OaVYyQlZvN0w5anBONCtqenl2czR3VnVHbTUzSHJh?=
 =?utf-8?B?V21wS2phUWJROGNyaEZJeE4zQk4rUUMrakJUaW9tOHRxaURjMDUvbFpXWXMv?=
 =?utf-8?B?ZWNPQ2hkQVVEWFZVSXoyWDlMZGNpMEZGb3VWVWlZVmhKMnNweTRBb2MyYUM4?=
 =?utf-8?B?NXY2ckVTRTJOdlRuZXRmbUlVcS96NVd4QWY0RDUwbkJHa1lqN2M2WlAwcXZH?=
 =?utf-8?B?RDBua1NBL3ZMTXBvem9vUzlHdVlIV09mUmVEQWw0alNpNFpyc3hDK0ExeHBL?=
 =?utf-8?B?blNDTHc0dUo1MXh4aHpuZ2ZPU3JoMHQ1MkpNa3BKUHRIRk5LZ0NjNEFQeklT?=
 =?utf-8?B?eDk2SjMvWjl4SEt6dGNWVFZWTWxaOEVvMWlsUUZRUk1HQ041ZnlWZEp4Z1c2?=
 =?utf-8?B?SThOVlMyamtWU1NFbHdQMTFYanJveUVrU0h3RERCOGZOUThwYjNlQ3FQMFpm?=
 =?utf-8?B?RE51RFZhelBhaCtLeVRWNi9HMGRyVFc0Z0tXSCt2L1FBRy9VVTREVDd2ZVVB?=
 =?utf-8?B?b2FDS2d2cDVQeVdLcjRVK25wSXJNOFAydXN5Vmt0akJPc3lXaklqNngrUzF2?=
 =?utf-8?B?MWJsQVcxbFFlMGNQUWhtZXVuSVVXcWNVbGdwZTNLYnM3WjM4Y3ZxUDBoYW1m?=
 =?utf-8?B?eHdPSzF6bFZlWi9obmtyTGFjVWYzTTUzWFdwK1N5OWMzZS82S2JteW1aZ3lk?=
 =?utf-8?B?VlFvNnNqdUhmdEpGRjNsQ3Azem1lUCtrRElsZ0lkWnV3YUE0RU5PSWkwZ1RR?=
 =?utf-8?B?TnJVdWtxVC80L1VPMVVjVzB2ejMzbmdGRmRmbzlDR1JFSld3YU9mM1RveFNZ?=
 =?utf-8?B?Z2VZN1lRV2VBYzJvS0Z2cDI3Mkt1dWJTanFnckhJbmpiTGQxVTE3Si9WeHhS?=
 =?utf-8?B?YWtUVHVqM2J6a0h4Vlc5TlNSMGo5UXc5QVdJTUJDckNxOXdSMU9PTGZyZlB6?=
 =?utf-8?B?MVQ3ZGtBUnR3MzB4K0p6KzVRbVBFRVJYdVNVZzlVRmcxbCtHeG85UE14UVdM?=
 =?utf-8?B?MTZaeWNIcU1MNnhDOG4zTG5zM0xtcnRMRndIeUxWc2ppbXJEc013ZkN0dTEx?=
 =?utf-8?B?V3Q1NnRsR1pBdi9ZUlJkcnhwZlNhcUphTHNUalYyMmZXdHBXNjRUclg1czBr?=
 =?utf-8?B?bzQxdVh2bjVGV28vSzZhVjNyZlJXOFpPZGNJZ0xCTXlhVkpGU0hsem1RakRp?=
 =?utf-8?B?MDYxQW0wWTBLUEJxODNYTUw1Tm83YmxzS01EeUNJUkNUREJlekVhb3VraWN1?=
 =?utf-8?B?YUtRaWRUWWsxNG1teTRvaHJEYVRmL0pjMWZnT1ExL2laTDFhbVFxbGJ1QXdG?=
 =?utf-8?B?K0lObDdkWHJqTFpXTFV3NFdETHV3VFp5T3cxV3o3SFVIZStsbStDb1gvaHVH?=
 =?utf-8?B?TGQ3dU9hSFhqS0gzQlhjQ3kzR0pEOTdySVZnWkRMVHB6bkdGa0U4UDI4OFZa?=
 =?utf-8?B?dUkxaGU4WUo4VFFoS3llRkJSUFlsY3JnWUF3R0x0VEdETkNaYnZ2QllvcWJY?=
 =?utf-8?B?OGdJZlZJdk9pTWRxTysycHR4QUUxeC92YzROeitONWhUQTNtS3o4b0lXQmlM?=
 =?utf-8?B?VVhOUkQ3TGsvcTBWeW1Vb3IxQ0oyYk1BQmF2Q2Rkd2ozdG5TbjZlaFh6QVRT?=
 =?utf-8?Q?145fUIWhdWaQvgmK6Zi6v9mwU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e31ffe68-5910-4f4e-746e-08dd783eea84
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 14:49:37.6849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r12E6QZyjcLERhG6eEyAvpS7zQi6KxIGf6S9gpIWWRlSULfeQhWRpBwA3mdTgDPXSfLt7vG6hVRipaPp4LWtWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9088

On 4/4/2025 8:16 AM, Jonathan Cameron wrote:
> On Thu, 3 Apr 2025 13:33:12 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
>> From: Nathan Fontenot <nathan.fontenot@amd.com>
>>
>> Add a release_Sam_region_adjustable() interface to allow for
> 
> Who is Sam?  (typo)
> 

Hi Jonathan,

It is a typo. I will fix.

>> removing SOFT RESERVE memory resources. This extracts out the code
>> to remove a mem region into a common __release_mem_region_adjustable()
>> routine, this routine takes additional parameters of an IORES
>> descriptor type to add checks for IORES_DESC_* and a flag to check
>> for IORESOURCE_BUSY to control it's behavior.
>>
>> The existing release_mem_region_adjustable() is a front end to the
>> common code and a new release_srmem_region_adjustable() is added to
>> release SOFT RESERVE resources.
>>
>> Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
>>  include/linux/ioport.h |  3 +++
>>  kernel/resource.c      | 55 +++++++++++++++++++++++++++++++++++++++---
>>  2 files changed, 54 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
>> index 5385349f0b8a..718360c9c724 100644
>> --- a/include/linux/ioport.h
>> +++ b/include/linux/ioport.h
>> @@ -357,6 +357,9 @@ extern void __release_region(struct resource *, resource_size_t,
>>  #ifdef CONFIG_MEMORY_HOTREMOVE
>>  extern void release_mem_region_adjustable(resource_size_t, resource_size_t);
>>  #endif
>> +#ifdef CONFIG_CXL_REGION
>> +extern void release_srmem_region_adjustable(resource_size_t, resource_size_t);
> I'm not sure the srmem is obvious enough.  Maybe it's worth the long
> name to spell it out some more.. e.g. something like
> 

Yes, I'll update with a re name.

> extern void release_softresv_mem_region_adjustable() ?
>> +#endif
>>  #ifdef CONFIG_MEMORY_HOTPLUG
>>  extern void merge_system_ram_resource(struct resource *res);
>>  #endif
>> diff --git a/kernel/resource.c b/kernel/resource.c
>> index 12004452d999..0195b31064b0 100644
>> --- a/kernel/resource.c
>> +++ b/kernel/resource.c
>> @@ -1387,7 +1387,7 @@ void __release_region(struct resource *parent, resource_size_t start,
>>  }
>>  EXPORT_SYMBOL(__release_region);
>>  
>> -#ifdef CONFIG_MEMORY_HOTREMOVE
>> +#if defined(CONFIG_MEMORY_HOTREMOVE) || defined(CONFIG_CXL_REGION)
>>  /**
>>   * release_mem_region_adjustable - release a previously reserved memory region
> 
> Looks like you left the old docs which I'm guessing is not the intent.
> 

Correct, this is not intended. Ill remove.

>>   * @start: resource start address
>> @@ -1407,7 +1407,10 @@ EXPORT_SYMBOL(__release_region);
>>   *   assumes that all children remain in the lower address entry for
>>   *   simplicity.  Enhance this logic when necessary.
>>   */
>> -void release_mem_region_adjustable(resource_size_t start, resource_size_t size)
>> +static void __release_mem_region_adjustable(resource_size_t start,
>> +					    resource_size_t size,
>> +					    bool busy_check,
>> +					    int res_desc)
>>  {
>>  	struct resource *parent = &iomem_resource;
>>  	struct resource *new_res = NULL;
>> @@ -1446,7 +1449,12 @@ void release_mem_region_adjustable(resource_size_t start, resource_size_t size)
>>  		if (!(res->flags & IORESOURCE_MEM))
>>  			break;
>>  
>> -		if (!(res->flags & IORESOURCE_BUSY)) {
>> +		if (busy_check && !(res->flags & IORESOURCE_BUSY)) {
>> +			p = &res->child;
>> +			continue;
>> +		}
>> +
>> +		if (res_desc != IORES_DESC_NONE && res->desc != res_desc) {
>>  			p = &res->child;
>>  			continue;
>>  		}
>> @@ -1496,7 +1504,46 @@ void release_mem_region_adjustable(resource_size_t start, resource_size_t size)
>>  	write_unlock(&resource_lock);
>>  	free_resource(new_res);
>>  }
>> -#endif	/* CONFIG_MEMORY_HOTREMOVE */
>> +#endif
>> +
>> +#ifdef CONFIG_MEMORY_HOTREMOVE
>> +/**
>> + * release_mem_region_adjustable - release a previously reserved memory region
> As above. I was surprised to see new docs in here for an existing function.
> I think you forgot to delete the now wrongly placed ones above.
> 
> Jonathan
> 
Right, I'll remove the now old function comment.

-Terry


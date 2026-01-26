Return-Path: <linux-fsdevel+bounces-75456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGrLEphcd2maeQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 13:22:48 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA64F88262
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 13:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B1D43043030
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 12:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FB33358BF;
	Mon, 26 Jan 2026 12:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wAG8a206"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012012.outbound.protection.outlook.com [40.107.209.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B66E55C;
	Mon, 26 Jan 2026 12:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769430016; cv=fail; b=K8jwvEIrEnxyHazXS8JT4YgI5hQW7/k4kYVYwu0PB4xqWZd0cry6o8tG9CTAvp41y4ou7Rk9ey8HSqyvfC4BlkK5RvaT0gwYT2APcawNnLnjKhp0eg5Szm+Zbfm1tsV1asRKNx2PzgXojhK56r2v7agqN4NphP013nL8fwaHR00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769430016; c=relaxed/simple;
	bh=muMFXQNOo7Xdy5gC/gx2B7sGezvT5Lc8b4VLWfTv9G0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SaiBJmrl1dCDxGYkQBqiYlN/LITExbNQv8YqXLLwBLm7j7hBOfX7R9GWjhumGqLkRDjO73xmSRVYre8rEP73y4t+XYnRP+R14gDsy97CHgHpwsyNo+x9ZjMd6Nd6lMMCHAHfJH8xZ7PGOkDcI+kAUdGsbTzNj7k9LXhVUC8qwkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wAG8a206; arc=fail smtp.client-ip=40.107.209.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VDRzp26nwtk7YoVGzA/lf1/6GZ36vOWi/Ll8dbzZ1pxTN+1cddroxEBuBAlnc6Bw4WEVSg1/6b9cQt83buv/etn/EW+ggEKK24r7fDWTy3j+ZhPHIne6lYDLoJSyfH4Tu4kPSmvBEyhWdkGADeQB5/JVxGiPV5bHX8DLii5q8414pqd9IbC1M8UnbzcyyAq3wDR2O0nNL/LsSXRPaHChBfObJuFiFbv2A0wy+omhuE2huUGZeOX3nZw6WTI3lqCOmvi1kxtO8+Xqk4XZCl9d2GidTmxNx3OynUUhTWadCA/YqWjALN+0hwGMKO8sZhaVqhX61PkbazXA0YROkdb8bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YFBIVEWQwIq6wcHIge0c3hp2QZkf4WhF6uw4p6sKEeQ=;
 b=S5UYAmC0YGxAiwRVSUl8YF3umDdztBWAD/rZYr4YhC4id4ULDnMcJrRLVEOYYx7gEgYDZZsVRorQC8sH+MHzNPpHTVURnQYvcL/gFPKwLaVoeGy6w/gExboEy7dxf02Vzl35ePXCdEdTbgeM7JBCgoc5QgEnacdy423gf7txlbuHE3W8GJ6i/4vkZ97A6DQTov0qckw6ODzrq4HwVUFTj5wO2K/bMz8SnFZv2PKX9G8HMOTpQEAgJYuDKGsH8j3Cq1hJVTxkB5Qbq9w4YbzNpR8/ARSvmKMkbEsZZJOw/0FBd9NrcAmfThNbHp5vaTrmck/ErlpfjIxamyWQAOKnhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFBIVEWQwIq6wcHIge0c3hp2QZkf4WhF6uw4p6sKEeQ=;
 b=wAG8a206JP6tYZBIuQySSKUXer0jVRxchdJ5KKzE/NRYVflz2gIOaDF0BkilpA4J+4MTJyiV3jB/E274j5fi7yE3jICPkJyY1sM5U6Y9+3dRs2JSOSr2ARVl8eTAfJ+8KWlJ+h3EX5Z3OH4ZJHvQ5Xy8gRjS7wxfMC0qQxk+qRo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SJ0PR12MB5661.namprd12.prod.outlook.com (2603:10b6:a03:422::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Mon, 26 Jan
 2026 12:20:11 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%4]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 12:20:11 +0000
Message-ID: <9ee0eb8b-9559-495a-8710-730e7f27d8a6@amd.com>
Date: Mon, 26 Jan 2026 12:20:03 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] dax/hmem, cxl: Defer and resolve ownership of Soft
 Reserved memory ranges
Content-Language: en-US
To: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Matthew Wilcox <willy@infradead.org>,
 Jan Kara <jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>,
 Li Ming <ming.li@zohomail.com>, Jeff Johnson
 <jeff.johnson@oss.qualcomm.com>, Ying Huang <huang.ying.caritas@gmail.com>,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nathan Fontenot <nathan.fontenot@amd.com>,
 Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
 Benjamin Cheatham <benjamin.cheatham@amd.com>,
 Zhijian Li <lizhijian@fujitsu.com>, Borislav Petkov <bp@alien8.de>,
 Tomasz Wolski <tomasz.wolski@fujitsu.com>
References: <20260122045543.218194-1-Smita.KoralahalliChannabasappa@amd.com>
 <20260122045543.218194-7-Smita.KoralahalliChannabasappa@amd.com>
 <e38625c5-16fd-4fa2-bec0-6773d91fd2b4@amd.com>
 <84d0ede7-b39d-4a41-b2b6-8183d9ccbb9e@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <84d0ede7-b39d-4a41-b2b6-8183d9ccbb9e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU7P190CA0020.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::34) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SJ0PR12MB5661:EE_
X-MS-Office365-Filtering-Correlation-Id: 01e9a77c-9c0c-4848-64be-08de5cd53ffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZnQzMS8rWmFRNC9Jelhsem1zL0lnVjdPSkJLUmNvS2IrVE85YkM5RlphcEdX?=
 =?utf-8?B?ZUlUcWJlUkdxakV1SFYvRXByaEY1TXZuWll1S3M4NEVHZldLcFU5NWhZOWUv?=
 =?utf-8?B?RG11ckNmc3ZnQXNMTjNwTUxZS0FqRllISFRaZnhwOG02dlJpNWFOb1ltZWJQ?=
 =?utf-8?B?NzZRK1d6Z1FWbzhTdlpRQU9YaU5kanZsc3dvUGtrNDk0RUhRNkU3eDNOUnh5?=
 =?utf-8?B?dWQ3SUVnUVoraitHYnFOVTR2eWphdnIrNGJWb3JjdkdCdW1QSXRaOWV0a0tQ?=
 =?utf-8?B?SkQzUVFlUXpVeWRrbTc2Qk5VYkYzT3hVZlJISml4M1ZJUGNFYVZqbnN2TnBq?=
 =?utf-8?B?MnR4YkpFU2hrZjVIMEhlY2s1RmRrWXhuWFFoSVdVdUdtVnVQUGtxenNESk8r?=
 =?utf-8?B?aFUyRjJLRHBvR296V0gwTitSOUVPYkZ0RmdETjh5K25xL1IzRkFBT0R3NXc2?=
 =?utf-8?B?dXhjelc5VzJ1MFhXcnJqVEpGa0JKN3paa2FFUXA1d3Y4MTdoQWVNTmhSa3FW?=
 =?utf-8?B?d0tlWjBqbWZ6QnB2ZW5ISjJxN1RrZE1oMkdoOHRZajJhR0hFczl3RVNaTGRR?=
 =?utf-8?B?dS9XamF5VW1KUXhIRVdRa01RZHhRM001UURSenFTcitPWXNxd0w0UnQ3VE9F?=
 =?utf-8?B?Nm1lZFovdzBTQlAzSE1LaHBhSHJEOGRtZ0tmUTRsLzFJMU81OXF6YjkwMC92?=
 =?utf-8?B?MnBDMUlqZGVjOWRzclVObGs5dGg4MWNGZU81dHl2d2JjSGdRdG1uMkdWUlli?=
 =?utf-8?B?SnZGVkJTZkJzWTU5aWhodzRpU212RU5pQ3RnNmY5dTNBMHdjdWJwb2JNZ211?=
 =?utf-8?B?a1lEUHZGMWN5NTFoQ0dhOHFJYjBiQitLSnp6azN6b0N5N05jc1dUbmJxMjMv?=
 =?utf-8?B?WThheVJIaGdvODlwT0Z2dDliOWhIdDVmSmh4MHZoT2pqRVFmVS8vVnNwZ0lW?=
 =?utf-8?B?d3J5V3dxMUlHQ1RaSm9NTzc5VHFmbXVDTVJwK2ZLQS9sWjUyY1F2WjZ2OHFp?=
 =?utf-8?B?aTlNbTRRcmtBWWZSaDB4NlJIbkJGYWRBM3BQbW0vU3FwUVFFcm9EbUNacHFF?=
 =?utf-8?B?U3VvVnFyUm1IUFBSMVFEcThYVFlEZkN1Wm8zakpBbWlrM095NzZXOVorMXdD?=
 =?utf-8?B?ei9pSk9ZbU44TGJOS1dPT0NVNTErNEZHdjNPbmxCUU9qVXF6ZndOekxJUFF4?=
 =?utf-8?B?bG00YWVHejlyeXUwQStSRDRGU0VyQjNPaFhlNHJZWU9MU1RaWCt0YlJYdnNl?=
 =?utf-8?B?Tzk1ZDdUUUJmM2lNd2FOY2VSSVh4eUhpZzczcloxUTh6QjlsK1pKbHFaelZF?=
 =?utf-8?B?bWNjME9hMi9MdG5Da3RxWHVmMGVCMTVMUzdxK1R1WGVGR1daWGVuOFhmdElX?=
 =?utf-8?B?QTllTy92S0VWWXdUZHFEdFJXT0RZRjczSDN4c0R6M0lQT3dRTWdkWmt6NEFi?=
 =?utf-8?B?VGUxQU5iaUVoei85TFhmVjJtVmJ1bjlPZjJYdTk2UXA4bjczNTdLTXBmRmY2?=
 =?utf-8?B?VS9BeXl1OFE5bGRmMlE0akQ1MTBXUGZoN0tka3hXbVJWaVZ3ZWpKQ2YxcU0x?=
 =?utf-8?B?ZTFCdjBvYTZFbzZ0am1ObHFUbUsrK2FPYVlzNHZpbFI5MC9uT0lMTzVnL1NU?=
 =?utf-8?B?Y21PZlYyU1I0OFd4Q0w3Z2sxZ2Jma2tzWVZFRlhZTzh4S2tIMkQ5ZlVZYzhq?=
 =?utf-8?B?QXpMclVQeTFzOUdxeU4xamUydHdWS2QzUUdlejhOTFhXbkFuNjQ3Mnk2M1lq?=
 =?utf-8?B?aEdlUC9WSkFKcTZjZVh1SThCWWk4eGV0TjFyWjgwWGpDa0NKOE80ZU9PME9l?=
 =?utf-8?B?ZjRCb1RCZzl0NEZIREQyOTd2MmVyN3RrcUNSbS9sYUlVZWxyelVZSFlGS1Bt?=
 =?utf-8?B?ZVZ5Rnk0WXd5RVM0dDVCdkhSclJIRjV3elQ2bUozQzBhMTV4WkNjUW90dHR6?=
 =?utf-8?B?WlFQS0h3Q3dua0pSeklTRmRwRVFPcEZycFBSMDRmRWlUZGZJUUNSQ1VPT3FM?=
 =?utf-8?B?VW9uQXJ6MzJjbWZkbEN6Rm8rblhKN211WFpqNnZYRk03emFFVFNndVA3aDNk?=
 =?utf-8?B?ZUNGbGg0VEM4Ri80UW1tdW1hY2w0ekdHQXc0R2EyK0ZRbjJ1VXU3OVhPUTBk?=
 =?utf-8?Q?ki68=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDl5RytLdWZSRzJDVlRVbytyOGtlM0VreStLN3pNdWxjQmZhKzBrUTIrYWYx?=
 =?utf-8?B?Zk9RTGM0cFFRSlRQYVRuak5US21seElvSHZmY29rQ1VyVlM3MzRZWlczeVZr?=
 =?utf-8?B?NjlscVJFOVRKYXJ4cEZiZWMzUzAyVUh3RjZERStyNTgwNDMya2xvUElQemQr?=
 =?utf-8?B?NlBMeU5kRUg5WUpxOStPb2dYdk1LQXRld0pJY1Q1dkQ0dXh0eVN2ZEtHT0hZ?=
 =?utf-8?B?T1lXUDFjNU5kR3Vvc21ydS9hMDhrRVU3MWw1cGUwK3dPL3BYVWRJaFNsOFRq?=
 =?utf-8?B?cXVtN1dUYWwxbWkxOHZrSkRsMDJ5ZHJHeUtsMTlKeHJ4VllXcmxXZWlzQ2Rr?=
 =?utf-8?B?Sk5hMy9mVC93eURCWXdOUVQ2RW9QYWk1dFQyaSt4YkFTSmlqbFgyS3NCVjB3?=
 =?utf-8?B?b3ZMb0NrYVRqYUZYMXE5dU9QRnNCQWp2MW5ZUG5NTitYTTBhL1RGc2tXcE9G?=
 =?utf-8?B?c0xuOWxCUG85VUt5alU4MHdEMU1waXpnY0ZZMU9IS0cvVlhPQTNhRjlMdS9r?=
 =?utf-8?B?Q3E4eTNsbzMxZ1kxK3d4K2dlNUdCWTNNczBaS3hNV21HdFFsL3FlK3lRREZk?=
 =?utf-8?B?Zno0Uk94UmVYS0hPbTYyUW1YTk5pRklPY2FHSCtnV2UzRHJCb2ZiSnNCUS9G?=
 =?utf-8?B?RnFzQnN3b1ZKYWluNFY1Vm83R2ViYkcwU3BGVjdhQkNSV3B1R05qT25jWGdN?=
 =?utf-8?B?bThtak80SXE0WlBaU1pVZUxBa2RUU3lBc05qOUhpR1VrR1lKcmZUeG9Sc1VC?=
 =?utf-8?B?QTZPcFhSbHRWdFZvZ0FDTmxZOWVxOHZBMkZhYVZXcmNSZWVuNWFHNTJEa2pE?=
 =?utf-8?B?eTEzeDFtdThrRUlHWmlKR2lqNXFtTW9FRWd1SGlMNld6WWdTc0wzME53Y2k0?=
 =?utf-8?B?MzhDeWYzb2c3a1lGZDJKQy9IV2ZzMlhMemxCSTBoSTdZT1JmVW95cmtacnBI?=
 =?utf-8?B?MzBmSExCUFBhVVQ2R09mYy9USEJoa1FQakdzMFRNMXNKUUs2QXZyTGFBSWpT?=
 =?utf-8?B?Ym1oNEhtQXlvRlVqWElBVXVnZDRGa1h3M0U3TkJ0emVzS2lYMFFBQ3o0azdI?=
 =?utf-8?B?cFFrWVpnWUE0MXQ2WVJBZmRaTDJpMDJVbFZVU2JXd0R4TVUrY1ZNa3M3YlB1?=
 =?utf-8?B?NWVZaGVLR2MwRjVwdTJ1WGE5S3Q2UitIa0R2cEVNUzE2ODl6bW1UZFFQcTdU?=
 =?utf-8?B?MXhWa3VzdmVpNEdEbnBKMmo3TWRIWXNrSmh5d0pSNHc5NEh3SVUyQlNlbmZj?=
 =?utf-8?B?dzU1aUszS2F6ZGFycUFTQk43cXBWMEYwSFVMVnV1eG5ZTStUTHluUFIwVi81?=
 =?utf-8?B?V21DMVBCVWlxUHZ0bzcvQVdCU0FJcWZBc1lPODNCL3dQMnlsQzhDZG1sRDdY?=
 =?utf-8?B?OEtvdVJpamFmN3dhNlpqclN0ZUJzVWhhQi94UmpsKzNRVWZqR25wZFNPalBi?=
 =?utf-8?B?c0hQZ2Q5cEVvSXpveFZMQ0xVMStFTy9yVW96ZjRQVGdQcllYbFpyL2RxZXpG?=
 =?utf-8?B?NFZNQVNMbFROUDBEWVJTc2N0YzByWGpHcWticlNCNHRkeXlUS3BCUU9CcXlD?=
 =?utf-8?B?TkdkcUZCMis1VTZBVEs2YjgrVUV5UVcrRkVNWGxiaThPcjNwYzhYcTFvcnJE?=
 =?utf-8?B?V2lHT0EwdUZOTFo5OUpQVFdqZHJZZ3VKQ081UFF1aVZzM1RSUk9vendiWUgr?=
 =?utf-8?B?NkJuOEZIVXZiWi9SMHVoYWZqbkRsSlBpaVlOVG9jd09xSTQxME5URm5ZeWRX?=
 =?utf-8?B?UkJoVERkZ0RSSVlaam4zdG5xSDY0Tm9uNWF6MVF1VGVzMTk1YXhoMnFteTlu?=
 =?utf-8?B?SFJTL0xmbmMrWHJMTE4wcmd6WWR3ckZPOXZLSXRzK3hrMWl0MTdDbzFibnp3?=
 =?utf-8?B?cmIxaE8xL1p2aHplb2h5U1VDbkFjeXZnYUkvc3Q1ZzBlS2kvdDRabm5lTzVj?=
 =?utf-8?B?K1R5VXhERnU0WmlxdjViVUFFTEU0L3lKcVBjNURicXJWSzVnaGtSdERNV0s4?=
 =?utf-8?B?Y20rTmxrdnNwOHJ6b3FhQjR0aGJUYXVranJDZUNNWlhubysvWVJ3S0l2ZFVU?=
 =?utf-8?B?YW4zTzFNZ3lmdDRhdTV3ZFR4Sm1wUXJEWDJqelZRZS80OEJuZ3lQNmFZWGRP?=
 =?utf-8?B?bjBGZWNEYjl6WHVpeEdoRWNrN2VHUkpxT3FSeHJDbXNvV1h0Wk5EL25CQUJW?=
 =?utf-8?B?WHYrNEVaZ1FOVEVUOVQ3TmN0VVdhTTF1OEVyZkcwNGVSZUpWUStPVHk3WFBY?=
 =?utf-8?B?V0J4YTc4dlJ4STZtVVJ3Vkh6Rk40SnlXb3lsU0VuRXlLekVWWTdkZG5SQlFj?=
 =?utf-8?B?ZUwxZ0Zva2dJNWlyWkw3YUIyQkxiei9ad2pqc2hLTUYraENpSjJPQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e9a77c-9c0c-4848-64be-08de5cd53ffc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 12:20:10.8158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JH2TAOKFGMHW7TEsaQ7Pd4VNExSt/Lk9Pnbh00WEimSBqj8wyRQ8DStLxGwGl7fswkXPd5YPivoGliDyu4cgsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5661
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[34];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75456-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alucerop@amd.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,amd.com:dkim,amd.com:mid,intel.com:email]
X-Rspamd-Queue-Id: DA64F88262
X-Rspamd-Action: no action

Hi Smita,


On 1/25/26 03:17, Koralahalli Channabasappa, Smita wrote:
> Hi Alejandro,
>
> On 1/23/2026 3:59 AM, Alejandro Lucero Palau wrote:
>>
>> On 1/22/26 04:55, Smita Koralahalli wrote:
>>> The current probe time ownership check for Soft Reserved memory based
>>> solely on CXL window intersection is insufficient. dax_hmem probing 
>>> is not
>>> always guaranteed to run after CXL enumeration and region assembly, 
>>> which
>>> can lead to incorrect ownership decisions before the CXL stack has
>>> finished publishing windows and assembling committed regions.
>>>
>>> Introduce deferred ownership handling for Soft Reserved ranges that
>>> intersect CXL windows at probe time by scheduling deferred work from
>>> dax_hmem and waiting for the CXL stack to complete enumeration and 
>>> region
>>> assembly before deciding ownership.
>>>
>>> Evaluate ownership of Soft Reserved ranges based on CXL region
>>> containment.
>>>
>>>     - If all Soft Reserved ranges are fully contained within 
>>> committed CXL
>>>       regions, DROP handling Soft Reserved ranges from dax_hmem and 
>>> allow
>>>       dax_cxl to bind.
>>>
>>>     - If any Soft Reserved range is not fully claimed by committed CXL
>>>       region, tear down all CXL regions and REGISTER the Soft Reserved
>>>       ranges with dax_hmem instead.
>>
>>
>> I was not sure if I was understanding this properly, but after 
>> looking at the code I think I do ... but then I do not understand the 
>> reason behind. If I'm right, there could be two devices and therefore 
>> different soft reserved ranges, with one getting an automatic cxl 
>> region for all the range and the other without that, and the outcome 
>> would be the first one getting its region removed and added to hmem. 
>> Maybe I'm missing something obvious but, why? If there is a good 
>> reason, I think it should be documented in the commit and somewhere 
>> else.
>
> Yeah, if I understood Dan correctly, that's exactly the intended 
> behavior.


OK


>
> I'm trying to restate the "why" behind this based on Dan's earlier 
> guidance. Please correct me if I'm misrepresenting it Dan.
>
> The policy is meant to be coarse: If all SR ranges that intersect CXL 
> windows are fully contained by committed CXL regions, then we have 
> high confidence that the platform descriptions line up and CXL owns 
> the memory.
>
> If any SR range that intersects a CXL window is not fully covered by 
> committed regions then we treat that as unexpected platform 
> shenanigans. In that situation the intent is to give up on CXL 
> entirely for those SR ranges because partial ownership becomes ambiguous.
>
> This is why the fallback is global and not per range. The goal is to
> leave no room for mixed some SR to CXL, some SR to HMEM 
> configurations. Any mismatch should push the platform issue back to 
> the vendor to fix the description (ideally preserving the simplifying 
> assumption of a 1:1 correlation between CXL Regions and SR).


I guess it is a good policy but my concern is with Type2, and at the 
time this check is done the Type2 driver could have not been probed 
(dynamic module), so a soft reserved range could not have a cxl region 
and that not being an error. I do not think this is a problem for your 
patch but something I should add to mine. I'm not sure how to do so yet 
because I will need to do it using some information from the PCI device 
struct while all this patchset relies on "anonymous" soft reserved range.


>
> Thanks for pointing this out. I will update the why in the next revision.
>
>>
>>
>> I have also problems understanding the concurrency when handling the 
>> global dax_cxl_mode variable. It is modified inside 
>> process_defer_work() which I think can have different instances for 
>> different devices executed concurrently in different cores/workers 
>> (the system_wq used is not ordered). If I'm right race conditions are 
>> likely.
>
> Yeah, this is something I spent sometime thinking on. My rationale 
> behind not having it and where I'm still unsure:
>
> My assumption was that after wait_for_device_probe(), CXL topology 
> discovery and region commit are complete and stable. And each deferred 
> worker should observe the same CXL state and therefore compute the 
> same final policy (either DROP or REGISTER).
>

I think so as well.


> Also, I was assuming that even if multiple process_defer_work() 
> instances run, the operations they perform are effectively safe to 
> repeat.. though I'm not sure on this.
>

No if they run in parallel, what I think it could be the case. If there 
is just one soft reserved range, that is fine, but concurrent ones 
executing the code in process_defer_work() can trigger race conditions 
when updating the global variable. Although the code inside this 
function does the right thing, the walk when calling to 
hmem_register_device() will not.

I would say a global spinlock should be enough.


Thank you,

Alejandro


> cxl_region_teardown_all(): this ultimately triggers the 
> devm_release_action(... unregister_region ...) path. My expectation 
> was that these devm actions are single shot per device lifecycle, so 
> repeated teardown attempts should become noops. And 
> cxl_region_teardown_all() ultimately leads to cxl_decoder_detach(), 
> which takes "cxl_rwsem.region". That should serialize decoder detach 
> and region teardown.
>
> bus_rescan_devices(&cxl_bus_type): I assumed repeated rescans during 
> boot are fine as the rescan path will simply rediscover already 
> present devices..
>
> walk_hmem_resources(.., hmem_register_device): in the DROP case,I 
> thought running the walk multiple times is safe because devm managed 
> platform devices and memregion allocations should prevent duplicate 
> lifetime issues.
>
> So, even if multiple process_defer_work() instances execute 
> concurrently, the CXL operations involved in containment evaluation 
> (cxl_region_contains_soft_reserve()) and teardown are already guarded.
>
> But I'm still trying to understand if 
> bus_rescan_devices(&cxl_bus_type) is not safe when invoked concurrently?
>
> Or is the primary issue that dax_cxl_mode is a global updated from one 
> context and read from others, and should be synchronized even if the 
> computed final value will always be the same?
>
> Happy to correct if my understanding is incorrect.
>
> Thanks
> Smita
>
>>
>>
>>>
>>> While ownership resolution is pending, gate dax_cxl probing to avoid
>>> binding prematurely.
>>>
>>> This enforces a strict ownership. Either CXL fully claims the Soft
>>> Reserved ranges or it relinquishes it entirely.
>>>
>>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>>> Signed-off-by: Smita Koralahalli 
>>> <Smita.KoralahalliChannabasappa@amd.com>
>>> ---
>>>   drivers/cxl/core/region.c | 25 ++++++++++++
>>>   drivers/cxl/cxl.h         |  2 +
>>>   drivers/dax/cxl.c         |  9 +++++
>>>   drivers/dax/hmem/hmem.c   | 81 
>>> ++++++++++++++++++++++++++++++++++++++-
>>>   4 files changed, 115 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>> index 9827a6dd3187..6c22a2d4abbb 100644
>>> --- a/drivers/cxl/core/region.c
>>> +++ b/drivers/cxl/core/region.c
>>> @@ -3875,6 +3875,31 @@ static int 
>>> cxl_region_debugfs_poison_clear(void *data, u64 offset)
>>>   DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
>>>                cxl_region_debugfs_poison_clear, "%llx\n");
>>> +static int cxl_region_teardown_cb(struct device *dev, void *data)
>>> +{
>>> +    struct cxl_root_decoder *cxlrd;
>>> +    struct cxl_region *cxlr;
>>> +    struct cxl_port *port;
>>> +
>>> +    if (!is_cxl_region(dev))
>>> +        return 0;
>>> +
>>> +    cxlr = to_cxl_region(dev);
>>> +
>>> +    cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>>> +    port = cxlrd_to_port(cxlrd);
>>> +
>>> +    devm_release_action(port->uport_dev, unregister_region, cxlr);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +void cxl_region_teardown_all(void)
>>> +{
>>> +    bus_for_each_dev(&cxl_bus_type, NULL, NULL, 
>>> cxl_region_teardown_cb);
>>> +}
>>> +EXPORT_SYMBOL_GPL(cxl_region_teardown_all);
>>> +
>>>   static int cxl_region_contains_sr_cb(struct device *dev, void *data)
>>>   {
>>>       struct resource *res = data;
>>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>>> index b0ff6b65ea0b..1864d35d5f69 100644
>>> --- a/drivers/cxl/cxl.h
>>> +++ b/drivers/cxl/cxl.h
>>> @@ -907,6 +907,7 @@ int cxl_add_to_region(struct 
>>> cxl_endpoint_decoder *cxled);
>>>   struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
>>>   u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa);
>>>   bool cxl_region_contains_soft_reserve(const struct resource *res);
>>> +void cxl_region_teardown_all(void);
>>>   #else
>>>   static inline bool is_cxl_pmem_region(struct device *dev)
>>>   {
>>> @@ -933,6 +934,7 @@ static inline bool 
>>> cxl_region_contains_soft_reserve(const struct resource *res)
>>>   {
>>>       return false;
>>>   }
>>> +static inline void cxl_region_teardown_all(void) { }
>>>   #endif
>>>   void cxl_endpoint_parse_cdat(struct cxl_port *port);
>>> diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
>>> index 13cd94d32ff7..b7e90d6dd888 100644
>>> --- a/drivers/dax/cxl.c
>>> +++ b/drivers/dax/cxl.c
>>> @@ -14,6 +14,15 @@ static int cxl_dax_region_probe(struct device *dev)
>>>       struct dax_region *dax_region;
>>>       struct dev_dax_data data;
>>> +    switch (dax_cxl_mode) {
>>> +    case DAX_CXL_MODE_DEFER:
>>> +        return -EPROBE_DEFER;
>>> +    case DAX_CXL_MODE_REGISTER:
>>> +        return -ENODEV;
>>> +    case DAX_CXL_MODE_DROP:
>>> +        break;
>>> +    }
>>> +
>>>       if (nid == NUMA_NO_NODE)
>>>           nid = memory_add_physaddr_to_nid(cxlr_dax->hpa_range.start);
>>> diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
>>> index 1e3424358490..bcb57d8678d7 100644
>>> --- a/drivers/dax/hmem/hmem.c
>>> +++ b/drivers/dax/hmem/hmem.c
>>> @@ -3,6 +3,7 @@
>>>   #include <linux/memregion.h>
>>>   #include <linux/module.h>
>>>   #include <linux/dax.h>
>>> +#include "../../cxl/cxl.h"
>>>   #include "../bus.h"
>>>   static bool region_idle;
>>> @@ -58,9 +59,15 @@ static void release_hmem(void *pdev)
>>>       platform_device_unregister(pdev);
>>>   }
>>> +struct dax_defer_work {
>>> +    struct platform_device *pdev;
>>> +    struct work_struct work;
>>> +};
>>> +
>>>   static int hmem_register_device(struct device *host, int target_nid,
>>>                   const struct resource *res)
>>>   {
>>> +    struct dax_defer_work *work = dev_get_drvdata(host);
>>>       struct platform_device *pdev;
>>>       struct memregion_info info;
>>>       long id;
>>> @@ -69,8 +76,18 @@ static int hmem_register_device(struct device 
>>> *host, int target_nid,
>>>       if (IS_ENABLED(CONFIG_DEV_DAX_CXL) &&
>>>           region_intersects(res->start, resource_size(res), 
>>> IORESOURCE_MEM,
>>>                     IORES_DESC_CXL) != REGION_DISJOINT) {
>>> -        dev_dbg(host, "deferring range to CXL: %pr\n", res);
>>> -        return 0;
>>> +        switch (dax_cxl_mode) {
>>> +        case DAX_CXL_MODE_DEFER:
>>> +            dev_dbg(host, "deferring range to CXL: %pr\n", res);
>>> +            schedule_work(&work->work);
>>> +            return 0;
>>> +        case DAX_CXL_MODE_REGISTER:
>>> +            dev_dbg(host, "registering CXL range: %pr\n", res);
>>> +            break;
>>> +        case DAX_CXL_MODE_DROP:
>>> +            dev_dbg(host, "dropping CXL range: %pr\n", res);
>>> +            return 0;
>>> +        }
>>>       }
>>>       rc = region_intersects_soft_reserve(res->start, 
>>> resource_size(res));
>>> @@ -123,8 +140,67 @@ static int hmem_register_device(struct device 
>>> *host, int target_nid,
>>>       return rc;
>>>   }
>>> +static int cxl_contains_soft_reserve(struct device *host, int 
>>> target_nid,
>>> +                     const struct resource *res)
>>> +{
>>> +    if (region_intersects(res->start, resource_size(res), 
>>> IORESOURCE_MEM,
>>> +                  IORES_DESC_CXL) != REGION_DISJOINT) {
>>> +        if (!cxl_region_contains_soft_reserve(res))
>>> +            return 1;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static void process_defer_work(struct work_struct *_work)
>>> +{
>>> +    struct dax_defer_work *work = container_of(_work, 
>>> typeof(*work), work);
>>> +    struct platform_device *pdev = work->pdev;
>>> +    int rc;
>>> +
>>> +    /* relies on cxl_acpi and cxl_pci having had a chance to load */
>>> +    wait_for_device_probe();
>>> +
>>> +    rc = walk_hmem_resources(&pdev->dev, cxl_contains_soft_reserve);
>>> +
>>> +    if (!rc) {
>>> +        dax_cxl_mode = DAX_CXL_MODE_DROP;
>>> +        rc = bus_rescan_devices(&cxl_bus_type);
>>> +        if (rc)
>>> +            dev_warn(&pdev->dev, "CXL bus rescan failed: %d\n", rc);
>>> +    } else {
>>> +        dax_cxl_mode = DAX_CXL_MODE_REGISTER;
>>> +        cxl_region_teardown_all();
>>> +    }
>>> +
>>> +    walk_hmem_resources(&pdev->dev, hmem_register_device);
>>> +}
>>> +
>>> +static void kill_defer_work(void *_work)
>>> +{
>>> +    struct dax_defer_work *work = container_of(_work, 
>>> typeof(*work), work);
>>> +
>>> +    cancel_work_sync(&work->work);
>>> +    kfree(work);
>>> +}
>>> +
>>>   static int dax_hmem_platform_probe(struct platform_device *pdev)
>>>   {
>>> +    struct dax_defer_work *work = kzalloc(sizeof(*work), GFP_KERNEL);
>>> +    int rc;
>>> +
>>> +    if (!work)
>>> +        return -ENOMEM;
>>> +
>>> +    work->pdev = pdev;
>>> +    INIT_WORK(&work->work, process_defer_work);
>>> +
>>> +    rc = devm_add_action_or_reset(&pdev->dev, kill_defer_work, work);
>>> +    if (rc)
>>> +        return rc;
>>> +
>>> +    platform_set_drvdata(pdev, work);
>>> +
>>>       return walk_hmem_resources(&pdev->dev, hmem_register_device);
>>>   }
>>> @@ -174,3 +250,4 @@ MODULE_ALIAS("platform:hmem_platform*");
>>>   MODULE_DESCRIPTION("HMEM DAX: direct access to 'specific purpose' 
>>> memory");
>>>   MODULE_LICENSE("GPL v2");
>>>   MODULE_AUTHOR("Intel Corporation");
>>> +MODULE_IMPORT_NS("CXL");
>


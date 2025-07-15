Return-Path: <linux-fsdevel+bounces-55018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6649B065E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 20:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A51E7A7FB8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 18:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788152BE631;
	Tue, 15 Jul 2025 18:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UfNuJp1o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2047.outbound.protection.outlook.com [40.107.102.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57250277813;
	Tue, 15 Jul 2025 18:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752603553; cv=fail; b=piR1alzKpN1z2o/JQYJrdPWEvh8g1d7uxrVOA1SEGZd0m1zUi3TUIOT/GFnXSCBtjlZ1w2JC9daZDkh92Cy3xF/XcyhuY23v38J6KdbeENQmoYNcQafF8ulz8fS9E95Oh062/v9CgDwKDtJYYOjbXFDeGaAlnS7h8pNmO+MXlYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752603553; c=relaxed/simple;
	bh=K1A42w3VjnpVaxtq21wzoyZlZGcgF/vSCTd/1z3rlvU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qg8cmC+ivskOpxEV6wVO37l2bH3IydlNA3BykMaX7TfTRs3V20TRNzR+mCPOYLO6wWMR1IgIheOBUNHxX6ek7SD12oE4w/acdfYVWHlrNDjvoIO4pGlYmsOfuAZx3GeAgiqJ87zmakPjHlNd762uOkAoIVurq0asybvUu5XYYEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UfNuJp1o; arc=fail smtp.client-ip=40.107.102.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fV6bKOtzGfJSb3ZgIhgwRB3VgsVDf/aui1MEj8AH+8W18kvRysGEF8fcCx8ZEzJKCQRKB6HFFjAp10w9V+fBqkiDv+8b44xQ/M0mG5kSg1xsPL22V1gMIy4EoGgapLUlnQ1U3p8A4ZCBbeDBF9MW9C9MDdX+dT3hKtFEZijx40cwnk8HQ8UeykbFCDfcre71B84LgyBZcDIgj+sHnDYoSTP3oEw+X5FSRme+eDGazPFMJ7XQwFrEEldYvhN2xP6iHtq9C/Dc4jxypedGqyXnac1mE/JjijA8d3foyFUhQHPdJvL2cEoz5SoN4o9lzLvKfWf1B6jKBmUUADvyJuh4yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBI1JL9/KZ10hgpaoeCDnnsWGSipDV6qC/IUWyEibU0=;
 b=TBBzhduNB+nuRo8OZhXFCn5YTNzCpvjZbxSEa64h1Z8rFxS1LrKuA3wFwSajr9c8NBQG8+hRoDn0fBplnWdMGBvT8HzcJNbZ1MsmFasN/GMOS0sf420DwdnwK+pH9dXJwNzaKfIClXBQp9X/YNExlsxwm8f6V6xy+ji2UqngaNm2KgMboNz6p7cHUAXKSlnlr8A3j5k0ykigBByrxBT8ZSsT3y9UtOVS/wdT5c+yVnsOeJqNVypVOWsl//xjpBarMhsx+t0zR3goPbDG+8ojks3rSmJVYe8YtozuNU34Bz2lYqW1++lln4ulTk8ZzUVPsY0ZHgVKEi1ciGI6gSiK+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBI1JL9/KZ10hgpaoeCDnnsWGSipDV6qC/IUWyEibU0=;
 b=UfNuJp1oYKnU/xdhO3t8VXKrqKZmAfm6/CvWzB1L0XVN9lufAcb6ttI+SfB77AkqctSCGDhbubOuZ4A64y+uYb0B92HxavL+MQAThMx63SRiJK2H68TrPb9BEThLZwBGKGJAPC6+PuEjkOt59TJq/3dBw0eCPJRfrgs48hP55QQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6)
 by SA1PR12MB9490.namprd12.prod.outlook.com (2603:10b6:806:45b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Tue, 15 Jul
 2025 18:19:08 +0000
Received: from MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3]) by MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3%3]) with mapi id 15.20.8901.033; Tue, 15 Jul 2025
 18:19:07 +0000
Message-ID: <4aefce95-0029-49d1-99d2-c132406ec84f@amd.com>
Date: Tue, 15 Jul 2025 11:19:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] cxl/dax: Defer DAX consumption of SOFT RESERVED
 resources until after CXL region creation
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Ying Huang <huang.ying.caritas@gmail.com>,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>,
 Greg KH <gregkh@linuxfoundation.org>,
 Nathan Fontenot <nathan.fontenot@amd.com>,
 Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
 Benjamin Cheatham <benjamin.cheatham@amd.com>,
 PradeepVineshReddy Kodamati <PradeepVineshReddy.Kodamati@amd.com>,
 Zhijian Li <lizhijian@fujitsu.com>
References: <20250603221949.53272-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250603221949.53272-8-Smita.KoralahalliChannabasappa@amd.com>
 <aHaBdj0QrEe_gymR@aschofie-mobl2.lan>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita"
 <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <aHaBdj0QrEe_gymR@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0193.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::18) To MW4PR12MB7142.namprd12.prod.outlook.com
 (2603:10b6:303:220::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7142:EE_|SA1PR12MB9490:EE_
X-MS-Office365-Filtering-Correlation-Id: 8af4a4eb-a877-4a8a-9d07-08ddc3cc1664
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXZHYTVxQTB1YUdST2phQkpVdE50eXRtazBudGFhY0VDTklSbE1aaHlTbjZw?=
 =?utf-8?B?aVFYNnliZUZrdndrNllzejZVNTJsYlRLSVZEcjl5eGlickZJQVRCUzdBVGpE?=
 =?utf-8?B?RWJQWnhrWlVOMEd6STFWUjZVeWd0TUhGdkFOM3B3dVZ5SEtKeGpFb29vVHR3?=
 =?utf-8?B?QmJBQnFFR1NoSmtMem03QThFdFZUTHV6K2dOVkVvcTluZGk3ZlZoeFppVTBt?=
 =?utf-8?B?aTRmdTJPUXh0Syt5VVF0OElvN09FZVBtSUYxRmM0QTN3V1V3M2RRTHdKMTBW?=
 =?utf-8?B?R2wwQSs1RjZ3RSsxS0k1MTdXNGVNeHNwMlZycHlOV3F1czNFb3NXamJwNnFo?=
 =?utf-8?B?NE81LzAvWThMNkc1ZEtBTUVjRndoNm4zQWgva3g0VDlBaWJLYUZBQWUrS3dv?=
 =?utf-8?B?OEtKVzdHZVRpT25OeDBZWFF0R1hFNGJ1RGdJWXlEYUhhZ0Roenc4NUhTU3J6?=
 =?utf-8?B?Um83cFR5Ri9sMTdSYklKeWhRVC82Y0FOR05VdW5FOHpFbldVbVpkTTR4SjhP?=
 =?utf-8?B?eldmNVphdzZlM3lQWDUvbTdIVkhlTHdDckorb0V4NkhuRGtXcXVGbnBRYkZB?=
 =?utf-8?B?KzViT3pFTVJwSGV3OVNaMlY3bUFsdmRPanl3bG1XSnYvWkszUmQvR0V3cWc0?=
 =?utf-8?B?KzRsQ3d1Mno1aWZhcDRzQkExWDIyQmhVaE9PQlFiZVFoUmR5NVFVb1U5eEIv?=
 =?utf-8?B?V01aVzJ5VTJPMjdXck5CbVpXSTVJdS9aK1dGdUVqZUhBMTlsZWZqaEl0UDBJ?=
 =?utf-8?B?Q1crT1BVTHFRU1ptQlY2TzJpdkdibm5EK3hCUW8raEZvcG9JMFUxYTR0eFBm?=
 =?utf-8?B?UFUxN3BUSWYzSXY2V2FpcXNmOGovRGJ6OFZ2WlhocXdUZWN6RnZ0L2d5YjMy?=
 =?utf-8?B?cmErL2I5VFhPNDJnd1FNQXRKcnFsckF2WXV0MXNRTWRRT2ZCMG5idndOa0J4?=
 =?utf-8?B?S3dOc1V2a1RKQWVQRC9nUkFObnBZR0E2OVNoMG5yZmJyVXdnZE1nTWF2dHI0?=
 =?utf-8?B?T21VTnUrb0FBZk5ocGUzNFNPVFVIeVNQRjkvUi81QjVjWURqZ3FxK1VjcVN3?=
 =?utf-8?B?eWV2VUdFdU0wMUVCQ3FLekM2TU1nWk9URERVSVowUm9mTGlNckNVWTIzQVhT?=
 =?utf-8?B?ZVVaUVU0OWg1YnhmV3RHUWEwMzJ2d2Ftekl4eDdFVi9RRVhKYXd4R0htL3pv?=
 =?utf-8?B?MTB4cHErOURSTjJOd05CN3F5RDFxbXcrK0NwSzk0RlZrT1ZxZk9XYVdmMzk0?=
 =?utf-8?B?MlFuNXdoM1VCZldpMy91ZjdwbE5HVG9lanFjMmxYZDAzdTdsYWZ1bmh2RnlI?=
 =?utf-8?B?TGNHYXpsWmdLTUZIRDBvZ0Q4MzV4RTJ5NDJMZ1ZycW1rVUZqU3RhK1VNT0dm?=
 =?utf-8?B?ejkrQThXYWNBZXp4cUhVVk1QMWxtQm00WkVMNnNTWVZKc25STWM2V1UxSFRP?=
 =?utf-8?B?OFYzeWJHZWRZcE9nTldJeFFkU01CSVFlRDZtMEtucDZmcy84VURLVDlLSHl4?=
 =?utf-8?B?WGMrTTlxNGlKUkhyVlhvMVdzektjK1VqVzYvZDlkL2FUdHppcm1tdTJtcnAy?=
 =?utf-8?B?eWZidHRldHNudUxtK1JTV0ZtRVRjLzNESkJmOVlOQ3pIZThVeFA1K0lpcWdJ?=
 =?utf-8?B?alowdUdKZnlaeWQvQUVFS0RkU3M0TFlvVWIyRElRakpPcVdMWHVRQVMwaTZ4?=
 =?utf-8?B?RHJ2S0dlUFp0emtqZkMzTUdkcmRZcTJIcG8vNmxFVWtrd2VWcVZyZ1RydFY3?=
 =?utf-8?B?TWdhMERod3VHL0JyZ2YwSnVMdmtuRGl0ZDZKQXFrdjYxZmhQQmZ5QXEzWi9t?=
 =?utf-8?B?QjhBQTdmMW9Wb25MWDFjcm1YaWNNYWhYNFkzTm83MU1ndmR0cGxxOGRqNjJz?=
 =?utf-8?Q?cbh9FPXm2o+j2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7142.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Uk15YlpVMng3MW5TN3laSlZTcmpWZk9zMjRHUjdNZTNvbW9PYmRxWll3c1Jl?=
 =?utf-8?B?ZnJxY20yUHk0REVEWHByYitsMHh0RGxoVVVscEVhOExXNm4yUVhmK2VqMGlt?=
 =?utf-8?B?L0NhSVRQV1lpOC9lK3pERy95bnEwT05ITVp6NUY4WjR3Z0UxcDZGUGY3MC9F?=
 =?utf-8?B?T2RmRXAyZU9jSExMSTk3N2RpZ296Q3VDdmFvcTIyR1NwWW5tZUppdHpnWnVi?=
 =?utf-8?B?bk9HU1FOUUlMM2VtMy9WeXV6cjZyLzBvRnExS2xKYk40SXVHams3OVJvbG4z?=
 =?utf-8?B?SWM4Wlh6ZGxvUGZJa2VLWXdtdUNFY2hrczNBNDZ1REpOV1A1a0hNMnNuNEJF?=
 =?utf-8?B?b1Q1QXdWaTYvVGx4NDI2NHpOUFNRQVRON2xRQnhqNkk0clJmTlBNK25KVU4x?=
 =?utf-8?B?N25laHgwVUl1ZkFVelA4My9yemJMcnhWTmJJWGJTS0ZzQTM5VjF2bElkcTF5?=
 =?utf-8?B?SGNhMHU2T251SGhiMnBvSkpGM3NyYkVDTkcxRThvTlVPS3JFZDdKOXM0c3Jz?=
 =?utf-8?B?R1RUaTJlT2FYeEJYQXdDS28xS2hyMFNXQkQyMGRjQzd4Qmp6ZEczZVBCellJ?=
 =?utf-8?B?SnBPcW9NMjZlOFU3dWFMNjROaFVlSFBRVDF0SnFsdjUxS3QyUG5XUTMxaVBF?=
 =?utf-8?B?aU45K2M2REg1TWRYbXNCR0VzOFlJdWhMdThtYXl3QnczZENaNEZPeWNaajlt?=
 =?utf-8?B?b0pwaXFOWG9SL0t3K3NWWmtkQmJPVWdEbEk0ZENKWDlkYkZkYkhrRkJNTzRO?=
 =?utf-8?B?aHgyUWFIb2ZUNVNUZ2ttd3RXOFVwQVpPN2dwQlFvMzFlN0JkWjZDOHgweW5j?=
 =?utf-8?B?ZlNzcDJNM09wRlNYNXkvTlNDeEt6SjhCU2U1Y0JWa29XVHE2V3ZOWXhQTkNN?=
 =?utf-8?B?STQ5QTRYZmFhR3FacG9CQkxyZ2JaOWdqZ0lYZlpjb1M2VXJtc3hUdVJlM294?=
 =?utf-8?B?R25LVDdza25UeEpKcXZDdWF5Y0szNmV2alc2U2ZENEFaOFVvWmVFTmVqRzdm?=
 =?utf-8?B?a1FXNHZGWThuRXRWaDRBcnNpbloxVDRqQ2dBc1pXSTI0bHd5TXV2SVlMN09k?=
 =?utf-8?B?TS8wb200SVFtZ1U3NENsR21vV2xxS3plKytaZzdTSS9zYktyUW5tRFBERk1x?=
 =?utf-8?B?dWQ0VHhoaVpiQkx6SUZZeUF3eUgyR0pLUWJwcHdpKzJ2YWZnV1c1Q3M4WXhJ?=
 =?utf-8?B?ZVk4WGJRRVNiSkhySkRDS0hrcDRIcHoxODdLQnRIRDB2cVJuRGJweEU5bjN1?=
 =?utf-8?B?U1g3a2NLOEZYWGJzU29hSStPUlVpbHhScHExcXBOQmt2TFI2NHBJUTFUUzFn?=
 =?utf-8?B?QWpxUFdmdmtsWnlldzhFejRHYktjQU05SUNqMTl5SVlDWURodXhuV3QwRTNC?=
 =?utf-8?B?WHF1dDhHUzV0QWNYd3ltRFUrZFFXTG5uU0FxVXphTCtWcXUrQjQ2N3luaDVz?=
 =?utf-8?B?cUZLWlpJd09Zd2RNOWJxY1dONnJSZ1d5czRZRkc3aHZNd3o2QjdlQklVVjhk?=
 =?utf-8?B?MFRLZkVJOVY2cWZJNFhOTlJ6OG9qTER1bEVOTllWSVFEeW95SEhWUFhWS3NQ?=
 =?utf-8?B?RktUcGZEQU1DelVmZXRFMlhqQzU2b0VKaDJjdGt3OGVvWjQ2Vk1hMjVTcWlF?=
 =?utf-8?B?eTVmTWhUc2ZLSjhwRmkxcDV4b2Irb21Pb095VWxVU1NhQmVCOU9YK1VZWTBh?=
 =?utf-8?B?RTFnRkpnOExrYmhhSFRneERvM0xHNC94VUEvYkJqcyt1b1N2V2cwZGNzZFl1?=
 =?utf-8?B?WjNsS1grNmJjeTgvdm9LS3hTTXJpWnNyc1ZncEl0QTF3Q3ZGSWdnSGVVRU5h?=
 =?utf-8?B?UVJzUlp6MGh1bk1PUVo5eHE2UG5jNk5rRHdUTkh5SnhTM3A4UTFjdktqckpR?=
 =?utf-8?B?Zk40ZHhDSmRhTjVZV2xJdVJQR2pNUURKbEg0UEtIZ0RkV1hOUUdQZW84eElN?=
 =?utf-8?B?UW5yR2FrQnRxVHhiV2pXMTQ3dUF3cXRoSjhLbHROdEhJTnhaOU1xMCs2OFhl?=
 =?utf-8?B?dEFLVy9UWXc0SUJmSFhhbUxFREt6clUzQ2JTY0ZyVjdCQVQwTDVSc0lFZWRh?=
 =?utf-8?B?c0NUTmdmRTZKaTVlS3pibmFpSkE4cFhLRndmQVkwYUZHVElYSkFlT2pCbWlw?=
 =?utf-8?Q?sNFg5bPJFvgKRrHPzFEcfRwlU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af4a4eb-a877-4a8a-9d07-08ddc3cc1664
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7142.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 18:19:07.5299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hwOtB8R/1KYhjY24e1YL8R7yqYPvLJqEPACCdUIjfMVASZefOodzGsI9rl5exgKnbN5FeWkEP6W6iL61fA9f6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9490

Hi Alison,

Sorry I missed this email before sending out v5. Comments inline.

On 7/15/2025 9:27 AM, Alison Schofield wrote:
> On Tue, Jun 03, 2025 at 10:19:49PM +0000, Smita Koralahalli wrote:
>> From: Nathan Fontenot <nathan.fontenot@amd.com>
>>
>> The DAX HMEM driver currently consumes all SOFT RESERVED iomem resources
>> during initialization. This interferes with the CXL driver’s ability to
>> create regions and trim overlapping SOFT RESERVED ranges before DAX uses
>> them.
>>
>> To resolve this, defer the DAX driver's resource consumption if the
>> cxl_acpi driver is enabled. The DAX HMEM initialization skips walking the
>> iomem resource tree in this case. After CXL region creation completes,
>> any remaining SOFT RESERVED resources are explicitly registered with the
>> DAX driver by the CXL driver.
>>
>> This sequencing ensures proper handling of overlaps and fixes hotplug
>> failures.
> 
> Hi Smita,
> 
> About the issue I first mentioned here [1]. The HMEM driver is not
> waiting for region probe to finish. By the time region probe attempts
> to hand off the memory to DAX, the memory is already marked as System RAM.
> 
> See 'case CXL_PARTMODE_RAM:' in cxl_region_probe(). The is_system_ram()
> test fails so devm_cxl_add_dax_region() not possible.
> 
> This means that in appearance, just looking at /proc/iomem/, this
> seems to have worked. There is no soft reserved and the dax and
> kmem resources are child resources of the region resource. But they
> were not set up by the region driver, hence no unregister callback
> is triggered when the region is disabled.

I believe this should be resolved in v5. I see the following dmesg 
entries indicating that devm_cxl_add_dax_region() is being called 
successfully for all regions:

# dmesg | grep devm_cxl_add_dax_region
[   40.730864] devm_cxl_add_dax_region: cxl_region region0: region0: 
register dax_region0
[   40.756307] devm_cxl_add_dax_region: cxl_region region1: region1: 
register dax_region1
[   43.689882] devm_cxl_add_dax_region: cxl_region region2: region2: 
register dax_region2

cat /proc/iomem

850000000-284fffffff : CXL Window 0
   850000000-284fffffff : region0
     850000000-284fffffff : dax0.0
       850000000-284fffffff : System RAM (kmem)
2850000000-484fffffff : CXL Window 1
   2850000000-484fffffff : region1
     2850000000-484fffffff : dax1.0
       2850000000-484fffffff : System RAM (kmem)
4850000000-684fffffff : CXL Window 2
   4850000000-684fffffff : region2
     4850000000-684fffffff : dax2.0
       4850000000-684fffffff : System RAM (kmem)

I suspect devm_cxl_add_dax_region() didn't execute in v4 because 
hmem_register_resource() (called from hmat.c) preemptively created 
hmem_active entries. These were consumed during walk_hmem_resources() 
and registered by hmem_register_device() before the CXL region probe 
could complete.

In v5, if CONFIG_CXL_ACPI is enabled, soft reserved resources are stored 
in hmem_deferred_active instead and hmem_register_resource() calls from 
hmat.c are disabled. This ensures DAX registration happens only through 
CXL drivers probing.

> 
> It appears like this:
> 
> c080000000-17dbfffffff : CXL Window 0
>    c080000000-c47fffffff : region2
>      c080000000-c47fffffff : dax0.0
>        c080000000-c47fffffff : System RAM (kmem)
> 
> Now, to make the memory available for reuse, need to do:
> # daxctl offline-memory dax0.0
> # daxctl destroy-device --force dax0.0
> # cxl disable-region 2
> # cxl destroy-region 2
> 
> Whereas previously, did this:
> # daxctl offline-memory dax0.0
> # cxl disable-region 2
>    After disabling region, dax device unregistered.
> # cxl destroy-region 2

I haven’t yet tested this specific unregister flow with v5. I’ll verify 
and follow up if I see any issues. Meanwhile, please let me know if you 
still observe the same behavior or need additional debug info from my side.

Thanks
Smita
> 
> I do see that __cxl_region_softreserv_update() is not called until
> after cxl_region_probe() completes, so that is waiting properly to
> pick up the scraps. I'm actually not sure there would be any scraps
> though, if the HMEM driver has already done it's thing. In my case
> the Soft Reserved size is same as region, so I cannot tell what
> would happen if that Soft Reserved had more capacity than the region.
> 
> If I do this: # CONFIG_DEV_DAX_HMEM is not set, works same as before,
> which is as expected.
> 
> Let me know if I can try anything else out or collect more info.
> 
> --Alison
> 
> 
> [1] https://lore.kernel.org/nvdimm/20250603221949.53272-1-Smita.KoralahalliChannabasappa@amd.com/T/#m10c0eb7b258af7cd0c84c7ee2c417c055724f921
> 
> 
>>
>> Co-developed-by: Nathan Fontenot <Nathan.Fontenot@amd.com>
>> Signed-off-by: Nathan Fontenot <Nathan.Fontenot@amd.com>
>> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> ---
>>   drivers/cxl/core/region.c | 10 +++++++++
>>   drivers/dax/hmem/device.c | 43 ++++++++++++++++++++-------------------
>>   drivers/dax/hmem/hmem.c   |  3 ++-
>>   include/linux/dax.h       |  6 ++++++
>>   4 files changed, 40 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 3a5ca44d65f3..c6c0c7ba3b20 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -10,6 +10,7 @@
>>   #include <linux/sort.h>
>>   #include <linux/idr.h>
>>   #include <linux/memory-tiers.h>
>> +#include <linux/dax.h>
>>   #include <cxlmem.h>
>>   #include <cxl.h>
>>   #include "core.h"
>> @@ -3553,6 +3554,11 @@ static struct resource *normalize_resource(struct resource *res)
>>   	return NULL;
>>   }
>>   
>> +static int cxl_softreserv_mem_register(struct resource *res, void *unused)
>> +{
>> +	return hmem_register_device(phys_to_target_node(res->start), res);
>> +}
>> +
>>   static int __cxl_region_softreserv_update(struct resource *soft,
>>   					  void *_cxlr)
>>   {
>> @@ -3590,6 +3596,10 @@ int cxl_region_softreserv_update(void)
>>   				    __cxl_region_softreserv_update);
>>   	}
>>   
>> +	/* Now register any remaining SOFT RESERVES with DAX */
>> +	walk_iomem_res_desc(IORES_DESC_SOFT_RESERVED, IORESOURCE_MEM,
>> +			    0, -1, NULL, cxl_softreserv_mem_register);
>> +
>>   	return 0;
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_region_softreserv_update, "CXL");
>> diff --git a/drivers/dax/hmem/device.c b/drivers/dax/hmem/device.c
>> index 59ad44761191..cc1ed7bbdb1a 100644
>> --- a/drivers/dax/hmem/device.c
>> +++ b/drivers/dax/hmem/device.c
>> @@ -8,7 +8,6 @@
>>   static bool nohmem;
>>   module_param_named(disable, nohmem, bool, 0444);
>>   
>> -static bool platform_initialized;
>>   static DEFINE_MUTEX(hmem_resource_lock);
>>   static struct resource hmem_active = {
>>   	.name = "HMEM devices",
>> @@ -35,9 +34,7 @@ EXPORT_SYMBOL_GPL(walk_hmem_resources);
>>   
>>   static void __hmem_register_resource(int target_nid, struct resource *res)
>>   {
>> -	struct platform_device *pdev;
>>   	struct resource *new;
>> -	int rc;
>>   
>>   	new = __request_region(&hmem_active, res->start, resource_size(res), "",
>>   			       0);
>> @@ -47,21 +44,6 @@ static void __hmem_register_resource(int target_nid, struct resource *res)
>>   	}
>>   
>>   	new->desc = target_nid;
>> -
>> -	if (platform_initialized)
>> -		return;
>> -
>> -	pdev = platform_device_alloc("hmem_platform", 0);
>> -	if (!pdev) {
>> -		pr_err_once("failed to register device-dax hmem_platform device\n");
>> -		return;
>> -	}
>> -
>> -	rc = platform_device_add(pdev);
>> -	if (rc)
>> -		platform_device_put(pdev);
>> -	else
>> -		platform_initialized = true;
>>   }
>>   
>>   void hmem_register_resource(int target_nid, struct resource *res)
>> @@ -83,9 +65,28 @@ static __init int hmem_register_one(struct resource *res, void *data)
>>   
>>   static __init int hmem_init(void)
>>   {
>> -	walk_iomem_res_desc(IORES_DESC_SOFT_RESERVED,
>> -			IORESOURCE_MEM, 0, -1, NULL, hmem_register_one);
>> -	return 0;
>> +	struct platform_device *pdev;
>> +	int rc;
>> +
>> +	if (!IS_ENABLED(CONFIG_CXL_ACPI)) {
>> +		walk_iomem_res_desc(IORES_DESC_SOFT_RESERVED,
>> +				    IORESOURCE_MEM, 0, -1, NULL,
>> +				    hmem_register_one);
>> +	}
>> +
>> +	pdev = platform_device_alloc("hmem_platform", 0);
>> +	if (!pdev) {
>> +		pr_err("failed to register device-dax hmem_platform device\n");
>> +		return -1;
>> +	}
>> +
>> +	rc = platform_device_add(pdev);
>> +	if (rc) {
>> +		pr_err("failed to add device-dax hmem_platform device\n");
>> +		platform_device_put(pdev);
>> +	}
>> +
>> +	return rc;
>>   }
>>   
>>   /*
>> diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
>> index 3aedef5f1be1..a206b9b383e4 100644
>> --- a/drivers/dax/hmem/hmem.c
>> +++ b/drivers/dax/hmem/hmem.c
>> @@ -61,7 +61,7 @@ static void release_hmem(void *pdev)
>>   	platform_device_unregister(pdev);
>>   }
>>   
>> -static int hmem_register_device(int target_nid, const struct resource *res)
>> +int hmem_register_device(int target_nid, const struct resource *res)
>>   {
>>   	struct device *host = &dax_hmem_pdev->dev;
>>   	struct platform_device *pdev;
>> @@ -124,6 +124,7 @@ static int hmem_register_device(int target_nid, const struct resource *res)
>>   	platform_device_put(pdev);
>>   	return rc;
>>   }
>> +EXPORT_SYMBOL_GPL(hmem_register_device);
>>   
>>   static int dax_hmem_platform_probe(struct platform_device *pdev)
>>   {
>> diff --git a/include/linux/dax.h b/include/linux/dax.h
>> index a4ad3708ea35..5052dca8b3bc 100644
>> --- a/include/linux/dax.h
>> +++ b/include/linux/dax.h
>> @@ -299,10 +299,16 @@ static inline int dax_mem2blk_err(int err)
>>   
>>   #ifdef CONFIG_DEV_DAX_HMEM_DEVICES
>>   void hmem_register_resource(int target_nid, struct resource *r);
>> +int hmem_register_device(int target_nid, const struct resource *res);
>>   #else
>>   static inline void hmem_register_resource(int target_nid, struct resource *r)
>>   {
>>   }
>> +
>> +static inline int hmem_register_device(int target_nid, const struct resource *res)
>> +{
>> +	return 0;
>> +}
>>   #endif
>>   
>>   typedef int (*walk_hmem_fn)(int target_nid, const struct resource *res);
>> -- 
>> 2.17.1
>>



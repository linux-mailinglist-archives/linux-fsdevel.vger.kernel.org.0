Return-Path: <linux-fsdevel+bounces-50861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBF3AD07C6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 19:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 539F317B0B2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 17:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1757428A3E1;
	Fri,  6 Jun 2025 17:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ULHoPa45"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7331E1E04;
	Fri,  6 Jun 2025 17:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749232412; cv=fail; b=GB4CXNAzY52vlG4+yM8NF/GBCCUQ6Zg/BcypzeAhcB8CbPnH9PkIY025EBBIyGd/h90wdhLAurLt1zqYKSkYHr0hEBdRH+fd//q8tO1i2vNmuj6qMmEAIH5lQI7yZIHVCizqRB6s+65NrI1/r2k37KonVVIi4g+BCjeWvTMxnlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749232412; c=relaxed/simple;
	bh=taHXxjpPrnxj6HP/DTMXUqcUll124lXB7IhycCTNM9E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P/zuq6HQaqEey6xj7SX/NG6uoXZA0lxDkhQGwK/9CBob1HSExbWQS9z/WXO11Wtc5ss/oopIaJcvpFG6VkzVfDT/qsPWo4UxA+ATvfLPU+OpUlYOVa5vUYa482K9b+08hBPWsY+c8ynzaM7vfwfMXX5s+wIO0+eX1se56aog2Rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ULHoPa45; arc=fail smtp.client-ip=40.107.237.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YH2UBhEPmcZEujBmIvcqq1BS2lBLxM/92Z78xAQngGjh6TLxiVG0UxdQ2pKi2Q+CnnustMt4DlJ7gO5I4c6rsy9xl0Ld7qvtPdi/+JeJTwny3MUAbmetBFninzDi41vX2zYDhN0OgAkFLVrwXE+SNIqud9zwfWvv+twMsMRkIi+qpmleWQmPyIEmQF6aTFBbAzoc64gt/PHUQFWdt0I7tuVDuLNPEzjDUB3UF+wms6K7c/ZiIkBc/cToe54BipG4WxBvGpkn+OYyatldvqVu1v+AoqD++Lf3hmTJOLufEc5auVBG1juPtxiXFdu0RFFSlUGrWtMMdXYP4EOrqzjzKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQjJLHeepOvbFeZt4T6ArMQ8+UJlF/ITImUijJAyedE=;
 b=kRx/HsqcvjyMXfyh72LtYsfKBk1GjG930b646DjJyvNGojHvaPVn4PSRks/bhllwtBKjwTiVkh35liM7Do++EuTmgcLLuozrlBm1qxTi4LZeIOYsH4Zp7pKkFfbEEcUVG8mSQixhuyjkOuhPh4f1DOdfZSCVHC2+e3l0g3XLvRbKNmKvEKwKrovMmEgz77eEHnDca1sU65yHikNydafgX2SFnipeTaRuT1DL21i4GbFZI7+VIurG7lXtxpgC/1n7YHTB1on6Z4pEUYUw6HlMPHIDGP23OEYfxDUXT1tlLnFFsGBvjuIG2Fw3VYNmz8vn5UynmNQWIAA7TMTY+pGPvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQjJLHeepOvbFeZt4T6ArMQ8+UJlF/ITImUijJAyedE=;
 b=ULHoPa45qtqjVI1K8XEsCa/SjQ4ikAZVFByKajwIzlPLTIjIt56Sc//VTHEz3ltVGTTAGvPxiHxq3UKvYFQGwrEsqErx5x9H9kAMvnS7ufUo0f9LugHBTIM0Jmd85MT3YfA6RULSpQDPfbwwy0G8WDojHqP/34hKFH6w5NEz0aw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6)
 by SJ1PR12MB6338.namprd12.prod.outlook.com (2603:10b6:a03:455::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.35; Fri, 6 Jun
 2025 17:53:25 +0000
Received: from MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3]) by MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3%3]) with mapi id 15.20.8792.038; Fri, 6 Jun 2025
 17:53:24 +0000
Message-ID: <8e077620-b1aa-4c51-9f66-58a9739aeb75@amd.com>
Date: Fri, 6 Jun 2025 10:53:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] cxl/region: Introduce SOFT RESERVED resource
 removal on region teardown
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox
 <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Ying Huang <huang.ying.caritas@gmail.com>,
 "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>,
 Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>,
 Nathan Fontenot <nathan.fontenot@amd.com>,
 Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
 Benjamin Cheatham <benjamin.cheatham@amd.com>,
 PradeepVineshReddy Kodamati <PradeepVineshReddy.Kodamati@amd.com>
References: <20250603221949.53272-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250603221949.53272-6-Smita.KoralahalliChannabasappa@amd.com>
 <3e045950-9ffb-4a9b-9793-958a16db0c33@fujitsu.com>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita"
 <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <3e045950-9ffb-4a9b-9793-958a16db0c33@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0014.namprd21.prod.outlook.com
 (2603:10b6:a03:114::24) To MW4PR12MB7142.namprd12.prod.outlook.com
 (2603:10b6:303:220::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7142:EE_|SJ1PR12MB6338:EE_
X-MS-Office365-Filtering-Correlation-Id: 169f02ce-2fda-4375-a6a4-08dda5230843
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dnZOcHVvZ085QXBiZjlWcG5OYnphbElwbGNUMzJkZlY0T3kyYVJHTnk5UXBm?=
 =?utf-8?B?WHVUeW9zWXFMcGNNVmd4YTl1VEtwcyt3dFIrUW1Yb1JQNHpxQjJGa0ZJL1Zz?=
 =?utf-8?B?bFo3WjJHWlBWcXlMaDhOdDJHUWVGTmxjRVlqZ25HMDZCOFpBYXh0bU9raXVn?=
 =?utf-8?B?QWNQeU1hRTQvSk02UVZ3Q3ZWSS9vWldOMFZXVE9abVpNTjN5ZGdqc0pjR2ha?=
 =?utf-8?B?ck83bEMvbnBBc2JpYzlxNlIrSkhndm1tcEdzOTA5QnEwQ1czeUg2clQrTzMr?=
 =?utf-8?B?Y0dyelkvMGNqdHF2WVNvd0psV0Z4dFVHWjh6TS9IZDdRVVcxNERkWkk2Slhj?=
 =?utf-8?B?MkZaTW0zYm5rUGZEQm05blZzcnRPNjRwWkVRRzg5S1ZXa2tjRXAxV3ZqdFBD?=
 =?utf-8?B?OXRCZVhvM0psUmhKL0lCQlpmOXlXTVlvZFlRQ2k0R09rM042Y2x2d3NWV3Nv?=
 =?utf-8?B?aXdBQ1A3dG55M1FuaEx2NlpkVUh4T0p2Skk4THlDWk40Z2tLU3BMZ3VvQ2Nr?=
 =?utf-8?B?Mnl0Z2FDU01hOVFUdjltK1NsbTlTU2FadEJENFllQjlnQ2dtTnpYdHdWdmtD?=
 =?utf-8?B?YVFleGZIY1gyNHRHdWJuZ051WlJUQitldFRYL09DZEFVNWxjOEFKME5KUTNG?=
 =?utf-8?B?WWlrd21SZGxHbHdZVVh3SXZtNDA5WlF0NFExcFhtYlZUaHFNVmg1UlRQdkpN?=
 =?utf-8?B?aytxNmwrVTREbVR1d0tKZ2xBdkQyK3lGbmNWUFQrenZ6cWpkUmN2cDNtd0dJ?=
 =?utf-8?B?L1pydHMwWFZVQVFlclFGY3UzMExDcnN1VElXSlROUEk4NG9LRkJlN2ZJMVBB?=
 =?utf-8?B?bmNMenJ4Tit3SlBzMnF6aGhNeXZoczRBM040SjlodmhkZWNoSmpQU1p2YW5V?=
 =?utf-8?B?YklZNkc1VFV5bnpDbkFWcmQyNXlhWFNGeE1heHI3RjFzREZzZzFRQ01KRGpy?=
 =?utf-8?B?dk5QUUxQeVNsU2QrUk16NmhqNGpML091SmFlNm40NGkxSVlhZ0RUd1pMbi9x?=
 =?utf-8?B?NWlPUWlPYXUyVkdZaUlxUDdSZzZFYTJBR0NRSlBLUXU3bVdidXFRZDNTbnJF?=
 =?utf-8?B?aWFaUlVoUDNuam1ZYlRYWVJEWks5bkVxTDVHVFBRMStCSGx2eUVlTFdKdTNa?=
 =?utf-8?B?MzdLZUd0aFVEY1VBZi9qb3FscmorQndYUVQ3eWoraVl2L2NORDg5S2IxVTNz?=
 =?utf-8?B?a1UvbWJwamoyNUNRV3hkWDN0UHp0cXNaVU5qUnFqRU94SVFoWWh5S1N2TGFu?=
 =?utf-8?B?U0F3OUl2a0NsaGtnR3doVzB6M3M2MUZhcFB5eXp0TFpUMzNmblhLRGhKb3lw?=
 =?utf-8?B?bW5mUG9HSHVSYkM2VE5BaGx5OUFaWVg2anR0alZOZVJidnZQRURsQXcrVXpQ?=
 =?utf-8?B?cUxMQ3VQa0ppUHRpdHdWeEw2N0ZXRUhHNDNUNHRZRDRzaEwzRm53ZVhJUDd6?=
 =?utf-8?B?YnpMY0l1M1hFQWJhKzh2bVh5ZVQ5QUd3K0M1Q1BRcENBOUhzOXpPVGRJSk1h?=
 =?utf-8?B?Wml0VTdoV1hvdGFIR3Q0VHVrSlBkZDBicjA1Y3pESUg1SS8yTDBBSFlXVm5U?=
 =?utf-8?B?eXpTVEVZWjB1Q2wrWGFXOWRaR1BPK2VTNy9IUXFtV3JhNHh1aXNBL2xCbVkv?=
 =?utf-8?B?SE1jTk95M2tZcmhoZkp5c25XaXp3UDRqVzBQR2FhOGQ4TC8vVzNGQUhWUTVJ?=
 =?utf-8?B?d0hwMnFmbmEyc1cxb01HckpMamZaUXk0T0NKWkVCQlp0dTFUVWZLRE5Za1lK?=
 =?utf-8?B?dUpSY0UwMDBMQm9mb1pvYUZhYkRheVl2eWlHVU42VnF4Q2FkWWcvVTJGN3lE?=
 =?utf-8?B?Y1BZZTEwaDNtUllZZWRLcVNlRFpZV1BNYU1LcDd4V01lNjdhM0xvRVpxemtj?=
 =?utf-8?B?OWh4TExEZ21Wb0hDTEUxUEk0NFNaUUpBT3Q3S05zTjNUdm5vcUxpUkdNK1pG?=
 =?utf-8?Q?ltC93woxOSM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7142.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qjk1Y3pQSUNtQklFQUtUQ0RDajJDRzNQbE0xcjNURVFsMjF0Ny9MdVh0SXBs?=
 =?utf-8?B?WmNYSWlEdVp2U0dLSVZQU0pGelI2UVhEZ2hoVkhJMFN1VEpJR3JLTWtlQzFs?=
 =?utf-8?B?WWwwalpmdkpNNTJzSittNnY1L3g5WXlwcXRzMFY0L3d6UnV5eVlhRUhualRF?=
 =?utf-8?B?L3pHeWR6Y1VvbnNORzJlZWZTUGtpNUVHVGh2aW9sb3ZkQmlTaHhhUUJ5UUZW?=
 =?utf-8?B?R2FjVDBjaEE4WjBxMnJFNjUyYitaMW0xaEppK1lJa0x3d0JrOW4xTUczRlBo?=
 =?utf-8?B?Y0h0a0pqM3hraEJuSHFXQ3gxVjFIWS94OU90MjBxdG96eHRzVTE3d1JIdE9R?=
 =?utf-8?B?bndDYkQ3QjlzR0R0N3JPSmdxM3Q4OTBQVC9KV09Cd3RNekNnTVhPSitLVWJW?=
 =?utf-8?B?YTFUTDRONkNkWWRzSXVQWFZ2ZGF5NEJqSTF6UFZ5dEwvdThUaXlFZk1kc3cr?=
 =?utf-8?B?VWdmdlhSL0kyVWlnRnl4VVlqOTZPWkxyMVV4NlVvWUpVUU9tU1ZnMWZET0NZ?=
 =?utf-8?B?MU9hbFF6WHBIZ0pNOGxYQUdCOTlFQUMvTDJHczVoWGxrcXBNWFdjbitUcUYr?=
 =?utf-8?B?UGVsSUFVZVFaNG0wR0xXbWJ1NUpOWkR0bFlnd0hXQ0lKMjNUMUdyUkRYQlQ0?=
 =?utf-8?B?VCszenpwZzNOTlpyS2VicEEwZkNnaEdKbzFXOVFKZzJFTEN4eW96dm1DUGRq?=
 =?utf-8?B?aUFDMkhLSVJXMWhlOUY5cWwvT2FYOTc5a2ZYRm5nVmhBZUtpMDlkcVZYR21t?=
 =?utf-8?B?d2o4ajJWdHhlUGJqSWFjZ3pqRXA1UVJlVFFIN1V2TllKc2FNN2VoengzeEdM?=
 =?utf-8?B?UlU2Skc5Y1JBaVFsenB1bHlLTjg3djdlakRLR2h4cDZ2R0JCMTB4cW5VU2E3?=
 =?utf-8?B?ZEN3L3ZoZzJmbUJnMjVVc1Z4UXc1czNiSEZ1VlM5QjdobGJJSk93QUk0bDBi?=
 =?utf-8?B?MkRJNFh2aENTZ3NackFFeC9yVGZMbUtjeWF1NzQ0MHJlY0VJaU95UXNsZ2gr?=
 =?utf-8?B?QStLM1VCSWlSdldwbWhUYUptUGZWVlJjUk1hUGN0VzdPMDloTlc3OU9udEQ1?=
 =?utf-8?B?MFpTYnB2OTRoZThpOXZ2TmJxWXdnVHNWaGErVk5MT1VKeTB1TkZQczdINlZM?=
 =?utf-8?B?SGJFZ3ZwNmdPakZscGRqWFUxVnF1ODVmQ1kzdEhSM1lPdVNVNFd6MGVBay9R?=
 =?utf-8?B?SXRBSTRBK3lPR0tLRVFkWEZ0eEgzK2VFcXJrRUkyY0g0bTFyUncrRnpSc2Fi?=
 =?utf-8?B?Rzk2OHk4a1gwMTZRRUptWUpBcGYrdVAxV2FhZzYyV2F2VHJzeS9mbGtNYjNz?=
 =?utf-8?B?SVZGcDJkZmVaSHpUMzNwbEF3NlVtVjFuSldKdE5wTElEbEFsREZ2enZWMkhB?=
 =?utf-8?B?UnYvdmFpQ0loa29xeFdUTmYveXdDZ3ZKeEVBeHBQd0I4UjRHNitWQlJ2cHUy?=
 =?utf-8?B?K2JFeUVGTWIyRHJleTkrZHN1aWtsdnJRaVZhZEU0ZVhLM0xkRFAvOHdKNE5z?=
 =?utf-8?B?cmx1ZDFJbjRONHlYQzFzQTd5clM5OFN2RUdNZmdyMXB4SGp3L1Boc1YrV1o4?=
 =?utf-8?B?SHJqWnB3UHc2d2RzRENEOVkxWllsY3l1cEFlUzlINlROMThWTFRKTHVnZkJV?=
 =?utf-8?B?b01kVkZTQ1M5TzFQU0FJSjdpK1FyeDZ1VlMvcEpQK3c5bzRjTTJEa0pRS0pW?=
 =?utf-8?B?MkIrZ0o1cWZDcWFaK0pYOGtDR01qZkI1b3ZMT0lITzE0bXJOSEJiTWJRQk1E?=
 =?utf-8?B?bWozUVFwMnNyY3NmQ3ZML2J4aGZPOWl4aWppRnJmWHNBVm50aVFuMXYvRW9L?=
 =?utf-8?B?RFhvWEwzbnVMblhTMGtJS1lMZEEvQUpIRk5CVjN0Nzc4OWwyRXNyZWE1ZUxq?=
 =?utf-8?B?dDJsa1BJK0tTYnBxSlJHTHF3eDh0OGcxd0k0YUN6cXFzVUx4WFIvSXoxZmxj?=
 =?utf-8?B?b1RiandrbWcwWXdtcDY0bm95QTAyaDNhUjFQeERpZlphWWcwZUQwN3VveDZo?=
 =?utf-8?B?VS9YeERXdk9mb2RxdmFyVmpwN1lrZEZzMHJCQjNZT2pKc3JtUUJvcnNrcFFJ?=
 =?utf-8?B?aTdqV21kcDB0bDU3Z0I1UGtQQUJla2YvU1hXaXBBTGl6QngvMXhBaEx0T3hE?=
 =?utf-8?Q?k3wm3U+m4igE/4efzWREEqIrr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 169f02ce-2fda-4375-a6a4-08dda5230843
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7142.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 17:53:23.9646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VrveUT8CuRkuwmVzfwGsrzrcJB/MTnKn/dUSzz9UJxZmUK3bPLhlOPeHNZ2s0LQXYAKybBBcpqwfNsHcyjZk2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6338

On 6/5/2025 9:16 PM, Zhijian Li (Fujitsu) wrote:
> 
> The term "region teardown" in the subject line appears inaccurate.
> 
> 
> As I understand, cxl_region_softreserv_update() should work only
> when the region is ready, but the current logic only guarantees that the *memdev* is ready.
> 
> Is there truly no timing gap between region readiness and memdev readiness?
> If this assumption is true, could we document this relationship in both the commit log and code comments?
> 
> 
> Thanks
> Zhijian

I think you're right in pointing this out.

We cannot guarantee region readiness unless there's an explicit ordering
or dependency ensuring that cxl_region_probe() always completes after or 
synchronously with memdev probing and wait_for_device_probe().

I don't believe we currently have such a guarantee.

I was considering adding a null check for cxlr->params.res in 
__cxl_region_softreserv_update(), along with a comment like below:

static int __cxl_region_softreserv_update(struct resource *soft,
					  void *_cxlr)
{
	struct cxl_region *cxlr = _cxlr;
	struct resource *res = cxlr->params.res;

	/*
	 * Skip if the region has not yet been fully initialized.
	 *
	 * This code assumes all cxl_region devices have completed
	 * probing before this function runs, and that params.res is
	 * valid.
	 */

	if (!res)
		return 0;

..
..

}

This would prevent a null dereference and make the assumption around 
region readiness more explicit.

That said, I'd appreciate input from Terry, Nathan, or others on whether 
there's a better way to guarantee that region creation has completed by 
the time this function is invoked.

Thanks
Smita

> 
> 
> On 04/06/2025 06:19, Smita Koralahalli wrote:
>> Reworked from a patch by Alison Schofield <alison.schofield@intel.com>
>>
>> Previously, when CXL regions were created through autodiscovery and their
>> resources overlapped with SOFT RESERVED ranges, the soft reserved resource
>> remained in place after region teardown. This left the HPA range
>> unavailable for reuse even after the region was destroyed.
>>
>> Enhance the logic to reliably remove SOFT RESERVED resources associated
>> with a region, regardless of alignment or hierarchy in the iomem tree.
>>
>> Link: https://lore.kernel.org/linux-cxl/29312c0765224ae76862d59a17748c8188fb95f1.1692638817.git.alison.schofield@intel.com/
>> Co-developed-by: Alison Schofield <alison.schofield@intel.com>
>> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
>> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> ---
>>    drivers/cxl/acpi.c        |   2 +
>>    drivers/cxl/core/region.c | 151 ++++++++++++++++++++++++++++++++++++++
>>    drivers/cxl/cxl.h         |   5 ++
>>    3 files changed, 158 insertions(+)
>>
>> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
>> index 978f63b32b41..1b1388feb36d 100644
>> --- a/drivers/cxl/acpi.c
>> +++ b/drivers/cxl/acpi.c
>> @@ -823,6 +823,8 @@ static void cxl_softreserv_mem_work_fn(struct work_struct *work)
>>    	 * and cxl_mem drivers are loaded.
>>    	 */
>>    	wait_for_device_probe();
>> +
>> +	cxl_region_softreserv_update();
>>    }
>>    static DECLARE_WORK(cxl_sr_work, cxl_softreserv_mem_work_fn);
>>    
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 109b8a98c4c7..3a5ca44d65f3 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -3443,6 +3443,157 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
>>    }
>>    EXPORT_SYMBOL_NS_GPL(cxl_add_to_region, "CXL");
>>    
>> +static int add_soft_reserved(resource_size_t start, resource_size_t len,
>> +			     unsigned long flags)
>> +{
>> +	struct resource *res = kmalloc(sizeof(*res), GFP_KERNEL);
>> +	int rc;
>> +
>> +	if (!res)
>> +		return -ENOMEM;
>> +
>> +	*res = DEFINE_RES_MEM_NAMED(start, len, "Soft Reserved");
>> +
>> +	res->desc = IORES_DESC_SOFT_RESERVED;
>> +	res->flags = flags;
>> +	rc = insert_resource(&iomem_resource, res);
>> +	if (rc) {
>> +		kfree(res);
>> +		return rc;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void remove_soft_reserved(struct cxl_region *cxlr, struct resource *soft,
>> +				 resource_size_t start, resource_size_t end)
>> +{
>> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>> +	resource_size_t new_start, new_end;
>> +	int rc;
>> +
>> +	/* Prevent new usage while removing or adjusting the resource */
>> +	guard(mutex)(&cxlrd->range_lock);
>> +
>> +	/* Aligns at both resource start and end */
>> +	if (soft->start == start && soft->end == end)
>> +		goto remove;
>> +
>> +	/* Aligns at either resource start or end */
>> +	if (soft->start == start || soft->end == end) {
>> +		if (soft->start == start) {
>> +			new_start = end + 1;
>> +			new_end = soft->end;
>> +		} else {
>> +			new_start = soft->start;
>> +			new_end = start - 1;
>> +		}
>> +
>> +		rc = add_soft_reserved(new_start, new_end - new_start + 1,
>> +				       soft->flags);
>> +		if (rc)
>> +			dev_warn(&cxlr->dev, "cannot add new soft reserved resource at %pa\n",
>> +				 &new_start);
>> +
>> +		/* Remove the original Soft Reserved resource */
>> +		goto remove;
>> +	}
>> +
>> +	/*
>> +	 * No alignment. Attempt a 3-way split that removes the part of
>> +	 * the resource the region occupied, and then creates new soft
>> +	 * reserved resources for the leading and trailing addr space.
>> +	 */
>> +	new_start = soft->start;
>> +	new_end = soft->end;
>> +
>> +	rc = add_soft_reserved(new_start, start - new_start, soft->flags);
>> +	if (rc)
>> +		dev_warn(&cxlr->dev, "cannot add new soft reserved resource at %pa\n",
>> +			 &new_start);
>> +
>> +	rc = add_soft_reserved(end + 1, new_end - end, soft->flags);
>> +	if (rc)
>> +		dev_warn(&cxlr->dev, "cannot add new soft reserved resource at %pa + 1\n",
>> +			 &end);
>> +
>> +remove:
>> +	rc = remove_resource(soft);
>> +	if (rc)
>> +		dev_warn(&cxlr->dev, "cannot remove soft reserved resource %pr\n",
>> +			 soft);
>> +}
>> +
>> +/*
>> + * normalize_resource
>> + *
>> + * The walk_iomem_res_desc() returns a copy of a resource, not a reference
>> + * to the actual resource in the iomem_resource tree. As a result,
>> + * __release_resource() which relies on pointer equality will fail.
>> + *
>> + * This helper walks the children of the resource's parent to find and
>> + * return the original resource pointer that matches the given resource's
>> + * start and end addresses.
>> + *
>> + * Return: Pointer to the matching original resource in iomem_resource, or
>> + *         NULL if not found or invalid input.
>> + */
>> +static struct resource *normalize_resource(struct resource *res)
>> +{
>> +	if (!res || !res->parent)
>> +		return NULL;
>> +
>> +	for (struct resource *res_iter = res->parent->child;
>> +	     res_iter != NULL; res_iter = res_iter->sibling) {
>> +		if ((res_iter->start == res->start) &&
>> +		    (res_iter->end == res->end))
>> +			return res_iter;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +static int __cxl_region_softreserv_update(struct resource *soft,
>> +					  void *_cxlr)
>> +{
>> +	struct cxl_region *cxlr = _cxlr;
>> +	struct resource *res = cxlr->params.res;
>> +
>> +	/* Skip non-intersecting soft-reserved regions */
>> +	if (soft->end < res->start || soft->start > res->end)
>> +		return 0;
>> +
>> +	soft = normalize_resource(soft);
>> +	if (!soft)
>> +		return -EINVAL;
>> +
>> +	remove_soft_reserved(cxlr, soft, res->start, res->end);
>> +
>> +	return 0;
>> +}
>> +
>> +int cxl_region_softreserv_update(void)
>> +{
>> +	struct device *dev = NULL;
>> +
>> +	while ((dev = bus_find_next_device(&cxl_bus_type, dev))) {
>> +		struct device *put_dev __free(put_device) = dev;
>> +		struct cxl_region *cxlr;
>> +
>> +		if (!is_cxl_region(dev))
>> +			continue;
>> +
>> +		cxlr = to_cxl_region(dev);
>> +
>> +		walk_iomem_res_desc(IORES_DESC_SOFT_RESERVED,
>> +				    IORESOURCE_MEM, 0, -1, cxlr,
>> +				    __cxl_region_softreserv_update);
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_region_softreserv_update, "CXL");
>> +
>>    u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa)
>>    {
>>    	struct cxl_region_ref *iter;
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 1ba7d39c2991..fc39c4b24745 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -859,6 +859,7 @@ struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev);
>>    int cxl_add_to_region(struct cxl_port *root,
>>    		      struct cxl_endpoint_decoder *cxled);
>>    struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
>> +int cxl_region_softreserv_update(void);
>>    u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa);
>>    #else
>>    static inline bool is_cxl_pmem_region(struct device *dev)
>> @@ -878,6 +879,10 @@ static inline struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
>>    {
>>    	return NULL;
>>    }
>> +static inline int cxl_region_softreserv_update(void)
>> +{
>> +	return 0;
>> +}
>>    static inline u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint,
>>    					       u64 spa)
>>    {



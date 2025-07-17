Return-Path: <linux-fsdevel+bounces-55281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B05CB093AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 19:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B590B5A03CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 17:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1E62FE39D;
	Thu, 17 Jul 2025 17:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5FJQc1hW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2044.outbound.protection.outlook.com [40.107.101.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5870C4503B;
	Thu, 17 Jul 2025 17:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752775128; cv=fail; b=uxdp37s/7rQt07OHwh5JIWVt/0aFmNhqWgRMAhppa+JTGDvanC0siCBOmv+FnWqv1+gFIymSyumG2rgdjfJ3DYG23kdCpPUgDaucVykGd+e+Qb1lgIf538LkL/gShG4+PkGX0t2fB13J4MTU8kS1YDru5FK99MbWGr8NtLNmNMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752775128; c=relaxed/simple;
	bh=ySbI7Sx/sLJlbEotFgCmuEAcLYndflfdVK6EWSN+WRI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rPIVEDdGGzdlJKyHl6SFWsLcTzLHk/IMii0sCubKjJzbiRFmfCgIFavDJw7nSw1+hM9GyjAdKqSUP5uJhReXkOWi1X7KNysyxd7AojHJESy+urmRYPZ3C/D4ySC2iOlhhKE0RwN2S1a0cVn9oMua3IBlJY6DlOEFOA+26+lgbik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5FJQc1hW; arc=fail smtp.client-ip=40.107.101.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Flh+Bz8H0480c+3I58kyNvd6/lTW+HG7/BMNJCj9BHDckvwu1AovlLU8jQd0fK7d5lz2+lfnyquVsDLCVlaNu7YMXjy6gJPpdTZwSTasjEpeOxe03pEel4dxGlaUr9Uf6jexFFmuxF94IMXrB8T3TEYqdB1Tf5uyMBPhNuMalzEPFPKha+F2za102WrhrSluHawXJkYINcb9b1Onh3V7tSuu3i0CsSWjjgFLVhdVSlnl/tSZi2V9ci7G5/ysyK6V8mQovzQP1duqwvolFWsXgfhi9qo62akZDuL4sQDgZ88W7N+RT3IuDbCyvZQkng5G26auYWEmOHN4dRaBp0lJXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUB3YAoKPZt/aTjjrmTw0DqGHz/mPh7X00s7SKRcTaQ=;
 b=ykOWbV9+j/0UTRjMWjBakQK1bnm2MUfNKiG7hevQ/hXPAPw1rhkX+x4+w7wVOWrZ4nCz6qGYO/zq9QSoBMMHH6m9bg7NSlE9I5ROWBCjjlObNsf6/IC9VVSEM+hndk9yplR4/0sZHhz+N1Z6CkA5lvJbJX3XYqt2sxw8ungU+1nyXyYod8efFuJKtpE/ZU3bF86WapgkMU5+cmEvFzFOKyViRaYrCo7R63Sk7fJ82zEmpAkiCGanyidMhdBXHqaAzZMCyvjdD48e2yUYUTSmhUccAhD0J05U74shuHZ0YIeYrPpCrKU2eVrMY0DWohedo05kvt325B7nKpOGeGM5Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUB3YAoKPZt/aTjjrmTw0DqGHz/mPh7X00s7SKRcTaQ=;
 b=5FJQc1hWuncj195PKt9L+i5TV04zM6gVBC93xbKTU73Sezt9eaxcD3CVYNHqkUPNXox4cXyQm1Ls/k1GBciywyon2el9gqD2owtMHWmAZUrc4+dwTfywViIYxjxoFTl3c7oLnwgFJyhzxcnCyO+x6W58N+XIrQgirtyG1nra3kw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6)
 by MN0PR12MB6001.namprd12.prod.outlook.com (2603:10b6:208:37d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Thu, 17 Jul
 2025 17:58:41 +0000
Received: from MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3]) by MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3%3]) with mapi id 15.20.8901.033; Thu, 17 Jul 2025
 17:58:40 +0000
Message-ID: <844ed7f7-f185-4706-a0ab-efc2f93e6ebb@amd.com>
Date: Thu, 17 Jul 2025 10:58:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/7] Add managed SOFT RESERVE resource handling
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
References: <20250715180407.47426-1-Smita.KoralahalliChannabasappa@amd.com>
 <aHbDLaKt30TglvFa@aschofie-mobl2.lan>
 <4ac55e2c-54a9-4fab-b0c5-2a928faef33e@amd.com>
 <aHgJq6mZiATsY-nX@aschofie-mobl2.lan>
 <9fc29940-3d73-4c71-bb2d-e0c9a0259228@amd.com>
 <aHg6Ri74pew-lenA@aschofie-mobl2.lan>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita"
 <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <aHg6Ri74pew-lenA@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0165.namprd05.prod.outlook.com
 (2603:10b6:a03:339::20) To MW4PR12MB7142.namprd12.prod.outlook.com
 (2603:10b6:303:220::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7142:EE_|MN0PR12MB6001:EE_
X-MS-Office365-Filtering-Correlation-Id: b277b35a-af90-48bd-f69c-08ddc55b8fe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWpSVWcxeTgrVGJFN3h2K1dRQk1malNLVGdiNStHRG9sZFNSN0ZwTGxDWnZr?=
 =?utf-8?B?VTJGWXh6QVVrWnFlRWx6R0RtcVZ5L0NtZ3AveXNmVis1bVpkVWVCMXFpZ1lP?=
 =?utf-8?B?OWNwN2NpOEFmemlvSjE4NGtlRHVQZ0RDclB3byt6ZklpZXZwZXZlUEVYZlBX?=
 =?utf-8?B?b0F2U0hadklNbE5lUjBIWkVBL21HcHR1bHF2REpMK01jclFrNWdkYzdZQ0xx?=
 =?utf-8?B?NG82eE5iVFY3TUlCeU5IV3pPVUMzZ0ZqZUh0MFBEcjZuZzE5ZGo4RWEydEpk?=
 =?utf-8?B?dUhEUEhSdnhLTExjd0JjSWVIWHgxZVk4RkNIZndRYSt2dVZIWTBEN2c0MFZl?=
 =?utf-8?B?bXgybGdPYkxXVDVESVlEZUthejBmVXcrK2crSEtEYkJYWHRuV2VYaU5XZnRZ?=
 =?utf-8?B?UHV1K3JueVNDTVR3aWhMS04vWkpMOS9QNVJvd2E2clVRL3JOS0tRMWdONXlG?=
 =?utf-8?B?MisxVXF1aGhDK1g5cDNSZHh1S1l0UlIrUG01WW5zdU1VWkU4M0JPMHRtaU5S?=
 =?utf-8?B?Y2Zrd1ZFNld4Wk1NN3gvUUJpYlIySUxJMGdJWVRtSWVWWHJCV3RwVXFKQjdE?=
 =?utf-8?B?dHcwQU93ek9wbE1ZSlNtOW1vTVMxMGkvTzluQ3F0bHVBSmJVZm9Qb2xCUHJ2?=
 =?utf-8?B?WGtVYUNPSUhPZjcyL29XbDNVaUtMZkgweUVhZW1MOFV4NUc0V1g2NlVJMlI0?=
 =?utf-8?B?ZVFzQm9rT1hQdDBuTHNtUnJadlZtUkkxaWdwNjBrV2J4RmMxRHJJc2pVamdS?=
 =?utf-8?B?dGJzYVBQeGgwcUUzaytHYUppWnBzUi9kSlBFUFJ5ejltaEI5eDNlN245WitG?=
 =?utf-8?B?ODZnTm1KcmxxSmhPRDZzL1orUkkyTHVqSGxlengrT0dTbUJWSGdJNjdoWDBy?=
 =?utf-8?B?OHJXWk1YcVhFeDY2Y0R0SUVXV0RHckNybEJxYmdzS1lmWGd1Tnd0Y0pURmJr?=
 =?utf-8?B?NmlGbFZWcW0veUlCWVpMWTcyV2VKTkNod0E5akNhSkFJbXVlNVV4Y2QweFVL?=
 =?utf-8?B?aGRobi84YVFaNUxlMTd2SUp1NWR4WDJRV1JLSW9hbWIrbktPdnNXM1liUnhV?=
 =?utf-8?B?YTRaR2ZiUkd1aE01UFROc3o0aVgzd0tqTmFybWRzZjhmL2FKRjFoTCtTTWRn?=
 =?utf-8?B?WlkyRkVKVVJsbkU1OG9zT3RtcmwvM3FnUDRaK1VsZGZZMkFsRE54cTVDaUlQ?=
 =?utf-8?B?RGlvNExTbUhOdXdjT3Vid0lpcnQxTXdUTVJuc1BHbWtYOTZpeUNIbDY4bnha?=
 =?utf-8?B?STR0cGJKRkIyYm9kQW42SzE3Vkk2ejNyRk1ldUszNENsNnh2bWxXVm9iU3hv?=
 =?utf-8?B?M0JkSWhoRGhJWDlGbXZaR1hsZDZpOE1xMG5NK0xVblh4a1JiWFhMd2s3TDl0?=
 =?utf-8?B?aUgveHJxYnVhcm41RTNaTGFPU0tzbTlZbmYzREY4Zlgzc3YrYkcxZWo5d2NU?=
 =?utf-8?B?c0FnbWM1ekRJRml4ZCs5QnF3OFR4TEJtQXV6Vk5PcFNJanluRGhpbzBZdWll?=
 =?utf-8?B?RkRMaVJObC9DUUJZNzAvR3hKdGNVYkMxaHRoSWtjMlVBSTlwRGxpWlpSdW5h?=
 =?utf-8?B?WUNwVFYzM2dPNjI3U0VycitCK2Q0Zm5RcTM5ZUh0Sm9zUi9yVmZRdFF1QjEw?=
 =?utf-8?B?WlRqS3o3OUZodFdSUlo0eGhDVEtYT08rUWRlTGlZa0UxYlNFeDJOL0VYS2E0?=
 =?utf-8?B?Y1RUN3dQdDRjRCtDQS9LYlFrTzBvL3JjcGhTRzRxOUQ5UTNIaFhCaDV3Nktv?=
 =?utf-8?B?RFBmWFVtTHBZQk0rbktwRnBhWSs3SkRPeTBWeXY4WExhVHZmcmRwYzZOZHlU?=
 =?utf-8?B?Zy9NeUVVVG9GeWRuVkk1YXVtc1hzeCsreUxNRERUUUt1WnBneHZJQ0N4ckEx?=
 =?utf-8?B?dEJtY0RzSXhVUVVLSUVhaThqVjFKMnp0N2crYTBWekhLdGJQM24yUHovUlBw?=
 =?utf-8?Q?QPPigrcXc6Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7142.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDZNaTdxcUQxUDhVMVAycnNLNmt6MUFORE5rNlE4K1ZmanZYekl4UVB3NG1k?=
 =?utf-8?B?eFpOT0lmd0x0R3lXMnFMeGZ2TkptdEZrOCtLTVliVk4yZm5tQmJTaTJyMXRS?=
 =?utf-8?B?NnlsdHFLUHVEZy9hWCtMajErRVhuWUVhU0ltdDRXVEFNYzJJMVZpT0dyOEpW?=
 =?utf-8?B?d3Nydit5cklLK3BsN2Q1L0U4c3lEczNEbTZQdk00b3RhTkxNUW4yMHR1bG0x?=
 =?utf-8?B?WDErOGx0K3Y0WlVFa3VPM1NCNU12QjFGNGMyQWJSQmtxUEUvakxsZlBuT0xx?=
 =?utf-8?B?VjM4WWoxbU9kSEhhRXJ3ZmlObjVrSWtaYjRJWmhiUVVqOGJ4NnRwaWxpWmVW?=
 =?utf-8?B?UHRSUHY1VXB6SUdJbSt6YU50WXBDeW01VGVFYWhzNVlpTkdsdnJId2gvUTJJ?=
 =?utf-8?B?OGZhWnl6dFJBVTFkTmp5ZjBYUUYwblNibDlLbEhvenovVmp6Z0dQUThFbU55?=
 =?utf-8?B?YUtGWmFZVno2dGZEQW10eGVrSzhYM2xFeDZqd005cm5VcDJjNHFkVEFWZDZD?=
 =?utf-8?B?aHVncDAza0tjWmVWby9Gdmp5amtGRi8vN29kMjQyN01UaCtYS3pxUDVXMXVL?=
 =?utf-8?B?MmRzUXZhUnFTVGtqQStuSi9yb1BFSGpLNVFncGx6VFJlVUpUclo4cGZleCti?=
 =?utf-8?B?WDhUWjBiZUk3N2gyc293S0ZFdTQ4SzNUQzRod251bURrQXpoVEd1UWVPZmVp?=
 =?utf-8?B?a1RrUDYzbDhxd3kyaUxrTUNycEZlUFBOdG1OZ3F4eFpONmpaVU1mRjBodlJJ?=
 =?utf-8?B?WnIwNjE0eG5qVS9WVi8zMkV5OGtGMlphUGdha3FzcDNTUUFXY29JZTFwWVVa?=
 =?utf-8?B?NExlQ1RDT2xNa2E2T2JLR0JRSGRlMURWeWN4SUdWV1hvRXRmZ2R6SlJEZVJs?=
 =?utf-8?B?b1hicmQ0MGVtZTlzQWQ1RnUyVzhqT3JndUVsTU9mSEd0bEtnN3k2M3BLUkdP?=
 =?utf-8?B?aTJnb3IvNTlxVFlQYWkzY0tHak5kZ2lBa2I3Tnp2cnBjSzVJVFFuV2JLMERv?=
 =?utf-8?B?VkRSdHhkZENsT1lBeHFTU1hZczFOUG1LeUpkTmY3U1NFenNiSzZUSW1SUDF5?=
 =?utf-8?B?M3FDaGl6Q3lMWjMrVDE5dlZxN2lVK2w2K01EWm44WWRsVGtocjBYL2FMa0Vp?=
 =?utf-8?B?aG5OMFo0ZW9wdUs3Zmtpb2dJK0pPclBqdzVnN3dOa2piRUdHREQrUm5mMDk3?=
 =?utf-8?B?R0ZvVklicWd0MzhiNzBHeTFQY2V6M3JiS2NEQTBMS1BIeFJUSEMwMVRXSk5K?=
 =?utf-8?B?MTFqYzJ2azlEZzh5bU02aFZDOFFOaE8xaDh2RVVuK1RVRTIveUY5dEFRRFYy?=
 =?utf-8?B?MDZjRzdDQkcrWlNWYnl6TGc1U3hKdU9mVW1BdzAxb3I4WW5Pei9oZHNTNEF6?=
 =?utf-8?B?bXlsbDBCdElhQXgremdYaGhNWDRPV0pzYkVxWkFSd3M0a2RMQ3BIeWFSL1VC?=
 =?utf-8?B?aXd2TURvZDVGUVowREV3SkRIWVZlcEhDY0p4TTVmdXVvcTYzRU41YWo2MTFH?=
 =?utf-8?B?NHJmMDc2dndhdVkxL3BaTWNSYWxtN1k3Q1dOeDNWS2NjdDY5d045Rk1tNGtE?=
 =?utf-8?B?YmxjR1AwSjUxaEVsQUxOaDMvYVRCaTB2RjRORDBSZkc1aHlPbGZJZnhNeVdU?=
 =?utf-8?B?S1N1MGtHWC9YTXluR2d1R2hXQXdycHRUdnNHT0Z3dkJwRmRTQk9TL1hFSDM1?=
 =?utf-8?B?bS9UUWIzZUlhZGduWjBWamVwRStNVERYY2RaYTBEbkJFcnZHNUFpU0JvdlJp?=
 =?utf-8?B?b0EwS2tLbzhZMWp1UThNdjRiVXRwR2tLZHFVVWtUVVFPcTVkT2x1SmQ0bk1N?=
 =?utf-8?B?UU5TRWFMM3FDdU1IQzRZZXVBWTZNRUdpQnR0TmtGTU1UNTBUaUlrcTZncnJR?=
 =?utf-8?B?aTFYUWZsVE1UdkNWd3NNWTRUZmZ1cTgzOWxWUW1VaGZjRUtVQXZCMFFMSUVn?=
 =?utf-8?B?NjY2OXUxbWRYbG1XUnNKU3JVRk54R0g1VitXTUd3eVlXUzA2QjNtNFhxazRI?=
 =?utf-8?B?enNGTFFIcUJYTTd6RytYRHNiZzRXWE9JYldJdi9GcXRpa1pTVkN3cnV1SklP?=
 =?utf-8?B?SWttcWNDbzUvZVRUYVEyTnM4MGlEeUVwbmdwOWh2bW1MZWhYdlpYTTdkSHBh?=
 =?utf-8?Q?Mz7kVSpVe2EZu5ZsmhlBwcnfG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b277b35a-af90-48bd-f69c-08ddc55b8fe1
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7142.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 17:58:40.5252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HAMT7bqKAmgGkgdgfUQL+XmQmuKQkNvU/sBziUtrQN1SLofH7loq9fMDjosa79iDD9YsA+aVIUFbefM85/dXpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6001



On 7/16/2025 4:48 PM, Alison Schofield wrote:
> On Wed, Jul 16, 2025 at 02:29:52PM -0700, Koralahalli Channabasappa, Smita wrote:
>> On 7/16/2025 1:20 PM, Alison Schofield wrote:
>>> On Tue, Jul 15, 2025 at 11:01:23PM -0700, Koralahalli Channabasappa, Smita wrote:
>>>> Hi Alison,
>>>>
>>>> On 7/15/2025 2:07 PM, Alison Schofield wrote:
>>>>> On Tue, Jul 15, 2025 at 06:04:00PM +0000, Smita Koralahalli wrote:
>>>>>> This series introduces the ability to manage SOFT RESERVED iomem
>>>>>> resources, enabling the CXL driver to remove any portions that
>>>>>> intersect with created CXL regions.
>>>>>
>>>>> Hi Smita,
>>>>>
>>>>> This set applied cleanly to todays cxl-next but fails like appended
>>>>> before region probe.
>>>>>
>>>>> BTW - there were sparse warnings in the build that look related:
>>>>>      CHECK   drivers/dax/hmem/hmem_notify.c
>>>>> drivers/dax/hmem/hmem_notify.c:10:6: warning: context imbalance in 'hmem_register_fallback_handler' - wrong count at exit
>>>>> drivers/dax/hmem/hmem_notify.c:24:9: warning: context imbalance in 'hmem_fallback_register_device' - wrong count at exit
>>>>
>>>> Thanks for pointing this bug. I failed to release the spinlock before
>>>> calling hmem_register_device(), which internally calls platform_device_add()
>>>> and can sleep. The following fix addresses that bug. I’ll incorporate this
>>>> into v6:
>>>>
>>>> diff --git a/drivers/dax/hmem/hmem_notify.c b/drivers/dax/hmem/hmem_notify.c
>>>> index 6c276c5bd51d..8f411f3fe7bd 100644
>>>> --- a/drivers/dax/hmem/hmem_notify.c
>>>> +++ b/drivers/dax/hmem/hmem_notify.c
>>>> @@ -18,8 +18,9 @@ void hmem_fallback_register_device(int target_nid, const
>>>> struct resource *res)
>>>>    {
>>>>           walk_hmem_fn hmem_fn;
>>>>
>>>> -       guard(spinlock)(&hmem_notify_lock);
>>>> +       spin_lock(&hmem_notify_lock);
>>>>           hmem_fn = hmem_fallback_fn;
>>>> +       spin_unlock(&hmem_notify_lock);
>>>>
>>>>           if (hmem_fn)
>>>>                   hmem_fn(target_nid, res);
>>>> --
>>>
>>> Hi Smita,  Adding the above got me past that, and doubling the timeout
>>> below stopped that from happening. After that, I haven't had time to
>>> trace so, I'll just dump on you for now:
>>>
>>> In /proc/iomem
>>> Here, we see a regions resource, no CXL Window, and no dax, and no
>>> actual region, not even disabled, is available.
>>> c080000000-c47fffffff : region0
>>>
>>> And, here no CXL Window, no region, and a soft reserved.
>>> 68e80000000-70e7fffffff : Soft Reserved
>>>     68e80000000-70e7fffffff : dax1.0
>>>       68e80000000-70e7fffffff : System RAM (kmem)
>>>
>>> I haven't yet walked through the v4 to v5 changes so I'll do that next.
>>
>> Hi Alison,
>>
>> To help better understand the current behavior, could you share more about
>> your platform configuration? specifically, are there two memory cards
>> involved? One at c080000000 (which appears as region0) and another at
>> 68e80000000 (which is falling back to kmem via dax1.0)? Additionally, how
>> are the Soft Reserved ranges laid out on your system for these cards? I'm
>> trying to understand the "before" state of the resources i.e, prior to
>> trimming applied by my patches.
> 
> Here are the soft reserveds -
> [] BIOS-e820: [mem 0x000000c080000000-0x000000c47fffffff] soft reserved
> [] BIOS-e820: [mem 0x0000068e80000000-0x0000070e7fffffff] soft reserved
> 
> And this is what we expect -
> 
> c080000000-17dbfffffff : CXL Window 0
>    c080000000-c47fffffff : region2
>      c080000000-c47fffffff : dax0.0
>        c080000000-c47fffffff : System RAM (kmem)
> 
> 
> 68e80000000-8d37fffffff : CXL Window 1
>    68e80000000-70e7fffffff : region5
>      68e80000000-70e7fffffff : dax1.0
>        68e80000000-70e7fffffff : System RAM (kmem)
> 
> And, like in prev message, iv v5 we get -
> 
> c080000000-c47fffffff : region0
> 
> 68e80000000-70e7fffffff : Soft Reserved
>    68e80000000-70e7fffffff : dax1.0
>      68e80000000-70e7fffffff : System RAM (kmem)
> 
> 
> In v4, we 'almost' had what we expect, except that the HMEM driver
> created those dax devices our of Soft Reserveds before region driver
> could do same.
> 

Yeah, the only part I’m uncertain about in v5 is scheduling the fallback 
work from the failure path of cxl_acpi_probe(). That doesn’t feel like 
the right place to do it, and I suspect it might be contributing to the 
unexpected behavior.

v4 had most of the necessary pieces in place, but it didn’t handle 
situations well when the driver load order didn’t go as expected.

Even if we modify v4 to avoid triggering hmem_register_device() directly 
from cxl_acpi_probe() which helps avoid unresolved symbol errors when 
cxl_acpi_probe() loads too early, and instead only rely on dax_hmem to 
pick up Soft Reserved regions after cxl_acpi creates regions, we still 
run into timing issues..

Specifically, there's no guarantee that hmem_register_device() will 
correctly skip the following check if the region state isn't fully 
ready, even with MODULE_SOFTDEP("pre: cxl_acpi") or using 
late_initcall() (which I tried):

if (IS_ENABLED(CONFIG_CXL_REGION) &&
	    region_intersects(res->start, resource_size(res), IORESOURCE_MEM, 
IORES_DESC_CXL) != REGION_DISJOINT) {..

At this point, I’m running out of ideas on how to reliably coordinate 
this.. :(

Thanks
Smita

>>
>> Also, do you think it's feasible to change the direction of the soft reserve
>> trimming, that is, defer it until after CXL region or memdev creation is
>> complete? In this case it would be trimmed after but inline the existing
>> region or memdev creation. This might simplify the flow by removing the need
>> for wait_event_timeout(), wait_for_device_probe() and the workqueue logic
>> inside cxl_acpi_probe().
> 
> Yes that aligns with my simple thinking. There's the trimming after a region
> is successfully created, and it seems that could simply be called at the end
> of *that* region creation.
> 
> Then, there's the round up of all the unused Soft Reserveds, and that has
> to wait until after all regions are created, ie. all endpoints have arrived
> and we've given up all hope of creating another region in that space.
> That's the timing challenge.
> 
> -- Alison
> 
>>
>> (As a side note I experimented changing cxl_acpi_init() to a late_initcall()
>> and observed that it consistently avoided probe ordering issues in my setup.
>>
>> Additional note: I realized that even when cxl_acpi_probe() fails, the
>> fallback DAX registration path (via cxl_softreserv_mem_update()) still waits
>> on cxl_mem_active() and wait_for_device_probe(). I plan to address this in
>> v6 by immediately triggering fallback DAX registration
>> (hmem_register_device()) when the ACPI probe fails, instead of waiting.)
>>
>> Thanks
>> Smita
>>
>>>
>>>>
>>>> As for the log:
>>>> [   53.652454] cxl_acpi:cxl_softreserv_mem_work_fn:888: Timeout waiting for
>>>> cxl_mem probing
>>>>
>>>> I’m still analyzing that. Here's what was my thought process so far.
>>>>
>>>> - This occurs when cxl_acpi_probe() runs significantly earlier than
>>>> cxl_mem_probe(), so CXL region creation (which happens in
>>>> cxl_port_endpoint_probe()) may or may not have completed by the time
>>>> trimming is attempted.
>>>>
>>>> - Both cxl_acpi and cxl_mem have MODULE_SOFTDEPs on cxl_port. This does
>>>> guarantee load order when all components are built as modules. So even if
>>>> the timeout occurs and cxl_mem_probe() hasn’t run within the wait window,
>>>> MODULE_SOFTDEP ensures that cxl_port is loaded before both cxl_acpi and
>>>> cxl_mem in modular configurations. As a result, region creation is
>>>> eventually guaranteed, and wait_for_device_probe() will succeed once the
>>>> relevant probes complete.
>>>>
>>>> - However, when both CONFIG_CXL_PORT=y and CONFIG_CXL_ACPI=y, there's no
>>>> guarantee of probe ordering. In such cases, cxl_acpi_probe() may finish
>>>> before cxl_port_probe() even begins, which can cause wait_for_device_probe()
>>>> to return prematurely and trigger the timeout.
>>>>
>>>> - In my local setup, I observed that a 30-second timeout was generally
>>>> sufficient to catch this race, allowing cxl_port_probe() to load while
>>>> cxl_acpi_probe() is still active. Since we cannot mix built-in and modular
>>>> components (i.e., have cxl_acpi=y and cxl_port=m), the timeout serves as a
>>>> best-effort mechanism. After the timeout, wait_for_device_probe() ensures
>>>> cxl_port_probe() has completed before trimming proceeds, making the logic
>>>> good enough to most boot-time races.
>>>>
>>>> One possible improvement I’m considering is to schedule a
>>>> delayed_workqueue() from cxl_acpi_probe(). This deferred work could wait
>>>> slightly longer for cxl_mem_probe() to complete (which itself softdeps on
>>>> cxl_port) before initiating the soft reserve trimming.
>>>>
>>>> That said, I'm still evaluating better options to more robustly coordinate
>>>> probe ordering between cxl_acpi, cxl_port, cxl_mem and cxl_region and
>>>> looking for suggestions here.
>>>>
>>>> Thanks
>>>> Smita
>>>>
>>>>>
>>>>>
>>>>> This isn't all the logs, I trimmed. Let me know if you need more or
>>>>> other info to reproduce.
>>>>>
>>>>> [   53.652454] cxl_acpi:cxl_softreserv_mem_work_fn:888: Timeout waiting for cxl_mem probing
>>>>> [   53.653293] BUG: sleeping function called from invalid context at ./include/linux/sched/mm.h:321
>>>>> [   53.653513] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1875, name: kworker/46:1
>>>>> [   53.653540] preempt_count: 1, expected: 0
>>>>> [   53.653554] RCU nest depth: 0, expected: 0
>>>>> [   53.653568] 3 locks held by kworker/46:1/1875:
>>>>> [   53.653569]  #0: ff37d78240041548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x578/0x630
>>>>> [   53.653583]  #1: ff6b0385dedf3e38 (cxl_sr_work){+.+.}-{0:0}, at: process_one_work+0x1bd/0x630
>>>>> [   53.653589]  #2: ffffffffb33476d8 (hmem_notify_lock){+.+.}-{3:3}, at: hmem_fallback_register_device+0x23/0x60
>>>>> [   53.653598] Preemption disabled at:
>>>>> [   53.653599] [<ffffffffb1e23993>] hmem_fallback_register_device+0x23/0x60
>>>>> [   53.653640] CPU: 46 UID: 0 PID: 1875 Comm: kworker/46:1 Not tainted 6.16.0CXL-NEXT-ALISON-SR-V5+ #5 PREEMPT(voluntary)
>>>>> [   53.653643] Workqueue: events cxl_softreserv_mem_work_fn [cxl_acpi]
>>>>> [   53.653648] Call Trace:
>>>>> [   53.653649]  <TASK>
>>>>> [   53.653652]  dump_stack_lvl+0xa8/0xd0
>>>>> [   53.653658]  dump_stack+0x14/0x20
>>>>> [   53.653659]  __might_resched+0x1ae/0x2d0
>>>>> [   53.653666]  __might_sleep+0x48/0x70
>>>>> [   53.653668]  __kmalloc_node_track_caller_noprof+0x349/0x510
>>>>> [   53.653674]  ? __devm_add_action+0x3d/0x160
>>>>> [   53.653685]  ? __pfx_devm_action_release+0x10/0x10
>>>>> [   53.653688]  __devres_alloc_node+0x4a/0x90
>>>>> [   53.653689]  ? __devres_alloc_node+0x4a/0x90
>>>>> [   53.653691]  ? __pfx_release_memregion+0x10/0x10 [dax_hmem]
>>>>> [   53.653693]  __devm_add_action+0x3d/0x160
>>>>> [   53.653696]  hmem_register_device+0xea/0x230 [dax_hmem]
>>>>> [   53.653700]  hmem_fallback_register_device+0x37/0x60
>>>>> [   53.653703]  cxl_softreserv_mem_register+0x24/0x30 [cxl_core]
>>>>> [   53.653739]  walk_iomem_res_desc+0x55/0xb0
>>>>> [   53.653744]  ? __pfx_cxl_softreserv_mem_register+0x10/0x10 [cxl_core]
>>>>> [   53.653755]  cxl_region_softreserv_update+0x46/0x50 [cxl_core]
>>>>> [   53.653761]  cxl_softreserv_mem_work_fn+0x4a/0x110 [cxl_acpi]
>>>>> [   53.653763]  ? __pfx_autoremove_wake_function+0x10/0x10
>>>>> [   53.653768]  process_one_work+0x1fa/0x630
>>>>> [   53.653774]  worker_thread+0x1b2/0x360
>>>>> [   53.653777]  kthread+0x128/0x250
>>>>> [   53.653781]  ? __pfx_worker_thread+0x10/0x10
>>>>> [   53.653784]  ? __pfx_kthread+0x10/0x10
>>>>> [   53.653786]  ret_from_fork+0x139/0x1e0
>>>>> [   53.653790]  ? __pfx_kthread+0x10/0x10
>>>>> [   53.653792]  ret_from_fork_asm+0x1a/0x30
>>>>> [   53.653801]  </TASK>
>>>>>
>>>>> [   53.654193] =============================
>>>>> [   53.654203] [ BUG: Invalid wait context ]
>>>>> [   53.654451] 6.16.0CXL-NEXT-ALISON-SR-V5+ #5 Tainted: G        W
>>>>> [   53.654623] -----------------------------
>>>>> [   53.654785] kworker/46:1/1875 is trying to lock:
>>>>> [   53.654946] ff37d7824096d588 (&root->kernfs_rwsem){++++}-{4:4}, at: kernfs_add_one+0x34/0x390
>>>>> [   53.655115] other info that might help us debug this:
>>>>> [   53.655273] context-{5:5}
>>>>> [   53.655428] 3 locks held by kworker/46:1/1875:
>>>>> [   53.655579]  #0: ff37d78240041548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x578/0x630
>>>>> [   53.655739]  #1: ff6b0385dedf3e38 (cxl_sr_work){+.+.}-{0:0}, at: process_one_work+0x1bd/0x630
>>>>> [   53.655900]  #2: ffffffffb33476d8 (hmem_notify_lock){+.+.}-{3:3}, at: hmem_fallback_register_device+0x23/0x60
>>>>> [   53.656062] stack backtrace:
>>>>> [   53.656224] CPU: 46 UID: 0 PID: 1875 Comm: kworker/46:1 Tainted: G        W           6.16.0CXL-NEXT-ALISON-SR-V5+ #5 PREEMPT(voluntary)
>>>>> [   53.656227] Tainted: [W]=WARN
>>>>> [   53.656228] Workqueue: events cxl_softreserv_mem_work_fn [cxl_acpi]
>>>>> [   53.656232] Call Trace:
>>>>> [   53.656232]  <TASK>
>>>>> [   53.656234]  dump_stack_lvl+0x85/0xd0
>>>>> [   53.656238]  dump_stack+0x14/0x20
>>>>> [   53.656239]  __lock_acquire+0xaf4/0x2200
>>>>> [   53.656246]  lock_acquire+0xd8/0x300
>>>>> [   53.656248]  ? kernfs_add_one+0x34/0x390
>>>>> [   53.656252]  ? __might_resched+0x208/0x2d0
>>>>> [   53.656257]  down_write+0x44/0xe0
>>>>> [   53.656262]  ? kernfs_add_one+0x34/0x390
>>>>> [   53.656263]  kernfs_add_one+0x34/0x390
>>>>> [   53.656265]  kernfs_create_dir_ns+0x5a/0xa0
>>>>> [   53.656268]  sysfs_create_dir_ns+0x74/0xd0
>>>>> [   53.656270]  kobject_add_internal+0xb1/0x2f0
>>>>> [   53.656273]  kobject_add+0x7d/0xf0
>>>>> [   53.656275]  ? get_device_parent+0x28/0x1e0
>>>>> [   53.656280]  ? __pfx_klist_children_get+0x10/0x10
>>>>> [   53.656282]  device_add+0x124/0x8b0
>>>>> [   53.656285]  ? dev_set_name+0x56/0x70
>>>>> [   53.656287]  platform_device_add+0x102/0x260
>>>>> [   53.656289]  hmem_register_device+0x160/0x230 [dax_hmem]
>>>>> [   53.656291]  hmem_fallback_register_device+0x37/0x60
>>>>> [   53.656294]  cxl_softreserv_mem_register+0x24/0x30 [cxl_core]
>>>>> [   53.656323]  walk_iomem_res_desc+0x55/0xb0
>>>>> [   53.656326]  ? __pfx_cxl_softreserv_mem_register+0x10/0x10 [cxl_core]
>>>>> [   53.656335]  cxl_region_softreserv_update+0x46/0x50 [cxl_core]
>>>>> [   53.656342]  cxl_softreserv_mem_work_fn+0x4a/0x110 [cxl_acpi]
>>>>> [   53.656343]  ? __pfx_autoremove_wake_function+0x10/0x10
>>>>> [   53.656346]  process_one_work+0x1fa/0x630
>>>>> [   53.656350]  worker_thread+0x1b2/0x360
>>>>> [   53.656352]  kthread+0x128/0x250
>>>>> [   53.656354]  ? __pfx_worker_thread+0x10/0x10
>>>>> [   53.656356]  ? __pfx_kthread+0x10/0x10
>>>>> [   53.656357]  ret_from_fork+0x139/0x1e0
>>>>> [   53.656360]  ? __pfx_kthread+0x10/0x10
>>>>> [   53.656361]  ret_from_fork_asm+0x1a/0x30
>>>>> [   53.656366]  </TASK>
>>>>> [   53.662274] BUG: scheduling while atomic: kworker/46:1/1875/0x00000002
>>>>> [   53.663552]  schedule+0x4a/0x160
>>>>> [   53.663553]  schedule_timeout+0x10a/0x120
>>>>> [   53.663555]  ? debug_smp_processor_id+0x1b/0x30
>>>>> [   53.663556]  ? trace_hardirqs_on+0x5f/0xd0
>>>>> [   53.663558]  __wait_for_common+0xb9/0x1c0
>>>>> [   53.663559]  ? __pfx_schedule_timeout+0x10/0x10
>>>>> [   53.663561]  wait_for_completion+0x28/0x30
>>>>> [   53.663562]  __synchronize_srcu+0xbf/0x180
>>>>> [   53.663566]  ? __pfx_wakeme_after_rcu+0x10/0x10
>>>>> [   53.663571]  ? i2c_repstart+0x30/0x80
>>>>> [   53.663576]  synchronize_srcu+0x46/0x120
>>>>> [   53.663577]  kill_dax+0x47/0x70
>>>>> [   53.663580]  __devm_create_dev_dax+0x112/0x470
>>>>> [   53.663582]  devm_create_dev_dax+0x26/0x50
>>>>> [   53.663584]  dax_hmem_probe+0x87/0xd0 [dax_hmem]
>>>>> [   53.663585]  platform_probe+0x61/0xd0
>>>>> [   53.663589]  really_probe+0xe2/0x390
>>>>> [   53.663591]  ? __pfx___device_attach_driver+0x10/0x10
>>>>> [   53.663593]  __driver_probe_device+0x7e/0x160
>>>>> [   53.663594]  driver_probe_device+0x23/0xa0
>>>>> [   53.663596]  __device_attach_driver+0x92/0x120
>>>>> [   53.663597]  bus_for_each_drv+0x8c/0xf0
>>>>> [   53.663599]  __device_attach+0xc2/0x1f0
>>>>> [   53.663601]  device_initial_probe+0x17/0x20
>>>>> [   53.663603]  bus_probe_device+0xa8/0xb0
>>>>> [   53.663604]  device_add+0x687/0x8b0
>>>>> [   53.663607]  ? dev_set_name+0x56/0x70
>>>>> [   53.663609]  platform_device_add+0x102/0x260
>>>>> [   53.663610]  hmem_register_device+0x160/0x230 [dax_hmem]
>>>>> [   53.663612]  hmem_fallback_register_device+0x37/0x60
>>>>> [   53.663614]  cxl_softreserv_mem_register+0x24/0x30 [cxl_core]
>>>>> [   53.663637]  walk_iomem_res_desc+0x55/0xb0
>>>>> [   53.663640]  ? __pfx_cxl_softreserv_mem_register+0x10/0x10 [cxl_core]
>>>>> [   53.663647]  cxl_region_softreserv_update+0x46/0x50 [cxl_core]
>>>>> [   53.663654]  cxl_softreserv_mem_work_fn+0x4a/0x110 [cxl_acpi]
>>>>> [   53.663655]  ? __pfx_autoremove_wake_function+0x10/0x10
>>>>> [   53.663658]  process_one_work+0x1fa/0x630
>>>>> [   53.663662]  worker_thread+0x1b2/0x360
>>>>> [   53.663664]  kthread+0x128/0x250
>>>>> [   53.663666]  ? __pfx_worker_thread+0x10/0x10
>>>>> [   53.663668]  ? __pfx_kthread+0x10/0x10
>>>>> [   53.663670]  ret_from_fork+0x139/0x1e0
>>>>> [   53.663672]  ? __pfx_kthread+0x10/0x10
>>>>> [   53.663673]  ret_from_fork_asm+0x1a/0x30
>>>>> [   53.663677]  </TASK>
>>>>> [   53.700107] BUG: scheduling while atomic: kworker/46:1/1875/0x00000002
>>>>> [   53.700264] INFO: lockdep is turned off.
>>>>> [   53.701315] Preemption disabled at:
>>>>> [   53.701316] [<ffffffffb1e23993>] hmem_fallback_register_device+0x23/0x60
>>>>> [   53.701631] CPU: 46 UID: 0 PID: 1875 Comm: kworker/46:1 Tainted: G        W           6.16.0CXL-NEXT-ALISON-SR-V5+ #5 PREEMPT(voluntary)
>>>>> [   53.701633] Tainted: [W]=WARN
>>>>> [   53.701635] Workqueue: events cxl_softreserv_mem_work_fn [cxl_acpi]
>>>>> [   53.701638] Call Trace:
>>>>> [   53.701638]  <TASK>
>>>>> [   53.701640]  dump_stack_lvl+0xa8/0xd0
>>>>> [   53.701644]  dump_stack+0x14/0x20
>>>>> [   53.701645]  __schedule_bug+0xa2/0xd0
>>>>> [   53.701649]  __schedule+0xe6f/0x10d0
>>>>> [   53.701652]  ? debug_smp_processor_id+0x1b/0x30
>>>>> [   53.701655]  ? lock_release+0x1e6/0x2b0
>>>>> [   53.701658]  ? trace_hardirqs_on+0x5f/0xd0
>>>>> [   53.701661]  schedule+0x4a/0x160
>>>>> [   53.701662]  schedule_timeout+0x10a/0x120
>>>>> [   53.701664]  ? debug_smp_processor_id+0x1b/0x30
>>>>> [   53.701666]  ? trace_hardirqs_on+0x5f/0xd0
>>>>> [   53.701667]  __wait_for_common+0xb9/0x1c0
>>>>> [   53.701668]  ? __pfx_schedule_timeout+0x10/0x10
>>>>> [   53.701670]  wait_for_completion+0x28/0x30
>>>>> [   53.701671]  __synchronize_srcu+0xbf/0x180
>>>>> [   53.701677]  ? __pfx_wakeme_after_rcu+0x10/0x10
>>>>> [   53.701682]  ? i2c_repstart+0x30/0x80
>>>>> [   53.701685]  synchronize_srcu+0x46/0x120
>>>>> [   53.701687]  kill_dax+0x47/0x70
>>>>> [   53.701689]  __devm_create_dev_dax+0x112/0x470
>>>>> [   53.701691]  devm_create_dev_dax+0x26/0x50
>>>>> [   53.701693]  dax_hmem_probe+0x87/0xd0 [dax_hmem]
>>>>> [   53.701695]  platform_probe+0x61/0xd0
>>>>> [   53.701698]  really_probe+0xe2/0x390
>>>>> [   53.701700]  ? __pfx___device_attach_driver+0x10/0x10
>>>>> [   53.701701]  __driver_probe_device+0x7e/0x160
>>>>> [   53.701703]  driver_probe_device+0x23/0xa0
>>>>> [   53.701704]  __device_attach_driver+0x92/0x120
>>>>> [   53.701706]  bus_for_each_drv+0x8c/0xf0
>>>>> [   53.701708]  __device_attach+0xc2/0x1f0
>>>>> [   53.701710]  device_initial_probe+0x17/0x20
>>>>> [   53.701711]  bus_probe_device+0xa8/0xb0
>>>>> [   53.701712]  device_add+0x687/0x8b0
>>>>> [   53.701715]  ? dev_set_name+0x56/0x70
>>>>> [   53.701717]  platform_device_add+0x102/0x260
>>>>> [   53.701718]  hmem_register_device+0x160/0x230 [dax_hmem]
>>>>> [   53.701720]  hmem_fallback_register_device+0x37/0x60
>>>>> [   53.701722]  cxl_softreserv_mem_register+0x24/0x30 [cxl_core]
>>>>> [   53.701734]  walk_iomem_res_desc+0x55/0xb0
>>>>> [   53.701738]  ? __pfx_cxl_softreserv_mem_register+0x10/0x10 [cxl_core]
>>>>> [   53.701745]  cxl_region_softreserv_update+0x46/0x50 [cxl_core]
>>>>> [   53.701751]  cxl_softreserv_mem_work_fn+0x4a/0x110 [cxl_acpi]
>>>>> [   53.701752]  ? __pfx_autoremove_wake_function+0x10/0x10
>>>>> [   53.701756]  process_one_work+0x1fa/0x630
>>>>> [   53.701760]  worker_thread+0x1b2/0x360
>>>>> [   53.701762]  kthread+0x128/0x250
>>>>> [   53.701765]  ? __pfx_worker_thread+0x10/0x10
>>>>> [   53.701766]  ? __pfx_kthread+0x10/0x10
>>>>> [   53.701768]  ret_from_fork+0x139/0x1e0
>>>>> [   53.701771]  ? __pfx_kthread+0x10/0x10
>>>>> [   53.701772]  ret_from_fork_asm+0x1a/0x30
>>>>> [   53.701777]  </TASK>
>>>>>
>>>>
>>



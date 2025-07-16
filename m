Return-Path: <linux-fsdevel+bounces-55188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA47B07FA1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 23:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51CE53B8C24
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 21:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034282E611D;
	Wed, 16 Jul 2025 21:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dOSrQNOd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63852E54D3;
	Wed, 16 Jul 2025 21:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752701399; cv=fail; b=REF77/UyhEmOoYoodwJqjUOuyZnsj+beJCe56O5nPfO6E8+/XNdhO5itMykfGjkAtLPXI2Xdj22i1gjjAK3mu7ZKLnKpyLbEQqFL9eK3WtWYP1fqv6FJtpkXMLX9fkAERafChL30ljTWbe5Al8D8m6Wc1XXQKyPZeX5Bfglkb74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752701399; c=relaxed/simple;
	bh=Uj0KcxwcZ1N1wXEGtT145qt/ENLRvjQobuWsrcVPy9w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Drv6Wr7raIFIM+5K5iTm8yfaUI9+bWkom4y+2YwWQ+bTL0I96o8nQLkqmA5g9u1lhfiaoNV7eZ0lW9EUhifLNXX9QsIFCLTWZLYCbMCGDMpNuko6AS6UXK8f/QqqiTmBKA9f0R/l5IWcnHyJYiOxa4bfowAIN/a+dA3YkoBZhaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dOSrQNOd; arc=fail smtp.client-ip=40.107.244.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xGTXHG7DEFVQUk0PE9ySnzDLb3JEgATm1TSzsSVHn2aUe3fvCrXxBbjR8UHRjdwnGGQNetebt3Xe7TUoApwHelAAijsnZj/EbrQN1Bq1zdA11navI6TPpcEcgw4/gLoyLZvQe+6WdAEWYcUjfyZTLJfxE0wqHMDeWnrUAHf9cVxTrPLedPA7N+eMyAQCK+u6EJNLnyQUdaYRdOG9mZaBFHYwE4qwxaPcOtWTF0kXgoorK4/9+5bLm9BOGNu1MNeIBZyXleV0glu2KaJKlzmqj/cff+0/DcywGvDhjKQjU81W+hTygitrpxmLMCw3Jgkg9HFjdwELa5wH5i7XU2gCtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1gX3xadEUc5r5OJt0hRrdiA8aA4SpVyg1gJu1zh6XE=;
 b=vbnuLJ4bgUjeQm/CuSHtQyqRmAfAhgaQV+NNAYsTNRDMe25JuAEqYJ4QlE8D7Zf61gX9Yi1zBecxHKpB9FwzfhSAeUi3qqS+LRkYc2F+kx3PQdnJuQdJ/wFvuSb/zkWZ7/Gg5usY1Osc7+aS+3VVXRnqU0HZdYaqa0ev9crjMYHr7vpdh02lsfdtsBPX6s5xrGqzTnzYRgyrP/pZRK3CriL/yY3wtqoYscgcsaZdlvRhEaJ/U+j6vr/ztvfpLvq65/yOJuYyw8EB7JmWAmfdMJPIXv6sRyS3nwvLgQZmC+zTlSZ44GaVJkC8doOorA1Gdj4mqukIySoluWYu8qjSXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1gX3xadEUc5r5OJt0hRrdiA8aA4SpVyg1gJu1zh6XE=;
 b=dOSrQNOdqlLZVnijmezv/HTCHqHTAUxLBsks6m6c9F+khrnD6UWG13b4LL0SAN3GEzkAIHHZrQmxXv8DIHVLcVcYz7B3cYEreAegLWk0zzyI9kWxuprinrnMDjfUQys1AJpEzvZJIHUt68PzKDLZX6wCglxuZ6vMGjehRYcbvKk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6)
 by CH8PR12MB9741.namprd12.prod.outlook.com (2603:10b6:610:27a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Wed, 16 Jul
 2025 21:29:54 +0000
Received: from MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3]) by MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3%3]) with mapi id 15.20.8901.033; Wed, 16 Jul 2025
 21:29:54 +0000
Message-ID: <9fc29940-3d73-4c71-bb2d-e0c9a0259228@amd.com>
Date: Wed, 16 Jul 2025 14:29:52 -0700
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
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita"
 <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <aHgJq6mZiATsY-nX@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0272.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::7) To MW4PR12MB7142.namprd12.prod.outlook.com
 (2603:10b6:303:220::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7142:EE_|CH8PR12MB9741:EE_
X-MS-Office365-Filtering-Correlation-Id: 3409d82d-c178-473c-f5c4-08ddc4afe7d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTk5d0l6S0hLQSttVWlGZTB2RlJHQWsrUDNVM0piRVJ3UjRXV0NUTWtYbXV0?=
 =?utf-8?B?N3EvQVVseXNnUkJ3MlF0VzgvbWp6N2xjQUx3YXF2bDZtVUR4TGRKY3d0Zjl1?=
 =?utf-8?B?aHkvNGI5cFVKZzB5TDI2UDNSckhGZWkrRmsyT3JUREdLbHBaY3dvOW9kU1hC?=
 =?utf-8?B?SFlUc09VdFVkaXJac0lOSC91ODRhR0NwL0dOS2xxUUZvaHRyRnlNMDN2NytE?=
 =?utf-8?B?aHBuNGdwU1IyU09ML2xjRldaSU9Zbll0Q1hDSTRnSWNJS0V2NDlXNFc1MC9F?=
 =?utf-8?B?UllWbDZjNjFONkI5cStTMnAyb1QxeHBCQjYrRHdVSUx6MUFveFVtc2dtVndC?=
 =?utf-8?B?RnBGVGUxbk8xVkF5cmF3cUVrYUErRFoyaVN1eVdlYkw2alRvby9FYW1jdFFH?=
 =?utf-8?B?L0ZldThkV0FydXhWWWhaZDdERjRWZkVnc1N6YVFSNkR6L3lpWEJ2bjZLU2hR?=
 =?utf-8?B?NStFcldBaVNLcXZXdmFCSHVjTGVybzE1Si9DL295NEtlZGJOeWNmblA2T0xq?=
 =?utf-8?B?SFc5Yit4SWhXeE43eTIzdThDQ2FwT2pTZm90UmEvdDhQd2c2b3A2OU9wa012?=
 =?utf-8?B?a3I5TFZhMnR5UWpPWXp4WTQxTzRvYzRaQ3psTnFtQlplNDkxMm4rN013TG8z?=
 =?utf-8?B?YXBMSytSeTNxMzBsYURuOGdhdVh1QUNzd1hMWGxzVjBUYW4weHhUQmZEdnpj?=
 =?utf-8?B?YmMxVXlwNDM3TjU1R0tFVVNqV1FQamFZV29USGdwKytSODdndDluOEhzY2VX?=
 =?utf-8?B?Z1Bld2JmeDdxQ2FhTzE1bEJXVnZtK1V0eUptdFY3NXNPUk9GZFBjSnVPbjB5?=
 =?utf-8?B?QXlsWWgxSGlYNWV5MzZ6NmFJQm5nSGpSRTZuUUJkZUduQkV5SGh5UFk2Rysy?=
 =?utf-8?B?TEhPTmdLWnA4SlA4bWh4WTNrOW8vbkZ1aXJzeTEwVGRJY09kOFYyZmwxN1k0?=
 =?utf-8?B?MUMzLzJhS3lJNno4OU4zVkQ3cUNuMnBOUmZpQWQ5RWZPa2k3ZmNTaWFlaEJ6?=
 =?utf-8?B?YmFtOEtDNjRVU0ZjYVZvcWxRV2ZrdlI4eDRYZXp5cEtteTROdnpVc05ZRzNX?=
 =?utf-8?B?ZHNRZ0U4bktLV2dndGwvZThhVitrUzVuSGd6dkRrSWlJVGdzQkxkKzNjVEZ0?=
 =?utf-8?B?WnJ1Si8rUEZKY2h6YUhhSWF6WnhjRlFkNk9hZ2RIT0dycnVHUHdaUFV5MDB1?=
 =?utf-8?B?ZU1LN3M5ZFBUQTN1SWloYUZTc21IUEViUmYvdmkxTHNrTmZIOERWODFrZkRy?=
 =?utf-8?B?WXpCdGFWZlJKMndWSmNGYVk0ZE1hNnlZRERJYXNWL242YSs4cGxIdXlDWUp5?=
 =?utf-8?B?WWhxNDVRK0RSaGN4dEhkbWhEdHBET1lLdnZ2U1IwUGRPemd6b2FvNks1ajEw?=
 =?utf-8?B?eEdUWWN0bUFvcFIxenNSZHBtSHNESG1LbW0rVjhtdThwM0FYMGJNbEluMHZB?=
 =?utf-8?B?WGYwTzRJNW95b2dLVklWQlpIN3F0VWg3ZkQ5TTZmNkQ5UGFjay9FSjV1cWp0?=
 =?utf-8?B?VEhtZXAyV1lIRG1nZVQ1YUN6cHdpaVo1QUY3K3VGYmJ2ZVNWZCs4RDZXTG9o?=
 =?utf-8?B?UkZRKzQ3bU9PV2ZpajdFdTJ3SGExWnlkdTZDTFNhcE8rQm9MY0NmM1JUZnF1?=
 =?utf-8?B?VWlEVGpnSGgzNEh4eGZGQzJrRnlqZzRiYjh3ZTY3cTV5ZFJWamlFbmhLVDNQ?=
 =?utf-8?B?aDF0SEIyV0tFZkNqaU1JYWExaC9HU1VjZlNqeHR1WEpKS1c2WTJyYnJPcG9w?=
 =?utf-8?B?NmNvbUlYc3lZb2xZeDBhdkR0RDgzcXVNK1JKNjNJOFU3c0RLZVBKMC9sWEJE?=
 =?utf-8?B?ampNMk56UTVKVlZzdWRuc1RxSWR1RjE2TFo4NzRqN212ZGFhTE1Lc0RCWmww?=
 =?utf-8?B?VCtxb2V3b0w5LytMbEtuOFdtMU5MeUhMM1NsSDVpRnJzT0h1MzczTGtEMUxi?=
 =?utf-8?Q?K6MAxvJQVPQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7142.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEo5WTBzZkJaZWtJR2hEM083TEpMdkxpNzhJblZTcUpoSWExUCtuYVhPNHox?=
 =?utf-8?B?dmlUWWMxeDgyVXFlOEtxKzIvSVBoU2xKQ1M1RGVoU3JIQlZYRUoyT2ExM3la?=
 =?utf-8?B?eXpCVnFGM3QwREtmTHRsdGZpVWZZcS8vYUZUMHVoNEp0QXdwNXE3aFRxSlkw?=
 =?utf-8?B?WTNHRWxML0JVMzRXOW9pUDJWMzEzRDN1dy9vb2dxNm5kbSs4YUlLVFdUODdZ?=
 =?utf-8?B?eXhlS011cUtQbE1ab0NZUUtaSzBhNUNqWVA4bmFUYnB5R05FKzM4enF0Zm5B?=
 =?utf-8?B?Z3JhQWhrS2JrMk9TT3gzbjRsT05qeUYvZFR6c2ZzN2M5U0pZd2ZrbFpZS0VD?=
 =?utf-8?B?bWxEbXQxdVdtUG1SR3ZiNjh4dW9WM3hsQzNhSmt5S0FQemt2Rm1OcUsrS2o0?=
 =?utf-8?B?WExkK3d6TFlHR0ZCbnZVenNHQ3o2U0NiNzdvRXpVcnhZUVRwOXdQTU1VNlZo?=
 =?utf-8?B?bVJFRzJzdGxPVmJwd1FqYTllQ3BuTmNqTGdzTVU0amVPWkJkU2ZuVVJ2SHlW?=
 =?utf-8?B?Q3I5RGZOSHNWbG8xaThKZmQxeVRSeHlkM3oyWFR4T0VrL1hzQ0ttMjBFUTlC?=
 =?utf-8?B?UlNnL0MyYUVKQ2FoODVOSHNyS1NJdDBFOC9kTThYVndUZ0lhOWhvN2QxUkJo?=
 =?utf-8?B?RjQvd05XcW9nVlZEYTNhYXB6OGhNQmI2cHNiZGE4MzVZdU9tdW5HS2xlRDkv?=
 =?utf-8?B?SDlzcXd2SzRxSXBPYzRrZW14bk53RU82clhFK09CUHVDRkpUbVRKeHB5bk41?=
 =?utf-8?B?SkdCbmhaMk5qNDM0eW9Rb1dDQUhLUkUzUXNNbDIrNjUwOURoSno4U05lQ0dF?=
 =?utf-8?B?bmwydmZmam5UN1Y4ZnhIam9ZZ1dEWFpuSHhVTGVsUW9xblpUUEw1RU1YS2Jt?=
 =?utf-8?B?TlphNDhtaEVwQ05SVkpLYXlqdndjbVA5NWdLWFoyTmQ1T1FpQStha3dGOHpk?=
 =?utf-8?B?Ymc4M3A5ckpGbTh3alQ4bTQ3VzB6V3lEU2MvNDNzalRZNzE5SVg5bVQ3RFc2?=
 =?utf-8?B?UjhZejhJUEo5bDZJa2dSU1ArM2pZeUYxcytSYkp2OUJMWjVVK08xb0RPaHBz?=
 =?utf-8?B?dEwvckt5VHNhNWJJRFhzdG5aNVAzL0VuU1BscU9uUXhLTVVaMG5EaG04MDhi?=
 =?utf-8?B?Qk0yVDNmY0YxTy9sRHNNS2dNWmd2c2NNY0NublB1d0FvQjQyQ3R2Yjltd0ZI?=
 =?utf-8?B?YkR2OHYzeDViaDdETWJMckFsZ05wbHlSckZIbWlkalRuU1VPWS9XV1JVb1dR?=
 =?utf-8?B?QWVXVUthbWVRWFpObWlMZThWTWJFOWkrY0gvZXpTZDNMU0s5MFptQWN3ZWZu?=
 =?utf-8?B?UVJabzkxLzBnSEx2dnFHMlJER2hwaDcxeWFKZmVVVnJoMG5aTE51TW5hM1pn?=
 =?utf-8?B?ekdWcUh0eXRrbnMwODQzSUk2S1RiTTZ3RnJKS3BLdnEwV3d6NlpmOXk4L2Iv?=
 =?utf-8?B?UWJBMGd1Rkk5Rmp0RHRkUVZ3MzYySmVhQWlSVHkvS290RjhFRkZ3dTBSZ0NP?=
 =?utf-8?B?RllkQ0QwNFI0a0x0V3pNL0VlcDZiMmExdFc2VFdadVcwbFFyMWhGMzJRRTZJ?=
 =?utf-8?B?WWFDUVp5U0dCNjhZUFZyRG9MUlVIdER4ZlRWbDNNaTU3RWRLb0d6QWdrQU52?=
 =?utf-8?B?dTJ0ZmtsazdzQ1I3RTFvQ1hBZmJaU29LOG1IYy96VEtmcHpBQjJpMElkdE4z?=
 =?utf-8?B?VCsxZStEWnhadXc4RWxLa2Znd0xSeEtSaFAvK2ZwZGJ0UHRjSDJkOTFiVHRs?=
 =?utf-8?B?VFVCRytBUDM3Nnk4MHBjaDZmdDF1Wk5qdUhOcmlFQ2xpaDNZUTIrdURSck00?=
 =?utf-8?B?dGhHeWhueGRxZ05SYlhGYk0vWWFnTHphQi9mUXFGZ2lreTNzekZVRDNEWUZE?=
 =?utf-8?B?VFZMYXlQcVZaTUZUNy9NOWpscHVxelJ4V3ZGaUdjbklPMG4xS0lneTkyL1V6?=
 =?utf-8?B?dnpZZUpOQm93MGN5QmNpcDE5VEt5Q05URTE3MW1PaVpIWkd2VlhDaUJOdzRw?=
 =?utf-8?B?M21lUlhCVWZJejFPdytZZVNFclNEVk1QN1JSb2NtdEtTczVpeDFTMVlkSkFU?=
 =?utf-8?B?bmxWYXlDUmFYRFV4MnZtNXVYdzV3UTltdDdac1ZFWlNwdjF3dDlkZjZKVEZ1?=
 =?utf-8?Q?hydJX3RpLNtTpmmY0nKTl7u7y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3409d82d-c178-473c-f5c4-08ddc4afe7d5
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7142.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 21:29:54.6885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dyp8oEdVSX6M8xj3EKuJnqYrrGet7nNCbFmTmflO5gL4tWTytNxY9Q5XTb4AFBIm2ZoZqtTlMDUyB4gLdL5tJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9741

On 7/16/2025 1:20 PM, Alison Schofield wrote:
> On Tue, Jul 15, 2025 at 11:01:23PM -0700, Koralahalli Channabasappa, Smita wrote:
>> Hi Alison,
>>
>> On 7/15/2025 2:07 PM, Alison Schofield wrote:
>>> On Tue, Jul 15, 2025 at 06:04:00PM +0000, Smita Koralahalli wrote:
>>>> This series introduces the ability to manage SOFT RESERVED iomem
>>>> resources, enabling the CXL driver to remove any portions that
>>>> intersect with created CXL regions.
>>>
>>> Hi Smita,
>>>
>>> This set applied cleanly to todays cxl-next but fails like appended
>>> before region probe.
>>>
>>> BTW - there were sparse warnings in the build that look related:
>>>     CHECK   drivers/dax/hmem/hmem_notify.c
>>> drivers/dax/hmem/hmem_notify.c:10:6: warning: context imbalance in 'hmem_register_fallback_handler' - wrong count at exit
>>> drivers/dax/hmem/hmem_notify.c:24:9: warning: context imbalance in 'hmem_fallback_register_device' - wrong count at exit
>>
>> Thanks for pointing this bug. I failed to release the spinlock before
>> calling hmem_register_device(), which internally calls platform_device_add()
>> and can sleep. The following fix addresses that bug. I’ll incorporate this
>> into v6:
>>
>> diff --git a/drivers/dax/hmem/hmem_notify.c b/drivers/dax/hmem/hmem_notify.c
>> index 6c276c5bd51d..8f411f3fe7bd 100644
>> --- a/drivers/dax/hmem/hmem_notify.c
>> +++ b/drivers/dax/hmem/hmem_notify.c
>> @@ -18,8 +18,9 @@ void hmem_fallback_register_device(int target_nid, const
>> struct resource *res)
>>   {
>>          walk_hmem_fn hmem_fn;
>>
>> -       guard(spinlock)(&hmem_notify_lock);
>> +       spin_lock(&hmem_notify_lock);
>>          hmem_fn = hmem_fallback_fn;
>> +       spin_unlock(&hmem_notify_lock);
>>
>>          if (hmem_fn)
>>                  hmem_fn(target_nid, res);
>> --
> 
> Hi Smita,  Adding the above got me past that, and doubling the timeout
> below stopped that from happening. After that, I haven't had time to
> trace so, I'll just dump on you for now:
> 
> In /proc/iomem
> Here, we see a regions resource, no CXL Window, and no dax, and no
> actual region, not even disabled, is available.
> c080000000-c47fffffff : region0
> 
> And, here no CXL Window, no region, and a soft reserved.
> 68e80000000-70e7fffffff : Soft Reserved
>    68e80000000-70e7fffffff : dax1.0
>      68e80000000-70e7fffffff : System RAM (kmem)
> 
> I haven't yet walked through the v4 to v5 changes so I'll do that next.

Hi Alison,

To help better understand the current behavior, could you share more 
about your platform configuration? specifically, are there two memory 
cards involved? One at c080000000 (which appears as region0) and another 
at 68e80000000 (which is falling back to kmem via dax1.0)? Additionally, 
how are the Soft Reserved ranges laid out on your system for these 
cards? I'm trying to understand the "before" state of the resources i.e, 
prior to trimming applied by my patches.

Also, do you think it's feasible to change the direction of the soft 
reserve trimming, that is, defer it until after CXL region or memdev 
creation is complete? In this case it would be trimmed after but inline 
the existing region or memdev creation. This might simplify the flow by 
removing the need for wait_event_timeout(), wait_for_device_probe() and 
the workqueue logic inside cxl_acpi_probe().

(As a side note I experimented changing cxl_acpi_init() to a 
late_initcall() and observed that it consistently avoided probe ordering 
issues in my setup.

Additional note: I realized that even when cxl_acpi_probe() fails, the 
fallback DAX registration path (via cxl_softreserv_mem_update()) still 
waits on cxl_mem_active() and wait_for_device_probe(). I plan to address 
this in v6 by immediately triggering fallback DAX registration 
(hmem_register_device()) when the ACPI probe fails, instead of waiting.)

Thanks
Smita

> 
>>
>> As for the log:
>> [   53.652454] cxl_acpi:cxl_softreserv_mem_work_fn:888: Timeout waiting for
>> cxl_mem probing
>>
>> I’m still analyzing that. Here's what was my thought process so far.
>>
>> - This occurs when cxl_acpi_probe() runs significantly earlier than
>> cxl_mem_probe(), so CXL region creation (which happens in
>> cxl_port_endpoint_probe()) may or may not have completed by the time
>> trimming is attempted.
>>
>> - Both cxl_acpi and cxl_mem have MODULE_SOFTDEPs on cxl_port. This does
>> guarantee load order when all components are built as modules. So even if
>> the timeout occurs and cxl_mem_probe() hasn’t run within the wait window,
>> MODULE_SOFTDEP ensures that cxl_port is loaded before both cxl_acpi and
>> cxl_mem in modular configurations. As a result, region creation is
>> eventually guaranteed, and wait_for_device_probe() will succeed once the
>> relevant probes complete.
>>
>> - However, when both CONFIG_CXL_PORT=y and CONFIG_CXL_ACPI=y, there's no
>> guarantee of probe ordering. In such cases, cxl_acpi_probe() may finish
>> before cxl_port_probe() even begins, which can cause wait_for_device_probe()
>> to return prematurely and trigger the timeout.
>>
>> - In my local setup, I observed that a 30-second timeout was generally
>> sufficient to catch this race, allowing cxl_port_probe() to load while
>> cxl_acpi_probe() is still active. Since we cannot mix built-in and modular
>> components (i.e., have cxl_acpi=y and cxl_port=m), the timeout serves as a
>> best-effort mechanism. After the timeout, wait_for_device_probe() ensures
>> cxl_port_probe() has completed before trimming proceeds, making the logic
>> good enough to most boot-time races.
>>
>> One possible improvement I’m considering is to schedule a
>> delayed_workqueue() from cxl_acpi_probe(). This deferred work could wait
>> slightly longer for cxl_mem_probe() to complete (which itself softdeps on
>> cxl_port) before initiating the soft reserve trimming.
>>
>> That said, I'm still evaluating better options to more robustly coordinate
>> probe ordering between cxl_acpi, cxl_port, cxl_mem and cxl_region and
>> looking for suggestions here.
>>
>> Thanks
>> Smita
>>
>>>
>>>
>>> This isn't all the logs, I trimmed. Let me know if you need more or
>>> other info to reproduce.
>>>
>>> [   53.652454] cxl_acpi:cxl_softreserv_mem_work_fn:888: Timeout waiting for cxl_mem probing
>>> [   53.653293] BUG: sleeping function called from invalid context at ./include/linux/sched/mm.h:321
>>> [   53.653513] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1875, name: kworker/46:1
>>> [   53.653540] preempt_count: 1, expected: 0
>>> [   53.653554] RCU nest depth: 0, expected: 0
>>> [   53.653568] 3 locks held by kworker/46:1/1875:
>>> [   53.653569]  #0: ff37d78240041548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x578/0x630
>>> [   53.653583]  #1: ff6b0385dedf3e38 (cxl_sr_work){+.+.}-{0:0}, at: process_one_work+0x1bd/0x630
>>> [   53.653589]  #2: ffffffffb33476d8 (hmem_notify_lock){+.+.}-{3:3}, at: hmem_fallback_register_device+0x23/0x60
>>> [   53.653598] Preemption disabled at:
>>> [   53.653599] [<ffffffffb1e23993>] hmem_fallback_register_device+0x23/0x60
>>> [   53.653640] CPU: 46 UID: 0 PID: 1875 Comm: kworker/46:1 Not tainted 6.16.0CXL-NEXT-ALISON-SR-V5+ #5 PREEMPT(voluntary)
>>> [   53.653643] Workqueue: events cxl_softreserv_mem_work_fn [cxl_acpi]
>>> [   53.653648] Call Trace:
>>> [   53.653649]  <TASK>
>>> [   53.653652]  dump_stack_lvl+0xa8/0xd0
>>> [   53.653658]  dump_stack+0x14/0x20
>>> [   53.653659]  __might_resched+0x1ae/0x2d0
>>> [   53.653666]  __might_sleep+0x48/0x70
>>> [   53.653668]  __kmalloc_node_track_caller_noprof+0x349/0x510
>>> [   53.653674]  ? __devm_add_action+0x3d/0x160
>>> [   53.653685]  ? __pfx_devm_action_release+0x10/0x10
>>> [   53.653688]  __devres_alloc_node+0x4a/0x90
>>> [   53.653689]  ? __devres_alloc_node+0x4a/0x90
>>> [   53.653691]  ? __pfx_release_memregion+0x10/0x10 [dax_hmem]
>>> [   53.653693]  __devm_add_action+0x3d/0x160
>>> [   53.653696]  hmem_register_device+0xea/0x230 [dax_hmem]
>>> [   53.653700]  hmem_fallback_register_device+0x37/0x60
>>> [   53.653703]  cxl_softreserv_mem_register+0x24/0x30 [cxl_core]
>>> [   53.653739]  walk_iomem_res_desc+0x55/0xb0
>>> [   53.653744]  ? __pfx_cxl_softreserv_mem_register+0x10/0x10 [cxl_core]
>>> [   53.653755]  cxl_region_softreserv_update+0x46/0x50 [cxl_core]
>>> [   53.653761]  cxl_softreserv_mem_work_fn+0x4a/0x110 [cxl_acpi]
>>> [   53.653763]  ? __pfx_autoremove_wake_function+0x10/0x10
>>> [   53.653768]  process_one_work+0x1fa/0x630
>>> [   53.653774]  worker_thread+0x1b2/0x360
>>> [   53.653777]  kthread+0x128/0x250
>>> [   53.653781]  ? __pfx_worker_thread+0x10/0x10
>>> [   53.653784]  ? __pfx_kthread+0x10/0x10
>>> [   53.653786]  ret_from_fork+0x139/0x1e0
>>> [   53.653790]  ? __pfx_kthread+0x10/0x10
>>> [   53.653792]  ret_from_fork_asm+0x1a/0x30
>>> [   53.653801]  </TASK>
>>>
>>> [   53.654193] =============================
>>> [   53.654203] [ BUG: Invalid wait context ]
>>> [   53.654451] 6.16.0CXL-NEXT-ALISON-SR-V5+ #5 Tainted: G        W
>>> [   53.654623] -----------------------------
>>> [   53.654785] kworker/46:1/1875 is trying to lock:
>>> [   53.654946] ff37d7824096d588 (&root->kernfs_rwsem){++++}-{4:4}, at: kernfs_add_one+0x34/0x390
>>> [   53.655115] other info that might help us debug this:
>>> [   53.655273] context-{5:5}
>>> [   53.655428] 3 locks held by kworker/46:1/1875:
>>> [   53.655579]  #0: ff37d78240041548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x578/0x630
>>> [   53.655739]  #1: ff6b0385dedf3e38 (cxl_sr_work){+.+.}-{0:0}, at: process_one_work+0x1bd/0x630
>>> [   53.655900]  #2: ffffffffb33476d8 (hmem_notify_lock){+.+.}-{3:3}, at: hmem_fallback_register_device+0x23/0x60
>>> [   53.656062] stack backtrace:
>>> [   53.656224] CPU: 46 UID: 0 PID: 1875 Comm: kworker/46:1 Tainted: G        W           6.16.0CXL-NEXT-ALISON-SR-V5+ #5 PREEMPT(voluntary)
>>> [   53.656227] Tainted: [W]=WARN
>>> [   53.656228] Workqueue: events cxl_softreserv_mem_work_fn [cxl_acpi]
>>> [   53.656232] Call Trace:
>>> [   53.656232]  <TASK>
>>> [   53.656234]  dump_stack_lvl+0x85/0xd0
>>> [   53.656238]  dump_stack+0x14/0x20
>>> [   53.656239]  __lock_acquire+0xaf4/0x2200
>>> [   53.656246]  lock_acquire+0xd8/0x300
>>> [   53.656248]  ? kernfs_add_one+0x34/0x390
>>> [   53.656252]  ? __might_resched+0x208/0x2d0
>>> [   53.656257]  down_write+0x44/0xe0
>>> [   53.656262]  ? kernfs_add_one+0x34/0x390
>>> [   53.656263]  kernfs_add_one+0x34/0x390
>>> [   53.656265]  kernfs_create_dir_ns+0x5a/0xa0
>>> [   53.656268]  sysfs_create_dir_ns+0x74/0xd0
>>> [   53.656270]  kobject_add_internal+0xb1/0x2f0
>>> [   53.656273]  kobject_add+0x7d/0xf0
>>> [   53.656275]  ? get_device_parent+0x28/0x1e0
>>> [   53.656280]  ? __pfx_klist_children_get+0x10/0x10
>>> [   53.656282]  device_add+0x124/0x8b0
>>> [   53.656285]  ? dev_set_name+0x56/0x70
>>> [   53.656287]  platform_device_add+0x102/0x260
>>> [   53.656289]  hmem_register_device+0x160/0x230 [dax_hmem]
>>> [   53.656291]  hmem_fallback_register_device+0x37/0x60
>>> [   53.656294]  cxl_softreserv_mem_register+0x24/0x30 [cxl_core]
>>> [   53.656323]  walk_iomem_res_desc+0x55/0xb0
>>> [   53.656326]  ? __pfx_cxl_softreserv_mem_register+0x10/0x10 [cxl_core]
>>> [   53.656335]  cxl_region_softreserv_update+0x46/0x50 [cxl_core]
>>> [   53.656342]  cxl_softreserv_mem_work_fn+0x4a/0x110 [cxl_acpi]
>>> [   53.656343]  ? __pfx_autoremove_wake_function+0x10/0x10
>>> [   53.656346]  process_one_work+0x1fa/0x630
>>> [   53.656350]  worker_thread+0x1b2/0x360
>>> [   53.656352]  kthread+0x128/0x250
>>> [   53.656354]  ? __pfx_worker_thread+0x10/0x10
>>> [   53.656356]  ? __pfx_kthread+0x10/0x10
>>> [   53.656357]  ret_from_fork+0x139/0x1e0
>>> [   53.656360]  ? __pfx_kthread+0x10/0x10
>>> [   53.656361]  ret_from_fork_asm+0x1a/0x30
>>> [   53.656366]  </TASK>
>>> [   53.662274] BUG: scheduling while atomic: kworker/46:1/1875/0x00000002
>>> [   53.663552]  schedule+0x4a/0x160
>>> [   53.663553]  schedule_timeout+0x10a/0x120
>>> [   53.663555]  ? debug_smp_processor_id+0x1b/0x30
>>> [   53.663556]  ? trace_hardirqs_on+0x5f/0xd0
>>> [   53.663558]  __wait_for_common+0xb9/0x1c0
>>> [   53.663559]  ? __pfx_schedule_timeout+0x10/0x10
>>> [   53.663561]  wait_for_completion+0x28/0x30
>>> [   53.663562]  __synchronize_srcu+0xbf/0x180
>>> [   53.663566]  ? __pfx_wakeme_after_rcu+0x10/0x10
>>> [   53.663571]  ? i2c_repstart+0x30/0x80
>>> [   53.663576]  synchronize_srcu+0x46/0x120
>>> [   53.663577]  kill_dax+0x47/0x70
>>> [   53.663580]  __devm_create_dev_dax+0x112/0x470
>>> [   53.663582]  devm_create_dev_dax+0x26/0x50
>>> [   53.663584]  dax_hmem_probe+0x87/0xd0 [dax_hmem]
>>> [   53.663585]  platform_probe+0x61/0xd0
>>> [   53.663589]  really_probe+0xe2/0x390
>>> [   53.663591]  ? __pfx___device_attach_driver+0x10/0x10
>>> [   53.663593]  __driver_probe_device+0x7e/0x160
>>> [   53.663594]  driver_probe_device+0x23/0xa0
>>> [   53.663596]  __device_attach_driver+0x92/0x120
>>> [   53.663597]  bus_for_each_drv+0x8c/0xf0
>>> [   53.663599]  __device_attach+0xc2/0x1f0
>>> [   53.663601]  device_initial_probe+0x17/0x20
>>> [   53.663603]  bus_probe_device+0xa8/0xb0
>>> [   53.663604]  device_add+0x687/0x8b0
>>> [   53.663607]  ? dev_set_name+0x56/0x70
>>> [   53.663609]  platform_device_add+0x102/0x260
>>> [   53.663610]  hmem_register_device+0x160/0x230 [dax_hmem]
>>> [   53.663612]  hmem_fallback_register_device+0x37/0x60
>>> [   53.663614]  cxl_softreserv_mem_register+0x24/0x30 [cxl_core]
>>> [   53.663637]  walk_iomem_res_desc+0x55/0xb0
>>> [   53.663640]  ? __pfx_cxl_softreserv_mem_register+0x10/0x10 [cxl_core]
>>> [   53.663647]  cxl_region_softreserv_update+0x46/0x50 [cxl_core]
>>> [   53.663654]  cxl_softreserv_mem_work_fn+0x4a/0x110 [cxl_acpi]
>>> [   53.663655]  ? __pfx_autoremove_wake_function+0x10/0x10
>>> [   53.663658]  process_one_work+0x1fa/0x630
>>> [   53.663662]  worker_thread+0x1b2/0x360
>>> [   53.663664]  kthread+0x128/0x250
>>> [   53.663666]  ? __pfx_worker_thread+0x10/0x10
>>> [   53.663668]  ? __pfx_kthread+0x10/0x10
>>> [   53.663670]  ret_from_fork+0x139/0x1e0
>>> [   53.663672]  ? __pfx_kthread+0x10/0x10
>>> [   53.663673]  ret_from_fork_asm+0x1a/0x30
>>> [   53.663677]  </TASK>
>>> [   53.700107] BUG: scheduling while atomic: kworker/46:1/1875/0x00000002
>>> [   53.700264] INFO: lockdep is turned off.
>>> [   53.701315] Preemption disabled at:
>>> [   53.701316] [<ffffffffb1e23993>] hmem_fallback_register_device+0x23/0x60
>>> [   53.701631] CPU: 46 UID: 0 PID: 1875 Comm: kworker/46:1 Tainted: G        W           6.16.0CXL-NEXT-ALISON-SR-V5+ #5 PREEMPT(voluntary)
>>> [   53.701633] Tainted: [W]=WARN
>>> [   53.701635] Workqueue: events cxl_softreserv_mem_work_fn [cxl_acpi]
>>> [   53.701638] Call Trace:
>>> [   53.701638]  <TASK>
>>> [   53.701640]  dump_stack_lvl+0xa8/0xd0
>>> [   53.701644]  dump_stack+0x14/0x20
>>> [   53.701645]  __schedule_bug+0xa2/0xd0
>>> [   53.701649]  __schedule+0xe6f/0x10d0
>>> [   53.701652]  ? debug_smp_processor_id+0x1b/0x30
>>> [   53.701655]  ? lock_release+0x1e6/0x2b0
>>> [   53.701658]  ? trace_hardirqs_on+0x5f/0xd0
>>> [   53.701661]  schedule+0x4a/0x160
>>> [   53.701662]  schedule_timeout+0x10a/0x120
>>> [   53.701664]  ? debug_smp_processor_id+0x1b/0x30
>>> [   53.701666]  ? trace_hardirqs_on+0x5f/0xd0
>>> [   53.701667]  __wait_for_common+0xb9/0x1c0
>>> [   53.701668]  ? __pfx_schedule_timeout+0x10/0x10
>>> [   53.701670]  wait_for_completion+0x28/0x30
>>> [   53.701671]  __synchronize_srcu+0xbf/0x180
>>> [   53.701677]  ? __pfx_wakeme_after_rcu+0x10/0x10
>>> [   53.701682]  ? i2c_repstart+0x30/0x80
>>> [   53.701685]  synchronize_srcu+0x46/0x120
>>> [   53.701687]  kill_dax+0x47/0x70
>>> [   53.701689]  __devm_create_dev_dax+0x112/0x470
>>> [   53.701691]  devm_create_dev_dax+0x26/0x50
>>> [   53.701693]  dax_hmem_probe+0x87/0xd0 [dax_hmem]
>>> [   53.701695]  platform_probe+0x61/0xd0
>>> [   53.701698]  really_probe+0xe2/0x390
>>> [   53.701700]  ? __pfx___device_attach_driver+0x10/0x10
>>> [   53.701701]  __driver_probe_device+0x7e/0x160
>>> [   53.701703]  driver_probe_device+0x23/0xa0
>>> [   53.701704]  __device_attach_driver+0x92/0x120
>>> [   53.701706]  bus_for_each_drv+0x8c/0xf0
>>> [   53.701708]  __device_attach+0xc2/0x1f0
>>> [   53.701710]  device_initial_probe+0x17/0x20
>>> [   53.701711]  bus_probe_device+0xa8/0xb0
>>> [   53.701712]  device_add+0x687/0x8b0
>>> [   53.701715]  ? dev_set_name+0x56/0x70
>>> [   53.701717]  platform_device_add+0x102/0x260
>>> [   53.701718]  hmem_register_device+0x160/0x230 [dax_hmem]
>>> [   53.701720]  hmem_fallback_register_device+0x37/0x60
>>> [   53.701722]  cxl_softreserv_mem_register+0x24/0x30 [cxl_core]
>>> [   53.701734]  walk_iomem_res_desc+0x55/0xb0
>>> [   53.701738]  ? __pfx_cxl_softreserv_mem_register+0x10/0x10 [cxl_core]
>>> [   53.701745]  cxl_region_softreserv_update+0x46/0x50 [cxl_core]
>>> [   53.701751]  cxl_softreserv_mem_work_fn+0x4a/0x110 [cxl_acpi]
>>> [   53.701752]  ? __pfx_autoremove_wake_function+0x10/0x10
>>> [   53.701756]  process_one_work+0x1fa/0x630
>>> [   53.701760]  worker_thread+0x1b2/0x360
>>> [   53.701762]  kthread+0x128/0x250
>>> [   53.701765]  ? __pfx_worker_thread+0x10/0x10
>>> [   53.701766]  ? __pfx_kthread+0x10/0x10
>>> [   53.701768]  ret_from_fork+0x139/0x1e0
>>> [   53.701771]  ? __pfx_kthread+0x10/0x10
>>> [   53.701772]  ret_from_fork_asm+0x1a/0x30
>>> [   53.701777]  </TASK>
>>>
>>



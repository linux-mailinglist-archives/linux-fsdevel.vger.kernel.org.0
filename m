Return-Path: <linux-fsdevel+bounces-60968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9341B53C70
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 21:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D88CE1C28895
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 19:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6491FECD4;
	Thu, 11 Sep 2025 19:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tMw+ASjs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AF9246BD8;
	Thu, 11 Sep 2025 19:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757619558; cv=fail; b=dwFVGgSopSLkLxdVQeKMQokeh2oIrsKN2+XIdKpAStPgX4vEeeFunTfMp4Hf59054CJeCnIeSKEKljFuxS14JOzbl6dZ+3lRn0v8LjRIGc/ay7gvk5lmsagJPVsdLBwORUHxfyo9TzJskqoFulxPxXG8MCg2LNufYYz/2ZcbZXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757619558; c=relaxed/simple;
	bh=ew44o9sS4K0l+t2GVsAOWd9xjRrT3YV2vu76kQobcjI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cJajHowiQBjbKqSHzfTzrPAu1/Fd2/9CI0q4SNPb5oaL5Oqw1bWjNsbvDOZBuGaz1jk09Dmy5bVaIDSuDE6Vqy9//r/BLjRyzXV3CThmNkgL8w3xWJ4KHxsUvGdy4qUqp9ovdF3RHsTn/NkIW7Z6M9XZf5QHqruX/R+9QSCeurE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tMw+ASjs; arc=fail smtp.client-ip=40.107.94.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jFRI8VFXblvwQqNWROlGTEBUurRc1S7KDNc6IIEIWL/wFtvaAa2cMhhwYCowx+vINNA/EYqnAccxDmXrKBkIuRB1rtbeBvnBL/xOaspbaKpAYj6TbVFCxDA+TTtgJmiaYiC2g0UfAZBRFAnUKCf0dXWX2yj95nYznCIJduIxHOO9NeLbyI5l0bnP0EL0iTgTJeCgXjFmtQScXCcAsTy2rJa1ptigXyLUbPuJR+9bsidp+qcYJrLwbrWSf1jlo3DMugi1Z5jZmPRyHnLbp5kRwoiRr7D4nDvYibIqfVfCrXwCFLP1SkXtCkx70l8hxP0d/qtrL6akUNvteEhNdGtq2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Xm6XA8qElkANEZ/Y6Gl7Cvd2GioaELQ9fx4B6cOS9E=;
 b=wBtxHjpt9WEM9qgeev6aV9VzzGaegDXqP1zD3c5pay1S7QVzUhgWZ6PspoQ5MjOVcsrfxI41lrLquRbdFpIczwmIlJYmFykUv5qjSTuhCAGv3hidxnc9wfLt7LSKtHZD1i9c15vjw03NBEMNeGm+bLvb/Fh/KTsegnvnao0QPnIH55dTLyB/QbfwcC0hF5LTpeuWGPBwbP4MUDSwgtE4rOZLuJt6ctgCQoWmS1KubgZYHsCW8QdQK5wnDWCoLLtPvF3hyHSgbZoUtwrZQYEUgIa/YjrzctnKSvz5vRnRxCsLlSHgk3sngqLMhrBDYjg+wJsfXLOthOeF8yQ4rSkTfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Xm6XA8qElkANEZ/Y6Gl7Cvd2GioaELQ9fx4B6cOS9E=;
 b=tMw+ASjsluFaWoVgQkVomAMRpqrqCsebtNfZq2iXDxl58+oTErRf/LiFBhonsOIPG3/EyLFLr2Anw1I3zQQTY2n/XCCja20iD3FdR7uGKz+OUpw2K9mDVKzLg8JBA/AYmGqqQTMP9qMGYMByNumDwmqYPPAppqJAay/nzdXJek0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB7127.namprd12.prod.outlook.com (2603:10b6:806:29e::18)
 by SA1PR12MB5659.namprd12.prod.outlook.com (2603:10b6:806:236::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 19:39:13 +0000
Received: from SA1PR12MB7127.namprd12.prod.outlook.com
 ([fe80::c7f2:591b:7587:a835]) by SA1PR12MB7127.namprd12.prod.outlook.com
 ([fe80::c7f2:591b:7587:a835%5]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 19:39:13 +0000
Message-ID: <d3e696c4-1ffa-47f0-baee-cb1bb4296332@amd.com>
Date: Thu, 11 Sep 2025 12:39:09 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dax/hmem, e820, resource: Defer Soft Reserved
 registration until hmem is ready
To: dan.j.williams@intel.com,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
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
 Zhijian Li <lizhijian@fujitsu.com>, ardb@kernel.org, bp@alien8.de
References: <20250822034202.26896-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250822034202.26896-2-Smita.KoralahalliChannabasappa@amd.com>
 <68bf603dee8ff_75e31001d@dwillia2-mobl4.notmuch>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
In-Reply-To: <68bf603dee8ff_75e31001d@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::30) To SA1PR12MB7127.namprd12.prod.outlook.com
 (2603:10b6:806:29e::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB7127:EE_|SA1PR12MB5659:EE_
X-MS-Office365-Filtering-Correlation-Id: 84e9e423-4777-4842-0164-08ddf16ae2aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aUlnTnpLaXZYOE83a1J0YVlTYnRIWGlCcFZXbUpQemVsamRqZVB1Sjc2cDJo?=
 =?utf-8?B?c1lMaG16bDMwWE1KdlJTdStUUUE2VCtMY0RCWlVQVEh2YkZoMjdHekptcm42?=
 =?utf-8?B?ajZvaFBpc3ZBRDNDc2hlRnhhT0Z5RHg0QlVRZ1lIdEJBRHdQNTQ0ZVV6V2JD?=
 =?utf-8?B?K2pGd3hnaFBYWXhzbWpLT2x3aGlIV2JXaDRNejJkWHVrZDlPWUVwU1FpZkU5?=
 =?utf-8?B?TmdHUWlpNnBobjl6K0RaNEVvdnVvdlVQelg2QzkyQWJUOHluMStCTzhEdlJG?=
 =?utf-8?B?OW5jYmhtUFB5UTBMMHc3bStVcnlKaUY3c3RIcU5BYXovR3pPV1E1UjFSRlR0?=
 =?utf-8?B?aE9rOSs5VXhTdXBkQWFZUmFRdThaVlZoNDZxVElmNG5iYmo1WU9xU0JiS0FK?=
 =?utf-8?B?NDZBbytZeE04YUlwb2RxelMxTHo4djRGSUk4TEJ5VmhJL29mWHpvWlJMVGMy?=
 =?utf-8?B?Ky9heXFIYzhKM01GdFJ1RWFvU2RPYk44dUFKYlc1TzZlMVBieU11cnljTzJ1?=
 =?utf-8?B?blF6VHJYQWhGNURYYlFxRjJ6YnhPalhvTGcwY0IvcVpGU2haZzM5NzlvYU1t?=
 =?utf-8?B?dEpYcjZOTVd3WjF0R0FOR1l6YTB3MC91WnNjUml1OXBuMVhtQ3Qwc0xtbW0v?=
 =?utf-8?B?c1U3Y2s5T0N6SlZtT2FLZm1zZGRZVkJKRWY2bjVJTnlEUVlTa3A3TXVqeUxC?=
 =?utf-8?B?MmpBMGVQRi9KWnR1Z2pVeElXVWo5bzQzalFGQ3JOa3MyblExa1NobytrUHYz?=
 =?utf-8?B?cEUwY1pJdzY5amZhcDZaWFVkMEJIclE4d2pFMkFJMFNyZzBVZU5XMjFLTWZO?=
 =?utf-8?B?TDA4SVJLaDZqVlhqZlVWaVB3WVM5VWRpN29Ib0owSWhFeWc5SnNJdmN0MWxX?=
 =?utf-8?B?YXBENUNSU3BuVTYvQXVYT0xGd0VQS29STXNpVjJLYWZxRHBGMmErSm9mSjNJ?=
 =?utf-8?B?cTQreHVPaHJ0SGdHV0w4RjhqbHJDNTZJN2xhSCtkMkhyRVVVZGMwWUFqUmJV?=
 =?utf-8?B?WkF6Vm11Y1hOMEZIQ3FtcEEwbmE5K0lIeHg4RWFVZ25hTXg0eW9tSjU5NFdM?=
 =?utf-8?B?eDVseEdmZkpac3NsT2dwYU1HYXBncC9acTVIQjk5V3hnRm9qRHlQUjhncXJB?=
 =?utf-8?B?WHRXY0dJN2p2ZDJxam51UXNrL3pSQ1FjSGNrL1lvVWFYMHRKVXJlaXZSdE9P?=
 =?utf-8?B?RThFbGxEdlVnZjRMV2hsTWpoSVZpR3IrZHVJZ3NobWI5UzF2TVVxOVFDUndV?=
 =?utf-8?B?K2owOG1pNUFWYlVxamQ1SmlrZmZKR3VpYTgxWFg5eHBpR0F0T3NENjVjZHJD?=
 =?utf-8?B?M1kvZVJyUGZWMzBJdTR4aHJWR21XUFlzOS9LbEI5TXNLL0xGUU9GbWhBcy90?=
 =?utf-8?B?Y3NjbTVHVHREZTd6UFJnVDlLaS91Qk41bVlnVjRXc09nZDBuK1ZMNWxDRGZK?=
 =?utf-8?B?UVI2eTlUc0JNMnFxT2FKOWNEb1Axc3pWRStlTk1ET01acXlzVjFrTFkwMWtD?=
 =?utf-8?B?TVhqc3UyejZYRXUzOVNMMFNITGJLT1A5dm81TTZjM0grblQvM0c3QXp3ZVQ5?=
 =?utf-8?B?ZWkrK2FGNVZBWWlSYi83cngyK3B6ZVJ1ZjF3MkRQYmtuckV2ZWU1TERUYjJw?=
 =?utf-8?B?Ukx0MWNmbFZTOE5Gd3ozTHRJTVVNUk5vMU1IaTVNbUppZVorMlBRRElHMVRs?=
 =?utf-8?B?TllvR2NqWERzZFBsR0QwNUh0bWd5eUs4dW1DQzlFMFcycHNsSWN0V3ZXOVpj?=
 =?utf-8?B?Z3QwUjJSMysvRExrb2lVdHE4UFdUQkg0UUVvUis1ZGtUZ1pxSklGMnROYkJO?=
 =?utf-8?B?VmRLUUEzNzROa2FrcnExM1dOUitjUWVKMFdybm5jaWRNaUVsS3E2U2lwTHVS?=
 =?utf-8?B?emROSElFOXlySExpOXpkVjhJaUR3YkVXeHc0TSt6bmlhQ3RqbnRXYnNVRzRS?=
 =?utf-8?Q?92Poa3NSmMg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB7127.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkdyYkVsVWgyVmJsdG10N3kreFFwREVBS1VKQitzMVhIaHNlQzVKN25JbTF5?=
 =?utf-8?B?R2Ixa2J6a3NScURNYnNwVkVqQy9oVVZiK28vK1JpL0ZzYzlEVlZ5VmU0eFhZ?=
 =?utf-8?B?YldWZFZvNmVMcU1sRzVOUjl2Q0FtMUlrd3VmT0dLbEtjaElKQi91a2t0ejhD?=
 =?utf-8?B?WmJhck95SURWdFpOcFoybmJnWDV1a3RBQnNjQ3EyU0luMVJURmRndDVLL2JZ?=
 =?utf-8?B?MGpTMGxYVkpIc2lXdDQyRkkzQTVuaHZWcmpuUjNFWGJKdDZyQnlYQ0JZVEpn?=
 =?utf-8?B?Qi9iZ2M4My8raHJYb2R3VnQ0WVRidUN0aGhlbWIzYUxOVHM2bnlwMjlHWnF4?=
 =?utf-8?B?cVhscXBoOUhVUU5Rb0RmYURrcCtabFdrMU0zaXpsTm5JbTFPRFNiV3hSczhk?=
 =?utf-8?B?WE95Y0daMXhnYlM4R3ljQ1RnN3FtMUh5WHJRSmNUV0NXUE1pdHV3UGEwUzU2?=
 =?utf-8?B?Tkp0OFBHUVhUNFVyV2xtZ2RTNUxQYlp5aDZwbUZBTktSbmRDeEhqMXRlbHFC?=
 =?utf-8?B?ZFRUMDVIdHBNR082N2sza0NsL1huaFhOMnducVQzTmhZM0VuaVhFREE1ZDB5?=
 =?utf-8?B?b09DR1lvKzdGZFpBc3dzR3pyVHhMN0pLbndGeTRCRVFKZlkrZzdLTVlTL0VT?=
 =?utf-8?B?YjZyY0F3Rm0rM250MUsweHp3dHdWcm5oZVBxY1l3WnNkNUNNWnZvaFM0UmVD?=
 =?utf-8?B?c2c2dFN5WVpaQ0w2dk5CTVcrbFFmWnJ0bUZKYmV5MWhFanFMYUVka3FjbW9L?=
 =?utf-8?B?QnY1VStRTTBDakR1bW1Mc3kxd0MwNGl0TGlhWUxTQ2xhajlGWFExOHV5Vjlx?=
 =?utf-8?B?c21yU3AwVDQ3L3dac0FFZTlYM0Z2OW91ZDBZY1lyTzUzWFczOHpybG1QMXZC?=
 =?utf-8?B?Z3F3dUNhd1JWVVVUUXdpOE9wRjE2V1ViWjhERE1zRndGMW1weDFSemVNamtG?=
 =?utf-8?B?OWJTbktoeEFOeU4zWmd6MTIvQlBlM2NGcnJXMlNOL0w0a2dieGd0ODFzNzM5?=
 =?utf-8?B?WWhmVU5rRzNReEtja3RWV2dmRDdwMEZ2UXhwL3hXZElJUEJORVJOanJmRUtu?=
 =?utf-8?B?blZHTFgvd2tiNnk0S05ucEhFZTQ0cXVzRXlqVStaZTlVeEJKcjRudFJJbDBk?=
 =?utf-8?B?ZWgwUW5adEh1Z3U2azFBU2lIQzNNQkd5dkpGMEt6VENVRjdSb2phL3E3cVhq?=
 =?utf-8?B?bnlkSFIxbGxxeVYzOHRqdEgzNzU1U1JCay9PQ09sMmhDYUFjbVhtYS9qWkJy?=
 =?utf-8?B?M0FwSjI2RjdLVStBMzU0OHBxWjY0cTZxTDM3MnFzclNxTnp0MHpVb081ajdi?=
 =?utf-8?B?eDNTSk1CU0Z2dDVNTm1FVzJSMHBIanNXanVKVEhWcmVUci9nbm01dWdDbXNY?=
 =?utf-8?B?RG9tYy96VnhZUG1mVm83cU9BWFJveFB5aDRmVitXUXpMazRON1VYOGEyTEk4?=
 =?utf-8?B?QWV2bGJvc3NmTVY2eUthRDRxWEVwOE82U3RmeldPMkU1UEgzMXV4UFlmdzUz?=
 =?utf-8?B?MlRxLytYLy9kUkcwemdnVU55Z2VXOFpTV0xpUXRCQzYxcnRtU0NGQ3lHdStU?=
 =?utf-8?B?RXJmOG83cFZQaGpQeURxMlVJYkd6Vkc2b2N5Lzh2Y0FPMnB1Um9yQ2I0QWQ0?=
 =?utf-8?B?a2hhNEpXWVAwQWZ0eWpyajNrRzMzYzY2VWlaZ3NUWlF2VEZPK2RXakZzWEQ0?=
 =?utf-8?B?d0R3TThRU3NKWUpJYVl2U0tKeEU4WWpvQm1LUUxkRVZRQ2s4dWYzVjBpK0JH?=
 =?utf-8?B?N3ZUS1NVK1YwNFUyVkhlaXJMUlpBbWJub1c4UVM1aHFxSjA1RkN3b0wrdGZB?=
 =?utf-8?B?Q2JBN1ZlS1ZuWXZKSFpDaC9KUUl6czQyRnNxWWd6bklLWlZqUkdzRWhpVkNB?=
 =?utf-8?B?MVYza0JXS09BYVMzWERJeEI1T1BnUWViczNRWU1INm1ieWRUNVZTOXNzMlN3?=
 =?utf-8?B?R3A3L3htSEJtRWhQa0RkeE5iQkFCQ1hHZHZsVE5FT1UvdGI4VlZuVjlZd3BE?=
 =?utf-8?B?OC8wa0lvWmVjbGM5MlBRTTR6OUtQeXBFdmV1M2xUMDhuTTFJYXhNaG5EbUp3?=
 =?utf-8?B?YjVuOGowWGUvWXBtSnZwUUc4VndETzVNUGY0MHJaTGZCaGRYNk9EcjJzQVZS?=
 =?utf-8?Q?LHRBDfS8LFIUOYowMlWXGaplM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e9e423-4777-4842-0164-08ddf16ae2aa
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7127.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 19:39:12.9690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F2SKvmxsU8bD+qYEEjAaEKYuaSxMkvG1M+mX9VWmLzGc75NlgFcjMLmyDE1Y2iBWKlBrVxIOSeC+iPGoCWOpaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5659

On 9/8/2025 4:01 PM, dan.j.williams@intel.com wrote:
> [ add Boris and Ard ]
> 
> Ard, Boris, can you have a look at the touches to early e820/x86 init
> (insert_resource_late()) and give an ack (or nak). The general problem
> here is conflicts between e820 memory resources and CXL subsystem memory
> resources.
> 
> Smita Koralahalli wrote:
>> Insert Soft Reserved memory into a dedicated soft_reserve_resource tree
>> instead of the iomem_resource tree at boot.
>>
>> Publishing Soft Reserved ranges into iomem too early causes conflicts with
>> CXL hotplug and region assembly failure, especially when Soft Reserved
>> overlaps CXL regions.
>>
>> Re-inserting these ranges into iomem will be handled in follow-up patches,
>> after ensuring CXL window publication ordering is stabilized and when the
>> dax_hmem is ready to consume them.
>>
>> This avoids trimming or deleting resources later and provides a cleaner
>> handoff between EFI-defined memory and CXL resource management.
>>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> 
> 
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> Smita, if you added changes this should have Co-developed-by. Otherwise
> plain Signed-off-by is interpreted as only chain of custody.  Any other
> patches that you add my Signed-off-by to should also have
> Co-developed-by or be From: me.
> 
> Alternatively if you completely rewritel a patch with your own approach
> then note the source (with a Link:) and leave off the original SOB.
> 
> Lastly, in this case it looks unmodified from what I wrote? Then it
> should be:
> 
> From: Dan Williams <dan.j.williams@intel.com>
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> 
> ...to show the chain of custody of you forwarding a diff authored
> completely by someone else.

Thanks for clarifying, Dan. I wasn’t aware of the distinction before 
(especially to handle the chain of custody..). I will update to reflect 
that properly and will also be careful with how I handle authorship and 
sign-offs in future submissions.

Thanks
Smita


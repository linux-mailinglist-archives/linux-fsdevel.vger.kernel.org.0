Return-Path: <linux-fsdevel+bounces-63070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D54AFBAB478
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 06:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A2F3B4AEF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 04:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBA526529B;
	Tue, 30 Sep 2025 04:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uoin9hVX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010050.outbound.protection.outlook.com [52.101.61.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DA92475C8;
	Tue, 30 Sep 2025 04:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759205089; cv=fail; b=F/yC+YZVdQmk6mWJTkfe10W22Ug8mn/G9HpGnKv0pMbQQxmucazOHoVCTV0DrO6FyyvnOVPU7Yqf2GRzYQ7y9e1q0YBtMcUXsKrUdlV203WK7gp1NO3uQPuYu8DJTXAdZ+64H9dkAUjEKaZYHD4Tj2RraV15iJX4tMUV9XPqT7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759205089; c=relaxed/simple;
	bh=T6WLO1YO4VBshilAd/fvSVYkR5QY23QQhZgIutlhy34=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D92QSSeyMN371UnmpCFUZe4V0lpACGGTNNBDfWT40V8r9Wn+CcBlq0zzz+S2IIMkTu2EEnUHEhdc1I7jjAuEM0EqLp0518KgSeaiVrZJA6uYztd8Xx57FsoblNdAnoE4c52N3HU/dl2HllPdjYn0/NrqxVADsS4Sdu4Zjr0+Jho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uoin9hVX; arc=fail smtp.client-ip=52.101.61.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ekbaeRVv26DcXfD+d2rBbYmyIv1SyXS99ZdT6c3jhJwaYZa35Tu8t6RPMF6tOpwr9In8+LxOHzH517vot+wOX8sJwTYVIJJw7qjMkH0ani2k6bj0Gt27tWNrWU7hv50oi6bK+FH3zjq1gzl8+Nvaeop3L2mh5IOvN/2hbY67Y6FrTtdFKVQgDLqIAjOKbhZMgg8yH9w3FL7/3qaRAkUHJZlHiZJun6+IUhQHPp/nGr1eLd+Pqig1gse9Ctc9v4M22rLZlgWHuq1VqJUQEPYjDfsfmW81pMVULeKK002gMPRhhe6sXY+1akbw7fSr9GL7gNPSSOgsSBZqaPTeYdAPyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMeDY8jA3RW4qFNK9qdhPtmPgZ/td4A648lupxtKiFE=;
 b=tBEryxnKQVLDaor12UcsFtkcwgFH5SZFrvBYZ7gZumhHauerVBqIQB2JWODB0+23zwkh6QTDACZvAbZGjVlvNqvO+BY/yUrzvQaMpod8PHTognSZ9ItRGRfNwJau+xKDLKPOYQ3LgDQd81+GlAldXK7qFjOa/AkbLGiTv3Tzi1K7Tx3QWGEyQVM64hCFtrGAqHGCPJmRneHULX6PQBrhYCv/LL6IYyi2IqsS0nnePsKePfaiTRTxMmqSfuUDt4WUT19LaZb98JEC4ie/r7Y28dkakob0EmFk29z0kBZpd1LrO1Pk7G1dQmB3Yvn9NzzWoJafnStopOnoqhTkLOhH3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMeDY8jA3RW4qFNK9qdhPtmPgZ/td4A648lupxtKiFE=;
 b=uoin9hVX33beeqj0Z37PnMolFCGnk6nOR12nPJ2Gco3JsMwsc12iUGVG9IQAR3qzLKnUJzUS40nBJ983/K220gaDfp6dOW0fw33HLR7IQrorN25qkPouYW4FWZ9FFSO5lAyeG9YVYuoAGUL58k4FIOIcOucK/EFc9UfY/2Efphg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6)
 by DM4PR12MB8572.namprd12.prod.outlook.com (2603:10b6:8:17d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 04:04:45 +0000
Received: from MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3]) by MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3%7]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 04:04:45 +0000
Message-ID: <876c01d5-0b32-4be0-92c7-acfdbf96767b@amd.com>
Date: Mon, 29 Sep 2025 21:04:42 -0700
User-Agent: Mozilla Thunderbird
From: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
Subject: Re: [PATCH 3/6] dax/hmem, cxl: Tighten dependencies on DEV_DAX_CXL
 and dax_hmem
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
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
References: <20250822034202.26896-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250822034202.26896-4-Smita.KoralahalliChannabasappa@amd.com>
 <e95590e9-5c39-430b-bccd-e531d46c2228@fujitsu.com>
Content-Language: en-US
In-Reply-To: <e95590e9-5c39-430b-bccd-e531d46c2228@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0061.namprd03.prod.outlook.com
 (2603:10b6:a03:331::6) To MW4PR12MB7142.namprd12.prod.outlook.com
 (2603:10b6:303:220::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7142:EE_|DM4PR12MB8572:EE_
X-MS-Office365-Filtering-Correlation-Id: b61d8ef4-075c-4c72-a90c-08ddffd67d50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGdwREliS0NHN1lBRUJPbU9JYVNGRDRLa3VlM2hacGF2ZGN6K2svS1oxdnho?=
 =?utf-8?B?cFBqYjdhdmlOaHN2bitZV3RsWkYxWHJUc25SMURBTGZjN1NnMjAyd3ZiN1BF?=
 =?utf-8?B?dzNrVUFtN2hKWVhIU1dsbmZZd2pVUk1EWHdmbUFKQU05OExHbEZlK1JaYWh1?=
 =?utf-8?B?bUg0dVhCN3Z5QmJ2SkJIZFE5alVrL0IzS0pwMGYxUXNmN1padzNlUC9MV3FM?=
 =?utf-8?B?aS93ckdMVFpObHJEbUUzdXFGY0hNRk9icll4SWZoTzhXcWExVXNVNTcwU00w?=
 =?utf-8?B?a3d6MXVEdjVRbzllbVlwWW9rdjF1MUlxZnpSR2JyMEtRQXdjcWRhM1EzdWQ5?=
 =?utf-8?B?c1NqdlZqVUovTzRNRi9JYW82VXdGcG1aS1BqVFRsL1BUOGtpcmRSajZUUW1w?=
 =?utf-8?B?dktvc1poL25yZ0JRWWxMMGs0Qzc1c3ZYcVh2TEFFaEtBL094b2FTa2w0NUtG?=
 =?utf-8?B?WXFIaEhId2ZYQTBZOVROREFFMk83RGtpY05QN0lKSldZRDVSVC9ndWV0bDRl?=
 =?utf-8?B?UEphdFB1MXdOY0Vvc1lwcTZKUityTy83UXA0WGUwb3Q1VU9BMGthcU5ZRVZo?=
 =?utf-8?B?OWxFdnJyWlZpcGdhblhoNldYTGlxUDNOSnRyejZjMFltRE5XVEJvdG1OWGFW?=
 =?utf-8?B?MmNPZWVISUhaL2V0aFluWnhlYzEvMDA2MmxjVVNzUnlGV0tQcGtrcjZ2N2tk?=
 =?utf-8?B?alZGY2lmaFVxYlRUYTAzd1AvQVZtQ0QwYjV0OUxHQ1VNakVxcnZEQ0NUUTRZ?=
 =?utf-8?B?REIydGtpdnRVVXhHK3F6K2NEZ2Z5eXVkUTlPTmlrTy91d0FsMHFwV0V0OCtt?=
 =?utf-8?B?cWtKODZSWUpwb3BJS3VMbUNXdzg0VUFoU0hJcjY2Y2JGQisyS0YzR1VlVy9u?=
 =?utf-8?B?aGIveUd5MXpOb0ZPM204OUFaZzFPQXRJVWNlU0tpNVB6YWI2L2xRV1BiMzRC?=
 =?utf-8?B?WjExNGdBS1ZJVm9UZDBBVWVHa3BKbVlVR3AxRW8wVWNxRXNJc0F0UXlwUTdG?=
 =?utf-8?B?OUoreWJtVURzaG1vVmhmd0lxZnBHeVRHZTdNWU5PcE5UWHhYVjVtOUNJalYx?=
 =?utf-8?B?d1VqU0xoS1BrRW5Ha1huTXUzcmRCeUh5bVBEK2U0Y01PbVZLeml0Z1JRMXFU?=
 =?utf-8?B?ckY2cTh5MisvSlBLQ3ZVZmJRTnh0S0NsS2NBUzViUVdES0MyYW1ac1Y3c3hZ?=
 =?utf-8?B?YXFENVVNR0dZVWRrU215VkV3OWt5VG1sVzJFMjNOVTY2QmdPNGltR2oyT3Js?=
 =?utf-8?B?a1ZZL1lYd2ZFOXhrVE8xWko2UmN1UG41UXhEdkNGa1Y4dFFkZU5Wd2l2L01X?=
 =?utf-8?B?ZzBIT003UUVkVlIxWHhrY2N1OUs2ZHV1RWhtOFF2ek1NQzQzS3B6NUVqOWhZ?=
 =?utf-8?B?YzZPNlhsczhNZmQ4NHpTcEZoQkZkNzRrbThHTzRkRVlWcytpMGV3Z1F1aExM?=
 =?utf-8?B?RW1ZWHhOZjhIQmxjRk80SzN4TmpUeVBKY2tQNzNxRGZOd25Dc3hpQ0JsZGw4?=
 =?utf-8?B?alJvSUZXKzlJYytuTkcwWW5SQnAwRXhVM25OLzUvMDhXYy9LUVc3VXMwc2k4?=
 =?utf-8?B?bVl0a2tpYThRSEY2MGxESElmR1BvRVR1RVBJWGZRMEJ3YVhPbGVra3JyeHhl?=
 =?utf-8?B?TG80d2Nxb29LWU5YUE05cEFXN0xOWjMwK1Q2SG9TLzY3QjVkc2ExTnJYN0xG?=
 =?utf-8?B?cTNoMEpydlRuT0k3WmdLNDBOZlh6emtPZERsUFdTWFUzUnIwakhCNjhmbnc0?=
 =?utf-8?B?ZldiREJHRWhSVCtLWExvaC9RYmhtOTV3SGlQZDZCR0I1QlIvSFArTlh5WEhL?=
 =?utf-8?B?Z1hoS2s3OU9pWHh1WndjVUlxaVBIdUtCUjgzaDVkY2tPckhVVXlBUW1JUXh0?=
 =?utf-8?B?bU9zNy9panJkZ3ZWVGY1ckxSQkcvb0VHVnAvc1R3TG0ya3J3d2dkZFFxTklo?=
 =?utf-8?Q?uuRH7LyzzIGUn9maO/k2fDlOZmF6tdQK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7142.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nm5VdUNWejVKeDVvWTR6K0p6SHJaTndjdm5rbDlHUEdMdEk5eklTRi94Sk1z?=
 =?utf-8?B?KzZZd2VmZTQydms1SysxV1JXY1lPemhWNk5yQTVqQzBQNnJ1R20vNGVwY3Fm?=
 =?utf-8?B?dWxQWEFwbUVORmtCQ2hmRk0vMERtdXd2cHVYd0IzQlUyend0MjNPV2ZFeVNn?=
 =?utf-8?B?MURDUFErSy92THpoejQzWnFJRWN4S1FRRmpQS2dhUnozc3RVU0FZemEzTzlp?=
 =?utf-8?B?NTBwVm50UnhrQU0vcjR5OWpEeHIrdmdMQU1KVjU3TWVtemliSTRiUlhNYnFX?=
 =?utf-8?B?dG5PWGxycm9rSndndTF5QXQ1QmduMmVyemRncE51RlFDZ2x4cXAwSUJCZGh5?=
 =?utf-8?B?NS9teDk4cWp0Q3FkQnRMakZSUnpwS3hkanNuMEhHZnJlM0IzczF0MEdCZGVv?=
 =?utf-8?B?UUxMVDJUQ3RPLytvZmZQUnM0YTlmRzNuVEFlbGFQK2p5RVMwRE81TUY4QjBt?=
 =?utf-8?B?ZTE3bUxyVVUwS2pXZXRpaEJSMk9sZkZJRHdlV2hFRlZqM1l3QlViZlJ0ZDUv?=
 =?utf-8?B?TUtzU0Y1Rk9YNGVTYUlNcWdsUnZSMDhWQUdCWlBwRWJxZXFEYlhtQnduTnl3?=
 =?utf-8?B?OWZwYngvRUdGOWl0OENQZ05Cc2l1NkJJa0dKTWZ1dHFLOGM5VjNJc3YvMzI2?=
 =?utf-8?B?cE9HVFBrbHFacWljZVpkYXRuWHhNOFNOQThUanUxMGRPYWM5SFhITDZmMEs1?=
 =?utf-8?B?U2RMNkF4cFBUVmtnU3NZSS9COC9aNnFyME1PelB3M3JHcldNTFBveXIzOVdU?=
 =?utf-8?B?OGRnbnpySmkvS2RwUUlGbEVqL3JOdE02S2cvUWZ0Rm5OTE9tNXJ2a1FyclAx?=
 =?utf-8?B?d05UTGcxalJjdVJnSnlCMGh2RG5oeWJhYkRQeDV6Q0pDRVYySGdGY1pZUVJO?=
 =?utf-8?B?NTJmMHV3M3RJaWdpcllMVy9qNHQzdm5hU1BreWd6dWRhOVlmSm5MZ1VUUUhH?=
 =?utf-8?B?aFUydnMyNFd0NG9EajZOa3ZZS1pZYWppUkZFcjJzOWZMdm5tNU41WXowQ1Y5?=
 =?utf-8?B?T2lBYk9nVUxJTURWWS93UTJSVHF4aDVCRnVuOE5pZlJLQW56QVBWMTUwcWRQ?=
 =?utf-8?B?RllXWG1oWVBwSE11SDFhOGZXZmdQUVhUUTA3RzZkSlFpeE5NaHdSOWE2RFJU?=
 =?utf-8?B?S1dvc2JucXduclh1a2pCd3VHUS9jSDczamxqNTk2THFTQXBNaGpIbGswKzRl?=
 =?utf-8?B?ZjF2NDJPZ3U3b1l6eFlhNWhPRjhEaWhIaCtYY0UrQVU4MjJGemFrVCtGS0Zj?=
 =?utf-8?B?UjZ3ajlaR1Y4L3hvNE1FMlFrZkdCclk0by96cU9sSWR2SjFwRlo3MEw1ZkRs?=
 =?utf-8?B?VnIvQ2gwSG0xUjZ0dXJUL0hzKzUxY3Rha0xhcVZrNUpHazUxRyttRjVRYUJv?=
 =?utf-8?B?RFZVQkF2MTN0RHVIcG5oeUFpbEVEZUdXNUFwSkNUWE9zeFdBVnRHVFlSY0Vx?=
 =?utf-8?B?OGQ0NWJQd2F2OUZ4S3Y3aEttUGZyZmRvMVVpcTc1T2tvcGFMRVR2QTcrSWJE?=
 =?utf-8?B?T3oveHR5SUwzV0NBSm1jT1NGL1RNeXA2eDFjaWZZUENORTVWNU9OeUxWWnUv?=
 =?utf-8?B?WU9HSVhmcG5rd1FWc1JDc0UraHE0aXo2bjNlKzdLaDVmNndDakE4UitTTTZY?=
 =?utf-8?B?YnJqMkd3NjRxZCtReENWTzRVenY1by9ZNzJIQm9tQTJyTkRxSFJxUXcyZGRQ?=
 =?utf-8?B?a2plU04zSTEyMm5BcGpuRUM3aHBnQStCWW55QzU4VWZpQ0pLTmp2Sk9FdWZs?=
 =?utf-8?B?OW44bHB1d0xaNmpSY09xUWp3NktkazVFV2FCK1pmRnlybStaWTVENHJKc1g1?=
 =?utf-8?B?d3lsM0sySlBPY2VILytVZVZramE3bFpRMzd2VWd4RXlJTkl1OVZDY0xLaTJs?=
 =?utf-8?B?STRRVTlYbzdRSHBaMU83dWRhZFUvbmhmRXNMUm1uUXczUms2ZDJCcnVVcXVn?=
 =?utf-8?B?cTN5MHhoaFczcktVaG1ld2orZXZRbEZDbEdlSk1OeDZDWjl5Tm9WdkdoNDVz?=
 =?utf-8?B?ZW05eUpub1gzejFyNTVFR2hMV2FLVE52Zm5jSkNzUHVpaG1tV0pqb215SExl?=
 =?utf-8?B?bDZiV0paZmg4enM1WFlzVm1hMmIyYjlFSUsyRjRkTEwrOUtPcWlxT0ZHai9G?=
 =?utf-8?Q?91OwafkAt4jpvD19mcGvxbIJP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b61d8ef4-075c-4c72-a90c-08ddffd67d50
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7142.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 04:04:44.8792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dpvQ9/WHoradxBN8e6wtkYGmCPmG4VnngbQoeOGObvH/nN6KgXTNdR5JuWCqL85NHp0MLxH8GdRjdxJi4m/AEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8572

On 8/31/2025 8:28 PM, Zhijian Li (Fujitsu) wrote:
> 
> 
> On 22/08/2025 11:41, Smita Koralahalli wrote:
>> Update Kconfig and runtime checks to better coordinate dax_cxl and dax_hmem
>> registration.
>>
>> Add explicit Kconfig ordering so that CXL_ACPI and CXL_PCI must be
>> initialized before DEV_DAX_HMEM.
> 
> Is this dependency statement fully accurate? To clarify, another prerequisite for
> this ordering to work correctly is that dax_hmem must explicitly call
> `request_module("cxl_acpi")` and `request_module("cxl_pci")` during its initialization.
>    
> Therefore, I recommend consolidating the following patches into a single commit
> to ensure atomic handling of the initialization order:
> - [PATCH 2/6] dax/hmem: Request cxl_acpi and cxl_pci before walking Soft Reserved ranges
> - [PATCH 3/6] dax/hmem, cxl: Tighten dependencies on DEV_DAX_CXL and dax_hmem
> 
> Thanks
> Zhijian

I have merged 2/6 and 3/6 in v2.

Thanks
Smita

>> This prevents dax_hmem from consuming
>> Soft Reserved ranges before CXL drivers have had a chance to claim them.
>>
>> Replace IS_ENABLED(CONFIG_CXL_REGION) with IS_ENABLED(CONFIG_DEV_DAX_CXL)
>> so the code more precisely reflects when CXL-specific DAX coordination is
>> expected.
>>
>> This ensures that ownership of Soft Reserved ranges is consistently
>> handed off to the CXL stack when DEV_DAX_CXL is configured.



Return-Path: <linux-fsdevel+bounces-26368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BC0958939
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 16:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B9BCB20A0C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 14:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CFD19149F;
	Tue, 20 Aug 2024 14:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="iulr3BfL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.135.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2AE383AB;
	Tue, 20 Aug 2024 14:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.135.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724164076; cv=fail; b=SFFrv8qnndsD5RCR6GHzar8b5ubujWMYv5b7qb30heYQSG+aMJaa2i+kX8gYf9mTG5NIqHsNbEWJDOu0pzAxI4ecmDn1uk6pUoKIXApggVb98u3Cj/3tIVQ7o1neWAxq/GXYeCCo9DJcm3KCXXfvX3V94mz6NPu3piOdSE13Ja4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724164076; c=relaxed/simple;
	bh=LSAnKegUL0kRo7p5f5Ij4shcOoRIouQwffQXZ3Y7oMM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xk6MCrx9PfUeLSzf6LXd53ZiY4iTevl/1LMgwWRfbIIFPj1B7lt66UDB90+951e1S0QVhhtMgZXzBObOmLr5JJPyd4dadOsLVs9TE42HdAyypquWEz2ufyyzIzcVHpvsANVMttSeUZ0A76X/60CGfOWuoub/cgpgSSZ2QQATmNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=iulr3BfL; arc=fail smtp.client-ip=216.71.135.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1724164074; x=1755700074;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LSAnKegUL0kRo7p5f5Ij4shcOoRIouQwffQXZ3Y7oMM=;
  b=iulr3BfLDA+tTZeen5v5c0osrzOIh9pU7BfxW0dAo8iSmUOe4sfnchKi
   5AmP0IweqYYmpajJCWRdA7AcLUeq4XhWnUo8uToutP/yMC1582NZrHVWq
   C0BYMzfEIjiNrYHY5nmjGvevWOLI0S8kyYtAHWfqJSyConCQj2ZlcWJ/K
   M=;
X-CSE-ConnectionGUID: hmMBEbgZSvaq9HK6P/TfcA==
X-CSE-MsgGUID: k/la3VAOS6C751iA/NsBwQ==
X-Talos-CUID: 9a23:6a/B7m/TFkgq3danc3OVv04RP+oIeHLv92nZOh6YKjhRD4GbQnbFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3AbNoYUg0e5holPcuvZadnBOvdkDUj4OOqARszuLI?=
 =?us-ascii?q?95eLbaHVxEnC7lx6oe9py?=
Received: from mail-canadaeastazlp17010004.outbound.protection.outlook.com (HELO YQZPR01CU011.outbound.protection.outlook.com) ([40.93.19.4])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 10:27:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OhLH4CO0gRp3OlQ/E2WrUrtXnPA0K6YFQyy9Qs2cJkKrasT0f46Z/bhwekPKwARX2WOJO9Ulrh5Eag8xN3/wXGuoCggHz+vCtH5xfy8F4/dap0V4MtIoRQX4jsaQL4UnQ5vOQu8AhJ363sjrDPVCs5ueJ4/GsR4NQtemAABUTAUx28eNjTFCzYh2sjKKOlxTPDJGAM2IZd/PB+QmkjFTAAs7IDrG2s+CKPzTA5VLdL0PgcFHOuXwWbhqeKZ+64rHcG7TIIlu1hf+8qo2h+iXPulTjiTFiwIurOvPnOb69CxWOMgA6KEHV76yTMK8LizoCF3rVUD4vy0PKUHpOsnDfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WiCMWB5f/YrSj76fzX8M3H3C+YPOCY8SeipNa1YHEx4=;
 b=BOZpU3CD8dA4KzyEjsfNSF6NQ9Uc/v4SxNHJ2jqtj5ScEW3mYVQLo1p7NFb/H3yEfhBkIuvcSt1hv6pN5XjwCV7jbwRW0Pxu5PDix9/xSU4Zp+cZojxQa4flffMLDTQs+7SwqkZr/c4eH/wvaggVtRB3sZtC0O3/kTCBirG2hcDU4nSkaRq3/+95uMy2G6yCxzIlSoDbXYEdEkulkSH0ZbHmBJpbP+y/tSZEgarj9pcGoqbPme6M5vNfm1sQMcFGAdAcMhDPWzx9F0ay2nkyuM7Ufp+6CBL6iQZh1vlgbUz8buupyU+gcutpc/yUIQnL5UFYxCu4ZvTQ/kUIW5kGbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13) by YQBPR0101MB6538.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:49::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Tue, 20 Aug
 2024 14:27:42 +0000
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930]) by YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930%4]) with mapi id 15.20.7897.014; Tue, 20 Aug 2024
 14:27:42 +0000
Message-ID: <3e68c3e0-cada-48e6-8a19-6d5fba86dd40@uwaterloo.ca>
Date: Tue, 20 Aug 2024 10:27:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 0/5] Suspend IRQs during preferred busy poll
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 Joe Damato <jdamato@fastly.com>, amritha.nambiar@intel.com,
 sridhar.samudrala@intel.com, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Breno Leitao <leitao@debian.org>, Christian Brauner <brauner@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jan Kara <jack@suse.cz>, Jiri Pirko <jiri@resnulli.us>,
 Johannes Berg <johannes.berg@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 "open list:FILESYSTEMS (VFS and infrastructure)"
 <linux-fsdevel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20240812125717.413108-1-jdamato@fastly.com>
 <ZrpuWMoXHxzPvvhL@mini-arch>
 <2bb121dd-3dcd-4142-ab87-02ccf4afd469@uwaterloo.ca>
 <20240813171015.425f239e@kernel.org>
 <15bec172-490f-4535-bd07-442c1be75ed9@uwaterloo.ca>
 <20240819190755.0ed0a959@kernel.org>
Content-Language: en-CA, de-DE
From: Martin Karsten <mkarsten@uwaterloo.ca>
In-Reply-To: <20240819190755.0ed0a959@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0280.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::15) To YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6572:EE_|YQBPR0101MB6538:EE_
X-MS-Office365-Filtering-Correlation-Id: 41e67fdc-42ff-47f4-c376-08dcc1244038
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0RBT3l6K0FOdGhxYmorbmFPRXBmbFdFbUQ1N2NmNTBWTDVlYTZ5WkQzVzlo?=
 =?utf-8?B?ZFFOZGlEclBUR3lBK1JQU0dTNi9JSUZrcWF4NU5PUG82bkkvN3ZHM1gybHNY?=
 =?utf-8?B?bjZjWTBNeXUzSnlraVhXMWhScE05c05IR3drbzlndDJBcGxJM3NvUEpUbGFw?=
 =?utf-8?B?Y2xTbDhId3VlVXArTXQyQ283TzlDcE4vTkRmSTRMMFVKWVRyMHpqc1k5TEpt?=
 =?utf-8?B?T01vc0RCQXVPM3RBcGNITHZHVlcrbUdiWFc0VWlzZEFzSDRuc0NVM21oYjNn?=
 =?utf-8?B?Y01aSERsM3c0TEtta1dGa25DMExacXcwckNRc0lrNGI5cjNGUXg3MnRpV3Iz?=
 =?utf-8?B?bXkvZTYvdEJ6K09VTWw0S1hlcnBiWFpQZjRhVFFBMDdmWlBqVENndWNURUtz?=
 =?utf-8?B?MlNKcDdza25zbjhyejBIUUtqdjd4djZ2SURDanhwc25QNVVvZHRpV0QvazZD?=
 =?utf-8?B?NjU1UW1nZUk5UUQzbDh0Vk5OWExPVGxBQ2JsZWdMUEpIMlVVdkFyVnBRWWZU?=
 =?utf-8?B?bENOaStLNkIrSDUySVpuSFVRR0prOEJpY3hRV2FmeHlQOUY5ZitYcXE2MFJN?=
 =?utf-8?B?eCtlNG12NW5JanpHYTNZTWJCWHplZkh5MUlpbmtxaVAvVXRGZXM0Wk13ckVF?=
 =?utf-8?B?TFhsa1FNWi8yMXJQS1JJOWt1dEg3eXl6U1Ric1EzUkJ5VTNMdW1pWjh5U3Yy?=
 =?utf-8?B?YmhnMTdLbzQyWXNrT2ZoTGFIWXdLS2JsUkpWeXpnL3lvMy9MRW9aRU1tTU85?=
 =?utf-8?B?WmFoMVVZRVMzN2s1aUdmKzhlS2lJZ3dqNk1IbE9MYjI2STQ0YXNSZS8raXNh?=
 =?utf-8?B?dFZTUmdhSU1KOFF1NzFNdThVajlwbzl4RVU2VGdBb1hlVWFwRVlBWEQ5UXlk?=
 =?utf-8?B?MmVvM085SXE2bXM1OXB4ZjNidllKN3FCUWVLZGVENTl5T1Z4Y2F6VE50Wkc1?=
 =?utf-8?B?aW5WOCsvZXgrMjNYSkNBRFF5YVpRWUhwbFp1UWVPL1RkUEI1c1ZVekxjV1Vj?=
 =?utf-8?B?cTVqSjNwc0dOSk5LWXhGVHAxRHdGRVM1SkhrMXJleVk3TDZrYWpaMCtWQTdo?=
 =?utf-8?B?a09PNkNYc3RHNnlta3h5eWlNdWl4Q2FINzZhWFlFVzJPcGhQOXpWNHVsUDlF?=
 =?utf-8?B?RGp5ZlFRMjNCeEdWbkpJNTVFQ1h4UW9XaG5HZlNIc0RHSVIyd2dvRUlPS1Z0?=
 =?utf-8?B?bU5VYnNndTF3T1AwbXFxaHVkRGJqVU91d1JuYk01a2lCaDRvbHYvcjlEY0VV?=
 =?utf-8?B?MVE2OUhGTjI4WUs4b1lMWDFnYWdyM1NjSjIxdlh4U3dRNzAyczR2TDFSdC9P?=
 =?utf-8?B?UnNtczNRbzRyRTZUVld5bmttaHNTdHFMeXhlWkMvRk15NU8rRHdMcGthWlVu?=
 =?utf-8?B?NHpiSFNxR1lja1JaMHV6TjZkby9WeHJ2ZjFQdGdzbTIycmF3VkJSQjRpQk5C?=
 =?utf-8?B?N1oxRXJ2ZjZKQmFYeWVmamVVdmI1Y09hVm5EcEZpbGxWdzZtWWdPYWx6Z3Ev?=
 =?utf-8?B?OUhhbDI0SWZNRXZXNmdmc2pueXFuUHluV1dsZmJKM2pXM0pYR3h6Mlk1SXov?=
 =?utf-8?B?ckE3bC9nOExIeXAzSDZVbnI3TUE5aGpIVVJYYk1aWVBaR2FyazJZbkM4aUNY?=
 =?utf-8?B?RFlwMitnR015bkxuV3NUckhva2dyQTR3ZE90enI2aDVKamtlTS8rVHdYMCtI?=
 =?utf-8?B?b3Ria2hMeS9RYm85bTc2Szh2aHJacnRLUlFveWllekVIUVJlTEpUdkhuOVhP?=
 =?utf-8?B?bysrdk5WWWdoVmFMN2tRRjRLbXVtZGF5NUQ3VlB3RThBWEl1allkUXhFY3JD?=
 =?utf-8?B?SkZUb2JKbTJrcFNNVW5IQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmNoSmJYZjZSNENPeXZaaDhvTjBybnBYNStrcVhoaGNqb3dkdXN2N2hwYjUz?=
 =?utf-8?B?MUFTZkxUdzMzdDJSSmtVNFNYaWY1WFY1WTY4anJFVkZzVjQrTXpFZFRVYnBq?=
 =?utf-8?B?Um1hck1QS2x3azJ2aUZkNzhKVnZyZnpmeXMvbnFFdStEVDAyalY4SEsvbXBN?=
 =?utf-8?B?eVpqUUIwSEJuRHVyN3pjenNFZDRielBzNjJVVlRSbDlsTUxLQUZMMHlRTnlU?=
 =?utf-8?B?dC9vRTNyTlpyNnVYN1AwWU9mRVRjQ05XT09ZaDRLRUlDY2F0T2owRzlwbGtq?=
 =?utf-8?B?SUdRa0hKRE1ENWF3ZXlCS1h0RzBhR3pnQzQ2MllKZEhuK3NDeVFBdWRDZks4?=
 =?utf-8?B?cFdZa0RiV3hoZnB6dllNdkU4eTEzSVk3WFF4VjNLN0Q4ZmRiT1JGaitwZDZD?=
 =?utf-8?B?U0s5N3Nka0FISlo3S0h3ajBGVDE1SzI0dVlVMXhsd0l0ZVpCd2orSnBaWTZU?=
 =?utf-8?B?Q05nelNCc0NjeW1OWkhLaEtjZGRlaTdyV2RJVXhYYXQ2TDVUb2x3WlJQZ3dy?=
 =?utf-8?B?YmFaNUZBaG5zZnViUlgwMlhiRXg5SnJOK0FUK25wRmZKRjJqOU0rQlVyTCtC?=
 =?utf-8?B?emM3VDVJWk55aks1azc0UTdWR2UxaHh3dGtxMlZHYVdXSzVoem90c3pVZVB0?=
 =?utf-8?B?RVlRT2dSMzRVdWV5dEN4czgyajMwM1IxbGRKV2lvRXpyL0E1d0s1cUYzUDhG?=
 =?utf-8?B?UUtCek9TYlhHdkViSUhqR0I0QzlxQnBKcThGWTFHRElySFRvVHQxMUJZdDZo?=
 =?utf-8?B?cldpYUtVOGZqUlI2RjkrTzllMEFCYlVRNlpza09IUmpEckNmWFVYSEtRR2o2?=
 =?utf-8?B?dmE1NGIxN2s5dmJOaTBKQTl4VHhmMnBFTlE2N2ZhODQ3ZzB0Z1lDRE5nV2Js?=
 =?utf-8?B?cmc4WDlJOUg3d3BRQVNzT0pjakhOMkQ2aW03V3F0ekQ0MExsNUpXYkQ0TEd3?=
 =?utf-8?B?TFRCVytZOThDemNVemVOVVlKRnRyQ2gzUE9GN2hEN2RpaytUQ0JaU3RnNTFl?=
 =?utf-8?B?VGkrS2FIZ1JCSTJLTzBFZGJDSjg1V3A2VGtyb1NiakpaeHg0NCtTTXZhREhU?=
 =?utf-8?B?QXZkdlFLRFYzTmxEL0k2M1RZUzJnMUFKZ0Y5YkQ1TCszWFB3VFk3RU5QTG8w?=
 =?utf-8?B?WktLTDFmUzZ4dWNTVFkyblBpaThGUU92a09mV2RRaWpNNUxjVmxoK1Z6Z2Uv?=
 =?utf-8?B?QmN2WlF6OEcvUzZDMlBuQnRDL05nRzlBWjRQWDZjRzN1T3BxVVBiT2RpQkdv?=
 =?utf-8?B?bFdYN0taMUpmZnJWUktua1FyREIvL0RuckVnclBVeFViOW1zdkR1Q1lSMHZi?=
 =?utf-8?B?ODI3OUMxbEs1L2VFK2k0RjZuL0VWZGxaYWljL002VzcrSnAzVU1xOU8rYlVx?=
 =?utf-8?B?N0lGVmRkQVpQRGo5dkkrTEhlcDhkLzZXaityQzVSVkc0UVNLYStNdTJEekI4?=
 =?utf-8?B?dFFyLzRtcytsazczTi9BbW42ZWE0Z2xSMXRQK3BJZzlmYjhmUnNETlo4ajIr?=
 =?utf-8?B?UCtyS1hKVFgwMlVvZEEvRWpBT2dRNEc0SGx0UWh2RHFESlNoVTV1UFhEZTR3?=
 =?utf-8?B?RExJbGhiRFlYdG5RQnIxS2VHMzRqQUYrWE01dkNSZi9JQnIwaW55M2JGVU9S?=
 =?utf-8?B?M0xaeDVMYzZpQU5Na2Y0V3RIbnNZYWlsTUlnaHVMc0I5eS93dXpBcW5Od1RJ?=
 =?utf-8?B?SUhkSDJmSit2aUJmYXVlWWlGN00ydHFJa2wrN0E2eDloOFlOVXJVVTdzaUho?=
 =?utf-8?B?V1VvNlp4NFh2ekk2SXUxV1VkSFRJazFUcTMyRWNaT3VIMllhNE5qMjBSSXZM?=
 =?utf-8?B?ZFNBdG9WZTIvamt2ZGhDOHFPc005TE9KbFZWMStEd0x2YzRPc25wSDZQMzMv?=
 =?utf-8?B?MXZxVDRlQXBiaElzNDEwNHJZZTFVN01QQlVvbUVnR1h3STBWQ3lBT1dkWklR?=
 =?utf-8?B?cjhiNmU3YWxndmFOcG9GUmxJODdnRENZRWtHL2NVaEkvRFJJdlpwNFJxdGpy?=
 =?utf-8?B?NXpBT0tJNlBXWXF3UkkySXJ0aDlZRHA5Q3RoNnQ4N0tXblZmR3hQeVl2TldM?=
 =?utf-8?B?eTV1b0h3V1piMjBYbVFLTHRRZkVQOTJndnZsS1IyWGFGY0VQN1VBWUdGdHFL?=
 =?utf-8?Q?IBpDiTjrCSUA3syBDyRN6sA4a?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UspDIRtSYIlER1dcUdYdBpf98j4rYljlGk5Vb7LFUQDno8UCUxK0ZWfpv2YBEkTQZZY1KGSXgmI6rYisK0JkXodoyQyeZDAJoPGzaG5vXDOVrYBgD14iBz5zORcJPeJ1BDppIbFocMXDrBInbFfqOAI8+HghhMEikNjvUkh5oLUPsxhNXh4CTX53eRwBSwuGHSPf17Po5LfAj0RC3tsv7OnXFJBJYe4NS7+VTKzFn10YZAD2jtQ8AJRE5pfO0r3h0i7ogZPHPDBvbJtRHwUf3xklDWFmf8nZRHlNNze0DeEN1AU0JDmCnohpOl+ehb0nKUrn2mtESWz1VFyHTI3ljo71C7ygxk25gL3amaLVMsRlF+A/GMFfBT+w6LRqj8EC1lcqgI77IZ+08Ku2Yy17ndIQfTHy2GjqIbYtnMP7bXn1YmRyloLTGLl+iGifAoaQNaPhPozM4mhIjdbGZmEQeEEWhSGQuSTVh6+mUTq91hjcvFhQ4B2kqUi9MfTHEoZLLqFawiRE5R+09MCOmwJtPRf9OXEWafax5jDpwdE0h7WN+LVSuy3GdWr54AtilfCNJrpjz3iYpuUEiRJXT8JZ6KqntNLwF+gY2jGoXf1VGltoZhKPvKFFbHVJo+2RvL2e
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e67fdc-42ff-47f4-c376-08dcc1244038
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 14:27:42.1309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZfHTEh6P2eDUcBSrwnpvrPWhVxudD8WrItsxJk6hCPYCbw3Np1Dpcv4YkM/KqCBT5swtSSiJpgodfLNRUz1s0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB6538

On 2024-08-19 22:07, Jakub Kicinski wrote:
> On Tue, 13 Aug 2024 21:14:40 -0400 Martin Karsten wrote:
>>> What about NIC interrupt coalescing. defer_hard_irqs_count was supposed
>>> to be used with NICs which either don't have IRQ coalescing or have a
>>> broken implementation. The timeout of 200usec should be perfectly within
>>> range of what NICs can support.
>>>
>>> If the NIC IRQ coalescing works, instead of adding a new timeout value
>>> we could add a new deferral control (replacing defer_hard_irqs_count)
>>> which would always kick in after seeing prefer_busy_poll() but also
>>> not kick in if the busy poll harvested 0 packets.
>> Maybe I am missing something, but I believe this would have the same
>> problem that we describe for gro-timeout + defer-irq. When busy poll
>> does not harvest packets and the application thread is idle and goes to
>> sleep, it would then take up to 200 us to get the next interrupt. This
>> considerably increases tail latencies under low load.
>>
>> In order get low latencies under low load, the NIC timeout would have to
>> be something like 20 us, but under high load the application thread will
>> be busy for longer than 20 us and the interrupt (and softirq) will come
>> too early and cause interference.
> 
> An FSM-like diagram would go a long way in clarifying things :)

I agree the suspend mechanism is not trivial and the implementation is 
subtle. It has frequently made our heads hurt while developing this. We 
will take a long hard look at our cover letter and produce other 
documentation to hopefully provide clear explanations.

>> It is tempting to think of the second timeout as 0 and in fact re-enable
>> interrupts right away. We have tried it, but it leads to a lot of
>> interrupts and corresponding inefficiencies, since a system below
>> capacity frequently switches between busy and idle. Using a small
>> timeout (20 us) for modest deferral and batching when idle is a lot more
>> efficient.
> 
> I see. I think we are on the same page. What I was suggesting is to use
> the HW timer instead of the short timer. But I suspect the NIC you're
> using isn't really good at clearing IRQs before unmasking. Meaning that
> when you try to reactivate HW control there's already an IRQ pending
> and it fires pointlessly. That matches my experience with mlx5.
> If the NIC driver was to clear the IRQ state before running the NAPI
> loop, we would have no pending IRQ by the time we unmask and activate
> HW IRQs.

I believe there are additional issues. The problem is that the long 
timeout must engage if and only if prefer-busy is active.

When using NIC coalescing for the short timeout (without gro/defer), an 
interrupt after an idle period will trigger softirq, which will run napi 
polling. At this point, prefer-busy is not active, so NIC interrupts 
would be re-enabled. Then it is not possible for the longer timeout to 
interject to switch control back to polling. In other words, only by 
using the software timer for the short timeout, it is possible to extend 
the timeout without having to reprogram the NIC timer or reach down 
directly and disable interrupts.

Using gro_flush_timeout for the long timeout also has problems, for the 
same underlying reason. In the current napi implementation, 
gro_flush_timeout is not tied to prefer-busy. We'd either have to change 
that and in the process modify the existing deferral mechanism, or 
introduce a state variable to determine whether gro_flush_timeout is 
used as long timeout for irq suspend or whether it is used for its 
default purpose. In an earlier version, we did try something similar to 
the latter and made it work, but it ends up being a lot more convoluted 
than our current proposal.

Thanks,
Martin



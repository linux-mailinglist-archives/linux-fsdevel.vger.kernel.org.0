Return-Path: <linux-fsdevel+bounces-35843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F53E9D8BFB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 19:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10997B2A8D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 18:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DF41B87CB;
	Mon, 25 Nov 2024 18:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ozbsb9xx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BD017548;
	Mon, 25 Nov 2024 18:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732557963; cv=fail; b=mCKFdWnWrCEcQX39NSmxgQ2FhW7c50eEPkroeaybeWKmV7rHZYgtjdNU9YL26yJ+RQ7/0hdPN/T7oZdI/hYUGOPIKQiiD0J3/yjCM7q/mUsH61vKF91be/rKRqo8+nG2OWXRfwI16RE6XHp8mZq76ynNtZTGuD2FZP2z/AyiYm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732557963; c=relaxed/simple;
	bh=XtbyKUwrl8NvJK3xgmzVgo4A9fSyRd38U/eQ9iqgw0A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i248gOErf6YqHRxzEt4NZy1hRSBwPSqnVsBvflu9WpVrP36kaYeghfEG+0eRrh+DtjmZvxwdIK3YMLM5OEQ59cndReNJpsvCnMbOFsHi7yIueaUQ4y7Yo3yjn0/DzCalk3NEnmvKU9zJbC/p6RVA8qF4bQvkhOg+oZiMHRKftNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ozbsb9xx; arc=fail smtp.client-ip=40.107.220.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q/V7jnfJvDUILE8vb6pf97Sxw+PSl2kIZfEr5Yr2CEARryy+pa9QptAYEMsGx78iQLaSJuqNJLEP77bLCdXZUXn/kXg+yxH6IsH+WR3q1DvZE640wbAT2n22gFORWLaHj3iLlnU1s3EZvXDbRhbynmeNCrNBcT8IhXIchSeM+V8rctfWKrWTOV2EWDOhn96VX2aZRNie8PCYbTXdQfoIU2ffZ9bNuRg0GAgTvCCQlEdPgYrRhqTk2N/SK+tuVD9nOyhXYFOxjNjjQsNDUvbQYjCiBYCs8mqGHmbHx1s0KXu2CjuvVeiUziyPydZap6lhiEJocI0ZJIcd22IP6829oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=of9arVcuY+Zk+7tAmxzqXYiMi9sUwQS+Ff29qCbKqOs=;
 b=qNmRnoBBGahbX8cNTaq0JTmzShrZC3v9QQuM8XzNIt6Uuk0svbFzV+3DNVQw9EdasUOabGMnnsbbXD5+2vDbT3qD0nNArh4zPKts0CdZGLe03VX60L7MZFooFevDhZDRPZHEENmrEmr2DCR03pMIR0q6mvjbVljboaYeIQit9BGUZ8W6yjhwYw8Usq3tu2iOEw5KxQVEtrlrFgMivu3gd5hJuO/+X3oU8okpEVahJctIL+KXMWJiGIp/GHjaSd/zJyFuxZMOkS/k+h3tM94XYJF4421LjSTunW564+qyI1FIqbakQ8bBWsinnJOSK37Zexq9K1voGnGJnZr0xbsZ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=of9arVcuY+Zk+7tAmxzqXYiMi9sUwQS+Ff29qCbKqOs=;
 b=Ozbsb9xxjC7QjGvxdDstV1hhXZXPLnnSxu0YeevjgZnBZ5iinSIkhVLSkkOI/cgoDbBrACqBhZKy4kEKYAOjsEE6p35yX7urZnUFUoQ+1fPg212nkj/DbQ3zgITK7F/Bt14ZNm4NzQi4iy492foyHt9PYoBn+97Xjb1+2BMCWyU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5688.namprd12.prod.outlook.com (2603:10b6:510:130::9)
 by IA1PR12MB6020.namprd12.prod.outlook.com (2603:10b6:208:3d4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 18:05:59 +0000
Received: from PH7PR12MB5688.namprd12.prod.outlook.com
 ([fe80::b26b:9164:45e2:22d5]) by PH7PR12MB5688.namprd12.prod.outlook.com
 ([fe80::b26b:9164:45e2:22d5%4]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 18:05:59 +0000
Message-ID: <573fc7db-f6c8-4a0d-b709-d113dc479652@amd.com>
Date: Mon, 25 Nov 2024 12:04:21 -0600
User-Agent: Mozilla Thunderbird
Reply-To: michael.day@amd.com
Subject: Re: [PATCH v5 0/2] mm: Refactor KVM guest_memfd to introduce guestmem
 library
To: Elliot Berman <quic_eberman@quicinc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sean Christopherson <seanjc@google.com>, Fuad Tabba <tabba@google.com>,
 Ackerley Tng <ackerleytng@google.com>, Mike Rapoport <rppt@kernel.org>,
 David Hildenbrand <david@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Jonathan Corbet <corbet@lwn.net>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Mike Marshall <hubcap@omnibond.com>,
 Martin Brandenburg <martin@omnibond.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: James Gowans <jgowans@amazon.com>, linux-fsdevel@vger.kernel.org,
 kvm@vger.kernel.org, linux-coco@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org,
 devel@lists.orangefs.org, linux-arm-kernel@lists.infradead.org
References: <20241122-guestmem-library-v5-0-450e92951a15@quicinc.com>
From: Mike Day <michael.day@amd.com>
Content-Language: en-US
In-Reply-To: <20241122-guestmem-library-v5-0-450e92951a15@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY8PR12CA0008.namprd12.prod.outlook.com
 (2603:10b6:930:4e::12) To PH7PR12MB5688.namprd12.prod.outlook.com
 (2603:10b6:510:130::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5688:EE_|IA1PR12MB6020:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bf7946c-e7fa-4200-a489-08dd0d7bd08c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TGxTdGJLcDFuSmR3OHNmZEhadHpCM1BLMVVYQUxSWTVjYkJLcm9hUXFmWXkv?=
 =?utf-8?B?MEFXMytTckl1bVRtc2JhaVVmV0wwUkFaNnNlZkFsdzhzemthYUlSdWtlTjRR?=
 =?utf-8?B?V2VFVC9yOWdmTWwvUU5HMTltYXZ0OEJWck1sNGRkNWFmR0JpRkFRTU05VVFj?=
 =?utf-8?B?bHRBZzJSZG5OdDBjTkJiRXN6TXNXKy9mb2FwNldCM0RhV1ZHUFBOMzJ0b1NR?=
 =?utf-8?B?MHNUQzVDM04zYWtRdStra0RDSEc1TjBEL3ZleFVVWC84Q0pkYVExQ0NCNlpB?=
 =?utf-8?B?WUR0WGhxMmIwQjVBbzh3RmtpaWdpajU1TlhORlBmUThkVy9OWkVScHV2bHU4?=
 =?utf-8?B?cVFjVlF0M3h2VEpzaFBUQzduLzhnL1dkS1BvWmRiOVg1TklJSUdtcTJtRHEx?=
 =?utf-8?B?MGZUM3J3R05JSjFOMUJhZHdsS1NSSjVacTByT1FOSlo4ellWWGpRUC94cGww?=
 =?utf-8?B?NmJ3NHJZNHVrS2dMb0ZWZUJHMVJGSitleS9COGVnKzNSKzB1ejRCcFZRZThX?=
 =?utf-8?B?UEJhbDE0RUtDSDBQNG5SN0RqZXZpM1ZMbitRRTFKZEIzWTUvT3poMEVSdTBY?=
 =?utf-8?B?cFcvbFlUcnJBbU9leDdGTkZBMlJGWDBRVlNETGNIUU5WdDRrckxKUUNsajBu?=
 =?utf-8?B?USthSloraHhvNi9ua2J4MVpFTk5XS05qY2JzNVNTcXpURVNhQXJ4M1RUb3R0?=
 =?utf-8?B?WTBiOHh4WTdQYlNEMzZ6alppMzBSWGZYeWVtdUlOeEY3NEwyZmVkNzVHRUIz?=
 =?utf-8?B?WjhJb1FSQXlTNXpvWk0wUENZMURQTFdBVXJYenlaZkpjQXNETzJnMTZZOFM0?=
 =?utf-8?B?dTYzMk1lSmhieU16UVNIYU42N01pSHo5TEtNd1JIbTJ6TVU0MHd4SjBwdmgr?=
 =?utf-8?B?K0RuK3daNGFobEFOU2l4TGY2R3VBZ2lMS05EMDNWejhIMFVwV0tHNUlZMXBm?=
 =?utf-8?B?bXV3VmkydXBLUHFlb2VNdXgrL3hmb1FtY2dwTE1aY2lkNEE0OGdGeWRJSFRY?=
 =?utf-8?B?RlN1YlAyQVppcGZJTGxSMS9uYkRKbXFHek5oeHpXenFubzZzTTN6MkdSckVu?=
 =?utf-8?B?NnZkWkFyWjc3ZXJ6dlhpQnk0NzU0QnNTV1BSdndjVEpXaXBzTlNuNXY0OHlu?=
 =?utf-8?B?RWV2cjY5N1BRUW96bWFNVzhBRnNHWWRNeUYyYmhjREtRdFFFMktmQjUxTHBO?=
 =?utf-8?B?RkZFS2NzdXkvQ2NKRXF3aDlIajdhV2hrMXh3b1JJN1dtRC9mYy9qdWxqMzEw?=
 =?utf-8?B?WXVBaHBEUU15SDMrSFhSV0J4azlycjg2cjRtK2o1VENZU09EYmE5RjZzVXFi?=
 =?utf-8?B?aStLZ2pVVWNOUU1pSkpQWnV5eDVZZFd3S0hXaHM2aU8wSEc4TkRCSElHby9U?=
 =?utf-8?B?THRNU0d0Y0JycnJ5OVo0aHEzRzQ4MGtqVm9IaWlmcXp4RmxLYkE0UndVWDVK?=
 =?utf-8?B?VUROU1c3c3gzeDhxa2lkcG9iWHJZd2NIMDYrVnNRZHJIbVFmaStpdzZMdDZi?=
 =?utf-8?B?NEQyNldsTGhVQVZkL1BsUlExK3lXU1A5cklvdG50aWFsa1NBdi80NHpqU3Ax?=
 =?utf-8?B?OGx4ektRMnNqemRtenF4VWE1OU5HRWRFbGdhNEQzNTd0ZnptRFRwOGZ4MW9r?=
 =?utf-8?B?WEIwY2M3Y1Q5L0hhdEFaQlZESm9ueDFVYzRveVZWZi9ET1dvT2RZczRwUmFH?=
 =?utf-8?B?WmdvWXZIVy9Sb2xvTlVVOE92ZWdlak8yWG1OL1dSMVhVcnpaR0EzRG1WM1Ev?=
 =?utf-8?B?UHJZdlQ3NExvNENzcmFCSnkwNC9vTURZS2JoSElnL3F0THBLc0N0MzZiZ2JX?=
 =?utf-8?Q?J4zLJhs8OYRlFN1Zk6HAAU8da4m00F+fQSPNU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5688.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REFJekdQTXZYMUxoSGZPMFl2blJuT3NYYXdaQ1B6TGt5aGZ3cnZZLzd1MEY3?=
 =?utf-8?B?UE9kUFowdUZqUElPb3hmL1FFRlhpR09zTjN6aXRMU2RERENMbDJjRzNtRTBI?=
 =?utf-8?B?c3dkeWJ5ckZLOXB6VlhtZHlmNXlzL3lDTzltYTgyck4zTWJXcE8yNFFxcWlo?=
 =?utf-8?B?QS82OGxrMjhoNTZ5UVRlVVFKUGE5RXNxUy9EMkNRVDU4VnFEeTBqRlAzQVVn?=
 =?utf-8?B?VWswVEpqMFJzbTc1enVjOU9zS2hyUlVsOTY4MjVUajJxY2xJazBpNnphYXZw?=
 =?utf-8?B?SHEvdUJRdURNU3d3OGNKcjJaU3lWQTlCSWFNK3hZUUtTSzB1Rk9WRkc0UUtk?=
 =?utf-8?B?ZmRmOUJKdnZyL2dGSisrSWFTZFZBWWFwZU8wa3ZVN2VDRENET1dDQ2dMS3M1?=
 =?utf-8?B?K0pIQjBPSFE0WU1iTk1RazFINitDNDNmREFvVC9rQlJCZW15Ly9GamNvRTVG?=
 =?utf-8?B?TFBMcW5BMlVwaXpCUCtscnlHNllaSmdKME4wV1Y1aGFrRXdOWXc2OFBaVlRU?=
 =?utf-8?B?WlFXQ3lTYnVhb0NIdnFYcTdNa2FNRUxyMWJTWDBIMm0wUkVhMGI4UHpCK1FK?=
 =?utf-8?B?Z0huOElOR2VCNmI3bCtrVmpWMGJPUmdJRFdVa015aU9RN3hRMjNTQjhmSjIw?=
 =?utf-8?B?d3RiR3ZIdHJ3NldXcEZJa2JHVjNZVk4xenRleVUvc1dhUDlWVW1tVUtkYThs?=
 =?utf-8?B?OU85ZXdncDRFRXJCSzhtZk81WGZpc1A2NzJDdC9sTWFoNk1xSi81eSswU1pC?=
 =?utf-8?B?dzc1dktYVXgyU0FBK0d4c2c5KzgwN3ROckpvL3ZBNGwxWlBGMno3U1AzNzUy?=
 =?utf-8?B?aTRPR3JHS003UFAxUmxVbTl0eDh3Z2lIclJLck9kYnVxMTc2aVlDY3B3UDdD?=
 =?utf-8?B?MUN1TXdkQTJkTlJvbDQzd3dmRllXYk9vMVlHRG9jOHg1SFI5QzJrWmcvMzhQ?=
 =?utf-8?B?anc5ZDdnK2UzOW9CQU8zVHV0ODNVWVhpZWFjZXpkTUtxaDVHeTJIVDgrSERM?=
 =?utf-8?B?MXkxMldJZ3AvMDhMM3A3NHB2L3p1K3UrYjBpV0RmazFBZEVWQW16WTAvZDBu?=
 =?utf-8?B?eWR2U1BoVGNmUzlCRW5tTGk2aVBNUURGKzN0R0xFclllY2ZHakdPVnZvbUwv?=
 =?utf-8?B?SHFhRXpaVW9uT2tlVkIvcG05c1E3bzVSTTc2Z2ZmVFQrTy9xOU5iRCt6NHZv?=
 =?utf-8?B?MUtWNE90d1ErN1BKM3Q4enNGM2ZXRFc5dngvajZuK3IxeVVrZ1dyZFd1cWNJ?=
 =?utf-8?B?aU9LdlJJSjJ4YmFlQnVhdFE4c3ZMaExWQUhWbDFVcUU1eUxmZXA2STZCaExF?=
 =?utf-8?B?NmhvcVVlcTJkeFhzZjRhQmRnT1ZmQVZXdkRkeUh1Zkp5ZUxDS2VwY0xub1h0?=
 =?utf-8?B?eER6SjA2alBFS0kwUlg0REQ3Q0ZMMExGbXpFWWFHS3BOYUs4K0dFa1ZJZXBQ?=
 =?utf-8?B?b2dJVjBuSEJQMzRqQkJmSDN0YWEra3Y0Q1VzRS9EdGJJSUJJWkpxNVJwQXMy?=
 =?utf-8?B?aUJZZ200M0dTY0NpT1FjTnNJTVpnbjNkVDZrNmhDQk1kd2JTcmtIY3pkSGVh?=
 =?utf-8?B?MDFuL0FLWUdHb2FjaGU3bnYxdUlmWll4S0h6NmVXREMyVnF4dDNFbzNqTFha?=
 =?utf-8?B?V2pIbEJKRHkwbXdqSm52WmNRU01nLytEa0NGb1FwSlpwWVBIUXppVGNaTzNI?=
 =?utf-8?B?bkxlUnZ5OHBXeWN5bjVaS0taSFJITGxnTjd4cFhTSmpnamF0bmIweDkzWUJK?=
 =?utf-8?B?S2Rnd0JBakkzZUQwUjhKeU1EUEhJZm1FUVRFK2hLRE85VkswZVlDWnNHN3cx?=
 =?utf-8?B?UXF1RjJ3d29EUTg1UTc0bC9SN2RFV2E1cm5uZzlzdkdSOXNaMlVDWkdaeWo3?=
 =?utf-8?B?YU1jeEhQbE1YMGxyQkNvVnI2aTFCTCtCKzgyU1ZTQ3FGQWpmdXpMaGFPNDJN?=
 =?utf-8?B?Z3lFT0VFZVBKVFJod1R1R1FmZ3pBRkxScVdSTDNoTjBzVkVCbk1OOHl2dkc1?=
 =?utf-8?B?SmM1dXVmbzhLUlAwQUtGYkxKQnJ3UHdPV3VsbHZFSHlqN3ZTSUR5eFNPWDBX?=
 =?utf-8?B?SU0yNW14bVg3bzhFRi9XcFdHUTdSN1pzVjF6VWZpbXpSSHBCTGExSzJmb1Uy?=
 =?utf-8?Q?fRQiD7cZbULbYaKWBqhEpuH21?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf7946c-e7fa-4200-a489-08dd0d7bd08c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5688.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 18:05:58.9093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fIl9Swjn6fgZq33yxWtZQVTAaScxr/VET+NSgrf9LP8MZn+f8Tsgc+K4IjE6FC9O17pPTFlx5TrJ4BuEGEEL/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6020



On 11/22/24 11:29, Elliot Berman wrote:
> In preparation for adding more features to KVM's guest_memfd, refactor
> and introduce a library which abtracts some of the core-mm decisions
> about managing folios associated with guest memory. The goal of the
> refactor serves two purposes:
> 
> 1. Provide an easier way to reason about memory in guest_memfd. KVM
>     needs to support multiple confidentiality models (TDX, SEV, pKVM, Arm
>     CCA). These models support different semantics for when the host
>     can(not) access guest memory. An abstraction for the allocator and
>     managing the state of pages will make it eaiser to reason about the
>     state of folios within the guest_memfd.
> 
> 2. Provide a common implementation for other users such as Gunyah [1] and
>     guestmemfs [2].
> 
> In this initial series, I'm seeking comments for the line I'm drawing
> between library and user (KVM). I've not introduced new functionality in
> this series; the first new feature will probably be Fuad's mappability
> patches [3].
> 
> I've decided to only bring out the address_space from guest_memfd as it
> seemed the simplest approach. In the current iteration, KVM "attaches"
> the guestmem to the inode. I expect we'll want to provide some helpers
> for inode, file, and vm operations when it's relevant to
> mappability/accessiblity/faultability.
> 
> I'd appreciate any feedback, especially on how much we should pull into
> the guestmem library.
> 
> [1]: https://lore.kernel.org/lkml/20240222-gunyah-v17-0-1e9da6763d38@quicinc.com/
> [2]: https://lore.kernel.org/all/20240805093245.889357-1-jgowans@amazon.com/
> [3]: https://lore.kernel.org/all/20241010085930.1546800-3-tabba@google.com/
> 
> Changes in v5:
> - Free all folios when the owner removes detaches the guestmem
> - Link to v4: https://lore.kernel.org/r/20241120-guestmem-library-v4-0-0c597f733909@quicinc.com
> 
> Changes in v4:
> - Update folio_free() to add address_space mapping instead of
>    invalidate_folio/free_folio path.
> - Link to v3: https://lore.kernel.org/r/20241113-guestmem-library-v3-0-71fdee85676b@quicinc.com
> 
> Changes in v3:
>   - Refactor/extract only the address_space
>   - Link to v2: https://lore.kernel.org/all/20240829-guest-memfd-lib-v2-0-b9afc1ff3656@quicinc.com/
> 
> Changes in v2:
> - Significantly reworked to introduce "accessible" and "safe" reference
>    counters
> - Link to v1: https://lore.kernel.org/r/20240805-guest-memfd-lib-v1-0-e5a29a4ff5d7@quicinc.com
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>

Tested-by: Mike Day <michael.day@amd.com>

> ---
> Elliot Berman (2):
>        filemap: Pass address_space mapping to ->free_folio()
>        mm: guestmem: Convert address_space operations to guestmem library
> 
>   Documentation/filesystems/locking.rst |   2 +-
>   MAINTAINERS                           |   2 +
>   fs/nfs/dir.c                          |  11 +-
>   fs/orangefs/inode.c                   |   3 +-
>   include/linux/fs.h                    |   2 +-
>   include/linux/guestmem.h              |  34 ++++++
>   mm/Kconfig                            |   3 +
>   mm/Makefile                           |   1 +
>   mm/filemap.c                          |   9 +-
>   mm/guestmem.c                         | 201 ++++++++++++++++++++++++++++++++++
>   mm/secretmem.c                        |   3 +-
>   mm/vmscan.c                           |   4 +-
>   virt/kvm/Kconfig                      |   1 +
>   virt/kvm/guest_memfd.c                |  98 +++++------------
>   14 files changed, 290 insertions(+), 84 deletions(-)
> ---
> base-commit: 5cb1659f412041e4780f2e8ee49b2e03728a2ba6
> change-id: 20241112-guestmem-library-68363cb29186
> 
> Best regards,


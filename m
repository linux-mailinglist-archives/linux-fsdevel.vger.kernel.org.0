Return-Path: <linux-fsdevel+bounces-36040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E7E9DB206
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 05:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEE4A2826F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 04:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E703C13211F;
	Thu, 28 Nov 2024 04:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="An/t794Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2048.outbound.protection.outlook.com [40.107.102.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE4E211C;
	Thu, 28 Nov 2024 04:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732766523; cv=fail; b=KiWyRRNdsULeI5iFjlLtgChJShABb3CpxM5U9C1N/6cwngUitVhYstm17jghp9WcQ5zzlgYnCpNaLJN04v2ROLx2MsSbfLXtHS/d5OWuV2vkrUESTOKXl4u0T0UWLaD+YIyAp8EThzDvNq/aSocqsGw+L/oKCNgsaqqdS1ZUYLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732766523; c=relaxed/simple;
	bh=x0aO+aG+0CwNI62eHi9YrW7xgVkgcStPtIh3N+krY0g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S6fbSJR/jelpWCqG0GYwNxGceKr/NJtXQS09MXCZ2a9idSadYeFRpy+/Coo01SSku6WFvd6rENxw1/ISHIcmKlXkg0yJ+a85iLaH6GzXJcjFR77vHzmCCfmsHtaUAG38oBXdD9bZK9s9vCBntMb5GAGTRAdtoig1l+EQkxKSj58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=An/t794Z; arc=fail smtp.client-ip=40.107.102.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZclqGzAB8rPhDt0IlbneF4mwYncmHjSM3XtZPidnz85Wk8kM+uUtjz9a4FcaMy5fCNdHyXd3RBrgKeJ234/sKgPukxadD7M9vqxg6lsFRrCQk3FrIb6BqgJnO3poVaY8awbDVXfN52Pq79sDs3vIl8N8aB9wpmbqwyvocAjTQTaB+YrQW5Iz2Z/QnYytEWvljEG9unezTfvIbIUtXo2CFiT3JPulZRpbiTI31Q7lR1UeA5Kjf+YyY3dAGNgr+WLpn/FTeuycZNOKCQmG3W7adLrbdMZIhcUv+fyLAbLsxHr8W84qzpZ3P+MTcGi4S9b6M61C3/P+GeVlgOquu/aSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85rPJ8S+bqPGLnrBb3FRVh+OGjNMhywHWWuL62mOym4=;
 b=cT3p2ZF0658dFD6NAsfiXWaFxbwJ+mmqTkGTpVWt3u1Z+egPB4seOSsti+J8O9w8WzMDFC0LZKfVvsSBnxpWYWXfmLLZhjnHJpGAVZgZsS0Ru9NDqaRtaWgA8jLEDmfwruLVcN8CTjmDqJKmDqAQsY1M/r2SD2d89YtM0SjENb7RxjAvegUpvUYviNKVJebkCZr91YN3OoczM7FvKF2FaC5VJekjg7RKvtkrXoelE7REY8nfjFbsKqGNxHSuXYUWhMDcL0qecX+x+cVg393NCmuAwobTlWW9vKLyH8lWRc3ru0thmhdsGolP8vBZNEmY6n7ajLWHSjRV5ByzGgtT/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85rPJ8S+bqPGLnrBb3FRVh+OGjNMhywHWWuL62mOym4=;
 b=An/t794ZTZP3RUtdUQbiqa+P/yZX4bpH+m/p1eHZBWZ129cyyaest4sEymAkSemp6c8dC7Ov7Qll0oFfq1j22EJImcIlZf1pADBGi406YxA2CUAVHzFdjkT9gSV6Nst9WTnqS99JrGeOtwgqqepRcBF3b8O2aPbvKEBjGx5cxtU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by IA0PR12MB8088.namprd12.prod.outlook.com (2603:10b6:208:409::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Thu, 28 Nov
 2024 04:01:58 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134%4]) with mapi id 15.20.8182.018; Thu, 28 Nov 2024
 04:01:58 +0000
Message-ID: <5a517b3a-51b2-45d6-bea3-4a64b75dfd30@amd.com>
Date: Thu, 28 Nov 2024 09:31:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] Large folios in block buffered IO path
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, nikunj@amd.com,
 willy@infradead.org, vbabka@suse.cz, david@redhat.com,
 akpm@linux-foundation.org, yuzhao@google.com, axboe@kernel.dk,
 viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 joshdon@google.com, clm@meta.com
References: <20241127054737.33351-1-bharata@amd.com>
 <CAGudoHGup2iLPUONz=ScsK1nQsBUHf_TrTrUcoStjvn3VoOr7Q@mail.gmail.com>
 <CAGudoHEvrML100XBTT=sBDud5L2zeQ3ja5BmBCL2TTYYoEC55A@mail.gmail.com>
 <3947869f-90d4-4912-a42f-197147fe64f0@amd.com>
 <CAGudoHEN-tOhBbdr5hymbLw3YK6OdaCSfsbOL6LjcQkNhR6_6A@mail.gmail.com>
Content-Language: en-US
From: Bharata B Rao <bharata@amd.com>
In-Reply-To: <CAGudoHEN-tOhBbdr5hymbLw3YK6OdaCSfsbOL6LjcQkNhR6_6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::7) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|IA0PR12MB8088:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f68d3d1-80e0-40a6-9d13-08dd0f6167b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZHMwVk82My96VWdaT3U3QllPYmJ5dlpwM0JCM29veTdYWTlUM0NITU1aOCtz?=
 =?utf-8?B?RlpTQUlHaGtINDQyOWxhbUdsaU1neEMyYzdIbzlFeFBhMGZHalplMERWVklv?=
 =?utf-8?B?V0hJcjhORGxWZXlUTmlZL0xrU050WU1yVUZwZm1Td0RPUEVTNzl4eHVoRHU0?=
 =?utf-8?B?bzFISmVDVXdSUzhxczZxUVdQMVpqVWxmVmNiUUE0a0Y5VnEwb0RFVlNrc2xC?=
 =?utf-8?B?T0tHeG9oMERBUDRVaDhld0N1eEJJSDFLVFZuSXBGb1Z1WS9UR2JrK21WaEIz?=
 =?utf-8?B?bTl1cEtpdS91U1pVeFRpNjBwNVpsbGRiR3ZLeGxzQ0xjTVRCSTE0NmhHUWtR?=
 =?utf-8?B?QU5BUGFPa0lhd0VIdlhGOG9uUUIyZi8yd3VaQ2hzNE0xUXh6QUtPWUQzNVpa?=
 =?utf-8?B?MU9RNlpaUmt5VjY4TjB5Nm5WMCs4Rzc5YjYvUHFLSkw5a2FJeWY4VTA1Tmhq?=
 =?utf-8?B?N1ZOY1ZpdGJnQ0xvcFM5VG1WZ3FvN0lONkl5QzRFVXJwdlVXQ1RrTmh1SFgv?=
 =?utf-8?B?TEF0YXpKcUxzODJDOGtWK29wL2ErYXFZaTk1WDlrL1FnbHdLelBuem50Smg0?=
 =?utf-8?B?TFp0WUhITFFUTjRGRjdZbGJheDlZbThqVkVZREtoUDZtMGFObXV3RFhWNWFs?=
 =?utf-8?B?bllybHZtUlFKN2dERVJvMG9lNHdxLzJJVEpmRFdTRG5ubWZrejFwNHYvZ0pL?=
 =?utf-8?B?VzJmUG96dkpVUzRJUkE0Q0tuZVNrR0krdkEwZ09TdlZCanVoWm1xbTNnQ2ND?=
 =?utf-8?B?QVo3dzVXRnlaU2ZVeDJHOGd2R05VYngzb1VaVHEwMGc3aEVaYzYzWVBhYTZw?=
 =?utf-8?B?c2E3RURpd0NRYjB0V2UxalAzVnVpaWp4MzVPVWJCRmRSYWxMVGVqb3ZGSTYx?=
 =?utf-8?B?MFhaU3RpZ2RMMlViSW9EZU1OdHFLS0VwSDVpR0Yrdjh3L1hlNVp3d2xOaWth?=
 =?utf-8?B?WDFwWncwYVVXKzloRVY1N0pOVUJiVXJVL0s5Ry9iU1lrY2phcGpsUFdSaDlF?=
 =?utf-8?B?NTBZN3BqRCs2U1gxMzY1RVJKcXA1SHpqK0djL1dEOFJmOHlJeW5NVDgwdDVT?=
 =?utf-8?B?Z01YMHFUSWozaXV2Y0I4WFBXREhYQkFPL0FMR09JVkNJS3A5dlJmaUR4RlNT?=
 =?utf-8?B?SXY0RWowMVdZMkVVL1ZTVDZpLzN2cGFJdzFkRnRPTHpsWVVCSzM2dnF0RnJo?=
 =?utf-8?B?UUJGaW9MSEJxM0dFSFhVUDBZeWtsRnBPaTRqNHd3RVJsSDIvMlBHU0k3VVJF?=
 =?utf-8?B?cGhjamF4SU5JdSsrQ01pSFh5cVNnQTlOa1NiVUFkL0F1VjkrWHlVdTNHNDQv?=
 =?utf-8?B?cE5CZTRHbjg4cHgydUlMZ3M0bTk2U2JFeUpLQmZpNHA5TDByTWFNczJrcEpO?=
 =?utf-8?B?MTFOZXRLbGpUdS9CUWNpazE0amZJZVZmUGhxVWUzM3hmWUN2Vm5xOUNSZjc3?=
 =?utf-8?B?YkdPZXpDSUZwajgxbzRxRDJaWmpiaEYxRndtWGxXOCswVDJvU2NFRUZvdXl3?=
 =?utf-8?B?eHdrNlBJT3dnbGJWRE9KdjA5akNYalJ2MURrQVZiMXJwYUJKcFFkbTJZUk14?=
 =?utf-8?B?SEhTMGIybTJHWklRd3IwdmtTR0l5Uy9MdEpLTktjQjZ5ellOTDJUdllzcm5u?=
 =?utf-8?B?SXNaTGQ3V3FRc3JVQUhjQitYMWRHNHROSTErMWpOWDU2UEh5S0hiZ2dCUSsv?=
 =?utf-8?B?MTI5M1owOGljdWd6bTVrVGVHWTJIRHZHWlZFcjdBd21DdTVTRmtFTjF0T2hT?=
 =?utf-8?B?dk45NEoxb1VrczBzUXVJNWhzVksyaUlMNG1acFYyalZVQ0lNbzRFYTFzTEta?=
 =?utf-8?B?VDd3Uy9jTjVpYTlCRXFadz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnJZYTA0QUxHNDF6NDJwZDcxZnV1aGdDd3JManZhWlpPYXExS3I0SmZoLzZF?=
 =?utf-8?B?TGZVZmxVSk52S1NDRnUza0N0M2ZSUXM0S3ozN2xKeXVNYTZ3YzRZY3A1amQx?=
 =?utf-8?B?WUUzRU9tNkN6MUJCYXh1N05DcXpBMmFVS1ltZmliRkxxSVJYb2kwVUtpVTNu?=
 =?utf-8?B?TVBzWndRM0h3N0VxSDhWaXlPdEFUNjRkK3BHSWpoQnBzWDQ0eXl5NDBDcE1T?=
 =?utf-8?B?Ym00U2RzK2NudHlyU2R3eURaWkFIVXV3aVJCWWxrLzQwQW9rNGFMWVFoelJF?=
 =?utf-8?B?d3g0Q29TbkEzTDlSQW5BMjQ2Rmp3VmJqVjRrNzNhdURMZGtRSTVOYmo2eEta?=
 =?utf-8?B?Rk5jaGgySUZ5UXBIUlhXOHVNaWoyMmtWVWZhVmZLZm1iSUsvanJLTFQ3K3NM?=
 =?utf-8?B?OCt4bTM5T1c5TXRGa3pJZlpDWllXZCtZeGVtcDZPTzY5Y0x4cEVTMjd3bzgz?=
 =?utf-8?B?SnQvRnZpczJTKzZVcEZzZllWTDFCV1pKdHNoYUFqOFNkRUd2cGJJNE01K0kx?=
 =?utf-8?B?UDFMMUNiQ2RWcEFiQ3owcmh3MGZhWmNUSWhtMFBmTk5aY0NCZXRDUmI2T3pT?=
 =?utf-8?B?dXlFb1lHb0Q2VVpuNWVndnVHMzNjTnFsSHB6bDI1bHYrZmtTUk0rVDczZWlD?=
 =?utf-8?B?S3poeXVzMzRoVHJTeEp0VDltbjVueTE1NTE5TmRwOGo3Nk8wZmdYOVlNTklk?=
 =?utf-8?B?SVFOK0dtdFV1M0cyVzJqNEVpYnprcXJjb1FDNGVLTzJ1dDc2KzFod0t1MHVE?=
 =?utf-8?B?NWJkVndNTWRsamd4UGt3bUJOM0kwYlFFUjZSNXNKYWIySStyYUs5TFBHSGsz?=
 =?utf-8?B?UWJGRmthdTBoUStKTG0zc3hHdmFlTWJQazZqOW1aUkkwYjJ4ZkdHOGRlVjYx?=
 =?utf-8?B?am1yeUNQTlo1aDFXQWJFeVpHeGo3ZGVsdk9wRHNYZTFiNUw0cDNkdzlGNG9u?=
 =?utf-8?B?Z2F6QlVNZmVyYm9IcGxmUXBOVjJLbGVqVTA3K09QSU9JcHBjbFpNc0FuWnpt?=
 =?utf-8?B?WDZkWU1VL1ZadEkvY2FEWCtwRzFINkxONm91VzFXcm8xY3d3UitaQjMwMzcx?=
 =?utf-8?B?S2cyOTJNem0rREJ3d0ovNlpiQVBxVzNNM3hQZDhPY3pVL29JSmpacThVMXpp?=
 =?utf-8?B?eGo0dVA1U3ZxeUNUL1BBVnY1S3ZDejNHODB2bE9FSjhCY3lBcE04ZElCZ2xT?=
 =?utf-8?B?d0VQV09yMUNFbzdlbGZ6OWFnQUM2enh2QkVBZVBUdjR5eHdaVFpLR1NWYW4x?=
 =?utf-8?B?VVBoaW94NzVPOVJicDBzNVNmWmQyRkN6VU5nRVZ3bWwzWmUveWswdTFuaW94?=
 =?utf-8?B?NWxTZ1FyWnQ3b1cxZE9TeEhoLzdXYnVpaEFOZzZZeWVrbFZEaGMwWUphaXpm?=
 =?utf-8?B?UHc0Sk1VNVJUY1ZHYktScnRuZ1NCSWlkWVRuMDJKMUkzU3RqM2s3VjQ3NDhx?=
 =?utf-8?B?RzdOWGJTeVl6QTUvaFM4aVNPaHFJRk9OQlJNeU1kaDlvQ3NwREQrSm83cnIv?=
 =?utf-8?B?MXlRZytpNzdwd3plaFlnTmJUblhRaVVnMFdzQUdzaTJucnhwajVuUjNpT1Vs?=
 =?utf-8?B?R3Q2UlJ5d21NcUQ3WUNFZXBTOW9HcHRrdWRMTDV6Q2hLS3VybU0zZGxQYWFL?=
 =?utf-8?B?VXdYVyt3UTJUciszZzZ3enlZdnpSSGtDRXllZmlMRUsvS2lRMlZTVUlPaldK?=
 =?utf-8?B?VXJEREFjQ3BhM05mUERyL0dpckhrZDRmenZ4a2EzaVNFVDlFbUtNYXVTanJm?=
 =?utf-8?B?cjN0Z1NJdXgzYitoUDk1SWV1QUhWV1pTZzUxWEh0ZnJvbEkwQ2pYOUhNNXRv?=
 =?utf-8?B?VVhadkJONnhwemZ2MnpCZE1VbzdWSVE2T280ejRUTDZqVC9jR3lIbFI1Y2Rh?=
 =?utf-8?B?b0NiYnFyVmJ5eEx4VlE1eW1RUDBIZjVtb1E4MWh5WXMvYWVDbDE3KzBZUGZw?=
 =?utf-8?B?cmhGN3ppVmNDMndjakJyNmZ1dFMrQ1FsbnVlVHRmalhzQ0ZSUzBOaFFmT0t6?=
 =?utf-8?B?dlYwUlU4MnFxcU9ZMFZIUFhSTG1lR25nWkZSQWMrT0FZakpQcDhaK0pqRHJB?=
 =?utf-8?B?bmNjMS8vQTNDK1hmWW04M296UWpFWVRZcG9NTWJ6b1gvODZQejNmTWkwSVVt?=
 =?utf-8?Q?vVo3RuWD/FSyQ0AtHHiZ8PZ7k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f68d3d1-80e0-40a6-9d13-08dd0f6167b7
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 04:01:58.5450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qxXtAdjPNYrsMkHBXEEPymvs/71d/YKPDUUQqG+ynqheF16ZNXDXbrSBmNuFKTxDxPnxu5doQTKrBuxptUPg5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8088

On 27-Nov-24 5:58 PM, Mateusz Guzik wrote:
> On Wed, Nov 27, 2024 at 1:18 PM Bharata B Rao <bharata@amd.com> wrote:
>>
>> On 27-Nov-24 11:49 AM, Mateusz Guzik wrote:
>>> That is to say bare minimum this needs to be benchmarked before/after
>>> with the lock removed from the picture, like so:
>>>
>>> diff --git a/block/fops.c b/block/fops.c
>>> index 2d01c9007681..7f9e9e2f9081 100644
>>> --- a/block/fops.c
>>> +++ b/block/fops.c
>>> @@ -534,12 +534,8 @@ const struct address_space_operations def_blk_aops = {
>>>    static loff_t blkdev_llseek(struct file *file, loff_t offset, int whence)
>>>    {
>>>           struct inode *bd_inode = bdev_file_inode(file);
>>> -       loff_t retval;
>>>
>>> -       inode_lock(bd_inode);
>>> -       retval = fixed_size_llseek(file, offset, whence, i_size_read(bd_inode));
>>> -       inode_unlock(bd_inode);
>>> -       return retval;
>>> +       return fixed_size_llseek(file, offset, whence, i_size_read(bd_inode));
>>>    }
>>>
>>>    static int blkdev_fsync(struct file *filp, loff_t start, loff_t end,
>>>
>>> To be aborted if it blows up (but I don't see why it would).
>>
>> Thanks for this fix, will try and get back with results.
>>
> 
> Please make sure to have results just with this change, no messing
> with folio sizes so that I have something for the patch submission.

The contention with inode_lock is gone after your above changes. The new 
top 10 contention data looks like this now:

  contended   total wait     max wait     avg wait         type   caller

2441494015    172.15 h       1.72 ms    253.83 us     spinlock 
folio_wait_bit_common+0xd5
                         0xffffffffadbf60a3 
native_queued_spin_lock_slowpath+0x1f3
                         0xffffffffadbf5d01  _raw_spin_lock_irq+0x51
                         0xffffffffacdd1905  folio_wait_bit_common+0xd5
                         0xffffffffacdd2d0a  filemap_get_pages+0x68a
                         0xffffffffacdd2e73  filemap_read+0x103
                         0xffffffffad1d67ba  blkdev_read_iter+0x6a
                         0xffffffffacf06937  vfs_read+0x297
                         0xffffffffacf07653  ksys_read+0x73
   25269947      1.58 h       1.72 ms    225.44 us     spinlock 
folio_wake_bit+0x62
                         0xffffffffadbf60a3 
native_queued_spin_lock_slowpath+0x1f3
                         0xffffffffadbf537c  _raw_spin_lock_irqsave+0x5c
                         0xffffffffacdcf322  folio_wake_bit+0x62
                         0xffffffffacdd2ca7  filemap_get_pages+0x627
                         0xffffffffacdd2e73  filemap_read+0x103
                         0xffffffffad1d67ba  blkdev_read_iter+0x6a
                         0xffffffffacf06937  vfs_read+0x297
                         0xffffffffacf07653  ksys_read+0x73
   44757761      1.05 h       1.55 ms     84.41 us     spinlock 
folio_wake_bit+0x62
                         0xffffffffadbf60a3 
native_queued_spin_lock_slowpath+0x1f3
                         0xffffffffadbf537c  _raw_spin_lock_irqsave+0x5c
                         0xffffffffacdcf322  folio_wake_bit+0x62
                         0xffffffffacdcf7bc  folio_end_read+0x2c
                         0xffffffffacf6d4cf  mpage_read_end_io+0x6f
                         0xffffffffad1d8abb  bio_endio+0x12b
                         0xffffffffad1f07bd  blk_mq_end_request_batch+0x12d
                         0xffffffffc05e4e9b  nvme_pci_complete_batch+0xbb
   66419830     53.00 m     685.29 us     47.88 us     spinlock 
__filemap_add_folio+0x14c
                         0xffffffffadbf60a3 
native_queued_spin_lock_slowpath+0x1f3
                         0xffffffffadbf5d01  _raw_spin_lock_irq+0x51
                         0xffffffffacdd037c  __filemap_add_folio+0x14c
                         0xffffffffacdd072c  filemap_add_folio+0x9c
                         0xffffffffacde2a4c  page_cache_ra_unbounded+0x12c
                         0xffffffffacde31e0  page_cache_ra_order+0x340
                         0xffffffffacde33b8  page_cache_sync_ra+0x148
                         0xffffffffacdd27c5  filemap_get_pages+0x145
        532     45.51 m       5.49 s       5.13 s         mutex 
bdev_release+0x69
                         0xffffffffadbef1de  __mutex_lock.constprop.0+0x17e
                         0xffffffffadbef863  __mutex_lock_slowpath+0x13
                         0xffffffffadbef8bb  mutex_lock+0x3b
                         0xffffffffad1d5249  bdev_release+0x69
                         0xffffffffad1d5921  blkdev_release+0x11
                         0xffffffffacf089f3  __fput+0xe3
                         0xffffffffacf08c9b  __fput_sync+0x1b
                         0xffffffffacefe8ed  __x64_sys_close+0x3d
  264989621     45.26 m     486.17 us     10.25 us     spinlock 
raw_spin_rq_lock_nested+0x1d
                         0xffffffffadbf60a3 
native_queued_spin_lock_slowpath+0x1f3
                         0xffffffffadbf5c7f  _raw_spin_lock+0x3f
                         0xffffffffacb4f22d  raw_spin_rq_lock_nested+0x1d
                         0xffffffffacb5b601  _raw_spin_rq_lock_irqsave+0x21
                         0xffffffffacb6f81b  sched_balance_rq+0x60b
                         0xffffffffacb70784  sched_balance_newidle+0x1f4
                         0xffffffffacb70ae4  pick_next_task_fair+0x54
                         0xffffffffacb4e583  __pick_next_task+0x43
   30026842     26.05 m     652.85 us     52.05 us     spinlock 
__folio_mark_dirty+0x2b
                         0xffffffffadbf60a3 
native_queued_spin_lock_slowpath+0x1f3
                         0xffffffffadbf537c  _raw_spin_lock_irqsave+0x5c
                         0xffffffffacde189b  __folio_mark_dirty+0x2b
                         0xffffffffacf67503  mark_buffer_dirty+0x53
                         0xffffffffacf676e2  __block_commit_write+0x82
                         0xffffffffacf685fc  block_write_end+0x3c
                         0xffffffffacfb577e  iomap_write_end+0x13e
                         0xffffffffacfb674c  iomap_file_buffered_write+0x29c
    5085820      7.07 m       1.24 ms     83.42 us     spinlock 
folio_wake_bit+0x62
                         0xffffffffadbf60a3 
native_queued_spin_lock_slowpath+0x1f3
                         0xffffffffadbf537c  _raw_spin_lock_irqsave+0x5c
                         0xffffffffacdcf322  folio_wake_bit+0x62
                         0xffffffffacdcf7bc  folio_end_read+0x2c
                         0xffffffffacf6d4cf  mpage_read_end_io+0x6f
                         0xffffffffad1d8abb  bio_endio+0x12b
                         0xffffffffad1ee8ca  blk_update_request+0x1aa
                         0xffffffffad1ef7a4  blk_mq_end_request+0x24
    8027370      1.90 m      76.21 us     14.23 us     spinlock 
tick_do_update_jiffies64+0x29
                         0xffffffffadbf60a3 
native_queued_spin_lock_slowpath+0x1f3
                         0xffffffffadbf5c7f  _raw_spin_lock+0x3f
                         0xffffffffacc21c69  tick_do_update_jiffies64+0x29
                         0xffffffffacc21e8c  tick_nohz_handler+0x13c
                         0xffffffffacc0a0cf  __hrtimer_run_queues+0x10f
                         0xffffffffacc0afe8  hrtimer_interrupt+0xf8
                         0xffffffffacaa8f36 
__sysvec_apic_timer_interrupt+0x56
                         0xffffffffadbe3953 
sysvec_apic_timer_interrupt+0x93
    4344269      1.08 m     600.67 us     14.90 us     spinlock 
__filemap_add_folio+0x14c
                         0xffffffffadbf60a3 
native_queued_spin_lock_slowpath+0x1f3
                         0xffffffffadbf5d01  _raw_spin_lock_irq+0x51
                         0xffffffffacdd037c  __filemap_add_folio+0x14c
                         0xffffffffacdd072c  filemap_add_folio+0x9c
                         0xffffffffacde2a4c  page_cache_ra_unbounded+0x12c
                         0xffffffffacde31e0  page_cache_ra_order+0x340
                         0xffffffffacde3615  page_cache_async_ra+0x165
                         0xffffffffacdd2b9c  filemap_get_pages+0x51c

However a point of concern is that FIO bandwidth comes down drastically 
after the change.

		default				inode_lock-fix
rw=30%
Instance 1	r=55.7GiB/s,w=23.9GiB/s		r=9616MiB/s,w=4121MiB/s
Instance 2	r=38.5GiB/s,w=16.5GiB/s		r=8482MiB/s,w=3635MiB/s
Instance 3	r=37.5GiB/s,w=16.1GiB/s		r=8609MiB/s,w=3690MiB/s
Instance 4	r=37.4GiB/s,w=16.0GiB/s		r=8486MiB/s,w=3637MiB/s

Regards,
Bharata.



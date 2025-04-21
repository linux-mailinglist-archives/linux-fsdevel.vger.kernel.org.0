Return-Path: <linux-fsdevel+bounces-46807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F43A953B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 17:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55E997A8974
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 15:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD5F1D8DEE;
	Mon, 21 Apr 2025 15:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TKdCuREd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C9079C0;
	Mon, 21 Apr 2025 15:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745250468; cv=fail; b=Lc1Wj2JgnO1ky6ubeVARVYKU/syLxp0uAtwF727TLYOkLJ8NQ97Y2cIu6DScmba4s+ykO1y4EhQX510d7K8vWuxGceAkqXT9FAH/INXAnEvic3aA7sQpL3NSpLi6HkA05vqmSBjbjVCJZ4WOWZ4k73szhykdC3njxXUI6jNPOdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745250468; c=relaxed/simple;
	bh=dDThITzT4GhbTdYCrVtyLtMIOmj92MHrY051BnCAGsE=;
	h=Message-ID:Date:Subject:To:References:From:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=WKKZdpKvhS2YEV3WPDrqh1AI/IwASHOxlFbUp92g6w/qs4z07BTjj8afnbniQ9RWF+vgCY24QQCR7i7g5CINumvZg/gyEIh1ytsk06YtuhEiNfRfIjHLvTUEvz0AMgbKO1bWbUHQJ2szlJnNVK3mGMUkzwsNKz1aaEVo/NakxPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TKdCuREd; arc=fail smtp.client-ip=40.107.94.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZSA9x32XMOLUE9LH1AhOGunVncNDdjabWxhkE2wFpw30K2fMGheWVSJirCNFTlw4aY87RtfjDFNQ7kr8kQs7argWFYmrqYo1BgHO10jqToXyJjaeSfg2X134yqOdTqWQZcQuSgbZLDHACxTWG4xGgqgzdtcr1yg549PLeuH/qL0alyako7JgTCFnLPuylmBIUnsh3bHLpXDSqm+qZ583CNtxPEv9WCSEQJudGLoGvbYDoyF/oHUyhOgcUvVqlxmppDSPLrSR0pV0gXUz0GfNGWI3atBnldUhv/F4lpas2mstRqX+ZzGrlNwzcxMLvRHfAxso8kPTrV2FJL0J5NbEOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5Si63vlPgHEI9M75ymzGaxJ3tMhCBECoFq2+HaivRw=;
 b=owxzBi0UpAO3JrkE0tUsdIyxdD34ugz8dAbuuUM1k8CWYiREcRcBJCbLJttX0VbdBLMU0Pi7kS39kR+akgwnHCJ30JigPzbjNkbLwRN7u4wasemrrOI1jrAY1T21+AN0SzpSqFJJqwXBrsYl0Dc3PUngC0KHxqPKbAb8oZqFFglck/siS7vwAy5ZCeuqujs9D1KpuBDIhG1xhe+Gb6/OIGRullfNQWb3qibDMgjNp2dK+1y5PeW/qR7qalPKftwC/DBvbcCpbDN76n1x0Ox/5mHkmOtdowyPA8Wmvk7D5c8xCkjGeVG4oIgKmLJ7pZJkFsgjo/VVYc31ZrqGgbTLSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5Si63vlPgHEI9M75ymzGaxJ3tMhCBECoFq2+HaivRw=;
 b=TKdCuREdNZN60fJ2KIwP624wqhVDdBFNVUtRDITq4LOjOfGeLF3HSwXklLJJezg1MJLT5Tz8H0y+Zzbkd9G1DfGnXEW+eg6JzBrF8tyYGqFJjUtYDfCwNptrW5XecYXruMRd4yUoN/8QM+68x/7QKwR/O+4Haxs61T5LSuMdlwU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5804.namprd12.prod.outlook.com (2603:10b6:208:394::5)
 by DM6PR12MB4139.namprd12.prod.outlook.com (2603:10b6:5:214::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Mon, 21 Apr
 2025 15:47:24 +0000
Received: from BL1PR12MB5804.namprd12.prod.outlook.com
 ([fe80::4a0:2bbf:df47:e64c]) by BL1PR12MB5804.namprd12.prod.outlook.com
 ([fe80::4a0:2bbf:df47:e64c%5]) with mapi id 15.20.8655.031; Mon, 21 Apr 2025
 15:47:24 +0000
Message-ID: <7b395468-d72d-42c1-b891-75f127a1c534@amd.com>
Date: Mon, 21 Apr 2025 21:17:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: scheduling while atomic on rc3 - migration + buffer heads
To: Kent Overstreet <kent.overstreet@linux.dev>, linux-mm@kvack.org,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <hdqfrw2zii53qgyqnq33o4takgmvtgihpdeppkcsayn5wrmpyu@o77ad4o5gjlh>
Content-Language: en-US
From: Raghavendra K T <raghavendra.kt@amd.com>
Cc: wqu@suse.com
In-Reply-To: <hdqfrw2zii53qgyqnq33o4takgmvtgihpdeppkcsayn5wrmpyu@o77ad4o5gjlh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0111.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2ad::8) To BL1PR12MB5804.namprd12.prod.outlook.com
 (2603:10b6:208:394::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5804:EE_|DM6PR12MB4139:EE_
X-MS-Office365-Filtering-Correlation-Id: e1eff45e-69e6-4122-1419-08dd80ebcee4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0gwaUIrM0lWbndjdnRacy9rMVZNN3duSkJJOExqRVE1TUpxRDY0V1lmem9k?=
 =?utf-8?B?cWs1cmNBYXU1aEl2cncvZmFoMXJTOFVmeW5reHNwemNyd3l4VVdiT0MyV05H?=
 =?utf-8?B?YWprTFBMQ3B0UU1vUmJkc2wrTnYxRkJYMHlISEUyU3pVdGxqdmFVeENTbW10?=
 =?utf-8?B?RVliUk5wYWJlQjZlYU5SQU1lUE9YNXgyZTBScHpNT3Z1U3VFWTV4NVg2Mk1q?=
 =?utf-8?B?THFuRGhEdGw2Sms0T3Q2OGZNMVc5eTlYSTRVNHdURzFHR2ZxYTVjNURtWDRr?=
 =?utf-8?B?UGZ0YnlWcUkyVTVLL25GRzVnRmU0Q25Rc3VQWmhXNmRnTWE0d1cvRVU0bnBJ?=
 =?utf-8?B?QWJXaXp3dUhqSjNUNk54SXJNUE5mU0t6OXRwMm9GMHM5S3hsdk5sQlNYQlRl?=
 =?utf-8?B?R0E2YjJyZ3gzWGl4bGpGcUNtSXFaTmRENkhua1FQR3VRbDAwdDdvNVA5bUhV?=
 =?utf-8?B?YW5VTDVFVmpLTndiRGZ1WE5XYkNocUw5NFpLVG1GK0xGT3RwTk9peXZyb1NQ?=
 =?utf-8?B?VDJCREtwVlZ6V1VpWDJkM2hKTGd6NWRZT0d6OVhDb3RGY2EyU1JsaDZKYXZy?=
 =?utf-8?B?NW5aZkJIK2JzT1Y3U2txQ2tiZXE5QTFlcDhBdHROMk55TnVybmx2ekxrMHlN?=
 =?utf-8?B?UTlJc0ZXSmtxQUNWNmRpMiszdUtMUkZDNDJlek5MWTVJM0dFeGp5R0RqVzQr?=
 =?utf-8?B?L3JMWFMzdnNtWFMxcWQyMGU3SXlob2dXdHhDcldsV2lCdWRGRGJFSzNyYlNq?=
 =?utf-8?B?R21LWGpWc1lXd3hkaTBjZmpSa01BNmRnUXBxMFkxaEtLQ1JlRmdWSzUyL05Y?=
 =?utf-8?B?UDYzRnZES20rRTJVaSsyempTQVEyV1dJRG1ZYzFIZmhPMnRJSCtwdmZhTzM3?=
 =?utf-8?B?WTdGNnkydmExamtHMVJkdm5NV0NmazRIb05SLzcxZkFpRXRYa0NWZUFadmJ6?=
 =?utf-8?B?MVpQcWpVMTZmV1R1ekcxcEl5QWpYajVUT2p4VXpFRkxCZ1lRaFpEZk43cWhj?=
 =?utf-8?B?MzBwOVR5QkZ6dEpSYTZ1S1kyenA2T25IdDRxUnNHWGpIQVpwQnVoK1NPeUlm?=
 =?utf-8?B?VXcraDJhQ0h3TU8wRzU5bk0yeTJYQXhubExjZEtPRDh3KzJucGZwQkdIQ2d6?=
 =?utf-8?B?UFpNbEJyMVZuZXhEYll2UXNqUHJhQStpeUFONURibjNMSkswNmxRd2hSUnFk?=
 =?utf-8?B?Q09hY0NId2ZVeWVRWE8zajVYaytMWnpaMFQ4TlBJbWU2N0JmeVV1WmlUM2Fr?=
 =?utf-8?B?UGt2bEdkV2lOMkxYbFFsOExUTC96NVE5MjRoMlowNkV0OWpjclJRemFzSmxS?=
 =?utf-8?B?aS9YRE56NjNOSTdwRWNlZXJzLzlLdGsvWjFpL0NORm13d3RUeW5Wekx5Unk0?=
 =?utf-8?B?OFhaSWFydzlqaW9Fc2h4WXRpYnF5RmdUdDMvdjZvZDdOenV5N3ZCbGx6dkY2?=
 =?utf-8?B?R0tOV29NajE5TGNIWFFEWGJmRTZTbHZTZ3FHdTRsYjJBUmNvUWxZNnI5SkE3?=
 =?utf-8?B?OTJVcXB5WlNpZmtrZEdzNGlBMkhrejZBNDFjUVFWWnNHNGxDNC90emxPUDJD?=
 =?utf-8?B?MnVIeWoyQXNCZHZkM3o1SlBVU3YzQnVXeDlzWFAyNnAyYnNDSmdpUm5jK1Bo?=
 =?utf-8?B?Y05PM09qRG1mcmFWSlowdFZnYjRtUktkTFFhYTFxanQyK1dTOVE1MVYzdGVO?=
 =?utf-8?B?U1JZUzlkK2Z2dTZDKzU3US9uSkZJR2lGbUVkQ0tDWlY2bVZsYU1BNytBRThB?=
 =?utf-8?B?VTRwQ0ovR2syZVhKaHJUam56aFRWK1hKRGhlVkpGakZEMjJCaGV0dEVQMUhK?=
 =?utf-8?B?REZPbDdXcGF0dWRXT3ZlQUhxaDhNUlFNV1JMeVl0ZktkODRhS3Jya0NsVTB3?=
 =?utf-8?B?NjZwblJNeU51amV6d1pUeGtTNi96ZFBBdXB6eHh6MTRCMGxuL0xJVEVXL3JY?=
 =?utf-8?Q?yUU8KqUKwE4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5804.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkxQbUVLRWlQZWYraG9wbU1zcjdpdFAwSGZ6WnRYODNZSlJoa0ZmTGt2VzF4?=
 =?utf-8?B?UWxIQ3BQcndNaC9LY0RTZEVGM3o5aDRUcHRadmtxam5yemFmWkJnVm9PN0Q1?=
 =?utf-8?B?dmhBcGVDa1lPZE9zRXpJYzNHV216Qyt1ekdKcFg2eENtTGYwZEhsN1k5b2pP?=
 =?utf-8?B?Vi82RzlDQmFDZ05ERDdnZHhVNkEvRGQ0Z29Yb1ZZaGhRSURLZ1RXbTJCc3lU?=
 =?utf-8?B?MlJvSmZMaDRZMGZTMEp0aXpNRzhURnpybTBVU3VHdFdaTHZXQnd3NXJBYWlQ?=
 =?utf-8?B?K0d1bklKSldWOWFQald0VEdCbE41ek5GU1BLOXJQa2VtUjUyb1o0ekd1OFR6?=
 =?utf-8?B?bVRUT09YL0VqZWkzaVpsTTdFQUYvVDJkREQ5bXhkSkZVdVowVkkwS2NzRWdG?=
 =?utf-8?B?eVNQYkN2UjMxajYwNlZqeVMvL0NyTkw3T3FMV0lvTS9rZUVid25oL0dCNFZM?=
 =?utf-8?B?WVV3amRVU2VQY2pSVUFOemd5SkIramZ6STd0cEtzYXJKSWtXSUtvWFIwV1Zl?=
 =?utf-8?B?ZUlpbGVUME1qRS80TzhaNFl1YURLa0w2YTBMczZWcWpLdFRRRmhnWm01cjk3?=
 =?utf-8?B?dUVMNVJCQ01jYzFIQ3VXVDFqQVJ3N0krMkNoUWR3UUFSUHVWYTd0eHRPSTFM?=
 =?utf-8?B?K3k4SjVaZnpsK3YybC8zbmY0Ym8wWGRzMG1uYk01STBuK0RIUnBPNzRwUFVD?=
 =?utf-8?B?QzJtQTBlQWJuZy82S3lrRC9TMzcwNzJpLzBLQzJiaGs0ak9zL2VEZzgvMHlo?=
 =?utf-8?B?ZkVxblpJTkM4WlpiWUVqcHZiUGducHllTTFJL1FvRnNGd3FuWHg2WDhvMlJw?=
 =?utf-8?B?U3dORmtTSlBIRUZrYUlmY2pTR3dRejFsTHovTXA3dnFzN0U2RDlxSWc3RUNL?=
 =?utf-8?B?am1JUVFrSUJsV0FWU2I2YndZQmQzbVVkME1VME83eStJVEgyYVB6bGJKVFdZ?=
 =?utf-8?B?YWt0M1ByOWZCSHBSRWNITktacHp1cW5YRktaVngrdXlOWkNMS3dtbHg4WTVw?=
 =?utf-8?B?TkFBWC9GQkI3UGo3dHk3RUR1NTFxS2p2dWRhc0Q1a3F5czBqSzhuazJMcGt5?=
 =?utf-8?B?RlVleWF3VE13d210UDkxOWR4K29GYUJyNUtUaUxYS2Yya21RZnpEOC9ES215?=
 =?utf-8?B?ZjJrZHo4LzJNc3BVdmNMdFhDd2hCV24rNEhLOUttMUxNMHQwZStpM3U4K0Jz?=
 =?utf-8?B?L291bDE1TDREWGRDNnZncGxyMWZRS3lsU1hTR2FiWmdlSFBFVzdiU0FxWXEx?=
 =?utf-8?B?YlZSOUxTSXREZlpMWjdnRkQveW5Odm1DVjJkUUYzTm1xSDBkRVVXakdNbUF3?=
 =?utf-8?B?L0FSS2s0VlZRNm51dkZ5cHQ2elJGRkh4OC9yQTkxbDdtSUc3Rkw2a2RXN0FH?=
 =?utf-8?B?TEdONkJSV1VZMGI1VFJNcFB2VEY0cnB0ekp0ZWFjTXBsUkpLWGhYWjdpR0I2?=
 =?utf-8?B?MG9SamdmdWwxWUh4aFltS0czSlF5MGtuNnFZcnRJMXRjWXhpd0dSMUZsZEZP?=
 =?utf-8?B?dUZIV3A1b1ZZZzhGa2VQbGg0RE5lbmw2ZTdWd0V3VjFwejZSbmRyWURlYkMr?=
 =?utf-8?B?Tkk1VzFvRi9jdFVwRGY1OGdyQlFtTStXcHQzVzlSb1UxODhxLzhvUW9vbHZW?=
 =?utf-8?B?Ukp6bC8yL1dNWGVYUzZVUWVnRE1ZKzRDRThxb25aTVd1dGRGVVV2QnJKcVBP?=
 =?utf-8?B?bU9BZjhBeTU3U2RHTy9Ic2dXMDNKT0lxN05BME9hMWQxcm9RZWs2SGNOUUxU?=
 =?utf-8?B?RmNLdlNucUtPRERDbEdHMTdTS05WLzQvTnBBM1ZXRGszYUJ2cEQ2UnNXY0Rr?=
 =?utf-8?B?WG5CMmlOWXFZeXlYU1oxZ01hRXpJUG5jeFA5bXA0dnpnQlR5ckVCSDJ4ZDBR?=
 =?utf-8?B?UDBwc2s2bzJsTDFScGdkNUFkU1ZkcWRKMHFwUDJFUkJGK0pOdmdLelhyMUJE?=
 =?utf-8?B?aUtDUDNoT2dneElnTWNySEJkN2YzaGdvUTU0ZElmR2wvb2R0U2xsREVHNFJh?=
 =?utf-8?B?dlRNODNkWkY3Mk1RRHEzNmpLYzhQZzFuREFUczRGd3hYaWh1b1UvZ2k4MWgr?=
 =?utf-8?B?SXZOdW9hMExaWWE3bTNUN3l1NEZ2RUN3NjBrUHJHUUJZSWRtUlJkOVFFNGha?=
 =?utf-8?Q?Ru0Hz5xdC5TrZFI3FUnUnhbt9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1eff45e-69e6-4122-1419-08dd80ebcee4
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 15:47:23.9569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CqXuYporrbJVFpGqDDE5IC5jlc4opPPYXcaAg+xh4KG+D1EBX9SbZ8PTuXwj66cFTx4yagOR8DGKV0myHH1wfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4139

On 4/21/2025 8:44 PM, Kent Overstreet wrote:

+Qu as I see similar report from him

> This just popped up in one of my test runs.
> 
> Given that it's buffer heads, it has to be the ext4 root filesystem, not
> bcachefs.
> 
> 00465 ========= TEST   lz4_buffered
> 00465
> 00465 WATCHDOG 360
> 00466 bcachefs (vdb): starting version 1.25: extent_flags opts=errors=panic,compression=lz4
> 00466 bcachefs (vdb): initializing new filesystem
> 00466 bcachefs (vdb): going read-write
> 00466 bcachefs (vdb): marking superblocks
> 00466 bcachefs (vdb): initializing freespace
> 00466 bcachefs (vdb): done initializing freespace
> 00466 bcachefs (vdb): reading snapshots table
> 00466 bcachefs (vdb): reading snapshots done
> 00466 bcachefs (vdb): done starting filesystem
> 00466 starting copy
> 00515 BUG: sleeping function called from invalid context at mm/util.c:743
> 00515 in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 120, name: kcompactd0
> 00515 preempt_count: 1, expected: 0
> 00515 RCU nest depth: 0, expected: 0
> 00515 1 lock held by kcompactd0/120:
> 00515  #0: ffffff80c0c558f0 (&mapping->i_private_lock){+.+.}-{3:3}, at: __buffer_migrate_folio+0x114/0x298
> 00515 Preemption disabled at:
> 00515 [<ffffffc08025fa84>] __buffer_migrate_folio+0x114/0x298
> 00515 CPU: 11 UID: 0 PID: 120 Comm: kcompactd0 Not tainted 6.15.0-rc3-ktest-gb2a78fdf7d2f #20530 PREEMPT
> 00515 Hardware name: linux,dummy-virt (DT)
> 00515 Call trace:
> 00515  show_stack+0x1c/0x30 (C)
> 00515  dump_stack_lvl+0xb0/0xc0
> 00515  dump_stack+0x14/0x20
> 00515  __might_resched+0x180/0x288
> 00515  folio_mc_copy+0x54/0x98
> 00515  __migrate_folio.isra.0+0x68/0x168
> 00515  __buffer_migrate_folio+0x280/0x298
> 00515  buffer_migrate_folio_norefs+0x18/0x28
> 00515  migrate_pages_batch+0x94c/0xeb8
> 00515  migrate_pages_sync+0x84/0x240
> 00515  migrate_pages+0x284/0x698
> 00515  compact_zone+0xa40/0x10f8
> 00515  kcompactd_do_work+0x204/0x498
> 00515  kcompactd+0x3c4/0x400
> 00515  kthread+0x13c/0x208
> 00515  ret_from_fork+0x10/0x20
> 00518 starting sync
> 00519 starting rm
> 00520 ========= FAILED TIMEOUT lz4_buffered in 360s
> 

I have also seen similar stack with folio_mc_copy() while testing
PTE A bit patches.

IIUC, it has something to do with cond_resched() called from
folio_mc_copy().

(Thomas (tglx) mentioned long back that cond_resched() does not have the
scope awareness), not sure where should the fix be done in these
cases..

(I mean caller of the migrate_folio should call with no spinlock held
but with mutex? )

Regards
- Raghu








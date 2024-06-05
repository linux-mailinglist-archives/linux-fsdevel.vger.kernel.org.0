Return-Path: <linux-fsdevel+bounces-21025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 726C48FC76A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 11:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A5A41C23494
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 09:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118F618FC65;
	Wed,  5 Jun 2024 09:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VkuBYPV3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4897614B093
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Jun 2024 09:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717578865; cv=fail; b=AucFRo6KYIlBQL/4UbW6Ow2DL5ho1wlgTb83DUV9oiB2wU/SmRFEJnf/x68z987aYnI5iDy3MK9boXL4RE41y5fN5DBwBvflIHGGIQJNd276CRe99wG+FMzjxFp1plILRojfLADoJ5BNdbKn6hsuz/oSDMtKNl5Sbt2vEOF0zAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717578865; c=relaxed/simple;
	bh=bvCKpzVt6MfKJmJxBCWETetD54RdLiD/jiWDFs1j5kM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u9VA5odxj7JYCmjZTJ6H1pdlOh9NXxw59Vfe5BUmfRGA12vhIOgr1aRRpOlT4iRAwy7FxL1+FS8MmpSPF6OAOOlu4mjtgyBfatonwEN2iD3k6naBzOxzU56ZomwfWHEsSodNbvayl7BHwrnQOS7s6ELGqTGdr1lAtjHESBTQiYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VkuBYPV3; arc=fail smtp.client-ip=40.107.237.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aU+jcJDKGbzJJegAPGs8HilsH3muvsSAMiIlcmdNsbhF2HPUxqSbYBchE7tAyCqq+EQWlgg2D6YZxWPA5rBsMpgZr7BIsylEKLTy3TRrL/YTozXXXUAlKEddN4mUWmjG63ahkcZq1OuQsGEX6A664kum/dn18tE4yfPydZMAkv6LXFeleTe67VpqNvZE09y0oUjW2x1UjPqczzAN17h/H8FX9t4E+EQVMMrLbkMq8xCV4//uG+qgWylUMkj54n5hZBcUD1YqcUHY5ymZI4sRW8Nvyqf+0Wz6RIf7C3P1sTgZX7fDhJs4O5TIcmnUcwLm1YzRJUqYLsx5TWZbSIXAvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwdyq+ozIKBDOOEDz5sOu5v0bg1lKgjVQmjiLtb2cK0=;
 b=muAkromTyloJy9SvxQbfYLVotW29MlTLIAqNEkdtLlGFGvmeNCX2bRSas/XdIP8KkAfH+2JbeMKYBPqD/1DsDzuJqHVFP4FBQQf5wmQlrx4e7hBD1ooVnOonCA/2IepsUCK55zf1Ruq7UdIuXUo1X0hx9YlSC3r6eTPJ+9OXkmQU6MYFNHwL8SxclLwlo443wZTdKLqZcDR0lHfAbh08l6epc16XelY7CyCXFd5zCWj9ivxW1m/nupqH9PQnWtzdpql6Xt1X2q++sH62d7yqSwmBhyBkUeYBfpZ5EUYLcosMhCaRT334fIEQsXS9TnoXvEfi+hj+6MR3F7Fau+VNsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwdyq+ozIKBDOOEDz5sOu5v0bg1lKgjVQmjiLtb2cK0=;
 b=VkuBYPV3rjAwA1czvjtULCl0Qk3LZabp+FD6xcSoEycUQ6sk6gndRACtFfVQFWMmiS6TXg4/QnVBO2KNT5JtlSo798D0BHibIn+ufWrxZn5tPuML8RiHMZZpQE7Tp8+Js3/KEKQsheKSFeujHXYqDQRWBHnW8NbUK+LtIgrqiw4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL3PR12MB6569.namprd12.prod.outlook.com (2603:10b6:208:38c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 09:14:20 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 09:14:20 +0000
Message-ID: <f5d487a7-fd11-4fb2-8301-74f74b0a2257@amd.com>
Date: Wed, 5 Jun 2024 11:14:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2][RFC] amdgpu: fix a race in kfd_mem_export_dmabuf()
To: Felix Kuehling <felix.kuehling@amd.com>, Al Viro
 <viro@zeniv.linux.org.uk>, amd-gfx@lists.freedesktop.org,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>
Cc: linux-fsdevel@vger.kernel.org
References: <20240604021255.GO1629371@ZenIV> <20240604021354.GA3053943@ZenIV>
 <611b4f6e-e91b-4759-a170-fb43819000ce@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <611b4f6e-e91b-4759-a170-fb43819000ce@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0168.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL3PR12MB6569:EE_
X-MS-Office365-Filtering-Correlation-Id: f14e0010-3092-4c3f-e8a8-08dc853fe1c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZVIwOUJXVlYyQjBQWDBaOFNCcFpBdmwvUldlRTJhMHREWWxBNU9UOXFHMnhN?=
 =?utf-8?B?RVNwSHFqR1BkcjFJNTFldG9UTExJR3lzaGw2NjQxaWhXK2swOXEwZHhSWkFo?=
 =?utf-8?B?Z2RuYXliaGRyc2Fma1JrcEtXWTFGaEp5L3ZOOVNmcTJwNGJIWVhnZFdRWGw0?=
 =?utf-8?B?d3h0SkZJU0llWjUxOC85YmV3Szl4MkxiUWpCT3lubDJTYXhDbkFJcVRDMXI1?=
 =?utf-8?B?R3BjcUlSeXFCSjZLRkNpcDdnSlB6eVhtNWtrVEFiQ2lCN2ExTmswMENiM0tV?=
 =?utf-8?B?b1VGR3g4cU1BYkJodWVPTXRMWjhyemVYcExzNW01ZDd2ZmVsaDhLQWR5R0lG?=
 =?utf-8?B?WFJMeXk0TEhucE1HQ2t4TEhLdXpKalB4WmFyVmVqUVl6TC9XN0M5Zjl1a0pv?=
 =?utf-8?B?aUt5MElYRytRUlRreTIzVktJTmJkTjlVZnFrN1BiS0h2TmlwYUxoME01cFds?=
 =?utf-8?B?U2RNeldZQkZUb3lWcks1NEJLWTBYbzZuNG9Pa05ka1pqeUlUZE9QWUZuS3FG?=
 =?utf-8?B?M2NaMnFXSVNDUDViNzRLR1Zocks3MVZ1NHhtRlhaUFMyeVNQUnJ0aHQ1Yysx?=
 =?utf-8?B?Wm16Y0lXbjNpN1gvUkVEcDlmYXBWbmlVRHR6Wnd4Z2pZVnNQQmhyb09HdHB1?=
 =?utf-8?B?RVJ4TG5YNkEwSXJVMGp2TG5nNmk4bUFDWFphZTJKMUFNRXNpOHFQemNzMTF3?=
 =?utf-8?B?SXhieHF1ckJwQVM3R29ZMlJHbGFXTmtsaFFUMUZncTVRZGJDd1AwSm1ITStG?=
 =?utf-8?B?aFVPNlBoU2pZMmdvVk9iWVJCaUx4QWI3ZDk2djQrQjNNc0dPUFlZdG80OWtF?=
 =?utf-8?B?Rjl2Y1RHL3k0Wm5Eb3ZOVUdHcFV0bElzcUdNN3U1Q0hwMWMvUGVmQkRyOU50?=
 =?utf-8?B?Z0I2a1hGeHpPSlRFNGgzNjFLWnc2OCs4b3FPRkFObkZpdVB6L3RoUXZLQVRZ?=
 =?utf-8?B?dkhRbnIxZGhIWloyNmpyNnRNbG1WSnFaQVNuNlNkTDNZZjN2a056ZFgwdE8w?=
 =?utf-8?B?UmlERTZ4eGJUcnVIeDNnZ0VWOXFYNys0YUJaWlhuSmdjdWdOTEk4WDU0MkFu?=
 =?utf-8?B?QmhkZlFEZmpKRTRKdW96UHdtdXJETGFER0pGU1V1T0wwL1ZaYStZZUxuN1Qy?=
 =?utf-8?B?bjhmRTlFcWEyUTMybERYMzdRVi90T2YyZWFyN1ZGT1pGZjhyVGY0amZHK09D?=
 =?utf-8?B?RFA5dDAxSStpRXdwTDV5WlFWK1FudExyaURvYU1WTVlNRTBTdDNQQ2M4NGRw?=
 =?utf-8?B?cWc0NVNKbC81ZWxRUlF2WSsxZjZldDhRLzlmVG56MUJJRlQ0dnRZUlFVcEhL?=
 =?utf-8?B?SHl4cG96TW02RGxtTXVxT3ZRRVJObElvSDBUQUFGQjhHZi9pa0FobHF3bnBZ?=
 =?utf-8?B?OGdLS3A4MWE2a1VlMDNLUWxhaUhXeFFrU2xWS3NYVmhXZVNCMnBDWG5SRGZT?=
 =?utf-8?B?Wm1DOGRMVW5KbGNLUDBidkVQYUlJQWR3TTl1MWNuMW1IQlpKODdudmRTdUp5?=
 =?utf-8?B?eGlTVEgxYUV5S0FTQy9XR1RQYW84TktENS9wcEgxT0pJVlFvR0FtOHMwM3pN?=
 =?utf-8?B?N05BRlE0NFdHb0IzNmRTSlVOb1Q2aEN4Y2hMODBuQnE1blZNR1hxQ3g1Nzht?=
 =?utf-8?B?a2FLenl6a3l1VHlJZjJhYkFod01Cd0pybDhPV25LZmxLeUpsMmxaZ2VuNC9M?=
 =?utf-8?B?UVByVGlOYmdKaGFqcU5MRnJ1L1A4NFZ6MVZ1UTY0WkY2TWVuSXllZStXYUZK?=
 =?utf-8?Q?DS3WTkwiFxD9K+8yqLX9eTZYYMHkxXuAZ8J5/ux?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0lwckxrYmJBUmV1dCsvZHUwN3ZDT1pCM1RtOCtZLzVPVDBGb0RqRWlLbVZP?=
 =?utf-8?B?WkZzMER6OHNkODRnODI0NGI2c2FQWmV5ZU5PRlZ5R1F5VVp3OWEwZUVNMG5s?=
 =?utf-8?B?aGxSZ0xJM1dGRzFJYmRnVUYyTkl5bzRTQUdZb3FWTmV6SDNzN3dFOFFJSXM3?=
 =?utf-8?B?UjFrdDlwYnhNOEg0OGxRTStBUXE4UTJsbGFkM0dOZUN1anVCSVJwT2lPb3Ju?=
 =?utf-8?B?THpPS2hYUTUxcUd6Wk1Rb2VvaVlZd3VEblpVVXdieVVLNzVxeElBV1F2L1Q1?=
 =?utf-8?B?S2QxL2ZxQWJLVjhZdnpjSWJmOFQ1S1JwaFhtdlNQemZFTndydnRRR3Z1eDVz?=
 =?utf-8?B?TnJZSUZvZ0c3TDZyNGtSaWNEVmhtOFBCUnZMU1R5MzcwRVExSlR6UGZld3dp?=
 =?utf-8?B?dFhUUGdWL0pYcjZEVWt6MFAzc2hVaWo0SUJYSFpJemVXbEpzUGRMZG9ELytF?=
 =?utf-8?B?TDM1Vk1mbmYrRVR6enFSalM1OWdvVG1jdFhDTWF4aFE1bkxVbC9BbWJSS1U5?=
 =?utf-8?B?NXQ3VW1TeXlTaGg3TTB6VFdLWGRCWG1tNUNweXl1ay9ZUzNsQUpjMXRCb3pq?=
 =?utf-8?B?VnlNQWJYQ1IxdVIwOWtDbUlIVUR4cHFPVFFoSTdWaGVPU1dmUCtsTTZpR2tC?=
 =?utf-8?B?cUYrNTFnRU1CS3VoTmR6cU1VNVdRMWJNbUlmd0FrQThsQkhPNmRTVnFSeXEv?=
 =?utf-8?B?dU8rVlp6azVaTnhKYUcxb0NXZ3FheFlHUmdJbUlGWEJReTBRV2tmNk8raURp?=
 =?utf-8?B?VWlpczdpcWpXOFdHMDRUZ01qUUNYY2JDR1J5OWdkLzRINzd0TU5wN1psbGd6?=
 =?utf-8?B?UkZSUkZ0UDZJcGcwMXJ5a3N1M0NDZEY5b1M5NnQ4d2tEeHdHUXVwakFWendR?=
 =?utf-8?B?Z3hSY2gxTDRnaW1qeU5mNkJON1hJNThUZ3ZGb1Rpa2xtY0hkNjc2RmVTS3c3?=
 =?utf-8?B?NHdsZzJKR3pOTGFkdnc3eGFTSEVQZ3UvSTJKdG02U1duMDNuTG8yQlduYllr?=
 =?utf-8?B?WmZRWGZKR1dvZnUwNkRFenVtditQNUR2dVVMMFFZWFZXSkFrVGRtQTRsMmMw?=
 =?utf-8?B?RloxdkNOZVVWallZUDF5RTZIanZxOWNPSU5XTzBGejNXQ1JBNGtNMzFmZUtv?=
 =?utf-8?B?N0gvQ2ppaTI1RWUxTDRYN3pSWU9mdFc2SEoxSDdJbk9QTVUrendBaTBHWUx5?=
 =?utf-8?B?dXlCeWx1Yksva3hsRWpRZHNnVGw4c0R6RGZPVEFrYk00SmZJUmZNVVM0NTk4?=
 =?utf-8?B?OHljQjFubmZxTHlNMGxNVm1QSm1PcmQrYVVjTWtUR3NzMFNKNkk4Q3Axc3hI?=
 =?utf-8?B?MktaY2ZKYUgzNElqU1g3Zk5yaVhhcTZlc0xNZk5Yd2JtV0FUVEFLOXJLb29M?=
 =?utf-8?B?enRHenZCNkxaNkMyR3dYemxGTVcxcUpwTXRNQU8rdkhJUmdSYnlqMlNKMTBu?=
 =?utf-8?B?Mk5Leld1VlY4RmxMeEYxVHhHWnhLS2R0NWRsbktqRC81YnFycjRsUUxsV05F?=
 =?utf-8?B?WmduMEErbUp4bG1na2JEanNZYjhQSzAwTVVoenM3VzRPd0dzMDZra2dDa0R6?=
 =?utf-8?B?TXFYdW81SnJZSUFXekNBaGh5MHdvWmpmWTY4OHF6UXp6NmpvQ3kxMVVxaElV?=
 =?utf-8?B?UCtVRHJEOENGRmtKNXJyS2VHdnhKNFdtVE5oM1ZzQ0pObzNKRThMS0MvYndT?=
 =?utf-8?B?eVpLVENUVmcyL2F6ZlNFQnZ3OHlNUmhINGNkcmZvclVkZU9aZkJOSVgzclFW?=
 =?utf-8?B?OUFZT1RxaUpjTFdQNnNicE9HK3FlcFRaUHd1Mnd0QlNZRkRlb0hZT1h0aDJx?=
 =?utf-8?B?YUZwMlZTM29qZXh4bUJmVVJjWUxLVGo1WXBnY2gyN291SkxwaVVuWkpqWGpp?=
 =?utf-8?B?dkhCZXZsMnFSOXd5YXYxU2hYdHdLSGs2aEhzdk9Pdi9vbXpjRTZ0SGVIRGNE?=
 =?utf-8?B?bEQvV3o3dnBkNXNtc01rbFRRd3pKSVVOKzFHL2NZaFUvYkJobTJLYU15Uk1U?=
 =?utf-8?B?YTNBUTFzbnM5c2l3UVpwQlI4VkVGNytJTFdxTHFjbVhkN2t0Z2J5WXdJNFhy?=
 =?utf-8?B?MUFPV1NzNVFtMHNzSzI5N3ZlTVJRVG5HOGRMc2Q3VHlPZndISW8zRlg5bDZQ?=
 =?utf-8?Q?RRfe/gW8Zj23dzF0EzMKKB54N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f14e0010-3092-4c3f-e8a8-08dc853fe1c1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 09:14:20.0872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AY+wDvLg6DrHj+9qTzfYj+RCOyXIwznMGBFWDRjbfTxGO7BSz9ciJO2JHh6zOxjI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6569

Am 04.06.24 um 20:08 schrieb Felix Kuehling:
>
> On 2024-06-03 22:13, Al Viro wrote:
>> Using drm_gem_prime_handle_to_fd() to set dmabuf up and insert it into
>> descriptor table, only to have it looked up by file descriptor and
>> remove it from descriptor table is not just too convoluted - it's
>> racy; another thread might have modified the descriptor table while
>> we'd been going through that song and dance.
>>
>> It's not hard to fix - turn drm_gem_prime_handle_to_fd()
>> into a wrapper for a new helper that would simply return the
>> dmabuf, without messing with descriptor table.
>>
>> Then kfd_mem_export_dmabuf() would simply use that new helper
>> and leave the descriptor table alone.
>>
>> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
>
> This patch looks good to me on the amdgpu side. For the DRM side I'm 
> adding dri-devel.

Yeah that patch should probably be split up and the DRM changes 
discussed separately.

On the other hand skimming over it it seems reasonable to me.

Felix are you going to look into this or should I take a look and try to 
push it through drm-misc-next?

Thanks,
Christian.

>
> Acked-by: Felix Kuehling <felix.kuehling@amd.com>
>
>
>> ---
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index 8975cf41a91a..793780bb819c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -25,7 +25,6 @@
>>   #include <linux/pagemap.h>
>>   #include <linux/sched/mm.h>
>>   #include <linux/sched/task.h>
>> -#include <linux/fdtable.h>
>>   #include <drm/ttm/ttm_tt.h>
>>     #include <drm/drm_exec.h>
>> @@ -812,18 +811,13 @@ static int kfd_mem_export_dmabuf(struct kgd_mem 
>> *mem)
>>       if (!mem->dmabuf) {
>>           struct amdgpu_device *bo_adev;
>>           struct dma_buf *dmabuf;
>> -        int r, fd;
>>             bo_adev = amdgpu_ttm_adev(mem->bo->tbo.bdev);
>> -        r = drm_gem_prime_handle_to_fd(&bo_adev->ddev, 
>> bo_adev->kfd.client.file,
>> +        dmabuf = drm_gem_prime_handle_to_dmabuf(&bo_adev->ddev, 
>> bo_adev->kfd.client.file,
>>                              mem->gem_handle,
>>               mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE ?
>> -                           DRM_RDWR : 0, &fd);
>> -        if (r)
>> -            return r;
>> -        dmabuf = dma_buf_get(fd);
>> -        close_fd(fd);
>> -        if (WARN_ON_ONCE(IS_ERR(dmabuf)))
>> +                           DRM_RDWR : 0);
>> +        if (IS_ERR(dmabuf))
>>               return PTR_ERR(dmabuf);
>>           mem->dmabuf = dmabuf;
>>       }
>> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
>> index 03bd3c7bd0dc..622c51d3fe18 100644
>> --- a/drivers/gpu/drm/drm_prime.c
>> +++ b/drivers/gpu/drm/drm_prime.c
>> @@ -409,23 +409,9 @@ static struct dma_buf 
>> *export_and_register_object(struct drm_device *dev,
>>       return dmabuf;
>>   }
>>   -/**
>> - * drm_gem_prime_handle_to_fd - PRIME export function for GEM drivers
>> - * @dev: dev to export the buffer from
>> - * @file_priv: drm file-private structure
>> - * @handle: buffer handle to export
>> - * @flags: flags like DRM_CLOEXEC
>> - * @prime_fd: pointer to storage for the fd id of the create dma-buf
>> - *
>> - * This is the PRIME export function which must be used mandatorily 
>> by GEM
>> - * drivers to ensure correct lifetime management of the underlying 
>> GEM object.
>> - * The actual exporting from GEM object to a dma-buf is done through 
>> the
>> - * &drm_gem_object_funcs.export callback.
>> - */
>> -int drm_gem_prime_handle_to_fd(struct drm_device *dev,
>> +struct dma_buf *drm_gem_prime_handle_to_dmabuf(struct drm_device *dev,
>>                      struct drm_file *file_priv, uint32_t handle,
>> -                   uint32_t flags,
>> -                   int *prime_fd)
>> +                   uint32_t flags)
>>   {
>>       struct drm_gem_object *obj;
>>       int ret = 0;
>> @@ -434,14 +420,14 @@ int drm_gem_prime_handle_to_fd(struct 
>> drm_device *dev,
>>       mutex_lock(&file_priv->prime.lock);
>>       obj = drm_gem_object_lookup(file_priv, handle);
>>       if (!obj)  {
>> -        ret = -ENOENT;
>> +        dmabuf = ERR_PTR(-ENOENT);
>>           goto out_unlock;
>>       }
>>         dmabuf = drm_prime_lookup_buf_by_handle(&file_priv->prime, 
>> handle);
>>       if (dmabuf) {
>>           get_dma_buf(dmabuf);
>> -        goto out_have_handle;
>> +        goto out;
>>       }
>>         mutex_lock(&dev->object_name_lock);
>> @@ -463,7 +449,6 @@ int drm_gem_prime_handle_to_fd(struct drm_device 
>> *dev,
>>           /* normally the created dma-buf takes ownership of the ref,
>>            * but if that fails then drop the ref
>>            */
>> -        ret = PTR_ERR(dmabuf);
>>           mutex_unlock(&dev->object_name_lock);
>>           goto out;
>>       }
>> @@ -478,34 +463,49 @@ int drm_gem_prime_handle_to_fd(struct 
>> drm_device *dev,
>>       ret = drm_prime_add_buf_handle(&file_priv->prime,
>>                          dmabuf, handle);
>>       mutex_unlock(&dev->object_name_lock);
>> -    if (ret)
>> -        goto fail_put_dmabuf;
>> -
>> -out_have_handle:
>> -    ret = dma_buf_fd(dmabuf, flags);
>> -    /*
>> -     * We must _not_ remove the buffer from the handle cache since 
>> the newly
>> -     * created dma buf is already linked in the global obj->dma_buf 
>> pointer,
>> -     * and that is invariant as long as a userspace gem handle exists.
>> -     * Closing the handle will clean out the cache anyway, so we 
>> don't leak.
>> -     */
>> -    if (ret < 0) {
>> -        goto fail_put_dmabuf;
>> -    } else {
>> -        *prime_fd = ret;
>> -        ret = 0;
>> +    if (ret) {
>> +        dma_buf_put(dmabuf);
>> +        dmabuf = ERR_PTR(ret);
>>       }
>> -
>> -    goto out;
>> -
>> -fail_put_dmabuf:
>> -    dma_buf_put(dmabuf);
>>   out:
>>       drm_gem_object_put(obj);
>>   out_unlock:
>>       mutex_unlock(&file_priv->prime.lock);
>> +    return dmabuf;
>> +}
>> +EXPORT_SYMBOL(drm_gem_prime_handle_to_dmabuf);
>>   -    return ret;
>> +/**
>> + * drm_gem_prime_handle_to_fd - PRIME export function for GEM drivers
>> + * @dev: dev to export the buffer from
>> + * @file_priv: drm file-private structure
>> + * @handle: buffer handle to export
>> + * @flags: flags like DRM_CLOEXEC
>> + * @prime_fd: pointer to storage for the fd id of the create dma-buf
>> + *
>> + * This is the PRIME export function which must be used mandatorily 
>> by GEM
>> + * drivers to ensure correct lifetime management of the underlying 
>> GEM object.
>> + * The actual exporting from GEM object to a dma-buf is done through 
>> the
>> + * &drm_gem_object_funcs.export callback.
>> + */
>> +int drm_gem_prime_handle_to_fd(struct drm_device *dev,
>> +                   struct drm_file *file_priv, uint32_t handle,
>> +                   uint32_t flags,
>> +                   int *prime_fd)
>> +{
>> +    struct dma_buf *dmabuf;
>> +    int fd = get_unused_fd_flags(flags);
>> +
>> +    if (fd < 0)
>> +        return fd;
>> +
>> +    dmabuf = drm_gem_prime_handle_to_dmabuf(dev, file_priv, handle, 
>> flags);
>> +    if (IS_ERR(dmabuf))
>> +        return PTR_ERR(dmabuf);
>> +
>> +    fd_install(fd, dmabuf->file);
>> +    *prime_fd = fd;
>> +    return 0;
>>   }
>>   EXPORT_SYMBOL(drm_gem_prime_handle_to_fd);
>>   diff --git a/include/drm/drm_prime.h b/include/drm/drm_prime.h
>> index 2a1d01e5b56b..fa085c44d4ca 100644
>> --- a/include/drm/drm_prime.h
>> +++ b/include/drm/drm_prime.h
>> @@ -69,6 +69,9 @@ void drm_gem_dmabuf_release(struct dma_buf *dma_buf);
>>     int drm_gem_prime_fd_to_handle(struct drm_device *dev,
>>                      struct drm_file *file_priv, int prime_fd, 
>> uint32_t *handle);
>> +struct dma_buf *drm_gem_prime_handle_to_dmabuf(struct drm_device *dev,
>> +                   struct drm_file *file_priv, uint32_t handle,
>> +                   uint32_t flags);
>>   int drm_gem_prime_handle_to_fd(struct drm_device *dev,
>>                      struct drm_file *file_priv, uint32_t handle, 
>> uint32_t flags,
>>                      int *prime_fd);



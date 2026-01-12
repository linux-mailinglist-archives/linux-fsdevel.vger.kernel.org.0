Return-Path: <linux-fsdevel+bounces-73216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E24D12369
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 12:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CE4A30C40C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 11:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A59F3559D4;
	Mon, 12 Jan 2026 11:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SIHuL6mA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010025.outbound.protection.outlook.com [52.101.201.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2945730171A;
	Mon, 12 Jan 2026 11:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768216363; cv=fail; b=TojNrOJ6mz0if4EuPEnN7k4RMFLVcUPo4/+TJDkJ40slkpJH4XyaY+jOUJrBId4YjC9qD3qt5tAmt6bF3rO1D62zkGhAehRmaufylrFUEPrD+W0dldVegaO2Ytg4laG0XayEK9ngTS7yDBTgsj+xd1P5yH0J3hVEBRoZKYrRmbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768216363; c=relaxed/simple;
	bh=Zc/3/Ev0JcZzUrOrJbvQEY0A23uJ4LM/5H0lvm7Gx2s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MHTDmE/0FOKZtrDGIUyk7/++oQwPAaAIDDhcR8ihubAyNYeygVrlM7ZQayWf62c+n/xzq32rZJmZL7GFIPY178IwrK2s/569Q0f/kUhCHH3++T7eT06zSU3Bc1bZcTboOwer3o4DLkPdk6CGkZM307wC3/D8SMArhTPFo7wZyxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SIHuL6mA; arc=fail smtp.client-ip=52.101.201.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A3ARLgEbtM0XSgoUv8QUq6nejFALavf1gfviBvz1V4z4XX2rZDvNUbxXSrHqXFZXKoWB6gdNnNC7lRh7iX46l4/GzypmT962VKu3aqJ2rUi7SYKj6TBowvMeNOaAekkP5A9S4luAsg6oV8CQkMtwSYaaDPdNlcuJ0A8OPJs/BimYEUUVDi+YeTihyOwhK/fVsN8vZFqVeVdChFHIQpNLR+sm+LDOmqTmdmV8cmjrM6B2dYPbZX/wBjZMvMXUvxcrjGc+XdSadzIgNWIcdh4uz+kiZl6SqnM11I6Juxt833L9FN+HITtthFBn3u3hb5iLdD5K9l3GIdZqQVwlddyClg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fLf/kIjInLHFsAq8aH+jHuG8Ikz06GF1EkWgd+RZIg=;
 b=JcPL3Zfwa3zcC+es3TwW4x5NIj2BNBU2mQR9xDLvKxjTsisJbYFHht/wpgGQY2Xf356LDcb48tbGsOtG216STz7G2gXNZPKx9MjqGyIIJMKnoZcg3CrHjqiBbD2NKmlEVbc2RlLQE0GmM7nCMmmGujAi0PJPdGdgbZz4l4Ga91fVRf0azhXt8fNmfT+fKr45VjTC2uPdQbPFyhO9JeIgDn/QmZx2pNRDPS0vug1mOskLkpolkzc3DuO/+dn+KttMSF7tMPfuKYUyaQPUEJJFv3hdJ/0FGot03jDKe5lDwkWwde53FR0Idfl2OkHhDJgKy8GYkzu3mAyJ8e/DnE4kow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fLf/kIjInLHFsAq8aH+jHuG8Ikz06GF1EkWgd+RZIg=;
 b=SIHuL6mAZP4pX3lRuA7g4CFluOGeK4BGdoM8IpNAbSk7W6LPN0BujFi96TP+3iNIlYjgrcWfMXYTlvzAG3twp57h9wf/2vbOHhps/+DBKWma5FL1vDvoVOJGNZaHjwl9phY9g/FNqhZuSBpcKTs8aCm/P+hULW8SAv59gqom+ML3iityAJEwWNIiZVPAnCWVvmhHHnfNBStfWuT9+rhpENUwemtQVADouRShd/1c4hLE4zThTOd8hGM2EpcdKIcyvmQMe3tpi5PRDWIPfhKHOVI0ygIt/QHUhYAx4QT2zeH11yo+Jk4EaVhDk1AvjawClZgHnPvyX0QRDlzFfBNyjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by PH7PR12MB6934.namprd12.prod.outlook.com (2603:10b6:510:1b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 11:12:38 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::2920:e6d9:4461:e2b4]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::2920:e6d9:4461:e2b4%5]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 11:12:37 +0000
Message-ID: <6604d787-1744-4acf-80c0-e428fee1677e@nvidia.com>
Date: Mon, 12 Jan 2026 22:12:23 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 0/8] mm,numa: N_PRIVATE node isolation for
 device-managed memory
To: Gregory Price <gourry@gourry.net>, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, kernel-team@meta.com, longman@redhat.com,
 tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, corbet@lwn.net,
 gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
 dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, akpm@linux-foundation.org, vbabka@suse.cz,
 surenb@google.com, mhocko@suse.com, jackmanb@google.com, ziy@nvidia.com,
 david@kernel.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 rppt@kernel.org, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, yury.norov@gmail.com, linux@rasmusvillemoes.dk,
 rientjes@google.com, shakeel.butt@linux.dev, chrisl@kernel.org,
 kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com,
 bhe@redhat.com, baohua@kernel.org, yosry.ahmed@linux.dev,
 chengming.zhou@linux.dev, roman.gushchin@linux.dev, muchun.song@linux.dev,
 osalvador@suse.de, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
 rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com,
 apopple@nvidia.com, cl@gentwo.org, harry.yoo@oracle.com,
 zhengqi.arch@bytedance.com
References: <20260108203755.1163107-1-gourry@gourry.net>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <20260108203755.1163107-1-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0246.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::11) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|PH7PR12MB6934:EE_
X-MS-Office365-Filtering-Correlation-Id: e46d4719-967d-4546-11f5-08de51cb7e9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzhxL3BmdWlacUtrUnFRdFlsWVEzMExZVlhpVG5xRm1xTnN3eStDZERma2U2?=
 =?utf-8?B?eVkwY0Jnckp0UjlLQWM1WFFGMUkyVnNRbTFhOUtEY2xlQ3JvNnJhZFhza3RH?=
 =?utf-8?B?eEdFS2Zwc3ZHMi96RG1PVkV3Vk44Qno1NGhHYzg3RFFJTTZQajFQbGEvWVhX?=
 =?utf-8?B?VVhqOGNjekVkRWVVdW9xWFlKYmRVM3QwZGo5eU15Zy95L3BwWSszZStaRFJN?=
 =?utf-8?B?bHdlWXByRy9BZ2tGMUlRWVZyQXJmU2F4R0RTOFpZdVl1NWFYc2JuYVo3MGl6?=
 =?utf-8?B?M2xzYVhEVy9TQ1Job2tZdkJha1U4bkhRRm9hZjNJOWJLN1pVNndSWHlMeVA2?=
 =?utf-8?B?TVJrcTFhYjhwczdWQ2Q2UmxoTVNnZ3VOMlRwaGVteG52Nlg5SVArZitwOXZE?=
 =?utf-8?B?NU9JOEVvdklyOUt6ZDAvSlIyM0J4MEhvbjdyeEw0UWFCRDBjN1RMZGNHRHZk?=
 =?utf-8?B?ZW51WnRLNkNmQ0Rqd2dFNTd4RFE0NEh6U1BqSjFMbEtNWm1OV0pPLzJ6QkJZ?=
 =?utf-8?B?V2hKSm9UNDl3ZklBeUdwYTlsK3JmeWRydUVLRmNWYVU4WjZnTWs0Z1B0bmM0?=
 =?utf-8?B?ekR5QlZudms3WjlJTHMrOHRvMzBRR3RHQ0FZSzFWM2g0bVZUUFlFMUdBTEdv?=
 =?utf-8?B?YkdpNWEwVUQxMjdOZDdhMVpXMy9UVm45RnNmVnVFaERSUzVDV015N3ErSEpj?=
 =?utf-8?B?NHFqR1FxeExidmxvR0M1T1hsSWVkYXdnditydGRrMi9lQ29TSjZ3QURveGQ0?=
 =?utf-8?B?Y2JrcVUyNkZOZldnNDRHL0V1L25kUDRmY1pLZXVYaHo1NlF6aVNsNlR2Q2Zt?=
 =?utf-8?B?WEM4QnNEQnJJRmRFR0xPNStZV2x6TmhTTVhlV0FPN3FDK2Y0dEF5NW1kUW9S?=
 =?utf-8?B?dlFzR2tNZDB3VUNBaFNoVE93bE1SUVh0cGpZN2E1U0FxaDFhTDF5S3JlL1hv?=
 =?utf-8?B?bWJTNlRkL2VhdE9MK05IM0FqVUhuN1R1WVl5Vkl4OFVoQzJaT2JhREl2VnNj?=
 =?utf-8?B?V0dhTVF6WFJwRGxxUFZ1RmdsaFBlbitBcFdJUURzK0lWcVp3aUd5WEgrNExY?=
 =?utf-8?B?RW1FNldVc2FLcEVYaVQzSlVUU0tBYmhSNHhoZmV2UDRxbFk4YnVBYm5xYUJv?=
 =?utf-8?B?dmN4QUpYd3RlZE5EQjM2Q3h3ZHZqSHh6M2dteEMwdlV5RHVNZVJYZWxiekNy?=
 =?utf-8?B?aHUwalhXbzE1SFdKcFVTTStQSXZ4STNGbEFqT3V5N2hITlZQNVpmdWJNRkZU?=
 =?utf-8?B?YW9RQmN4UG1GOC9WQ3pSbDdMR0VuRGJJQjFPa0RBWkVLejhWQ0t4b0RkSDIr?=
 =?utf-8?B?d0NONTNjdnd2L2pNcnJXS1JzM0pkRHhLNURSODVDVVMvUmdNRzNZdlVhc1dI?=
 =?utf-8?B?dVZtVlRRcldFU3lBaXJnUjFRMmJLajJIbWVxMHFNanZ5WjFLdnowMkVOeGVS?=
 =?utf-8?B?K0xTbkZNbEhvSlJoNU1IVU9ROGlrUHBRam5mamk2eFd3b3VPdzRmM1ZWYVVC?=
 =?utf-8?B?dXVNVnZVYlBjQkxXRDhIRUdsTGQwd2NNL3dHUzA5d3FSVktkQnVZQ2ZrSkNm?=
 =?utf-8?B?SFNWeTJXMnkrOHU5ZWZDSks4cER6dWk1TWxsQUhvVENzTHBvRFVYWDRWaWtH?=
 =?utf-8?B?UXJFK0c1N05HOU5qNWdmTzlONG1tQldqYkhzSmpBV3VpN2pmblhrOEFxM3pv?=
 =?utf-8?B?MzVzcTZSM1Jrdy91QWRmKzgvSzk5dUYxdG1sMHpMUWxVVlFXLytBaXZrdTZG?=
 =?utf-8?B?dS91L0pVUWpUZVdQK3ViUzVZL0M0M1FiSHkxSGkxSzgxdmUzVEI2MGI2cm8z?=
 =?utf-8?B?OFJkNWVYajAxaFkxdzRKOUh4Rk95Qk1lelE5TEpQT1RTb3B4ak5sazFFWnM3?=
 =?utf-8?B?bjhxZUk5bTU2RXBVSlhMLzBnV1RjcjlPQUVYZkwwcXFBRnA4REZ5R3R2RGRw?=
 =?utf-8?Q?Yi65GrFA6XsJ5RHm7XUicWWR12O1hDt/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2ZjMEsvUTF0NHZFcnVOOHdrVlhtRUJObzFva2dqZHE3dVI1amNDbXNEcHpw?=
 =?utf-8?B?aXFNTGZQOC9kMEprUkpxakJZNzc3cS9Qb2VMN2c0MVZtdVVONlZNdXg2YlA0?=
 =?utf-8?B?M2dKdXVXNWlSY0FMakhJREh2elF4RkdFajh1aWpTeHhxTnRzOEw5U1Bsd21p?=
 =?utf-8?B?b0NHdHNYdmxGOEFCQzdqc3hqYmttakN0YTdSVjd3QTNtMGJKRGVJSnBPQzlF?=
 =?utf-8?B?RWVRWURhZUQ2enJ6d1Y5ZkMwaTNBQ002VkdqWUtCcTQ2S3NTUWxhMGdZaWpJ?=
 =?utf-8?B?SGEvOHB6eUpUaVZUSDJRUDNsV0NsdGFWeldjVjVIUnhMcGVMajV5SWpEaGIx?=
 =?utf-8?B?cFU2SUMrK3RrelJ0UzFvNWFNdlRkRWVSYzc5QUgzNXhRWjFtbmU4MVZabU16?=
 =?utf-8?B?MmExVFNrTGs0RjFhckhRc3krNHh2MTZuZGNXd0xsVURXVjJ1YlJiZUkrU29Z?=
 =?utf-8?B?Ri82TXp5YTJ0ZzhsNVhTTjZremVKZnN0SkEycThWTmdlcno0UVR4MjhnRTMx?=
 =?utf-8?B?aUhPc3R3c1Y2am1DbWtzWHR5QXJ0dmJOQjE3STFrbjhpQjJ0ckhPYTdDampW?=
 =?utf-8?B?NS9LendHVXl2cndua3MvMkx5SDY2TnRTR2xweS9IMGtEcUlxWkp2REtnbFg1?=
 =?utf-8?B?SGtjLzRKS29FTXM0R1Rmbm1kM3NENENqbXN4Qit5Q0NCdWtEL0hHVjkxRzRj?=
 =?utf-8?B?cFpQRlo2dmJqZTZ0aTFheUdveVRuajFtRlE5a3VhWGNSNFJycEVBWHRzOE9X?=
 =?utf-8?B?TXZoYkJ1Y2NIaWRJbkdUVjBaemtNZWxpMnNsb3RYV2I2dXpzN0JxQVpieUcz?=
 =?utf-8?B?a0pnMlljYy84UXNRUnd0dXplbWhWOEcxZStSMHNOdVgrMEc5ZXNPZ0JGT1pO?=
 =?utf-8?B?VVA1VlR2b0p6Rm1kWjNqVWd6bVhQS21mQ1dzQk1mbE90bDhGTHl5WDNubW1K?=
 =?utf-8?B?czlHMUVMRGQyajMzRU54cU9RU2x4YUJFY2xjRGdBUVB6QnowdkRwUUtudDE2?=
 =?utf-8?B?aXFXNUlwZWtBNTNncjczT1N2bnc5a1Y0QTc3TW5pbXdXRUdKOTdYRFlNdDFr?=
 =?utf-8?B?N2NHeWN0ZEl6TUtKUmpVdUx3bVQzUmRBK2N1MlpSZlc0SThOY21RWS9tcVFE?=
 =?utf-8?B?eXhQQWJlZ3pDdHZDQW5KNDdaeHMvLy9uejNxRXNWNkF6djB5MkcvWjQraGxk?=
 =?utf-8?B?cmdEU2VXMVJubkRwNklaSGZKN2xMekJ3cHd2VHlsUEd4cnAvZkh5cWtMODFV?=
 =?utf-8?B?bmdGb2NXRXVZdXpQamY1QUpJb2tjelA1Q2ZHeWpFd1JGNURESVQ2Y0N0RHZu?=
 =?utf-8?B?S0taWVVRK0pLdEl1M1RjVFVMZnV0WXFNZnZuNFNQSlRuRVl2TFV5eEtsblNY?=
 =?utf-8?B?cm91azdnUGJiQTVZamsrb0w3cmkrSmRSK2FwNTduTnB2bzdISVorUVpFWGFL?=
 =?utf-8?B?NFhWTXVHZUZuRVZaT3A4Wkd0RkdmQW9lWG11c25ZSWkzcnFCS1FYc1FCS00y?=
 =?utf-8?B?cUx2YnhDUVY5RDZKeHBLSDdHeWI4ZFMzVzA5UzY0bHVxK1ZDZGJnZEkvL1Qr?=
 =?utf-8?B?cG5xTTFPTkM5TnZ6VkgwL0tlVVczUUJ1QVVkbTVsaFh6NkthZU1uaGJlb1RH?=
 =?utf-8?B?VUEyTzVaMHM3VUJHMzhXVlB2ajdJOVo4TjM2MlVoQTBHYTdlT00xMnBlQVh4?=
 =?utf-8?B?eEdvTlNCU3lkWHdEM1lHN1JqQVZHdmptR1dBcjAvRFo1b0crNEtlNWY2TVRL?=
 =?utf-8?B?NWZPSjcwWFBoL0ZvcytueGU5ZUhnTDNxQmZZVHk2R2gzc3FrUzl1bDZGeERt?=
 =?utf-8?B?R3ZkSnFXNkRQQTJlNnF2dUlDUnNackxpOG9pL1dvaWNSTkp2Rm02SGxMbXpD?=
 =?utf-8?B?d05Mend1Mkg4RWNYSmY1TzBNbWhzSlhQNk5Ed2ZRT2RNNHAvU1hnc0JJUFRz?=
 =?utf-8?B?REY1M2prR3hDOWd4UWEzdUU5aTZaNjdPTm4rNTk5M3MyYzgzdlRmN29ZZDJI?=
 =?utf-8?B?QXVMa1p5YStDS1NJaWUvNzhlYjFJTXoxVnRSbWJKT0dtc0hlR25MTjVxZU1W?=
 =?utf-8?B?VlhwUTZoRXVxYXc5WG5vU2hadTV2YnFZVVA5RDUwbFJNNjk3Y2x4OE00MVJH?=
 =?utf-8?B?V1NWdHlKYURxNjN4d2hDdzJRcVc0NXVxS1dVNEJ5MHVEak5QQ2xrNVk1ZWo0?=
 =?utf-8?B?VjNlZFdPcm8vL3drcWV4QUFvRmQvVWxxRHgrM3pPSmJVWEkrOXpQZHNCWXJq?=
 =?utf-8?B?M080VVNCS1BpTnp3SENlM21YTGNZSHRwU1drbllpQVFQZ1MwTmlEaGJiamxB?=
 =?utf-8?B?d2NxZFR4NkI4Zi9vMkN4YTFPMENoQjdrSzR3VjU5MnF1ODByd01Pa2YyL3dp?=
 =?utf-8?Q?VlCJ/BKgcpTX8lf1YzaHHHxkYxYM7pCfZS13oz5I7f68F?=
X-MS-Exchange-AntiSpam-MessageData-1: LrQQcvo2bPNwRg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e46d4719-967d-4546-11f5-08de51cb7e9b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 11:12:37.8855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m7IztdQuFrNc0dgYBDLrQEliEdqtNMUXT4YRmdI2EYUG+iHvxjfe4sHkFOJHmWrjzzzLb/fi+16jjJMJIfSTIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6934

On 1/9/26 06:37, Gregory Price wrote:
> This series introduces N_PRIVATE, a new node state for memory nodes 
> whose memory is not intended for general system consumption.  Today,
> device drivers (CXL, accelerators, etc.) hotplug their memory to access
> mm/ services like page allocation and reclaim, but this exposes general
> workloads to memory with different characteristics and reliability
> guarantees than system RAM.
> 
> N_PRIVATE provides isolation by default while enabling explicit access
> via __GFP_THISNODE for subsystems that understand how to manage these
> specialized memory regions.
> 

I assume each class of N_PRIVATE is a separate set of NUMA nodes, these
could be real or virtual memory nodes?

> Motivation
> ==========
> 
> Several emerging memory technologies require kernel memory management
> services but should not be used for general allocations:
> 
>   - CXL Compressed RAM (CRAM): Hardware-compressed memory where the
>     effective capacity depends on data compressibility.  Uncontrolled
>     use risks capacity exhaustion when compression ratios degrade.
> 
>   - Accelerator Memory: GPU/TPU-attached memory optimized for specific
>     access patterns that are not intended for general allocation.
> 
>   - Tiered Memory: Memory intended only as a demotion target, not for
>     initial allocations.
> 
> Currently, these devices either avoid hotplugging entirely (losing mm/
> services) or hotplug as regular N_MEMORY (risking reliability issues).
> N_PRIVATE solves this by creating an isolated node class.
> 
> Design
> ======
> 
> The series introduces:
> 
>   1. N_PRIVATE node state (mutually exclusive with N_MEMORY)

We should call it N_PRIVATE_MEMORY

>   2. private_memtype enum for policy-based access control
>   3. cpuset.mems.sysram for user-visible isolation
>   4. Integration points for subsystems (zswap demonstrated)
>   5. A cxl private_region example to demonstrate full plumbing
> 
> Private Memory Types (private_memtype)
> ======================================
> 
> The private_memtype enum defines policy bits that control how different
> kernel subsystems may access private nodes:
> 
>   enum private_memtype {
>       NODE_MEM_NOTYPE,      /* No type assigned (invalid state) */
>       NODE_MEM_ZSWAP,       /* Swap compression target */
>       NODE_MEM_COMPRESSED,  /* General compressed RAM */
>       NODE_MEM_ACCELERATOR, /* Accelerator-attached memory */
>       NODE_MEM_DEMOTE_ONLY, /* Memory-tier demotion target only */
>       NODE_MAX_MEMTYPE,
>   };
> 
> These types serve as policy hints for subsystems:
> 

Do these nodes have fallback(s)? Are these nodes prone to OOM when memory is exhausted
in one class of N_PRIVATE node(s)?


What about page cache allocation form these nodes? Since default allocations
never use them, a file system would need to do additional work to allocate
on them, if there was ever a desire to use them. Would memory
migration would work between N_PRIVATE and N_MEMORY using move_pages()?


> NODE_MEM_ZSWAP
> --------------
> Nodes with this type are registered as zswap compression targets.  When
> zswap compresses a page, it can allocate directly from ZSWAP-typed nodes
> using __GFP_THISNODE, bypassing software compression if the device
> provides hardware compression.
> 
> Example flow:
>   1. CXL device creates private_region with type=zswap
>   2. Driver calls node_register_private() with NODE_MEM_ZSWAP
>   3. zswap_add_direct_node() registers the node as a compression target
>   4. On swap-out, zswap allocates from the private node
>   5. page_allocated() callback validates compression ratio headroom
>   6. page_freed() callback zeros pages to improve device compression
> 
> Prototype Note:
>   This patch set does not actually do compression ratio validation, as
>   this requires an actual device to provide some kind of counter and/or
>   interrupt to denote when allocations are safe.  The callbacks are
>   left as stubs with TODOs for device vendors to pick up the next step
>   (we'll continue with a QEMU example if reception is positive).
> 
>   For now, this always succeeds because compressed=real capacity.
> 
> NODE_MEM_COMPRESSED (CRAM)
> --------------------------
> For general compressed RAM devices.  Unlike ZSWAP nodes, CRAM nodes
> could be exposed to subsystems that understand compression semantics:
> 
>   - vmscan: Could prefer demoting pages to CRAM nodes before swap
>   - memory-tiering: Could place CRAM between DRAM and persistent memory
>   - zram: Could use as backing store instead of or alongside zswap
> 
> Such a component (mm/cram.c) would differ from zswap or zram by allowing
> the compressed pages to remain mapped Read-Only in the page table.
> 
> NODE_MEM_ACCELERATOR
> --------------------
> For GPU/TPU/accelerator-attached memory.  Policy implications:
> 
>   - Default allocations: Never (isolated from general page_alloc)
>   - GPU drivers: Explicit allocation via __GFP_THISNODE
>   - NUMA balancing: Excluded from automatic migration
>   - Memory tiering: Not a demotion target
> 
> Some GPU vendors want management of their memory via NUMA nodes, but
> don't want fallback or migration allocations to occur.  This enables
> that pattern.
> 
> mm/mempolicy.c could be used to allow for N_PRIVATE nodes of this type
> if the intent is per-vma access to accelerator memory (e.g. via mbind)
> but this is omitted from this series from now to limit userland
> exposure until first class examples are provided.
> 
> NODE_MEM_DEMOTE_ONLY
> --------------------
> For memory intended exclusively as a demotion target in memory tiering:
> 
>   - page_alloc: Never allocates initially (slab, page faults, etc.)
>   - vmscan/reclaim: Valid demotion target during memory pressure
>   - memory-tiering: Allow hotness monitoring/promotion for this region
> 
> This enables "cold storage" tiers using slower/cheaper memory (CXL-
> attached DRAM, persistent memory in volatile mode) without the memory
> appearing in allocation fast paths.
> 
> This also adds some additional bonus of enforcing memory placement on
> these nodes to be movable allocations only (with all the normal caveats
> around page pinning).
> 
> Subsystem Integration Points
> ============================
> 
> The private_node_ops structure provides callbacks for integration:
> 
>   struct private_node_ops {
>       struct list_head list;
>       resource_size_t res_start;
>       resource_size_t res_end;
>       enum private_memtype memtype;
>       int (*page_allocated)(struct page *page, void *data);
>       void (*page_freed)(struct page *page, void *data);
>       void *data;
>   };
> 
> page_allocated(): Called after allocation, returns 0 to accept or
> -ENOSPC/-ENODEV to reject (caller retries elsewhere).  Enables:
>   - Compression ratio enforcement for CRAM/zswap
>   - Capacity tracking for accelerator memory
>   - Rate limiting for demotion targets
> 
> page_freed(): Called on free, enables:
>   - Zeroing for compression ratio recovery
>   - Capacity accounting updates
>   - Device-specific cleanup
> 
> Isolation Enforcement
> =====================
> 
> The series modifies core allocators to respect N_PRIVATE isolation:
> 
>   - page_alloc: Constrains zone iteration to cpuset.mems.sysram
>   - slub: Allocates only from N_MEMORY nodes
>   - compaction: Skips N_PRIVATE nodes
>   - mempolicy: Uses sysram_nodes for policy evaluation
> 
> __GFP_THISNODE bypasses isolation, enabling explicit access:
> 
>   page = alloc_pages_node(private_nid, GFP_KERNEL | __GFP_THISNODE, 0);
> 
> This pattern is used by zswap, and would be used by other subsystems
> that explicitly opt into private node access.
> 
> User-Visible Changes
> ====================
> 
> cpuset gains cpuset.mems.sysram (read-only), shows N_MEMORY nodes.
> 
> ABI: /proc/<pid>/status Mems_allowed shows sysram nodes only.
> 
> Drivers create private regions via sysfs:
>   echo region0 > /sys/bus/cxl/.../create_private_region
>   echo zswap > /sys/bus/cxl/.../region0/private_type
>   echo 1 > /sys/bus/cxl/.../region0/commit
> 
> Series Organization
> ===================
> 
> Patch 1: numa,memory_hotplug: create N_PRIVATE (Private Nodes)
>   Core infrastructure: N_PRIVATE node state, node_mark_private(),
>   private_memtype enum, and private_node_ops registration.
> 
> Patch 2: mm: constify oom_control, scan_control, and alloc_context 
> nodemask
>   Preparatory cleanup for enforcing that nodemasks don't change.
> 
> Patch 3: mm: restrict slub, compaction, and page_alloc to sysram
>   Enforce N_MEMORY-only allocation for general paths.
> 
> Patch 4: cpuset: introduce cpuset.mems.sysram
>   User-visible isolation via cpuset interface.
> 
> Patch 5: Documentation/admin-guide/cgroups: update docs for mems_allowed
>   Document the new behavior and sysram_nodes.
> 
> Patch 6: drivers/cxl/core/region: add private_region
>   CXL infrastructure for private regions.
> 
> Patch 7: mm/zswap: compressed ram direct integration
>   Zswap integration demonstrating direct hardware compression.
> 
> Patch 8: drivers/cxl: add zswap private_region type
>   Complete example: CXL region as zswap compression target.
> 
> Future Work
> ===========
> 
> This series provides the foundation.  Planned follow-ups include:
> 
>   - CRAM integration with vmscan for smart demotion
>   - ACCELERATOR type for GPU memory management
>   - Memory-tiering integration with DEMOTE_ONLY nodes
> 
> Testing
> =======
> 
> All patches build cleanly.  Tested with:
>   - CXL QEMU emulation with private regions
>   - Zswap stress tests with private compression targets
>   - Cpuset verification of mems.sysram isolation
> 
> 
> Gregory Price (8):
>   numa,memory_hotplug: create N_PRIVATE (Private Nodes)
>   mm: constify oom_control, scan_control, and alloc_context nodemask
>   mm: restrict slub, compaction, and page_alloc to sysram
>   cpuset: introduce cpuset.mems.sysram
>   Documentation/admin-guide/cgroups: update docs for mems_allowed
>   drivers/cxl/core/region: add private_region
>   mm/zswap: compressed ram direct integration
>   drivers/cxl: add zswap private_region type
> 
>  .../admin-guide/cgroup-v1/cpusets.rst         |  19 +-
>  Documentation/admin-guide/cgroup-v2.rst       |  26 ++-
>  Documentation/filesystems/proc.rst            |   2 +-
>  drivers/base/node.c                           | 199 ++++++++++++++++++
>  drivers/cxl/core/Makefile                     |   1 +
>  drivers/cxl/core/core.h                       |   4 +
>  drivers/cxl/core/port.c                       |   4 +
>  drivers/cxl/core/private_region/Makefile      |  12 ++
>  .../cxl/core/private_region/private_region.c  | 129 ++++++++++++
>  .../cxl/core/private_region/private_region.h  |  14 ++
>  drivers/cxl/core/private_region/zswap.c       | 127 +++++++++++
>  drivers/cxl/core/region.c                     |  63 +++++-
>  drivers/cxl/cxl.h                             |  22 ++
>  include/linux/cpuset.h                        |  24 ++-
>  include/linux/gfp.h                           |   6 +
>  include/linux/mm.h                            |   4 +-
>  include/linux/mmzone.h                        |   6 +-
>  include/linux/node.h                          |  60 ++++++
>  include/linux/nodemask.h                      |   1 +
>  include/linux/oom.h                           |   2 +-
>  include/linux/swap.h                          |   2 +-
>  include/linux/zswap.h                         |   5 +
>  kernel/cgroup/cpuset-internal.h               |   8 +
>  kernel/cgroup/cpuset-v1.c                     |   8 +
>  kernel/cgroup/cpuset.c                        |  98 ++++++---
>  mm/compaction.c                               |   6 +-
>  mm/internal.h                                 |   2 +-
>  mm/memcontrol.c                               |   2 +-
>  mm/memory_hotplug.c                           |   2 +-
>  mm/mempolicy.c                                |   6 +-
>  mm/migrate.c                                  |   4 +-
>  mm/mmzone.c                                   |   5 +-
>  mm/page_alloc.c                               |  31 +--
>  mm/show_mem.c                                 |   9 +-
>  mm/slub.c                                     |   8 +-
>  mm/vmscan.c                                   |   6 +-
>  mm/zswap.c                                    | 106 +++++++++-
>  37 files changed, 942 insertions(+), 91 deletions(-)
>  create mode 100644 drivers/cxl/core/private_region/Makefile
>  create mode 100644 drivers/cxl/core/private_region/private_region.c
>  create mode 100644 drivers/cxl/core/private_region/private_region.h
>  create mode 100644 drivers/cxl/core/private_region/zswap.c
> ---
> base-commit: 803dd4b1159cf9864be17aab8a17653e6ecbbbb6
> 

Thanks,
Balbir



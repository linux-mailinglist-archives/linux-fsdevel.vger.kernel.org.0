Return-Path: <linux-fsdevel+bounces-73330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AA58BD15B09
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 23:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CDEF5300BFA0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 22:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458C02C21F7;
	Mon, 12 Jan 2026 22:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S2wYuRTm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010042.outbound.protection.outlook.com [40.93.198.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4141428C866;
	Mon, 12 Jan 2026 22:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768258491; cv=fail; b=pznCT9v7iF6c3EHRfqGVdt9ocJEsXe2eDTEWFKs+FOU9jtT2OEj7YAUssHhhRB5JwUvdNB/PqI0ZPgW5IHhGMrpuyvPX1UuWYKpkdirrY859c76HTlt2ar0IlOOUntvIfQvs+fCIielexB9D+SXCD2d+I1KuFk7nJDbBoUYDAkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768258491; c=relaxed/simple;
	bh=gCpLBgl0sLJIAdtDf/dKEOIwt0T/uaklGaFAFmpLIoc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bbH9s6WLs+tkuPOfNZxYC17CFwjnUd5eCHe0mcUIxO6NKkhCd2iOgS46FryCfIe8jYe/DlTRMoGuAIQVPHHWPHqehxRQmhLOxiLfYhL+ne+RENrsdKgmqzcOu/HKz2fhqTaCbIsmuheTSO5T2zkzzTxNPE55yW7YdZmengWLsBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S2wYuRTm; arc=fail smtp.client-ip=40.93.198.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LdT27useTC6Y3m4lNAT/vACHoMJ+NiOakNiYvniArd11vPuPE6AK7/h9RoCnWIO5HdBbVHbJj8MOqwqcKOC/oUwTbZTihOyja3l0ispo7RrG2xwYtsxO3k71dAXcWRImGAY0aXdd5aVREQbBnIJfDwAPP/2XDZebYvrOh7D4LnAQ29T8QNXnmoYGLJj/1vDP4L24RTLFVPzbY2fkj7pOeO+ayb20aOZLznxrTHjvAuqbv3xxviGHm1icQvQaMEVqqjv7R49QTPwkNwCtIzDh8U+lJFRxQhToN8dkrGOSm01uVdOh2Y0ctH80cUxnFlnaunE72LrK7RRMklqbLM9AMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJP5GgSYoDfCvPIcvFRQTY1Exn6RFIdQSrWeHu29c/o=;
 b=GRKvn+oQu7ErEGpFL3WG2dXzM4JRFM9e7DgGnsp5jbIEIu09RiJSowWptqBmuOLXJu9HchuGAZ6sph+r8g6qJ2lojRCGxPBwGn2Ta9/kv5Te5emZRXiB+vTWZonXotkFGBPE++hHwhUCYjHCnSC4oZBMEBOtzxgEjl9+YNYYLU3CxZSXD42vmMsKe4e9mDtE83dsvovHPofu9AUjXYjzZAWvAoNUj2DQjSoSM3gYfwOo7cNxa0PEPp9S3DdZlrKwEX7hUn3uYZqHmS8ZPpchr2v4UAfasQXW9V+Qr/P3/ne3z9kkpyWfnr/LP2I5pMdFfXnpOp74TLqEC/qeWX4Eog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJP5GgSYoDfCvPIcvFRQTY1Exn6RFIdQSrWeHu29c/o=;
 b=S2wYuRTm6J9n4v4rkG8Wp1x4iN/6evPpxejEzgwovGB+UK4pv2W5B5B1asNd8TAMSmBGlRacRBcTghNVy8r2ntYbjrK+GbQqlEs4Tl1ugAoRnQOIchduouqt1YAlOGeg5iYtZxYtOzyP6zavziBOta2SgrcE4LQnC1mDqWRFivJN8NMZYOV4QE4V9VhZ2Arr9EG0YL4dRhGhG6+OnUr3cB6hBfjqB8uIYXET6pgeaZ4KVI9KV5Xd0D9VucNJV6ZiroP8OlANRApCqa+cbUKPBHFao+7keILjoyC3DnZYqZeSq8LoYOYq+SQ61aHV1B2OzK/bPQm5rDkcBdXIhYJmMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by LV2PR12MB5846.namprd12.prod.outlook.com (2603:10b6:408:175::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 22:54:46 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::2920:e6d9:4461:e2b4]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::2920:e6d9:4461:e2b4%5]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 22:54:46 +0000
Message-ID: <966ce77a-c055-4ab8-9c40-d02de7b67895@nvidia.com>
Date: Tue, 13 Jan 2026 09:54:32 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 0/8] mm,numa: N_PRIVATE node isolation for
 device-managed memory
To: dan.j.williams@intel.com, Yury Norov <ynorov@nvidia.com>,
 Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, kernel-team@meta.com, longman@redhat.com,
 tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, corbet@lwn.net,
 gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
 dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
 mhocko@suse.com, jackmanb@google.com, ziy@nvidia.com, david@kernel.org,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 yury.norov@gmail.com, linux@rasmusvillemoes.dk, rientjes@google.com,
 shakeel.butt@linux.dev, chrisl@kernel.org, kasong@tencent.com,
 shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com,
 baohua@kernel.org, yosry.ahmed@linux.dev, chengming.zhou@linux.dev,
 roman.gushchin@linux.dev, muchun.song@linux.dev, osalvador@suse.de,
 matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 byungchul@sk.com, ying.huang@linux.alibaba.com, apopple@nvidia.com,
 cl@gentwo.org, harry.yoo@oracle.com, zhengqi.arch@bytedance.com
References: <20260108203755.1163107-1-gourry@gourry.net>
 <6604d787-1744-4acf-80c0-e428fee1677e@nvidia.com>
 <aWUHAboKw28XepWr@gourry-fedora-PF4VCD3F> <aWUs8Fx2CG07F81e@yury>
 <696566a1e228d_2071810076@dwillia2-mobl4.notmuch>
 <e635e534-5aa6-485a-bd5c-7a0bc69f14f2@nvidia.com>
 <696571507b075_20718100d4@dwillia2-mobl4.notmuch>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <696571507b075_20718100d4@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0041.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::16) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|LV2PR12MB5846:EE_
X-MS-Office365-Filtering-Correlation-Id: ae932fb4-6222-48f6-9680-08de522d9543
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1V0eXBhVWkrZ1lpbEZlQ0hPZ01LQW1FbGRybE1VWFQxcmtPSHZybzBKRjVU?=
 =?utf-8?B?UHlDK1crTUkzbFdndWFVcncxdzh0a05WY3pqM0x0ZGE1MWpnc3VRQTd0RWJl?=
 =?utf-8?B?V3VMWUxyL0gxbkRtM0pYcDRFYWJKTXY1N2RHNnVVazlkSHVEV1h1OTR1Rmdt?=
 =?utf-8?B?cmZ1TjNXMmIwRVpVanNvNGJyQ3lXMHhtWTFpc1N1SmpTVm5mdzhzTXh3bFpZ?=
 =?utf-8?B?T1lRcUZzTzUvVTdqRCtNWVRyVG40eVhCaWpXb21NWHYycGtEdFgwT09BMUV3?=
 =?utf-8?B?aWFvUE5iR1JDT1JVcDhGWUw2Sit4cXFzZkh5Z09KMlcxTnJpS1paNmVrVzJv?=
 =?utf-8?B?d201aTFjSE51MjREZW1aOGlvc09FNlFvMCt1Z3JyQVhwVnljcjdXK3RSSmxj?=
 =?utf-8?B?aDZVTFF5SmlKUTFrTWNlUEhFcjBLY1VpQ28rVTJFRlhWaUpNcG9tNFFybklV?=
 =?utf-8?B?S1BSUEI2TEpXcmlDTlVNODhOV29VTWcxYjdhaEZZUkxBUTlwd0Jia09QOVhm?=
 =?utf-8?B?Q2dqc3hBazJWQU8zQXA5OVdkekhRdzlSL25MdS9qTU04Z1M4Y3JMMW1XN2l0?=
 =?utf-8?B?RXNIUFIvMXR3NlBKakRsSWl2S1drSjJhdEpVRkYzVUVWQ2JDNS95N0JQNnF5?=
 =?utf-8?B?OTVwQUlKS1FRUHJrcFQyK2cxOTY0VzFNSVBZQWEvcjVzN2J0V1ZrSmI0TDAv?=
 =?utf-8?B?dWl5NVZ5Q0xOdCtmUFU2dGdMdEI1VFBnVWNyc2VESElLZ2tZL2lSOFYwK3ov?=
 =?utf-8?B?ZExWNVRDWDlacFdBdmJlSlpIVGVxb000N1B3cE9VS0d6cElKUnpiY1hGSjlT?=
 =?utf-8?B?WGdZRzcvdGtVbTFDeGFKc2FjQWU5YjUrQ2VaTzlxNFh5N3Z0TzlvclRPcVZo?=
 =?utf-8?B?SkxBN0FldVBYTmdXRnIxSTQyaXZldUJOOW0xQXNHV2lOQ0hWYU1ndnVJN05l?=
 =?utf-8?B?TEVQeThHMUIyZnJDQzgwZVNxOVpxVEx5UTRYSE5zck5rU1BGbTZWLzZmSlRF?=
 =?utf-8?B?U1YyZzdXMEZwQlAvWmgrMlV6azJCWjNGeVVJN1E1M1o2ejhqNGFsc2NzODhT?=
 =?utf-8?B?TzVFcFRvMkxkVXkvREVESmVQejAzQ3MzT0s2TUlwVjZEYkNxMkpMZ0htMjN6?=
 =?utf-8?B?emRJWmhuUmdJSEFtTG5RNm5BS1J5cVJtSlVlWEpzNW93aWo2NU8zYkY3L1ZY?=
 =?utf-8?B?ek03SmFFY0xFS1ZvRzN6b3A3L3pRTXl2REhMNGVadG81d2RIUXhxeXhoUnlE?=
 =?utf-8?B?cnpMeWxqN3Y0Um1TaUlOTVJ0dEtEV0tnWDA5dGFvZTRpM1JZWFVDaE5SbENs?=
 =?utf-8?B?ZEhjU2FiSnJPT0RhZHVrMUY4SjVzT1h5czRkVGVVSUIvVWY5d3NiNHhMTDh1?=
 =?utf-8?B?Zk1CWnFpM1FydjV2cmVJenFpRDFycFJqbTZLUGJGZkJDdVpxSnZrK3Q1WGwv?=
 =?utf-8?B?RTFKU25Tc1ZQbGhKU1JzRXM0dTB0K2lNMysxeFdoNnpYZnZvbjI1OEJSQWZj?=
 =?utf-8?B?cG15Wk1LaDNVeXMrWEc4THlmQVlFOXIzUXVzQVpXOXh4cm5STEpvSzZiRUU5?=
 =?utf-8?B?N0xCYnQxbFZXeWJ4ZElFZTBoYVU4WFdsd1ViVTZiSjNjYWNBckZ3eGxYQm5R?=
 =?utf-8?B?WWxqcmVhckovVmh5QXRSRTEyb1N4L0d4T2tRRVBMSDg3RUkwWVNSVUVHMk5R?=
 =?utf-8?B?K0dFb3UwSzhMcW1rWndhc2NIZm5pem1PWkRKTHk2NmxuN1ZXZ1FBZVRyOUQ1?=
 =?utf-8?B?SU9SSkxpeXUwcTFiQXMzcE01WEU1Zm8wY3RhK1dZSThOajJYV1BUaTRIKzN1?=
 =?utf-8?B?U0pwMi9ZUi9MdlpBaGxIdUdPdnhnZmZCUmpzbXVrajZVdzVxcHUzeXZGZWNx?=
 =?utf-8?B?SmxndEtSaW1PakRpZWdzdTNaZTdBNlpjWlNkbTVPKytHcDlZektESGtTdXRw?=
 =?utf-8?Q?7dRFJkvds1oGxGkTCSqtjlPg9emB6l/6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXpqQWhjODZRcWVDc0g4c3JGa0hFU3F1SUhCUDhDMWc4SUFzcG4rSmg0aUxS?=
 =?utf-8?B?SFR3VEpaVDB4QmJFN3JKRDFQTHJwM0xtVGtZTTN0ZnhEWlJvZHRGSmpHWXZ3?=
 =?utf-8?B?Tld0M05NYTdNbTIvVGpEbFp0S3lFbmRkVUJrbW5lWXRvNEJXeE9DNzF1VkVH?=
 =?utf-8?B?cHB2R1lvWUdxNDE4MzNKamNrMmlLZjNIb3puZ1BFaVRHaXc0QnB1MnZXTUtT?=
 =?utf-8?B?UWc1eGo3NnIrNDY4ODg1clVDU1BYRkxSeGI1TzRabDg1eEJCbjRjcFdsUkw0?=
 =?utf-8?B?NlZaNDEwaTVjM3BRQmgxSVZXL2FQZWt0NnRNL1ZDclRCTm11dmd1c2U4Nk1D?=
 =?utf-8?B?V3JFeHluYW1HYUovRzhyQzVxWUxOSGp1Q3liM0JJMmp3YVl6OVU0b0xHRTE3?=
 =?utf-8?B?TS9JL0VIdEtMT1hURDl4SEZxa0hYSGgyOEJwL29WRjAzNlNLWmhSajh5VDBr?=
 =?utf-8?B?ZGMxckFyU24yU2NFdUhMTEl0VXBQQ0svdUxwQ2EzTmJPMW9ubEpKM2pFSG1n?=
 =?utf-8?B?UXZpOExvdkNrVFhjelZaK3pMQVFqL2JGU2tNcWdwZFp6QXM1MTBkdW9MU2pZ?=
 =?utf-8?B?SGFrYkYrdWxUbVZoRU5CeWZtbzdoTythUWJsQThhM3Z2SFNMVFVlYXVVYlU5?=
 =?utf-8?B?aXVlNzNwWGF2MktJNVZlU25nWFRKa3dmbTFocG94NTZuZHZWQzVLNzZnbDJv?=
 =?utf-8?B?RVhvWHRRMldkMUIrdzgzUWoxcjMxL1hIT3VFL3N3WC81R2F2QXlpUVNRNnJZ?=
 =?utf-8?B?eW1YVFpaYlFQQUIzZVFjYkZTTkJqZElRWUcrSjJqUVVqWlRKdUJrY2NGZURG?=
 =?utf-8?B?Nkd6T0FLZmtTZ1h0S3dldnN1U0o4RUR0VDFvNVZrQWx6ZzVMV0N5WmtPSzl1?=
 =?utf-8?B?VTNnOFg1emJWNUVFUFZhaHUyZDIwQkRlbHVZbWp0NVNLRzdOUm40K1ZEcHFM?=
 =?utf-8?B?OFFnc3FOZ0dVb3lNYk9aSWJ2VUxWWW5UekpJckRUSE9iY3RrVXlrU2V1QWJZ?=
 =?utf-8?B?RjIvaDJZcVJEdE9maXU1amFDUE9NeVdjUWw3V2xxMXNXendpWWxmYVlDMkh3?=
 =?utf-8?B?QVk1QklsZkQ3c2Q0eEh3YldabEVBVVdEQzlDVHhyZERzSUhCVHBzZmttaS9h?=
 =?utf-8?B?NXlJbWhKVDhCRDZSc2ttcDI5Y1lwWlpva1NyaTh3bGFOYWl3TlZVWmtKSTlZ?=
 =?utf-8?B?QnFERVZJV2s5dVBnOFpPY3RsU1VpRWE5QzY3Rks3bGg4OCtSS1lhcFQwNmlV?=
 =?utf-8?B?NWpmZE1KbnZXZ1BzdmhrZ3RMcFNBYTk2R0lHTEE2WEhEN25WNGdmTFo1U1hZ?=
 =?utf-8?B?cElZN3FwMmNrTzU2STB5TnM0Ny9BMS94STlxOVBSc0F6Qk56b0FUQ2cvRW5B?=
 =?utf-8?B?R2hkL3VyVGcxOGtING51ZEZiazkvVlhPd2d3SW5UYjZpYzRIZGUxOVk1OUFW?=
 =?utf-8?B?S3lXcWRFM3NGWG43UlFBSUdnaVBGVWNJbXFoVjVvdFVoRkpWVk5JMjFyank1?=
 =?utf-8?B?NHBBQThZTzNXWHVMbVNVa0RJOWtjRVdxUjFud3YyWkpkVEVBWk15aHJzVlpw?=
 =?utf-8?B?N05UTzJ3a3Bwa2MwNklpc1BTNjFVQ3VuaDJCc3krUHZxOXFGRjNFTFZtd2ww?=
 =?utf-8?B?MFRHR0dlcWFQLytHTU9hVThrQmp0L0s1aCt4TkJ6cmRvY0I1THFtWTlzVnVD?=
 =?utf-8?B?VGNUOXpqQ2t2VlRRYUFEYXhJVjFQbkFVdmllUTdnUERmVmpFZFVNMGN6RkhX?=
 =?utf-8?B?OW00OEVVV2YrTXhUU0kzcEJqNDloQmk2OTVJc0plTzNpeTAySUZlSFZZdDlK?=
 =?utf-8?B?UlFrbW4xR3NETEVnQTFOK1ppenRadE10VVEwNWdqV25iZ0FpNnpkQ3VmYjc3?=
 =?utf-8?B?emdlK0xjT200N0thc0k5ZHRpOVI2R1E3VkNvTjMvdjdIdm4yY2hGY09WemUx?=
 =?utf-8?B?WGtvZUFmbnNXTEU1ckU5T2pZN1hMNHBqUERONnpxL0hPV1dTN2NJd2IrL2VI?=
 =?utf-8?B?TGY0eERCeis2NFBRVlRZcS9ocy9UTyt3YkVURFFkelc4d0dwYUswS3BnRStJ?=
 =?utf-8?B?R1NYOHMvSnBXZEpOWElxSzVyeDdrUjRXUXd1cVgvNnpTV0M1T3pFZThhT09B?=
 =?utf-8?B?Tnh2R2lEelVEcGI1OHFlZnh0TzZEdHozRGYyR3VPSXBObjByb1ZXbGNOQ0sv?=
 =?utf-8?B?OUtEc2t1eHFCUEVFa0lkTWQrU2ExTlRwY290SVJTdFIvWXJLUjRGeCsxUHYy?=
 =?utf-8?B?azJ2UnRLTlZDZm1PTzZoNzFEYkpJamhxVXFqUzdNZkorSWFFbThxeFE1NjVl?=
 =?utf-8?B?d29qWGorNmlOTVlJMEtxRFpvWGt3RWU1TzUxbnd6RzQ0aFVRWTNBaWhGaFJo?=
 =?utf-8?Q?tggANKRuv6nwXI6HM9u+x+4xK/Qu03YA3OpTKQlSB9tcX?=
X-MS-Exchange-AntiSpam-MessageData-1: 8MJa63H25ElJHw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae932fb4-6222-48f6-9680-08de522d9543
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 22:54:46.5589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GklsSvXB9vKeC9sOfLzgB7NT2NZ0W57l6/v3E2DLp4dnWDX5JXQeTob8gG3wbNEL3A3sIPwT5WeQhg6a8LgiIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5846

On 1/13/26 08:10, dan.j.williams@intel.com wrote:
> Balbir Singh wrote:
> [..]
>>> I agree with Gregory the name does not matter as much as the
>>> documentation explaining what the name means. I am ok if others do not
>>> sign onto the rationale for why not include _MEMORY, but lets capture
>>> something that tries to clarify that this is a unique node state that
>>> can have "all of the above" memory types relative to the existing
>>> _MEMORY states.
>>>
>>
>> To me, N_ is a common prefix, we do have N_HIGH_MEMORY, N_NORMAL_MEMORY.
>> N_PRIVATE does not tell me if it's CPU or memory related.
> 
> True that confusion about whether N_PRIVATE can apply to CPUs is there.
> How about split the difference and call this:
> 
>     N_MEM_PRIVATE
> 
> To make it both distinct from _MEMORY and _HIGH_MEMORY which describe
> ZONE limitations and distinct from N_CPU.

I'd be open to that name, how about N_MEMORY_PRIVATE? So then N_MEMORY
becomes (N_MEMORY_PUBLIC by default)

Balbir


Return-Path: <linux-fsdevel+bounces-41679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6FFA34DAE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 19:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C0E2188F06B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 18:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46837245031;
	Thu, 13 Feb 2025 18:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aVcD3pzx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0089C28A2DC;
	Thu, 13 Feb 2025 18:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739471255; cv=fail; b=JBrKVWSErqeHbhuoMyM0FdKaff5inA9Evj2h0ePTrxwmgJpMkaRGzz+bnGhe/YvecYAlpZdm4KyQOLkHxNSnamRWhXTj8iHSbKQdxZViVNY/EfICEcpdJnYS2p/FvH3Cr6/2hGdUlXC49S1mm8gu72zwjTBjXHbuX/Gt/aj5Vw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739471255; c=relaxed/simple;
	bh=WzBJI/xDM1hPeReoXdZgiepr460jUXdILMvNiRW2JrU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tFM73KBr5QWreFvV+Yyj7XahKUeAYPtjFiBFthoOOZxVQCqsXuCptjxhKgcenZFDgCsdxrEA6ee9hCSMtX4S4JH7ySDltGAf6SRx6t9Ok6NEmhAJm7OwGRJaVkPEZYfdYqwOTajWRL1g1jStz8SaAHfwmWP+1MSpzO/VZflx/wA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aVcD3pzx; arc=fail smtp.client-ip=40.107.220.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R8WfVlWfsZepiN5kdMnX1Zf7XFs9aCCOvkQAqeiMposKJsOnNpLOGZYJqn7OpGEybmud5gTVwZK9crJTYNSNvB/AQ+R1On6cLydimopjcKPo4wTShyTEhx06nI3RyAamxrZE9nm+o9raurslGftQWAUJPfzuShJaWqxDaWP2mkmxAEAYv3+bQsOBfvzC3w0CeKmiliF9nj9vXGz/j/fuWf4qMKiAS22y9lGbT4B7e9i9Yp7D+YfmHr17jGCa73Np4F0o45rc3j9xIuciPtcW6kFDB1TbaMPmU8cqV8O5rRC8z4IqRmSSXlKf2s8x14RbHD7S3JF9zl65Bs2d9qdrrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBSkixRaAcmHecXTkTLgwrK6KopORuQDyEyPKMtr7dw=;
 b=WS6Jc2IRfd1I5BNahGPcefJ1eWDL4VCFSwkn1bebhCVDswJFoik5e3Z+OUjbZseboKUOfUwZGYwa9wob5mXVfhIgBn2GVXSJaWLKSL/HWQWFHGB7Aq3PEBsjcpVuZju64vmDB2G5IdwMFWyyhvoobLpju0bwRkJe6zzXUogCwD75CAIWiT9ptV/L9kdKj+ijYT74qWLW8w2uTZ/HNhDDKIK3KoiUdIMjOJcjqxy8UgNpoQogjtudguNeEgqFwb4rplBGhSzGZXBhVrAN7OzBMdMna37oBBwh0o+AStrjXNPNN0HhFg9FaH6dAAf+PHdDP78i32y89Ve4JIHO3boW4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBSkixRaAcmHecXTkTLgwrK6KopORuQDyEyPKMtr7dw=;
 b=aVcD3pzxT9l/eVgCaG4I0VsOtwHCVkqkV+lA+GG83ZnpO8LyxN7QoEzkhPWE8hjESO3lhk31hv1VUZB3L8Ywoj2N8StmhANrvN1DURaH7g4j+D/RAesTI8VPN5Mx4+QZO07mSZXkt4rGxW+Xzo5IpeT7le6OVK1w/HYgFAEdMk0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8)
 by SJ1PR12MB6026.namprd12.prod.outlook.com (2603:10b6:a03:48b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 13 Feb
 2025 18:27:31 +0000
Received: from CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870]) by CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870%5]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 18:27:31 +0000
Message-ID: <03d1ffc5-2752-4c2b-a95f-e9f337bdab9b@amd.com>
Date: Thu, 13 Feb 2025 23:57:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 2/3] mm/mempolicy: export memory policy symbols
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 willy@infradead.org, pbonzini@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, chao.gao@intel.com, seanjc@google.com,
 ackerleytng@google.com, vbabka@suse.cz, bharata@amd.com, nikunj@amd.com,
 michael.day@amd.com, Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com,
 michael.roth@amd.com
References: <20250210063227.41125-1-shivankg@amd.com>
 <20250210063227.41125-3-shivankg@amd.com>
 <9392618e-32de-4a86-9e1e-bcfeefe39181@redhat.com>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <9392618e-32de-4a86-9e1e-bcfeefe39181@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0233.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::12) To CH2PR12MB4262.namprd12.prod.outlook.com
 (2603:10b6:610:af::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4262:EE_|SJ1PR12MB6026:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d8d4c25-815e-4e18-737a-08dd4c5c13e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RG50dkdqSGhCSGthZ0ZYcGxIcS85a2JWR0diaHNzbVM0Z2kvZ3hSS2hscG1T?=
 =?utf-8?B?aDRCY0JTN2U3QmcvMDZEdURtRWtmdGlWYnI2enZMZnNZNDN3SFB2RnRGREs5?=
 =?utf-8?B?RXh2MnNCalZuQm01Y3hoYS81ajYwang1NXZGNnJJZ2NCY3JvZFBGRTMybFg0?=
 =?utf-8?B?a3RjaWFIK01IRkdjMUd5M1JJYzhTVnhEakRYS1B5V3BBVWJwcTcvdzYyNms2?=
 =?utf-8?B?c2htL29tS1NmTndFY1o0NXo2VmVkNjl0SzJFSkszTnhRYXRZa1RnUGhyQVpl?=
 =?utf-8?B?M0UvK0ZCSTlGQk12UGt2NlJieWd6bXJwTWpDRDNxbmxTTVF2TnV2ZUhHZ1ha?=
 =?utf-8?B?Z3dCWTNOMnI0Ukl5SHljMjVsQ1ArWUxYZ013dlZONlYzUys0SXR0dk0zdkhO?=
 =?utf-8?B?aGZyNlNXaDhGNFprUWdJek1CQndmek9nWGc5Ty9wM3ovSWM1Q3RVaXlzYjNQ?=
 =?utf-8?B?aU5FTVpCcCszeXdXdHAvckhrUE10Qml2Q1lKa3VrNFVaT1JoR05TQWdQbUha?=
 =?utf-8?B?NVV6bGpTRWhTemZFVE1YRDBIQWRIOHZsOEhqcHVXNFFOclp1TGVZMFdGaEkr?=
 =?utf-8?B?dm9yR0xWVXBKbnN4OGpYRFpHQm5sNmg0UC9Zd2Fpb1NvRmlkM3dXa3pZTzNR?=
 =?utf-8?B?RjBKY2ZRL2ltNFk4eXZLNWtGYjBmdHl1RnR4T01ZbWYyU3d0QjJheUdhUzRl?=
 =?utf-8?B?UUJZZmF5TThidzlsajYyV2RSSzhNNDF6NGI0VHhhMGwvQnVCQkR5RDFUYVR6?=
 =?utf-8?B?Yk8zcGUvaUJVd2pHOW5tVzlNajkraG41djNlYlNMWU1WK3RydWsrMTQwbG9n?=
 =?utf-8?B?UEYzcEVCcWErSXB6K21wSmd3WXlEMEtKd0dqM0J6YldEVUJSMC83YkcyRXJl?=
 =?utf-8?B?eTZVUmE5WEFXRmJKVmxNNHhnbGhSZ1pwM0RZNTN3cklMWCt6eDdyK1RVYlBl?=
 =?utf-8?B?ZjBjS3M0UlBYQ3huUDVKY3IwZ1Z1cWh3d0VWZWkyN2pOQnVPT1hsK1hDSCt5?=
 =?utf-8?B?bEtHNGpSbktnNGVtdTlIemxHWk5VRTk1V2JaYUR4ak5XVlB2L00vMjhNL0Ra?=
 =?utf-8?B?VlMrMXJZcDgrQTRocExEUDhHRWhNQWgvRUJvMUlLSTIwY04ybFhmaGN3dTJV?=
 =?utf-8?B?dXVPNDdYbFMwdkRpZnNUMlR5SCtjZm5iaVpHWUUxMld4cHExSWJyb2Q5VXVh?=
 =?utf-8?B?STE3dWRmWG5KeTlwb0hVZEs3QjF6aGNzUnI5MWJ3VDNNR0t2OTR3YWZlNnVW?=
 =?utf-8?B?YXlKaDlyUldJdm9IS1FjeXJHT1F4T21qdVE0T2lYUkNqTVBBM2ZEcURJK0lw?=
 =?utf-8?B?ZkE3WW1aZWhGRU1RYTBzOXhiVTlzWGZBblVwU3BKM2o4Uk9QNXVJWW80TVVE?=
 =?utf-8?B?R3lNM1lJY1h5NU5Uemd1eTl1TXM4amorUnE4SjlpWno3bHQzUGtucHZiVUtT?=
 =?utf-8?B?OU01UlIvakxOUVk4K25tNzdlNUU0WlZ1c2dmVDdGK3FpeGJrS3JnTnJKNXVS?=
 =?utf-8?B?TWJwSXhOUkhUQUN0UlVTS1dpMi90Si9QS2pMcnlFNVZUdy9BYTVXK1hidWpu?=
 =?utf-8?B?V2NoRlArSXRIZUU5VjlVRVZYY0FjaVh6d2NTTTVmaHpyVGdQcWtQQTFqd2Vx?=
 =?utf-8?B?bmxCUkNEQ2FPWVRtdHlWZG1UZzNvdGxSdFZUakIySDFmeFFwTGJUT0UwS2Jy?=
 =?utf-8?B?amJONk9ZSi9TODJPaFhuUEc4VlpRdW9PVExWcHlHaHRIZGo0TEs1bzZ6RHQv?=
 =?utf-8?B?OWdoTmVmTGhBS2w0MUprQkJkR011cjNkZDloNGNzanpvSlRva2RFMmF5dHFi?=
 =?utf-8?B?SXZ3RGN5V3ROQTQxMHY5OEhHVVd3bnNCS1lSY0VDSkUxSnVxTlRrWFA0a29U?=
 =?utf-8?Q?y7phSgx48TYRw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4262.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWZGckdMOFNBeWtya2V6MjVQT3RpQkJWMWhUWnE1LzlTS3NFM0NsaithV2R5?=
 =?utf-8?B?U3RVVkxHZ21tL3lxS1VQSGswTTQvM0g4S1p4ZzF3bnZndXVwaEhzeDlZYnBi?=
 =?utf-8?B?YmljdXA4OTc0TWhYTTh6dDRodkNZV3RCUVJIc3RvS3p5SjhKMVNIcmlpNmln?=
 =?utf-8?B?OElSblYwOEVGblBIOGkxeDNJZCtESm1RY09KMEpCRERjaUd5TUhORVhQVWhT?=
 =?utf-8?B?WHpKZ3A3V0pDSmNKZ3NRMDF5RlNybEZmcHM5dEt3RldvUnpnS0NTOHRYMDFH?=
 =?utf-8?B?NE5DdzNOaEk5NDJIblVwRkRYdlJzb2d6OGY5S2owSXo0S01IVTA0cHdZbXVw?=
 =?utf-8?B?Z3FQRFZ6WFVGWEJPT2p1THFDV0NIOTZWejJlVXFySGRsUzZoRWI3bmU3KzVP?=
 =?utf-8?B?OHIrT1F5bVBXaUN4ZjRBcVFreElmWWl6VnA2N3FFNEk4d3V0K0NBbmhZOEpS?=
 =?utf-8?B?dVFxOTJhRVpDR1IxMHZNU0xxY3NkVmw0bDIwU0pTQWJQaExnaXl5Zmo5VHh5?=
 =?utf-8?B?RWJsVURuTnYwMXd2QVkwK1h0QkF4SUpsdGJsT21acUVUNWQwU2J0M05BOGxN?=
 =?utf-8?B?dWIrT2dRRVcyVTRDWWtuaE11ZUhlNFd5eHA0TzB6QTNnWnZ2Mm9SSFo2NW5q?=
 =?utf-8?B?YkhhYTVmdkF3a3JQSGJDdGFZbC9iTEFuSktpRU1xelJ6bVd0bDluc1ZOSEdI?=
 =?utf-8?B?QWx3T1RDNGM1QXE5a3lObW9NWkJtR3N0U0tuZHg2bXFSWjhFZ3AwbUFIVUtQ?=
 =?utf-8?B?TWJ1M3I3bCt0ZlJLNlhWQVhvdS9hK0ZzUi9TNWJSTVV5Vk1JeWFXd2toY0R3?=
 =?utf-8?B?TzQ1SkQ0cU5FOFZUdjd2ZDBUa3V0MXJKQkcvMlRGcnFEUGtoUklEakN5UEhl?=
 =?utf-8?B?ZnVLbWQ3MVRveGc0QVNoaG5Ua0F4MUxOQjIwMmJNMklNOGN1bXpOUCtmQVBV?=
 =?utf-8?B?YW1XZElxNjJFVExEWEI5aDEyZ2F6UFRNVXdiRktZcXdvbys5QVZoblNZTkdO?=
 =?utf-8?B?MVZIc0lYcjFrQklwTllzc2xhYmhkMTdJelRvUVQ5cXVkUzNWemMrQ0pPL3hX?=
 =?utf-8?B?NkUxNTFiYnRURWNoZVNONzR1eVowTWlXRmNuN25zeXRSZ3ZCVHpDWEVnRzly?=
 =?utf-8?B?SVlZRlNrc0p0Ym5HSXlyTWcyV1ExcGlsQ3pYNEd5cjQ3VWRmSnZiYjcrREJp?=
 =?utf-8?B?aFdsVGlnWDJ6QmVCUVZPNUVkSWhHME5hdFRtbjIyTktONmhKVGkwYis2YWlm?=
 =?utf-8?B?ZXpCNTZoN1NsM1ZwUmlkNU9aOUFsRnQvQlVxM283OXpnYkhyeFpGNWUwai9Q?=
 =?utf-8?B?dFRVZHBUSmhKRjB5VEloWmFHQ0JzYkY4S0xFVGpFcnlHcWp5QjE2czJYdzds?=
 =?utf-8?B?ZGZpUEdZYWlMbk0zSWdnR2xnQTZhVVJvRTB2d1F0eFYyN0tEeG1mRE9iQVAx?=
 =?utf-8?B?OXVzQlVFV1lTck5MR1ZMeXdzYXYzNjJuOHVnOGE3c2p5T3JmTzRtd0IwR05V?=
 =?utf-8?B?UjNJc2RXZWVOZ2RnWTY1bDdFSkI1eDkwTXJGYytiVmh4SWVnNHFCM2ZNU21m?=
 =?utf-8?B?bzdBRUM5TlZtdWEwbHdJc2hFYU93cDhFdmtscmx3Y1pvZmdJUm1SY3JHNEVX?=
 =?utf-8?B?RVM2RWJIRlhGL2dFT1hlNG1lNHgvOGhic0hlN0VaR1dyTXNPYkNjSTB6TWdm?=
 =?utf-8?B?b0NNTFovbHgrWnlJYTdzZllrSnlJY2VHK0M2ODg4L3BodWJuVGxtc2U2bDd1?=
 =?utf-8?B?azkyOWtFbjRTVlJ4SGNpUXZQRjBjMk56NnFUZEFkUXFmUStPUksxS1h6Kysw?=
 =?utf-8?B?NmxUS1V2Z2MzRVRMWGVPR2RKaURWVzBIZUdoMXlDd1NOOW5hS05PK0JsLzRF?=
 =?utf-8?B?NGVhcUtPVXFSemZUZ0V6Y1pvNytqeU5hVnFodVdGWVJldkgwb2RGOVhWSUxJ?=
 =?utf-8?B?VW9sTWdLR0IzbVkxaFUzYlZ3V0ZYYXRXRkUvMDdWdVNDSTdUdzJ6bHNKOGZO?=
 =?utf-8?B?QXBJemlkOVQxSkxIb0Z2TVhRd25TTEc2SjI4eFJBUURJZ011VEpESVd6MW1J?=
 =?utf-8?B?WWZSS1RCdmxlWE51V1RkNVlzOG55Wkd2a08wSUZzd09LOU5LMGZidnFXNmhX?=
 =?utf-8?Q?IJhSpf8G6STB6AbKGkPZgVFHU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8d4c25-815e-4e18-737a-08dd4c5c13e2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4262.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 18:27:31.4687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cV3yglGcYbJf6zmbNUVDwzU6dRR+uJxaHxLeu8zzMXZUJry/KPiF7d0PfTeMzqYz2dzJU6+Xl3J5Pj+bm1P4Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6026



On 2/12/2025 3:53 PM, David Hildenbrand wrote:
> On 10.02.25 07:32, Shivank Garg wrote:
>> Export memory policy related symbols needed by the KVM guest-memfd to
>> implement NUMA policy support.
>>
>> These symbols are required to implement per-memory region NUMA policies
>> for guest memory, allowing VMMs to control guest memory placement across
>> NUMA nodes.
> 
> Probably worth mentioning something like
> 
> "guest_memfd wants to implement support for NUMA policies just like shmem already does using the shared policy infrastructure. As guest_memfd currently resides in KVM module code, we have to export the relevant symbols.
> 
> In the future, guest_memfd might be moved to core-mm, at which point the symbols no longer would have to be exported. When/if that happens is still unclear."
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 

Thanks for the suggestion.
I'll add it.

Best Regards,
Shivank



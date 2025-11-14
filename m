Return-Path: <linux-fsdevel+bounces-68545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF752C5F4B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 21:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A26893A5F94
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 20:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A582FB09E;
	Fri, 14 Nov 2025 20:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O91S32GI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012021.outbound.protection.outlook.com [52.101.48.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA7B2F9DB1
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 20:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763153630; cv=fail; b=RoHfXaPmlh/Z22QM+8h+oEcA0Lc97KhkBaFbRiDEfmTfisBo394nYjLHNC3yOo/sRwHPRjd8MMY91JgyaJVct6O79HxGDDdQbsJEu23j4Com8l3BFJtEb6CDpf2zaZLez35RNhq+CSzQ7ifZNKvbh542BJSrVkUwZAIFNuf7wNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763153630; c=relaxed/simple;
	bh=9FoA4LdTGwpx/dgP5y81MJrkA0ofp2YjSfoAj0hfrwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T5EHpV/CkswHY+mRz+wr+lygBgGKhwA9MIWE2utHrs6gbOjg0UIPRfMH3ZRzphwQ6EiYlWH3JDD+qFDqhAPr2ZVfJxeOF8RxTIREK9IwtdPYWpNsk3O5gj+gCmQzjYavXiQdG7zpHPSDq2HQqRIDqwbcGauirr6goGG/Hjp5oB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O91S32GI; arc=fail smtp.client-ip=52.101.48.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VeeDT/Yq7Tell2M8W72oC7BNt4cK/xkimcY1Ret9UUwcggDq7p0yIv6U8CCRBRggZeI8w7P0K1JJOvKWF2TQvTIRlaY8TrkQqR3N+Uq3LnRZ+PxhdasEHCjkl1+So69hNQiAEEIGEIv+uErVB5bqBBuKzKuc2eVDI+BLIUDfw/ZFMstTGuZqSSophrgzNgzetjpaHnAOifilH09iTibI+8SVm4Xfstusjajcr3B2DtXU1hYwDDX8Ym7wLJWxjWlfEIOnZTozDew8q+/WhaI0igaMcCHB9najr326353L0eUdeJ15/iEIdiGTl+Wl6SX2gYypse7d48umlpmrV675Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DlOaRvzrTgPOGtLGk1k14RETmsGNHzFq9yeEg6P16OI=;
 b=cEoXx2l/yzVQadMxs8tvrY/9z4xdfsZf8CCslxoxdInt4ryMU9WsyD4vJE2TaX7NZq8Y2Azi1NExVwYQYKV1wC97faXMVVAYMuj/Dp1Z+hG1ARPk7egHBp0oRjGvs8x5g0FfpPjjF7XmqzNc1Dolsf90QvYXGR8+IZgNT27W4GxUI++7o9Gb4ZXSXF25ijUKKotcZOkGnMrZ4paaWeYVOZTL977cSD5wGXMp9EXBNNCkkviqvQrqGCZGUbGvYbNtqLw+UEi6u+YunyRHty2tgn51U7mra5rgwTRLUiYCsgHniNR+hWsKdnxwVXl0WNsn5FSpxjBVDtSA/hGEG031PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlOaRvzrTgPOGtLGk1k14RETmsGNHzFq9yeEg6P16OI=;
 b=O91S32GIQM72eOHYj2uqpYc4cpIvH1aIs5Mz13nLMJFvR13pAcgFC/u1CC5tRK7liE2Ep/GT00hr4UMy7axIdbeN3qG90ICdOgH2FGS+0sCVoLMi9mTThrbQKS7qwN6J6dCgXQ1HaoY+o9lhwIhSEmhnOMTnDqIwsYnzQ04ExBrrCDwbKdo4+59HccSgZrjbkEskL8xyvyEvI8O0fYWkmbk4bhLImHOa3EELisDgICpLgZwU5GcvXQknFf3RO5ehSRgxsTJF4jlgaEVUKEmmkv5pzy7rGO93U/DH1sKCnpx3+X+Jf38kdta0lqOB2KKTjsJnJxEytldUxkJNGXi6/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA0PR12MB7676.namprd12.prod.outlook.com (2603:10b6:208:432::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.18; Fri, 14 Nov 2025 20:53:44 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 20:53:44 +0000
From: Zi Yan <ziy@nvidia.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>, willy@infradead.org,
 akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, baolin.wang@linux.alibaba.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 lance.yang@linux.dev, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/huge_memory: consolidate order-related checks into
 folio_split_supported()
Date: Fri, 14 Nov 2025 15:53:42 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <AE04E232-34A2-47A2-B202-3F1E32AFAC0C@nvidia.com>
In-Reply-To: <20251114143015.k46icn247a4azp7s@master>
References: <20251114075703.10434-1-richard.weiyang@gmail.com>
 <827fd8d8-c327-4867-9693-ec06cded55a9@kernel.org>
 <01FABE3A-AD4E-4A09-B971-C89503A848DF@nvidia.com>
 <20251114143015.k46icn247a4azp7s@master>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN0P222CA0024.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::26) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA0PR12MB7676:EE_
X-MS-Office365-Filtering-Correlation-Id: f3ba5824-9cf5-49e6-4081-08de23bfe671
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVRaWCtVWTNlNzBzMWpJbFpPM1JNbjh1MGYwWmtENVEvajAzcHFMN3dmL3g0?=
 =?utf-8?B?T0RERkEyY1hCSDEyWlNhVk16THJQdVdqMmhkUDlRWDlZTkFDNy9iMlNVMG9h?=
 =?utf-8?B?OWREcVhIS00weHUzaUhyTFBnU2Jad29rcHF0cVYxbUtPcUMyd2ZhcXRvSjd1?=
 =?utf-8?B?OXNzZE0vN3BWcUxaQ2VUemhyUmdsRFRVeEIydzNvajg4b2w4VXZYcnRLclN3?=
 =?utf-8?B?bm12cVFnb1h6aVJybUlqUlFLQkZIbVM5aytGLzRKRGx1NjAzYjMwK09leU9Q?=
 =?utf-8?B?T3lOSklNdTVUZCtuSzRDWVExM3JtdHZVaGt4R096YlQzSElKWVBjRmZBRUN4?=
 =?utf-8?B?clNmdmJvajMzSkEzUHFGRFlIRWorQXRiV2dCci9OdW9TZnlMSVlHWTFVNGNS?=
 =?utf-8?B?RlJnaW55TnIyN1k1MFp4RmpjekFMVVIyQkNVYzQxTHNUM01kanlrZ3RybEJV?=
 =?utf-8?B?MUVJV3JOTVNTQzBiTXZkdXlsZGpGT28wOWFISUhiY2ZTMjJseXMyYnk3OUI2?=
 =?utf-8?B?dS9nWVZOT0wzcXcvcXdwZjhLMkNTZEZvWjRCL2g1STU2L2Z1Qi9UVFNsK3JD?=
 =?utf-8?B?VDcrWFpzM2RRelZ5U2NPTWQ1aCtJMVZWc25vb09WaEVPUG1BWm0xUFVOSTho?=
 =?utf-8?B?ait0UVZoRVpiMU1ncjdqdGFCV2RkL2RDREwySTlMVFVhSndnNWozMndZWFp4?=
 =?utf-8?B?aW5vTzdUZk93TnNxaWFXNlYvRHB4Ti81TVljWG1sQmxQamxxLzljZFRMLzlN?=
 =?utf-8?B?aW1LTTZGenRVMzZKYTdhaTcvM2NrY3dQWGxyLzVoMWdQNHF0MTQvNXQ3V0Nh?=
 =?utf-8?B?Y2tmVEVWeGZNNjhHWDJHb1R5a2hwVk5BaGpuaU5mMG9OeWdVWjdwRmUzUHFZ?=
 =?utf-8?B?VW94dHJFNjRoRi9oSUVsWG0rRE1mdTY2TDdoQzNxU3BxTWE5UllGSlg0T1Q2?=
 =?utf-8?B?dHE4WUNHTURHTzlmYTc4R1daUzEvZnkrT2RpVUZnNFo1NXZiaXozTHVQbjhQ?=
 =?utf-8?B?RzBpajNHbDRXYlBiRXVybWFhRDAvbXh6bzBzV20xcnZHaFpOQVhVaXZoRWRz?=
 =?utf-8?B?UmR1T0xXbmJGSFp6NnoySE9aMm52aXVTYkZ0NlNzU0RWYUxEcHp4S1RxRnJJ?=
 =?utf-8?B?WnBzVEVMbkhrcHg4Z3c2dDFxR1c3UWc4c2tublpBWFFKQmxsZTVmQUwxcjJ1?=
 =?utf-8?B?REN2ZVlSMzVOUExmbGR3SkttZkV6Z2g2K0ErYXVCRVl4V2pWZWp2eFFTT095?=
 =?utf-8?B?endJbVNxOVlJT3lGbTBDei91U3F3Y1dvUVh3cndLU2JMankxU1AvcUtlcFJy?=
 =?utf-8?B?Z2dxa0kzTENTNUZqVnlnOENXSURZeEhtUDFSZmMrMnZrTHY1KzF6alJTbXpS?=
 =?utf-8?B?VERPdlFUNkZXVXpWQldORkxEOUZsU21DejRPQWduNHZkUS9JaFlmME9aRmdT?=
 =?utf-8?B?R080Q2N1TTI1Y3dDbzRMbGpQeVpsTkt5cWx3d1Q4Um9rZHRWL1U1Ky93T2s3?=
 =?utf-8?B?ZkpmdjYvTUp4cndLeVp0amM0eHV4cmJNZlBYd1NZSWJLZmdqckR3RnU4NUtl?=
 =?utf-8?B?SWIwUlYzeVRpcGkrUGZBay9tdi83UkY0ZGVGYVRWQjhSWWpOYS9JcWJCRUhi?=
 =?utf-8?B?aVE3ZTNEaTJEVjFuVUhUTkdteWFydWo4VUtISDhBdGRGWnlnRnNvaGFBOURj?=
 =?utf-8?B?ZmhXOXNocCsyL2ZVRTh3L3hrZ0tFS2VnelFpWlU4cERURTlYL2dVZUZJSmhW?=
 =?utf-8?B?Z29nRHhDcWlPREQ1UENSeDgrNGljdnhLWTBtMkVMc3RTdGUvemRGTjNMQkRw?=
 =?utf-8?B?aHVoaEpFdUlpckI4cnJVZ3hvaEMxMzlXNlVlUHFrME1PaHJlOFdiSkFWQ2Z2?=
 =?utf-8?B?d2xKQktDRmVUL2RIV1BKMTd6ZVFoMVR4RDdvNFpEaVVzR2VUdWRQenRKY1Fm?=
 =?utf-8?B?ZlhJN0lvdDNlWllDamZMemV5QVVoWEMzWnBnZWVxZmZIMzJ4QVNTVlhqRjUz?=
 =?utf-8?B?N3ptczYvT3pBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHArVytJWEdvYmNiTWRSaHZKSzdJT0lRRi9FNlVIZXZWY0I5dFB4VHVjTS9h?=
 =?utf-8?B?TjVwNGJWOEZsL3pVdjVxYmRiZVg1bWtURGFpSGVxUW1TejF2WFFVd0QwTlJW?=
 =?utf-8?B?MG5tN25yamJobjF2RmVpRElxdlI4dTRia3NQejAvMllvaHMwVXF4Zy9mRUtn?=
 =?utf-8?B?eU1KVnY1THVLQlZiWEVMdzUvejNwbnFuaEo1RHVza3BWODlZbGtWZWV1Zzcx?=
 =?utf-8?B?V0dUb0wyMEFGNjlmVmp1RjN3YVRJVXp4cERtVVd5c3BIRjRCTEhON3lLSkV2?=
 =?utf-8?B?YktrRWZ4NEVLeVhxVjQ1clV0S0tDdFVTQ1VvQkdnbEduYXRUczdiWERLVmM5?=
 =?utf-8?B?T1RkNnhMb21VOSs2VnNoNmVNaWFLcmZMTGlUL3BST0R1WXdYMHpWZXJVcTlm?=
 =?utf-8?B?WUgzeDM5YjVieTMzNjhuN0FMcEF4RlFNRmtqM0FwNzA1V0dKL0NzOFhVdzRO?=
 =?utf-8?B?OFNRNDBSTllVakxZS01OMzZsYUswVlBmS0txUFJrcXpwdGY1UHFDcVFzSGdk?=
 =?utf-8?B?MzdsNkxZL2p6RDROdDRBRmU5dDJUejg3TDM3VTJPa09LM0RkcGFiS1k2cHJi?=
 =?utf-8?B?VHI4VDhmcXFkOUUwanF4Q3pOZktuOGxkemtnZHc0TWpuZVZiZExFR1NWRENP?=
 =?utf-8?B?YjRWMWx3Z0hlbnR0emhyMmpTemN5S0JocEQxSWhTQ1VpeXBybGZReXRydjQ3?=
 =?utf-8?B?S0t2K2lFME4xNVFpM2ovajk5R0ZaK2FhTVdFMmNEaDhyZlZwOHErOXBNQmdH?=
 =?utf-8?B?V2RDbWRqdEZNUTlyM09JUVpmb3NZZXVSSnpHOG9ydzlaY0tHSFEzekZCbGMy?=
 =?utf-8?B?dENqcHo5U1g0bUdWNVcxQ0o4NzEvQmFaZDBNM3FTRkI5SnYyR2Jua0ZoVjUv?=
 =?utf-8?B?Wmg3UmcwSVdhUEprcUFRR1EvdEJ4VStTWGxMd0JnUWRsbXVsZnJSM3RnUlJt?=
 =?utf-8?B?Z1g2UTU5aUtQdkE0RmhzOGRuNVZtdzNFRVlxTkV4MU9sb3ZHRW9hakozZHgr?=
 =?utf-8?B?YXRzUHpUOGlqcGF5RGlTeHp5YU0ydU00cTIyczZ6ZDJoQ3pXUDhpOFZCbGVm?=
 =?utf-8?B?RWRyK0l0cldINlpVZU1YWjV5NTVVWHdacnBDaXhqRVhqNzliV244bURKNmFy?=
 =?utf-8?B?VS9aNVk3UGp4dUNGSzVadE5QMGg3dlFIYURyVmQ4NmpyYWo1UVZxL1JmTWp6?=
 =?utf-8?B?WVdmbWQrK0hSSXdGYUNXNEVXQTNSNWJ4SVVxTVZWWGY1WTJQdktXYzlnYkJG?=
 =?utf-8?B?dTRxYXlXNW1TNUVJZ3A0RTdyZHJmU3VNRldISVF4OHRlOFYyY1pSakhSNDFU?=
 =?utf-8?B?RC9hTEM4M2lLbEFYM2J1aXd2dFlRaTRlUXNNZnRNc3RKWHFNaG5hQTlPYllj?=
 =?utf-8?B?NEo5VVk1NHZLQldWUG1xL3ZwY0Y1emwrMjg4MEwwRFAyV2VuUDErRGltZWx2?=
 =?utf-8?B?dHRzNFZlTDRSWXNuZTJDMEdrTTBXMnVRYk95bGRMMkFNZURRNm5oU3hqS2Nr?=
 =?utf-8?B?OUxNaVhiQ25LL1lJeXM2ZHF3NUpzb0lpamJjTkJIVktSSkpwRkdVMjhpdVN3?=
 =?utf-8?B?YUdiYm1Bcml3VVlsN0NtcFVyeEl4NXBac01CeExSNFBkTVVTN0E4L1JKNXNy?=
 =?utf-8?B?Ym0zVjBZT3pGbHlBZXhXWU4rY2tqbGVLRmF0UXB0QkZlSzFhdTZUd1RjUTVV?=
 =?utf-8?B?UGowV1RHcDlhNUV1MDF2UkZpbFRNRnphSXE4Sjc2c2lnSGVRZXNwWTRBUHFH?=
 =?utf-8?B?VGxSQiszUEFnSi9pWlEzYktKaHY5YVZmUWdNdnd2ZWhMeHpVdEJNSEt1VnZS?=
 =?utf-8?B?YzV3cEFReXFjYVhXZUNrVmtXbTBYMVlVUURBOXdaRk9ZZ1J3Q3BRUWVQWE1M?=
 =?utf-8?B?OWN3NHhNZ201L3FrYW1UTlNraGlIQUVXOTNqQkVvNThqaTNCZHFvYVVvemt5?=
 =?utf-8?B?MEp2ZDdKblV0anlmTTA5Szd1ZFBHcTA3aC9LUUlsc2xsM3FJOE1tZ2NiSCtU?=
 =?utf-8?B?WUlOVDE0amQvVjBxRENrRXdmM1EvcldZcUJxeHFWZnZlY1VBR3V1bnFMZjI4?=
 =?utf-8?B?UVVDdXliWC9wYTJWb1hvbDJacVk2NitNSlpsQlNjanhYV3FhZ0ZMOWJWaDRC?=
 =?utf-8?Q?LeLKmkrMBGg4H3TMI0XqTq1fa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3ba5824-9cf5-49e6-4081-08de23bfe671
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 20:53:44.6222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6YA5mBPZ/LSzMARzSSFy2kiAWUuqDOfNOkZuPQ1Cf2sIEHgAFhCU/YgKKaSbsu5s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7676

On 14 Nov 2025, at 9:30, Wei Yang wrote:

> On Fri, Nov 14, 2025 at 07:43:38AM -0500, Zi Yan wrote:
>> On 14 Nov 2025, at 3:49, David Hildenbrand (Red Hat) wrote:
>>
> [...]
>>>> +
>>>> +	if (new_order >=3D old_order)
>>>> +		return -EINVAL;
>>>> +
>>>>   	if (folio_test_anon(folio)) {
>>>>   		/* order-1 is not supported for anonymous THP. */
>>>>   		VM_WARN_ONCE(warns && new_order =3D=3D 1,
>>>>   				"Cannot split to order-1 folio");
>>>>   		if (new_order =3D=3D 1)
>>>>   			return false;
>>>> -	} else if (split_type =3D=3D SPLIT_TYPE_NON_UNIFORM || new_order) {
>>>> -		if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
>>>> -		    !mapping_large_folio_support(folio->mapping)) {
>>>> -			/*
>>>> -			 * We can always split a folio down to a single page
>>>> -			 * (new_order =3D=3D 0) uniformly.
>>>> -			 *
>>>> -			 * For any other scenario
>>>> -			 *   a) uniform split targeting a large folio
>>>> -			 *      (new_order > 0)
>>>> -			 *   b) any non-uniform split
>>>> -			 * we must confirm that the file system supports large
>>>> -			 * folios.
>>>> -			 *
>>>> -			 * Note that we might still have THPs in such
>>>> -			 * mappings, which is created from khugepaged when
>>>> -			 * CONFIG_READ_ONLY_THP_FOR_FS is enabled. But in that
>>>> -			 * case, the mapping does not actually support large
>>>> -			 * folios properly.
>>>> -			 */
>>>> +	} else {
>>>> +		const struct address_space *mapping =3D NULL;
>>>> +
>>>> +		mapping =3D folio->mapping;
>>>
>>> const struct address_space *mapping =3D folio->mapping;
>>>
>>>> +
>>>> +		/* Truncated ? */
>>>> +		/*
>>>> +		 * TODO: add support for large shmem folio in swap cache.
>>>> +		 * When shmem is in swap cache, mapping is NULL and
>>>> +		 * folio_test_swapcache() is true.
>>>> +		 */
>>>> +		if (!mapping)
>>>> +			return false;
>>>> +
>>>> +		/*
>>>> +		 * We have two types of split:
>>>> +		 *
>>>> +		 *   a) uniform split: split folio directly to new_order.
>>>> +		 *   b) non-uniform split: create after-split folios with
>>>> +		 *      orders from (old_order - 1) to new_order.
>>>> +		 *
>>>> +		 * For file system, we encodes it supported folio order in
>>>> +		 * mapping->flags, which could be checked by
>>>> +		 * mapping_folio_order_supported().
>>>> +		 *
>>>> +		 * With these knowledge, we can know whether folio support
>>>> +		 * split to new_order by:
>>>> +		 *
>>>> +		 *   1. check new_order is supported first
>>>> +		 *   2. check (old_order - 1) is supported if
>>>> +		 *      SPLIT_TYPE_NON_UNIFORM
>>>> +		 */
>>>> +		if (!mapping_folio_order_supported(mapping, new_order)) {
>>>> +			VM_WARN_ONCE(warns,
>>>> +				"Cannot split file folio to unsupported order: %d", new_order);
>>>
>>> Is that really worth a VM_WARN_ONCE? We didn't have that previously IIU=
C, we would only return
>>> -EINVAL.
>>
>
> Sorry for introducing this unpleasant affair.
>
> Hope I can explain what I have done.
>
>> No, and it causes undesired warning when LBS folio is enabled. I explici=
tly
>> removed this warning one month ago in the LBS related patch[1].
>>
>
> Yes, I see you removal of a warning in [1].
>
> While in the discussion in [2], you mentioned:
>
>   Then, you might want to add a helper function mapping_folio_order_suppo=
rted()
>   instead and change the warning message below to "Cannot split file foli=
o to
>   unsupported order [%d, %d]", min_order, max_order (showing min/max orde=
r
>   is optional since it kinda defeat the purpose of having the helper func=
tion).
>   Of course, the comment needs to be changed.
>
> I thought you agree to print a warning message here. So I am confused.

This is exactly my point. You need to know what you are doing. You should n=
ot
write a patch because of what I said. And my above comment is to
CONFIG_READ_ONLY_THP_FOR_FS part of code. It has nothing
to do with the check pulled into folio_split_supported().

>
>> It is so frustrating to see this part of patch. Wei has RB in the aforem=
entioned
>> patch and still add this warning blindly. I am not sure if Wei understan=
ds
>> what he is doing, since he threw the idea to me and I told him to just
>> move the code without changing the logic, but he insisted doing it in hi=
s
>> own way and failed[2]. This retry is still wrong.
>>
>
> I think we are still discussing the problem and a patch maybe more conven=
ient
> to proceed. I didn't insist anything and actually I am looking forward yo=
ur
> option and always respect your insight. Never thought to offend you.

Not offended.
>
> In discussion [2], you pointed out two concerns:
>
>   1) new_order < min_order is meaning less if min_order is 0
>   2) how to do the check if new_order is 0 for non-uniform split
>
> For 1), you suggested to add mapping_folio_order_supported().
> For 2), I come up an idea to check (old_order - 1) <=3D max_order. Origin=
ally,
> we just check !max_order. I think this could cover it.
>
> So I gather them together here to see whether it is suitable.
>
> If I missed some part, hope you could let me know.

Based on the discussion in [2], your patch mixes the checks for FS does not
support large folio and FS supporting large folio has min_order requirement
and I told you that it does not work well and suggested you to just move
=E2=80=9Cif (new_order < min_order) {=E2=80=9C part into folio_split_suppor=
ted() as an
easy approach. Why not do that?

>
>> Wei, please make sure you understand the code before sending any patch.
>>
>> [1] https://lore.kernel.org/linux-mm/20251017013630.139907-1-ziy@nvidia.=
com/
>> [2] https://lore.kernel.org/linux-mm/20251114030301.hkestzrk534ik7q4@mas=
ter/
>>
>> Best Regards,
>> Yan, Zi
>
> --=20
> Wei Yang
> Help you, Help me


Best Regards,
Yan, Zi

